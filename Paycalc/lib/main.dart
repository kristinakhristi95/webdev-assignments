import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hello World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;

  void calculatePay() {
    final double hoursWorked = double.tryParse(hoursController.text) ?? 0.0;
    final double hourlyRate = double.tryParse(rateController.text) ?? 0.0;

    if (hoursWorked <= 40) {
      regularPay = hoursWorked * hourlyRate;
      overtimePay = 0.0;
    } else {
      regularPay = 40 * hourlyRate;
      overtimePay = (hoursWorked - 40) * hourlyRate * 1.5;
    }

    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Part: Input and Calculation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: hoursController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Number of Hours Worked',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: rateController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Hourly Rate',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: calculatePay,
                    child: const Text('Calculate Payment'),
                  ),
                  const SizedBox(height: 16),
                  Text('Regular Pay: \$${regularPay.toStringAsFixed(2)}'),
                  Text('Overtime Pay: \$${overtimePay.toStringAsFixed(2)}'),
                  Text(
                      'Total Pay (before tax): \$${totalPay.toStringAsFixed(2)}'),
                  Text('Tax: \$${tax.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
