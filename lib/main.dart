import 'package:flutter/material.dart';
import 'package:number_to_word_arabic/number_to_word_arabic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _displayValue = '';

  void _showValue() {
    setState(() {
      String inputText = _controller.text;
      // Convert the input text to a double
      double? number = double.tryParse(inputText);
      // Use the Tafqeet.convert method if the number is valid
      if (number != null) {
        // Split the number into whole and decimal parts
        int wholePart = number.toInt();
        int decimalPart = ((number - wholePart) * 100).round(); // Get two decimal places

        // Convert whole and decimal parts to Arabic words
        String wholePartArabic = Tafqeet.convert(wholePart.toString());
        String decimalPartArabic = ' و '+Tafqeet.convert(decimalPart.toString())+' مليم ';

        // Construct the display value
        _displayValue = '$wholePartArabic  دينار  $decimalPartArabic ';
      } else {
        _displayValue = 'Please enter a valid number';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a number',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true), // Allow decimal input
            ),
            const SizedBox(height: 20), // Space between input and button
            ElevatedButton(
              onPressed: _showValue,
              child: const Text('Show Value in Arabic'),
            ),
            const SizedBox(height: 20), // Space between button and displayed value
            Text(
              _displayValue,
              style: const TextStyle(fontSize: 24),
              textDirection: TextDirection.rtl, // Set text direction to right-to-left
            ),
          ],
        ),
      ),
    );
  }
}
