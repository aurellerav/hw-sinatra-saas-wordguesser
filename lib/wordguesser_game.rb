class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  def guess(letter)
    if letter.nil? || letter.empty? || letter !~ /^[a-zA-Z]$/
    raise ArgumentError
    end
    letter = letter.downcase
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
    return false
    end
    if @word.include?(letter)
    @guesses += letter
    else
    @wrong_guesses += letter
  end
  true
  end
  def word_with_guesses
  @word.chars.map do |letter|
    if @guesses.include?(letter)
    letter
    else
    '-'
    end
  end.join
  end
  def check_win_or_lose
  if word_with_guesses== @word
    :win
  elsif @wrong_guesses.length >= 7
    :lose
  else
    :play
  end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord')
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      response = http.get(uri.path)
      return response.body.scan(/<div>(.+?)<\/div>/).flatten.first
    end
  end
end
