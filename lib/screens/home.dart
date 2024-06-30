import 'package:flutter/material.dart';
import 'package:test_project_01/constants/colors.dart';
import 'package:test_project_01/model/todo.dart';
import 'package:test_project_01/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();
  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  void _runFilter(String q) {
    List<Todo> results = [];
    if (q.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where(
              (item) => item.todoText!.toLowerCase().contains(q.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }

  void handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void handleDeleteItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todoText) {
    setState(() {
      todoList.insert(
          0,
          Todo(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              todoText: todoText));
    });
    _todoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            'All TODOs',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (Todo todo in _foundTodo)
                          TodoItem(
                            todo: todo,
                            onTodoChanged: handleTodoChange,
                            onDeleteItem: handleDeleteItem,
                          ),
                      ],
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      // _addTodoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(60, 60),
                        elevation: 10),
                        child: const Icon(Icons.upload, color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTodoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(60, 60),
                        elevation: 10),
                        child: const Icon(Icons.add, color: Colors.white),
                    // child: const Text(
                    //   '+',
                    //   style: TextStyle(fontSize: 40),
                    // ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 1,
        backgroundColor: tdBGColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: tdBlack,
              size: 40,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: 40,
              height: 40,
              // if you want to add border radius to container, use below...
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/avatar.png')),
            )
          ],
        ));
  }

  Widget searchBox() {
    // searchBox({required this.onSearch})
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey),
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25)),
      ),
    );
  }
}
