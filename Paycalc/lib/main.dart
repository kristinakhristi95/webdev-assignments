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
        scaffoldBackgroundColor: Colors.lightBlue[50],
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final _formKey = GlobalKey<FormState>();

  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;

  void calculatePay() {
    if (_formKey.currentState!.validate()) {
      final double hoursWorked = double.parse(hoursController.text);
      final double hourlyRate = double.parse(rateController.text);

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
  }

  String? validateHours(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the number of hours worked';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (double.parse(value) <= 0) {
      return 'Hours worked must be greater than 0';
    }
    return null;
  }

  String? validateRate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the hourly rate';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (double.parse(value) <= 0) {
      return 'Hourly rate must be greater than 0';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Calculator'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: hoursController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Number of Hours Worked',
                        border: OutlineInputBorder(),
                      ),
                      validator: validateHours,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: rateController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Hourly Rate',
                        border: OutlineInputBorder(),
                      ),
                      validator: validateRate,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: calculatePay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 210, 210, 25),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      ),
                      child: const Text('Calculate Payment', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                    Text('Regular Pay: \$${regularPay.toStringAsFixed(2)}'),
                    Text('Overtime Pay: \$${overtimePay.toStringAsFixed(2)}'),
                    Text('Total Pay (before tax): \$${totalPay.toStringAsFixed(2)}'),
                    Text('Tax: \$${tax.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
