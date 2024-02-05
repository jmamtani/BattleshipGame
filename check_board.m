function [winner] = check_board(board)
%this will check when either of the players sprite on the board is remaing, whichevers players sprite is remaing will be the winner

%and thar will be displayed in the source code
if ismember(11, board) == 1
winner = (‘Player 1 won’);
elseif ismember(13, board) == 1
winner = (‘Player 2 won’);
end

end

