import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:speech_text_tutorial/speech_text_recognizer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechText extends StatefulWidget {
  const SpeechText({Key? key}) : super(key: key);

  @override
  State<SpeechText> createState() => _SpeechTextState();
}

class _SpeechTextState extends State<SpeechText> {
  String recognizedText = "Recognize text is";
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkSpeechAvailability();
  }

  _checkSpeechAvailability() async {
    isEnabled = await SpeechTextRecognizer.initialize();
    setState(() {});
  }

  _recognizedText() async {
    await SpeechTextRecognizer.startListning(speechRecogListner);
  }

  void speechRecogListner(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    recognizedText = result.recognizedWords;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Speech to Text"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            child: !SpeechTextRecognizer.isListning()
                ? const Icon(Icons.mic)
                : const Icon(Icons.stop),
            onPressed: () {
              SpeechTextRecognizer.isListning()
                  ? SpeechTextRecognizer.stopListning
                  : _recognizedText();
            }),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Speech Recognition Availability $isEnabled"),
            const SizedBox(height: 15),
            Text(
              recognizedText,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
