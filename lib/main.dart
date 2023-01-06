import 'package:flutter/material.dart';
import 'Board.dart';
void main() => runApp(MaterialApp(
  home: TicTacToe(),
));

Board b = Board();
int score1 = 0, score2 = 0;
int turn = 0;
int vict = 0;
Set<int> filled = Set();
Set<int> won = Set();

class TicTacToe extends StatefulWidget {

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

Widget buildPlayer(String name)
{
  return Container(height: 50.0, width: 170.0, decoration: BoxDecoration(
      color: Colors.pink[700],
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(100.0),
        bottomRight: Radius.circular(100.0),
        topLeft: Radius.circular(100.0),
        topRight: Radius.circular(100.0),

      )),child: Center(child:Text('${name}',style:TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,color:Colors.white))));
}

Widget buildPlayerScore(int score){
  return Container(
      height: 40.0, width: 45.0, child: Center(child:Text('$score',style:TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold , color:Colors.white))));
}

Widget gameStatus(String status){
  return Stack(
    children: <Widget>[
      // Stroked text as border.
      Text(
        '$status',
        style: TextStyle(
            fontSize: 40,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = Colors.pink
        ),
      ),
      // Solid text as fill.
      Text(
        '$status',
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
        ),
      ),
    ],
  );
}

Widget boardStatus(int index){
      return Container(color: turn==2?(won.contains(index)?Colors.pink[600]:Colors.indigo[900]):Colors.indigo[900],
          child:Center(child:Stack(
            children: <Widget>[
              // Stroked text as border
              // Solid text as fill.
              Text(
                '${b.board[(index/3).toInt()][index%3]}',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ],
          )));
}

class _TicTacToeState extends State<TicTacToe> {

  void update(int index, String char){
    setState((){
      if(!filled.contains(index)) {
        if (char == 'X') {
          (b.board as List<List<String>>)[(index / 3).toInt()][index %
              3] = char;
          turn = 1;
          filled.add(index);
          for (int i = 0; i < 3; i++) {
            if (b.board[i][0] == char && b.board[i][1] == char &&
                b.board[i][2] == char) {
              won.add(i * 3 + 0);
              won.add(i * 3 + 1);
              won.add(i * 3 + 2);
              score1++;
              turn = 2;
              vict = 1;
              break;
            }

            if (b.board[0][i] == char && b.board[1][i] == char &&
                b.board[2][i] == char) {
              won.add(i);
              won.add(3 + i);
              won.add(6 + i);
              score1++;
              turn = 2;
              vict = 1;
              break;
            }
          }
          if (won.isEmpty) {
            if (b.board[0][0] == char && b.board[1][1] == char &&
                b.board[2][2] == char) {
              won.add(0);
              won.add(4);
              won.add(8);
              score1++;
              turn = 2;
              vict = 1;
            }
            else if (b.board[0][2] == char && b.board[1][1] == char &&
                b.board[2][0] == char) {
              won.add(2);
              won.add(4);
              won.add(6);
              score1++;
              turn = 2;
              vict = 1;
            }
          }
          if (filled.length == 9 && vict == 0) {
            turn = 2;
            vict = 3;
          }
        }
        else
          {
            (b.board as List<List<String>>)[(index / 3).toInt()][index %
                3] = 'O';
            turn = 0;
            filled.add(index);
            for(int i=0; i<3; i++)
            {
              if(b.board[i][0] ==char && b.board[i][1]==char && b.board[i][2]==char) {
                won.add(i*3+0);
                won.add(i*3+1);
                won.add(i*3+2);
                score2++;
                turn = 2;
                vict = 2;
                break;
              }

              if(b.board[0][i] ==char && b.board[1][i]==char && b.board[2][i]==char) {
                won.add(i);
                won.add(3+i);
                won.add(6+i);
                score2++;
                vict = 2;
                turn = 2;
                break;
              }
            }
            if(won.isEmpty)
            {
              if(b.board[0][0] ==char && b.board[1][1]==char && b.board[2][2]==char)
              {
                won.add(0);
                won.add(4);
                won.add(8);
                turn = 2;
                vict = 2;
                score2++;
              }
              else if(b.board[0][2] ==char && b.board[1][1]==char && b.board[2][0]==char)
              {
                won.add(2);
                won.add(4);
                won.add(6);
                turn = 2;
                vict = 2;
                score2++;
              }
            }
            if(filled.length==9 && vict == 0)
            {
              turn = 2;
              vict = 3;
            }
          }
      }
    });
  }

  void clear(){
    setState(() {
      filled.clear();
      turn = 0;
      for(int i=0; i<3; i++)
      {
        for(int j=0; j<3; j++)
        {
          b.board[i][j] = '';
        }
      }
      won.clear();
      vict = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Column(
          children:<Widget>[
            SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:<Widget>[
                buildPlayer('PLAYER-X'),
                buildPlayer('PLAYER-O'),
              ],
            ),
            SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:<Widget>[
                buildPlayerScore(score1),
                buildPlayerScore(score2),
              ],
            ),
            Expanded(
              flex: 4,
              child:Center(
                child: Padding(
                  padding: EdgeInsets.only(left:30.0,right:30.0),
                  child: GridView(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    shrinkWrap:true,
                    // Generate 100 widgets that display their index in the List.
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      crossAxisCount: 3,
                    ),
                    children: turn == 0 ? List.generate(9, (index) => GestureDetector(
                        onTap: (){
                          update(index,'X');
                        },
                        child: boardStatus(index))): turn == 1 ? List.generate(9, (index) => GestureDetector(
                        onTap: (){
                          update(index,'O');
                        },
                        child: boardStatus(index))) : List.generate(9, (index) => boardStatus(index)),
                  ),
                ),
              ),
            ),
            turn==2? vict==1? gameStatus('PLAYER-X WON'):vict==2? gameStatus('PLAYER-O WON'): gameStatus('DRAW'): Text(''),
            SizedBox(height:20.0),
            Expanded(
              child: Container(
                  child: ElevatedButton(
                    onPressed: (){
                      clear();
                    },
                    child:Text("REPLAY",style:TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    )),
                    style: ElevatedButton.styleFrom(shape: CircleBorder()),
                  )
              ),
            ),
            SizedBox(height:10.0)
          ],
        ),
      ),
    );
  }
}