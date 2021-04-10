import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Todos extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final textfieldController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ListView(
        children: [
          SizedBox(height: 24.0),
          Center(
            child: Text(
              'Todos',
              style: TextStyle(
                fontSize: 54.0,
                fontWeight: FontWeight.w300,
                color: Colors.cyan,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(labelText: 'what do you want to do?'),
            onSubmitted: (value) {
              textfieldController.clear();
            },
            controller: textfieldController,
          ),
          SizedBox(height: 24.0),
          SelectBar(),
          Divider(height: 0.0),
        ],
      ),
    );
  }
}

final selectBarProvider = StateProvider((_) => SelectBarType.All);
enum SelectBarType { All, Active, Completed }

class SelectBar extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selectBar = useProvider(selectBarProvider).state;
    Color updateColor(SelectBarType selectBarType) {
      return selectBar == selectBarType ? Colors.indigoAccent : Colors.black54;
    }

    FontWeight updateFontWeight(SelectBarType selectBarType) {
      return selectBar == selectBarType ? FontWeight.bold : FontWeight.w300;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          key: UniqueKey(),
          onPressed: () {
            context.read(selectBarProvider).state = SelectBarType.All;
          },
          child: Text('All'),
          style: TextButton.styleFrom(
            primary: updateColor(SelectBarType.All),
            textStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: updateFontWeight(SelectBarType.All),
            ),
          ),
        ),
        TextButton(
          key: UniqueKey(),
          onPressed: () {
            context.read(selectBarProvider).state = SelectBarType.Active;
          },
          child: Text('Active'),
          style: TextButton.styleFrom(
            primary: updateColor(SelectBarType.Active),
            textStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: updateFontWeight(SelectBarType.Active),
            ),
          ),
        ),
        TextButton(
          key: UniqueKey(),
          onPressed: () {
            context.read(selectBarProvider).state = SelectBarType.Completed;
          },
          child: Text('Completed'),
          style: TextButton.styleFrom(
            primary: updateColor(SelectBarType.Completed),
            textStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: updateFontWeight(SelectBarType.Completed),
            ),
          ),
        ),
      ],
    );
  }
}
