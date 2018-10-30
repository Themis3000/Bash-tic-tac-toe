#!/bin/bash

#sets up the programs vars
function setup()
{
  #assigns all squares to a number from 1 to 9 (where var is squares)
  for value in {1..9}; do
    var[${value}]=${value}
  done
  gameRunning=true
  turn=X
  echo "Game start!"
  update
}

#updates the game board (what you see)
function update()
{
  echo
  echo
  echo " ${var[1]} | ${var[2]} | ${var[3]} "
  echo "---|---|---"
  echo " ${var[4]} | ${var[5]} | ${var[6]} "
  echo "---|---|---"
  echo " ${var[7]} | ${var[8]} | ${var[9]} "
}

#sets a square to its requested value
function set()
{
  #checks if turn is already taken
  if [ "${var[${1}]}" = "${1}" ]; then
    var[${1}]="${turn}"
    #switches who's turn it is (the var it is passing indicates that it wants to check if their is a winning condition before switching turns)
    turnCount $2
  else
    echo "that square has already been taken"
  fi
  update
}

#switches who's turn it is
function turnCount()
{
  checks if it should check is their is a winning condition before swapping turns
  if [ "${1}" = "true" ]; then
    winDetect
  fi
  #switches who's turn it is
  if [ "${turn}" = "X" ]; then
    turn=O
  elif [ "${turn}" = "O" ]; then
    turn=X
  fi
}

#checks if the board is in a winning condition for the current players turn
function winDetect()
{
  #condenced the amount of "or's" needed using the magic of math and for loops
  for value in {1..3}; do
    if [[ ${var[$[((value-1))*3+1]]} = ${turn} && ${var[ $[((value-1))*3+2]]} = ${turn} && ${var[$[((value-1))*3+3]]} = ${turn} ]] || [[ ${var[$[value]]} = ${turn} && ${var[$[value+3]]} = ${turn} && ${var[$[value+6]]} = ${turn} ]] || [[ ${var[1]} = ${turn}  &&  ${var[5]} = ${turn}  &&  ${var[9]} = ${turn} ]] || [[ ${var[3]} = ${turn}  &&  ${var[5]} = ${turn}  &&  ${var[7]} = ${turn} ]]; then
      echo "player ${turn} has won!"
      #stops the game
      gameRunning=false
    fi
  done
}

function start()
{
  setup
while [ ${gameRunning} = true ]; do
#reads user input
read -rsn1 input
#checks if the user inputed the key 1 - 9
for value in {1..9}; do
  if [ "${input}" = "${value}" ]; then
    #the value it is passing indicates that it wants to check if their is a winning condition before switching turns
    set ${value} true
  fi
done
done
}

#starts the whole shzam
start
