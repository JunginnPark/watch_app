import 'package:flutter/material.dart';

import '../models/calendar.dart';

class CalendarTestScreen extends StatefulWidget {
  const CalendarTestScreen({Key? key}) : super(key: key);

  @override
  State<CalendarTestScreen> createState() => _CalendarTestScreenState();
}

class _CalendarTestScreenState extends State<CalendarTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Test'),
      ),
      body: Container(
        child: CalendarModel(),
      ),
    );
  }
}
