import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flip_card/flip_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Moussa app',
          style: GoogleFonts.pacifico(),
        )),
        backgroundColor: Colors.red,
      ),
      body: DicePage(),
    ),
  ));
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  var leftDiceNumber = 2, rightDiceNumber = 5;
  double score1 = 0.0, score2 = 0.0;
  int nombre1 = 0, nombre2 = 0;
  void changeValue() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  double score(int i) {
    return (i * 100) / 4;
  }

  void resultats() {
    if ((nombre1 == 3) && (nombre2 == 3) && (score1 > score2)) {
      Alert(
              context: context,
              title: "FIN",
              desc: "VOUS AVEZ GAGNER AVEC $score1")
          .show();
      setState(() {
        nombre1 = 0;
        nombre2 = 0;
      });
    } else {
      if ((nombre1 == 3) && (nombre2 == 3) && (score1 < score2)) {
        Alert(
                context: context,
                title: "FIN",
                desc: "VOUS AVEZ GAGNER AVEC $score2")
            .show();
        setState(() {
          nombre1 = 0;
          nombre2 = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 40.0,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$score1',
                    style: GoogleFonts.pacifico(
                        textStyle:
                            TextStyle(color: Colors.white70, fontSize: 40.0)),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$score2',
                    style: GoogleFonts.pacifico(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 40.0)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 180.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    changeValue();
                    setState(() {
                      score1 += score(leftDiceNumber) + score(rightDiceNumber);
                      nombre1++;
                      resultats();
                    });
                  },
                  child: Image.asset('images/dice$leftDiceNumber.png'),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    changeValue();
                    setState(() {
                      score2 += score(leftDiceNumber) + score(rightDiceNumber);
                      nombre2++;
                      resultats();
                    });
                  },
                  child: Image.asset('images/dice$rightDiceNumber.png'),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: FlatButton(
              color: Colors.green,
              onPressed: () {
                setState(() {
                  score2 = 0;
                  score1 = 0;
                  nombre2 = 0;
                  nombre1 = 0;
                });
              },
              child: Text(
                'Recommencer',
                style: GoogleFonts.pacifico(),
              ),
            ),
          ),
          SizedBox(
            height: 70.0,
          )
        ],
      ),
    );
  }
}
