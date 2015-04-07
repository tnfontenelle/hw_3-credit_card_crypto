require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../aes_cipher'
require_relative '../double_trans_cipher'
require 'minitest/autorun'
require 'yaml'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020', 'Soumya Ray', 'Visa')
    @key = 35
  end

  describe 'Using Caeser cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Caeser.encrypt(@cc, @key)
      enc.wont_equal @cc.to_s
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Caeser.encrypt(@cc, @key)
      dec = SubstitutionCipher::Caeser.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end

  describe 'Using Permutation cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      enc.wont_equal @cc.to_s
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end
  describe 'Using Double Transposition cipher' do
    it 'should encrypt card information' do
      enc = DoubleTranspositionCipher.encrypt(@cc, @key)
      enc.wont_equal @cc.to_s
    end

    it 'should decrypt text' do
      enc = DoubleTranspositionCipher.encrypt(@cc, @key)
      dec = DoubleTranspositionCipher.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end

    it 'should have card info to encrypt' do
      @cc.to_s.wont_equal ''
    end
  end
  #describe 'Using Aes cipher' do
  #  it 'should encrypt card information' do
  #    enc = AesCipher.encrypt(@cc, @key)
  #    enc.wont_equal @cc.to_s
  #  end

  #  it 'should decrypt text' do
  #    enc = AesCipher.encrypt(@cc, @key)
  #    dec = AesCipher.decrypt(enc, @key)
  #    dec.must_equal @cc.to_s
  #  end
  #end
end
