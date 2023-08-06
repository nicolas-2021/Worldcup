#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games, teams;")
echo $($PSQL "INSERT INTO teams (name) VALUES ('France'),('Croatia'),('Belgium'),('England'),('Russia'),('Sweden'),('Brazil'),
('Uruguay'),('Colombia'),('Switzerland'),('Japan'),('Mexico'),('Denmark'),('Spain'),('Portugal'),('Argentina'),('Germany'),('Netherlands'),
('Costa Rica'),('Chile'),('Nigeria'),('Algeria'),('Greece'),('United States');")
cat games.csv|while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS
do
if [[ $YEAR!='year' ]]
then
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
if [[ -z $WINNER_ID ]]
then
WINNER_ID=null
fi
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
if [[ -z $OPPONENT ]]
then
OPPONENT_ID=null
fi
INSERT_GAME_RESULT=$($PSQL "INSERT INTO games (year,round,winner_id,opponent_id,winner_goals,opponent_goals)
VALUES ($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$W_GOALS,$O_GOALS);")
if [[ $INSERT_GAME_RESULT="INSERT 0 1" ]]
then
echo Se inserto un game
fi
fi
done

