import 'package:flutter/material.dart';
import 'dart:math';

const Color backgroundColor = Color.fromRGBO(34, 2, 105, 1);
const List<String> choices = ['rock', 'paper', 'scissors'];

enum GameResult { win, lose, draw }

void main() {
  runApp(
    MaterialApp(
      home: GamePage(),
    ),
  );
}

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String userChoice = '';
  String computerChoice = '';
  int userScore = 0;
  int computerScore = 0;
  GameResult gameResult = GameResult.draw;

  String computerChoiceGenerator() {
    int index = Random().nextInt(3);
    computerChoice = choices[index];
    return computerChoice;
  }

  // false => the user lost , true => user won
  GameResult checkWinner(String user, String computer) {
    if ((user == 'rock' && computer == "scissors") ||
        (user == 'paper' && computer == 'rock') ||
        (user == 'scissors' && computer == 'paper')) {
      ++userScore;
      return GameResult.win;
    } else if ((computer == 'rock' && user == "scissors") ||
        (computer == 'paper' && user == 'rock') ||
        (computer == 'scissors' && user == 'paper')) {
      ++computerScore;
      return GameResult.lose;
    } else {
      return GameResult.draw;
    }
  }

  void _playGame(String user) {
    setState(() {
      userChoice = user;
      computerChoice = computerChoiceGenerator();
      gameResult = checkWinner(userChoice, computerChoice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Rock - Paper - Scissors",
          style:
              TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[400],
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    onPressed: () {
                      _playGame(choices[0]);
                    },
                    child: Image.asset('images/rock.png')),
              ),
              Expanded(
                  child: TextButton(
                      onPressed: () {
                        _playGame(choices[1]);
                      },
                      child: Image.asset('images/paper.png'))),
              Expanded(
                  child: TextButton(
                      onPressed: () {
                        _playGame(choices[2]);
                      },
                      child: Image.asset('images/scissor.png'))),
            ],
          ),
          Column(
            children: [
              Text(
                'PLAYER : $userChoice',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                'Computer : $computerChoice',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 50),
              Text(
                gameResult == GameResult.win
                    ? "YOU WIN !!"
                    : gameResult == GameResult.lose
                        ? "YOU LOSE :("
                        : "IT'S A DRAW !!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: gameResult == GameResult.win
                      ? Colors.green
                      : gameResult == GameResult.lose
                          ? Colors.red
                          : Colors.white,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "User score : $userScore",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                "Computer score : $computerScore",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
