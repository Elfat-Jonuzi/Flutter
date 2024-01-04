import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData.dark(),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> _tasks = [];
  List<bool> _completedTasks = [];
  TextEditingController _taskController = TextEditingController();

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
      _completedTasks.add(false);
    });
    _taskController.clear();
  }

  void _toggleTask(int index) {
    if (!_completedTasks[index]) {
      setState(() {
        _tasks[index] = '✅ ' + _tasks[index];
        _completedTasks[index] = true;
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _completedTasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List App'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Aggiungi un testo',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      _addTask(_taskController.text);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_tasks[index]),
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                  ),
                  onDismissed: (direction) {
                    _deleteTask(index);
                  },
                  direction: DismissDirection.endToStart,
                  child: ListTile(
                    title: Text(_tasks[index]),
                    onTap: () {
                      _toggleTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
