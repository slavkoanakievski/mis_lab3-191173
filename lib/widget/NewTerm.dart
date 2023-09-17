import 'package:flutter/material.dart';
import 'package:mis_lab3/model/term.dart';
import 'package:date_time_picker/date_time_picker.dart';

class NewTerm extends StatefulWidget {
  final void Function(Term) addTermToList;

  const NewTerm({super.key, required this.addTermToList});

  @override
  State<NewTerm> createState() => _NewTermState();
}

class _NewTermState extends State<NewTerm> {
  final _subjectNameController = TextEditingController();
  final _examDateTimeController = TextEditingController();

  String subjectName = '';
  DateTime examDateTime = DateTime.now();

  void _submitData() {
    final String subjectNameInserted;
    final DateTime examDateTimeInserted;

    if (_subjectNameController.text.isEmpty ||
        _examDateTimeController.text.isEmpty) {
      return;
    }

    subjectNameInserted = _subjectNameController.text;
    examDateTimeInserted = DateTime.parse(_examDateTimeController.text);

    Term newTerm = Term(
        subjectName: subjectNameInserted, examScheduled: examDateTimeInserted);

    widget.addTermToList(newTerm);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(top: 0, left: 50, right: 50, bottom: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _subjectNameController,
                decoration: const InputDecoration(labelText: 'Subject Name'),
                onSubmitted: (_) => _submitData,
              ),
              DateTimePicker(
                controller: _examDateTimeController,
                type: DateTimePickerType.dateTime,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: _submitData, child: const Text("Submit")),
              )
            ],
          ),
        ));
  }
}
