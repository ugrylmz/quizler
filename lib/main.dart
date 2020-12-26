import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
void main() => runApp(Quizler());

class Quizler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent.shade400,
        body: SafeArea(
          child:Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}
_onAlertButtonsPressed(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "FINISHED",
    desc: "The Quiz Was Finished",
    buttons: [
      DialogButton(
        child: Text(
          "Close",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => {
          Navigator.pop(context),

        },
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}




class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  QuizBrain quizBrain = QuizBrain();
  void reset(){
    scoreKeeper = [];
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex:5,
          child:Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style:TextStyle(color: Colors.white,fontSize: 35.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color:Colors.green,
              child: Text('True',style: TextStyle(color: Colors.white,fontSize: 20.0,),),
              onPressed: () {
                if(quizBrain.getQuestionIndex() == quizBrain.getQuestionBankLength()-1){
                  _onAlertButtonsPressed(context);
                  reset();
                }

                setState(() {
                  quizBrain.nextQuestion();
                  quizBrain.getCorrectAnswer() == true ? scoreKeeper.add(Icon(Icons.check,color: Colors.greenAccent.shade100,)) :scoreKeeper.add(Icon(Icons.close,color: Colors.redAccent,),);
                });

              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FlatButton(
              color:Colors.redAccent.shade700,
              child: Text('False',style: TextStyle(color: Colors.white,fontSize: 20.0,),),
              onPressed: () {
                if(quizBrain.getQuestionIndex() == quizBrain.getQuestionBankLength()-1){
                  _onAlertButtonsPressed(context);
                  reset();
                }
                setState(() {
                 quizBrain.nextQuestion();
                 quizBrain.getCorrectAnswer() == false ? scoreKeeper.add(Icon(Icons.check,color: Colors.greenAccent.shade100,)) :scoreKeeper.add(Icon(Icons.close,color: Colors.redAccent,),);
                });

              },

            ),
          ),
        ),
        Wrap(
            direction: Axis.horizontal,
            children: [...scoreKeeper],

        ),
      ],

    );
  }
}