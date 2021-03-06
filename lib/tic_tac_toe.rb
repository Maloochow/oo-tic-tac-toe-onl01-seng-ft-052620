require 'pry'

class TicTacToe

    # define a board at the creation of an instance.
    def initialize()
    @board = Array.new(9, " ")
    end

    # create scenarios where the instance can recognize the winner
    WIN_COMBINATIONS = [
        [0, 4, 8],
        [1, 4, 7],
        [0, 3, 6],
        [2, 4, 6],
        [2, 5, 8],
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end


    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == " " ? false : true
    end

    def valid_move?(index)
        if index < 0 || index >= 9 || position_taken?(index)
            false
        else
            true
        end
    end

    def turn
        puts "Plese enter 1 - 9"
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            move(index, self.current_player)
            self.display_board
        else puts "Sorry, that move is invalid. Please enter a new number."
            self.turn
        end
    end

    def turn_count
        turns = 0
        @board.each do |value|
        turns += 1 if value != " "
        end
        turns
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end


    def won?
        winning_pattern = nil

        WIN_COMBINATIONS.each do |pattern|
        if @board[pattern[0]] == @board[pattern[1]] && @board[pattern[0]] == @board[pattern[2]] && @board[pattern[0]] != " "
            winning_pattern = pattern
        end
        end
        winning_pattern
    end

    def full?
        (0..8).to_a.all? {|index| position_taken?(index)}
    end


    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        if won?
        @board[won?[0]]
        else nil
        end
    end

    def play
        display_board
        while !over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end

end