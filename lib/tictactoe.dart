import 'package:flutter/material.dart';

void main() => runApp(TicTacToeApp());

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> board;
  String currentPlayer;
  String winner;

  @override
  void initState() {
    super.initState();
    resetBoard();
  }

  void resetBoard() {
    board = List.generate(3, (i) => List.generate(3, (j) => '');
    currentPlayer = 'X';
    winner = null;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && winner == null) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWinner(row, col)) {
          winner = currentPlayer;
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool checkWinner(int row, int col) {
    // Check rows
    if (board[row][0] == currentPlayer &&
        board[row][1] == currentPlayer &&
        board[row][2] == currentPlayer) {
      return true;
    }
    // Check columns
    if (board[0][col] == currentPlayer &&
        board[1][col] == currentPlayer &&
        board[2][col] == currentPlayer) {
      return true;
    }
    // Check diagonals
    if (row == col &&
        board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer) {
      return true;
    }
    if (row + col == 2 &&
        board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer) {
      return true;
    }
    return false;
  }

  Widget buildGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        int row = index ~/ 3;
        int col = index % 3;
        return GestureDetector(
          onTap: () {
            makeMove(row, col);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                board[row][col],
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (winner != null)
            Text('Winner: $winner', style: TextStyle(fontSize: 30)),
          buildGrid(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                resetBoard();
              });
            },
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }
}
