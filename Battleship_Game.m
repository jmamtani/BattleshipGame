clc
clear

warning(‘off’,’all’)

battleship = simpleGameEngine(‘Battleship1.png’, 84,84);

% initializing all the sprites required for the game

blank_sprite = 1;
water_sprite = 2;
left_ship_sprite = 3;
horiz_ship_sprite = 4;
right_ship_sprite = 5;
top_ship_sprite = 6;
vert_ship_sprite = 7;
bot_ship_sprite = 8;
hit_sprite = 9;
miss_sprite = 10;
water_sprite1 = 11;

%setting up the board for the players and loading them with the water sprite on each side divided by blank sprite

%to show the 2 areas for player 1 and 2 respectively

board(1:10,1:21) = 2;

board(:,11) = 1;

drawScene(battleship, board)

%using m and z as variables to store the ships postion which can be retrived later while attacking to show miss or hit
m = 0;
z = 0;

%initialise play_again as 1
play_again = 1;

%infinite while loop to play the game as many times as required

%%taking player 1 inputs for the placement of ships

while play_again == 1

%using confirm variables to ask user to confirm the set positions of their ships
confirm = 0;

drawScene(battleship, board)
while confirm == 0
m = 0;
position = [0,0];
for l = 1:3
fprintf(‘\n\nPlace your ships on the left side of the board, PLayer 1’)
fprintf(‘\n\nMake each ship 4 units long’)

fprintf(‘\n\nDo not overlap your ships!’)

%asking user if he wants to place ship horizontally or vertically
choice = input(“\n\nIf its horizontal enter ‘1’ and if its vertical enter ‘2’: “);
if choice == 1
fprintf(‘\nPlace the ships left to right.’)
elseif choice == 2
fprintf(‘\nPlace the ships top to bottom.’)
end

%using getMouseInput to capture the row and columns selected by the user as th initial and final position
[y,x] = getMouseInput(battleship);
[y1,x1] = getMouseInput(battleship);

%for horizantal placement we will use the left and right ship sprite filled with the horizontal ship sprite in between

if choice == 1
board(y,x) = left_ship_sprite;
board(y,x+1:x1-1) = horiz_ship_sprite;
board(y1,x1) = right_ship_sprite;

%for vertical placement we will use the top and bottom ship sprite filled with the vertical ship sprite in between
elseif choice == 2
board(y,x) = top_ship_sprite;
board(y+1:y1-1,x) = vert_ship_sprite;
board(y1,x1) = bot_ship_sprite;

end

%storing the position of the ships
drawScene(battleship, board)
position(m+1, 1) = y;
position(m+1, 2) = x;
m = m+1;
position(m+1, 1) = y1;
position(m+1, 2) = x1;
m = m+1;

end

%confirming user placements if not accepted the board will reset and the user can place the ships again
confirm = input(“\n\nIf you accept theese placements type ‘1’ if you dont type ‘0’: “);
board(1:10,1:21) = 2;
board(:,11) = 1;
drawScene(battleship, board)
end

 

%using confirm variables to ask user to confirm the set positions of their ships
confirm1 = 0;
board(1:10,1:21) = 2;
board(:,11) = 1;
drawScene(battleship, board)
while confirm1 == 0
position1 = [0,0];
z = 0;
for n = 1:3
fprintf(‘\n\nPlace your ships on the left side of the board, PLayer 2’)
fprintf(‘\n\nMake each ship 4 units long’)

fprintf(‘\n\nDo not overlap your ships!’)

%asking user if he wants to place ship horizontally or vertically
choice1 = input(“\n\nIf its horizontal enter ‘1’ and if its vertical enter ‘2’: “);
if choice1 == 1
fprintf(‘\nPlace the ships left to right.’)
elseif choice1 == 2
fprintf(‘\nPlace the ships top to bottom.’)
end

%using getMouseInput to capture the row and columns selected by the user as th initial and final position
[k,h] = getMouseInput(battleship);
[k1,h1] = getMouseInput(battleship);

%for horizantal placement we will use the left and right ship sprite filled with the horizontal ship sprite in between
if choice1 == 1
board(k,h) = left_ship_sprite;
board(k,h+1:h1-1) = horiz_ship_sprite;
board(k1,h1) = right_ship_sprite;

%for vertical placement we will use the top and bottom ship sprite filled with the vertical ship sprite in between
elseif choice1 == 2
board(k,h) = top_ship_sprite;
board(k+1:k1-1,h) = vert_ship_sprite;
board(k1,h1) = bot_ship_sprite;

end

%storing the position of the ships
drawScene(battleship, board)
position1(z+1, 1) = k;
position1(z+1, 2) = h;
z = z+1;
position1(z+1, 1) = k1;
position1(z+1, 2) = h1;
z = z+1;
end

%confirming user placements if not accepted the board will reset and the user can place the ships again
confirm1 = input(“\n\nIf you accept theese placements type ‘1’ if you dont type ‘0’: “);
board(1:10,1:21) = 2;
board(:,11) = 1;
drawScene(battleship, board)
end

%%targeting the opponent

title(‘Player 1 vs Player 2, Player 1 Start!’)
drawScene(battleship,board)

%overlapping the ships position with sprite 11 for player 1 and sprite 13 for player 2 where sprite 11 and sprite 12 are replicas of

%the water sprite but by overlapping them we made an algorithm to identify the winner by checking if any of the sprites 11 or

%13 are remaining on the board and changing the sprite 11 and 13 to hit sprite when clicked and the water sprite to miss sprite

board(position(1,1):position(2,1),position(1,2):position(2,2)) = 11;
board(position1(1,1):position1(2,1),position1(1,2):position1(2,2)) = 13;
board(position(3,1):position(4,1),position(3,2):position(4,2)) = 11;
board(position(5,1):position(6,1),position(5,2):position(6,2)) = 11;
board(position1(3,1):position1(4,1),position1(3,2):position1(4,2)) = 13;
board(position1(5,1):position1(6,1),position1(5,2):position1(6,2)) = 13;

%while loop when when both the players have at least 1 sprite of their ship remaining in the board
while ismember(11, board) == 1 && ismember(13, board) == 1
[r,c] = getMouseInput(battleship);

%changing the sprite 11 and 13 to hit sprite when clicked and the water sprite to miss sprite if missed the ship

if board(r,c) == 11
board(r,c) = hit_sprite;
elseif board(r,c) == 13
board(r,c) = hit_sprite;
else
board(r,c) = miss_sprite;
end
title(“Next Player’s Turn”)
drawScene(battleship,board)
end

%declaring the winner on the board

%using function check_board explained below
winner = check_board(board);

title(winner)
drawScene(battleship,board)

%asking user to play the game again
play_again = input(“\nIf you want to play again type ‘1’ if you dont type ‘0’: “);
end

fprintf(‘\n\nThank you for playing the Battleship Game by Team Swaziland!’)