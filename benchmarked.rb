require 'benchmark'
n = 10_000
arr_length = 1_000
arr = (1...arr_length).map{|i| i}

Benchmark.bmbm do |bench|
  bench.report('luhn') do
    n.times do
      number = "2323242453535"
      nums_a = number.to_s.chars.map(&:to_i)
      nums_a = nums_a.reverse
      account_number = nums_a.drop(1)
      sum = 0
      counter = 1
      account_number.map do |p|
        if counter.even?
          sum += p
        else
          if (p * 2) > 9
            sum += (p * 2).to_s.chars.map(&:to_i).inject(:+)
          else
            sum += (p * 2)
          end
        end
        counter += 1
      end
      (sum *=9) % 10 == nums_a.first
    end
  end

  bench.report('luhn tiff') do
    n.times do
      number = "2323242453535"
      nums_a = number.to_s.chars.map(&:to_i)

		  # TODO: use the integers in nums_a to validate its last check digit

		  # Reversing the array and multiplying the value in every other index by 2
		  n_arr = nums_a.reverse.map.with_index { |n, i| i.even? ? n : n * 2 }

		  # adding up the digits in any number that has more than one digit
		  n_arr.map! { |n| n > 9 ? n.to_s.chars.map(&:to_i).reduce(:+) : n }
		  # adding up all numbers
		  check_digit = ((n_arr[1..n_arr.length - 1].reduce(:+)) * 9) % 10

		  # implicit return to check whether check_digit is correct
		  check_digit == nums_a.last
    end
  end
  bench.report('luh') do
    n.times do
      number = "2323242453535"
      nums_a = number.to_s.chars.map(&:to_i)
    # TODO: use the integers in nums_a to validate its last check digit
    nums_a_reverse = nums_a.reverse
    nums_a_process = nums_a_reverse.each_with_index.map do |num, index|
      if index.odd?
        num = num.to_i * 2
        num.to_s.chars.map(&:to_i).reduce(:+)
      else
        num.to_i
      end
    end

    checksum = nums_a_process.shift
    sum_of_digits = nums_a_process.reduce(:+)
    sum_of_digits * 9 % 10 == checksum
    end
  end
  bench.report('Ceasar') do
    n.times do
      key = 45
      document = "Zero ASCII value by subtracting 32 so modulus will be correct for
    printable character.  Subtract offset and then take modulo 95 so
    character will wrap back around to zero.  Then add back 32 so
    ASCII value will be between 32 and 126."
      document.to_s.chars.map{|p| (((p.ord - 32)+ key) %95 + 32).chr}.join
    end
  end
  bench.report('Ceasar') do
    n.times do
      key = 45
      document = "Zero ASCII value by subtracting 32 so modulus will be correct for
    printable character.  Subtract offset and then take modulo 95 so
    character will wrap back around to zero.  Then add back 32 so
    ASCII value will be between 32 and 126."
      cipher_text = document.to_s.chars.map do |char|
        char.ord + key < 95 ? (char.ord + key).chr : (char.ord + key - 95).chr
      end.join
    end
  end
  bench.report('Ceasar Tiff1') do
    n.times do
      key = 45
      document = "Zero ASCII value by subtracting 32 so modulus will be correct for
    printable character.  Subtract offset and then take modulo 95 so
    character will wrap back around to zero.  Then add back 32 so
    ASCII value will be between 32 and 126."
      new_doc = document.to_s.chars.map{|d| ((d.ord - 32) + key) % 95 + 32}
      # using the new ord number as a key to get the char from hash
      new_doc.map { |c| c.chr}.join
    end
  end
  bench.report('Ceasar Tiff2') do
    n.times do
      key = 45
      document = "Zero ASCII value by subtracting 32 so modulus will be correct for
    printable character.  Subtract offset and then take modulo 95 so
    character will wrap back around to zero.  Then add back 32 so
    ASCII value will be between 32 and 126."
      hash = (32..126).inject({}) {|h, n| h[n] = n.chr; h}
      # Performing calculation to find new ord number
      new_doc = document.to_s.chars.map{|d| (d.ord - 32 + key) % 95 + 32}
      # using the new ord number as a key to get the char from hash
      new_doc.map { |c| hash[c]}.join
    end
  end
  bench.report('permutation') do
    n.times do
      key = 45
      document = "Zero ASCII value by subtracting 32 so modulus will be correct for
    printable character.  Subtract offset and then take modulo 95 so
    character will wrap back around to zero.  Then add back 32 so
    ASCII value will be between 32 and 126."
      cipher = (0..127).to_a
      a = cipher.shuffle(random: Random.new(key))
      document.to_s.chars.map{|p| a[p.ord].chr}.join
    end
  end
  bench.report('permutation') do
    n.times do
      key = 45
      document = "Zero ASCII value by subtracting 32 so modulus will be correct for
    printable character.  Subtract offset and then take modulo 95 so
    character will wrap back around to zero.  Then add back 32 so
    ASCII value will be between 32 and 126."
      cipher = (0..127).to_a
      a = cipher.shuffle(random: Random.new(key))
      document.to_s.chars.map{|p| a[p.ord].chr}.join
    end
  end
  bench.report('permutationTiff1') do
    n.times do
      key = 45
      document = "Zero ASCII value by subtracting 32 so modulus will be correct for
    printable character.  Subtract offset and then take modulo 95 so
    character will wrap back around to zero.  Then add back 32 so
    ASCII value will be between 32 and 126."
      ori = (0..127).to_a
      # randomly shuffling ords in parallel array
      new_ar = ori.shuffle(random: Random.new(key))
      # mapping each char->ord and using its index to search parall.array
      new_doc = document.to_s.chars.map{ |d| new_ar[ori.index( d.ord )] }
      #joining all chars to implicitly return a string
      new_doc.map{ |d| d.chr }.join
    end
  end
  bench.report('permutation Tiff2') do
    n.times do
      key = 45
      document = "Zero ASCII value by subtracting 32 so modulus will be correct for
    printable character.  Subtract offset and then take modulo 95 so
    character will wrap back around to zero.  Then add back 32 so
    ASCII value will be between 32 and 126."
      ori = (0..127).to_a
      # randomly shuffling ords in parallel array
      new_ar = ori.shuffle(random: Random.new(key))
      # mapping each char->ord and using its index to search parall.array
      new_doc = document.to_s.chars.map{ |d| new_ar[ori.index( d.ord )] }
      #joining all chars to implicitly return a string
      new_doc.map{ |d| d.chr }.join
    end
  end

end
