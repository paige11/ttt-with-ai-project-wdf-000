class Game
  attr_accessor :board, :player_1, :player_2

  @@wins = 0
  @@draws = 0

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1, @player_2, @board = player_1, player_2, board
    @@game = self
    @board.display
  end

  def current_player
    turn = @board.turn_count
    if turn.even?
      @player_1
    else
      @player_2
    end
  end

  def over?
    won? || draw?
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board.cells[win_index_1]
      position_2 = @board.cells[win_index_2]
      position_3 = @board.cells[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
    end
    false
  end

  def draw?
    !won? && self.board.full?
  end

  def winner
    if won?
      @board.cells[won?[0]]
    end
  end

  def turn
    puts "Please choose a position, 1-9:"
    player = current_player
    input = player.move(board)
    if @board.valid_move?(input)
      @board.update(input, player)
      @board.display
    else
      puts "That move is invalid. Choose again."
      turn
    end
  end

  def play
    until over?
      turn
    end
    if winner == "X"
      @@wins += 1
      puts "Congratulations X!"
    elsif winner == "O"
      @@wins += 1
      puts "Congratulations O!"
    else
      @@draws += 1
      puts "Cats Game!"
    end
  end

end
