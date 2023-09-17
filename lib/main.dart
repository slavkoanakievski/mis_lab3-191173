import 'package:flutter/material.dart';
import 'package:mis_lab3/model/term.dart';
import 'package:mis_lab3/widget/NewTerm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = Colors.lightBlue;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student organizer',
      theme: ThemeData(
        primarySwatch: primaryColor as MaterialColor,
        primaryColor: primaryColor,
        primaryColorLight: (primaryColor as MaterialColor)[200],
        primaryColorDark: (primaryColor as MaterialColor)[700],
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const AppSchedule(title: 'App scheduler'),
    );
  }
}

class AppSchedule extends StatefulWidget {
  const AppSchedule({super.key, required this.title});

  final String title;

  @override
  State<AppSchedule> createState() => _AppScheduleState();
}

class _AppScheduleState extends State<AppSchedule> {
  final List<Term> _terms = [
    Term(subjectName: 'MIS', examScheduled: DateTime.now()),
  ];

  String _getExamTime(DateTime dateTime) {
    String date = dateTime.toLocal().toString();
    return date;
  }

  void _addTerm() {
    showModalBottomSheet<void>(
        context: context,
        elevation: 3,
        enableDrag: true,
        showDragHandle: true,
        builder: (_) {
          return SizedBox(
            height: 400.0,
            child: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTerm(
                addTermToList: _addTermToList,
              ),
            ),
          );
        });
  }

  void _addTermToList(Term term) {
    setState(() {
      _terms.add(term);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => _addTerm(),
              icon: const Icon(Icons.add_circle_outline_sharp))
        ],
      ),
      body: _terms.isEmpty
          ? const Center(child: Text('No upcoming terms'))
          : ListView.builder(
              itemCount: _terms.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 2,
                    borderOnForeground: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            _terms.elementAt(index).subjectName,
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColorLight,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Date: ${_getExamTime(_terms.elementAt(index).examScheduled)}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ));
              },
            ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
