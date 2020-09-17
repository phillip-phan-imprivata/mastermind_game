class Computer
  #randomly generates a code
  def initialize
    @computer_code = []
    4.times do
      num = rand(1..6).to_s
      @computer_code.push(num)
    end
  end

  def check_guess(guess)
    a = 0
    b = 0

    #new array that will be modified when guess matches code digits
    unused_digits = Array.new(@computer_code)

    #turns the digits from user input into an array of strings
    arr = guess.to_s.split("")

    #if the guess matches the code, exit loop
    if arr == @computer_code
      return true
    else
      #find correct digits that are in the correct position
      arr.each_with_index do |digit, index|
        if unused_digits[index] == digit
          a += 1
          #removes the digits as from the arrays so that they won't be reused
          unused_digits[index] = "_"
          arr[index] = "_"
        end
      end
      #find correct digits that are in the wrong positions
      arr.each_with_index do |digit, index|
        if unused_digits.include?(digit) && unused_digits[index] != digit
          b += 1
          #removes digits from arrays
          unused_digits[unused_digits.index(digit)] = "_"
          arr[index] = "_"
        end
      end
    end
    #displays the results of the guess
    puts "A#{a}B#{b}"
  end
end

class Player
  def initialize(name)
    @name = name
    #generates the guess
    @computer = Computer.new
    puts "\nWelcome to Mastermind, #{@name.capitalize}! \nYour opponent has made a 4-digit code that you need to crack."
    puts "\nRules: \n1. The only possible digits are 1-6. \n2. 'A' tells you how many of your digits are correct and are in the correct position."
    puts "3. 'B' tells you how many of your digits are correct but are not in the correct position."
    puts "4. You have 12 turns to correctly guess the code!"
    puts "\nGood Luck."
    #starts the game
    play_game
  end

  def get_guess
    puts "\nGuess the code!"
    #gets user guess
    @guess = gets.chomp.to_i
    #accepts guesses that are 4-digits long and are each 1-6
    if @guess.digits.all? { |digit| (1..6).include? digit } && @guess.to_s.split("").count == 4
      return @guess
    #rejects everything else and prompts again
    else
      puts "\nThat is not a valid guess! The code is 4-digits long and each digit can only be 1-6.."
      get_guess
    end
  end

  def play_game
    #loops for 12 turns or until the player guesses correctly
    i = 12
    while i > 0
      guess = get_guess
      if @computer.check_guess(guess)
        break
      end
      i -= 1
      puts "Guesses Remaining: #{i}"
    end
    puts i == 0 ? "\nSorry, #{@name.capitalize}.. You could not crack the code.." : "\nCongratulations, #{@name.capitalize}! \nYou cracked the code!"
  end
end

puts "What is your name?"
player = gets.chomp
player = Player.new(player)