import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);
  static const String id = 'ToDoScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TodoList(),
              ),
            ),
            TaskInputField(),
          ],
        ),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(
      builder: (context, todo, child) {
        if (todo.items.isNotEmpty) {
          return ListView.builder(
            itemCount: todo.items.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskListItem(index: index);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class TaskListItem extends StatelessWidget {
  final int index;

  const TaskListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(builder: (context, tasks, child) {
      return Row(
        children: [
          Expanded(
            child: Text(
              tasks.items[index].title,
            ),
          ),
          Checkbox(
            onChanged: (e) {
              tasks.toggleDone(index);
            },
            value: tasks.items[index].isDone,
          )
        ],
      );
    });
  }
}

class TaskInputField extends StatefulWidget {
  const TaskInputField({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskInputField();
  }
}

class _TaskInputField extends State<TaskInputField> {
  final taskInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    taskInputController.dispose();
    super.dispose();
  }

  void onPressAdd() {
    if (taskInputController.text != '') {
      var tasks = context.read<TaskModel>();
      tasks.add(TaskCreator.create(
        title: taskInputController.text,
        memo: '',
        isDone: false,
      ));
      taskInputController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              key: const Key('taskInput'),
              controller: taskInputController,
              decoration: const InputDecoration(hintText: 'what to do ?'),
            ),
          ),
          TextButton(onPressed: onPressAdd, child: const Text('ADD'))
        ],
      ),
    );
  }
}
