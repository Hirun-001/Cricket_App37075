import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const CricketScoreApp());

class CricketScoreApp extends StatelessWidget {
  const CricketScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cricket Score',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101820),
        useMaterial3: true,
      ),
      home: const ScoreScreen(),
    );
  }
}

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  int runs = 0;
  int balls = 0;
  String lastResult = 'Ready to Bat';
  final Random random = Random();

  void playBall() {
    if (balls == 6) return;
    final score = random.nextInt(7);

    setState(() {
      runs += score;
      balls++;
      if (score == 0) {
        lastResult = 'No Runs';
      } else if (score == 1) {
        lastResult = '1 Run';
      } else {
        lastResult = '$score Runs';
      }
    });
  }

  void restartGame() {
    setState(() {
      runs = 0;
      balls = 0;
      lastResult = 'Ready to Bat';
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameFinished = balls == 6;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CRICKET SCORE',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF17232C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'CURRENT SCORE',
              style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF1B2A34),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.4)),
              ),
              child: Column(
                children: [
                  Text(
                    '$runs',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  const Text(
                    'RUNS',
                    style: TextStyle(fontSize: 15, letterSpacing: 3, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < balls
                        ? Colors.greenAccent
                        : const Color(0xFF293943),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: index < balls ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoCard('BALLS', '$balls / 6', Icons.sports_baseball),
                _infoCard('RESULT', lastResult, Icons.scoreboard),
              ],
            ),
            const Spacer(),
            Text(
              gameFinished ? 'INNINGS COMPLETE' : lastResult,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: gameFinished ? Colors.redAccent : Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: gameFinished ? restartGame : playBall,
                icon: Icon(gameFinished ? Icons.refresh : Icons.sports_cricket),
                label: Text(
                  gameFinished ? 'RESTART' : 'BAT',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: gameFinished ? Colors.redAccent : Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon) {
    return Container(
      width: 145,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2A34),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.greenAccent, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 11, letterSpacing: 1.5, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
