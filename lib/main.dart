import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _bmi = 0;
  String _message = "";

  void _calculateBMI() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
        if (_bmi < 18.5) {
          _message = "Underweight";
        } else if (_bmi >= 18.5 && _bmi < 24.9) {
          _message = "Normal weight";
        } else if (_bmi >= 25 && _bmi < 29.9) {
          _message = "Overweight";
        } else {
          _message = "Obesity";
        }
      });
    } else {
      setState(() {
        _message = "Please enter valid values!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Height (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: const Text("Calculate BMI"),
            ),
            const SizedBox(height: 16),
            if (_bmi > 0)
              Column(
                children: [
                  Text(
                    "Your BMI: ${_bmi.toStringAsFixed(1)}",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _message,
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 10,
                        maximum: 40,
                        ranges: <GaugeRange>[
                          GaugeRange(
                            startValue: 10,
                            endValue: 18.5,
                            color: Colors.blue,
                            label: 'Underweight',
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.15,
                            endWidth: 0.15,
                          ),
                          GaugeRange(
                            startValue: 18.5,
                            endValue: 24.9,
                            color: Colors.green,
                            label: 'Normal',
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.15,
                            endWidth: 0.15,
                          ),
                          GaugeRange(
                            startValue: 24.9,
                            endValue: 29.9,
                            color: Colors.orange,
                            label: 'Overweight',
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.15,
                            endWidth: 0.15,
                          ),
                          GaugeRange(
                            startValue: 29.9,
                            endValue: 40,
                            color: Colors.red,
                            label: 'Obesity',
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.15,
                            endWidth: 0.15,
                          ),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value: _bmi,
                            needleColor: Colors.black,
                            knobStyle: const KnobStyle(color: Colors.black),
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Text(
                              _bmi > 0 ? _bmi.toStringAsFixed(1) : '',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.8, // Mengatur posisi angka agar lebih jauh dari jarum
                          ),
                        ],
                        axisLabelStyle: const GaugeTextStyle(fontSize: 12), // Ukuran angka skala
                        interval: 5, // Jarak antar skala
                      ),
                    ],
                  )

                ],
              ),
          ],
        ),
      ),
    );
  }
}
