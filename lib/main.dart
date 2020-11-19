import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Quizbrain quizbrain = Quizbrain();
void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan[900],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizePage(),
          ),
        ),
      ),
    );
  }
}

class QuizePage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizePage> {
  List<Icon> scorkeepr = [];
  int questionsnum = 0;

  // TODO: checkanswer
  void checkanswer(bool pickAnswer) {
    bool corectanswer = quizbrain.questionBank[questionsnum].questionAnswer;

    // quizbrain.questionBank[questionsnum].questionAnswer;

    setState(() {
      if (corectanswer == pickAnswer) {
        scorkeepr.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scorkeepr.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      if (questionsnum < quizbrain.questionBank.length - 1) {
        questionsnum++;
      } else {
        Alert(
          context: context,
          type: AlertType.success,
          title: "QUIZZLER",
          desc: "END.",
          buttons: [
            DialogButton(
              child: Text(
                "COOL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Quizzler()),
                );
              },
              width: 120,
            )
          ],
        ).show();
      }
    });
  }

//   List<String> questions = [
//     'You can lead a cow down stairs but not up stairs.',
//     'Approximately one quarter of human bones are in the feet.',
//     'A slug\'s blood is green.'
//   ];
  // List<bool> answers = [false, true, true];

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  // quizbrain.questionBank[questionsnum].questionText;
                  quizbrain.questionBank[questionsnum].questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                  "True",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  checkanswer(true);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text(
                  "False",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  checkanswer(false);
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Row(
              children: scorkeepr,
            ),
          )
        ]);
  }
}

// question1: 'You can lead a cow down stairs but not up stairs.', false,
// question2: 'Approximately one quarter of human bones are in the feet.', true,
// question3: 'A slug\'s blood is green.', true,
