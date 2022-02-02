import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.freezed.dart';

class TaskModel extends ChangeNotifier {
  final List<Task> _items = [];

  UnmodifiableListView<Task> get items => UnmodifiableListView<Task>(_items);

  void toggleDone(int index) {
    final bool _isDone = items[index].isDone;
    final Task _item = items[index].copyWith(isDone: !_isDone);
    update(_item, index);
  }

  void complete(int index) {
    final Task item = items[index].copyWith(isDone: true);
    update(item, index);
  }

  void unComplete(int index) {
    final Task item = items[index].copyWith(isDone: false);
    update(item, index);
  }

  void add(Task item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Task item) {
    _items.remove(item);
    notifyListeners();
  }

  void update(Task item, [int? index]) {
    final _index =
        index ?? _items.indexWhere((element) => element.id == item.id);
    final _item = item.copyWith(updatedAt: DateTime.now());
    _items[_index] = _item;
    notifyListeners();
  }
}

class TaskCreator {
  static Task create({
    String? id,
    required String title,
    required String memo,
    required bool isDone,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) {
    final _id = id ?? Uuid().v1();
    final _createdAt = createdAt ?? DateTime.now();
    final _updatedAt = updatedAt ?? DateTime.now();

    return Task(
      id: _id,
      title: title,
      memo: memo,
      isDone: isDone,
      createdAt: _createdAt,
      updatedAt: _updatedAt,
    );
  }
}

@freezed
class Task with _$Task {
  factory Task({
    required String id,
    required String title,
    required String memo,
    required bool isDone,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? completedAt,
  }) = _Task;
}
