import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

const Color backgroundColor = Color.fromRGBO(34, 2, 105, 1);
const List<String> choices = ['paper', 'rock', 'scissor'];

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
    if ((user == 'rock' && computer == "scissor") ||
        (user == 'paper' && computer == 'rock') ||
        (user == 'scissor' && computer == 'paper')) {
      ++userScore;
      return GameResult.win;
    } else if ((computer == 'rock' && user == "scissor") ||
        (computer == 'paper' && user == 'rock') ||
        (computer == 'scissor' && user == 'paper')) {
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

  void playSound(int index) {
    final player = AudioPlayer();
    player.play(AssetSource('sound$index.wav'));
  }

  Expanded buildKey(int player_choiceI, String player_choiceS) {
    return Expanded(
      child: TextButton(
          onPressed: () {
            playSound(player_choiceI);
            _playGame(choices[player_choiceI]);
          },
          child: Image.asset('images/$player_choiceS.png')),
    );
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildKey(0, 'paper'),
              buildKey(1, 'rock'),
              buildKey(2, 'scissor'),
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
