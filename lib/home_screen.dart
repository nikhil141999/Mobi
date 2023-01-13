import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int m = 1, n = 1;
  String input = "";
  String word = "";
  List<int> x = [-1, -1, -1, 0, 0, 1, 1, 1];
  List<int> y = [-1, 0, 1, -1, 1, -1, 0, 1];

  bool search2D(
      List<List<String>> grid, int row, int col, String word, int R, int C) {
    // If first character of word doesn't
    // match with given starting point in grid.
    if ((grid[row][col])[0] != word[0]) return false;

    int len = word.length;

    // starting from (row, col)
    for (int dir = 0; dir < 8; dir++) {
      // Initialize starting point
      // for current direction
      int k, rd = row + x[dir], cd = col + y[dir];

      // First character is already checked,
      // match remaining characters
      for (k = 1; k < len; k++) {
        // If out of bound break
        if (rd >= R || rd < 0 || cd >= C || cd < 0) break;

        // If not matched,  break
        if ((grid[rd][cd]) != word[k]) break;

        // Moving in particular direction
        rd += x[dir];
        cd += y[dir];
      }

      if (k == len) return true;
    }
    return false;
  }

  void patternSearch(List<List<String>> grid, String word, int R, int C) {
    for (int row = 0; row < R; row++)
      for (int col = 0; col < C; col++)
        if (search2D(grid, row, col, word, R, C))
          print("pattern found at $row $col ");

    //snack bar
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: ((value) {
            m = int.parse(value);
            setState(() {});
          }),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: ((value) {
            n = int.parse(value);
            setState(() {});
          }),
        ),
        TextFormField(
          onChanged: ((value) {
            input = value;
            setState(() {});
          }),
          maxLength: m * n,
        ),
        TextFormField(
          onChanged: ((value) {
            word = value;
            setState(() {});
          }),
        ),
        SizedBox(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: m, mainAxisSpacing: 2, mainAxisExtent: 4),
              itemBuilder: (BuildContext context, index) {
                return SizedBox(child: Center(child: Text(input[index])));
              }),
        ),
        Text(input),
        TextButton(
            onPressed: () {
              var ascList = List.generate(
                  m, (i) => List.generate(n, (j) => input[i * n + j]));

              print("hiiii $ascList");
              ascList.forEach((element) {
                print(element);
              });

              patternSearch(ascList, word, m, n);
            },
            child: const Text("ok"))
      ],
    );
  }
}
