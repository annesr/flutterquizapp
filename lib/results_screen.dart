import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/data/questions.dart';
import 'package:quizapp/questions_summar.dart';
import 'package:quizapp/quiz.dart';

class Resultsscreen extends StatelessWidget {
  const Resultsscreen(
      {super.key, required this.chosenAnswer, required this.refreshButton});

  final List<String> chosenAnswer;
  final void Function() refreshButton;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswer.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswer[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Yaahhyy....!  You answered $numCorrectQuestions out of $numTotalQuestions correctly!',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summarydata: summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: refreshButton,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
