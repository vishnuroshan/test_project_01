import 'package:flutter/material.dart';
import 'package:test_project_01/constants/colors.dart';
import 'package:test_project_01/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onTodoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onTodoChanged,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () => onTodoChanged(todo),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            onPressed: () => onDeleteItem(todo.id)
            ,
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
          ),
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
      ),
    );
  }
}
