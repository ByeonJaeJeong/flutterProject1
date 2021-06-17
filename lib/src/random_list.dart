import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app_namings/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved =
      Set<WordPair>(); //List와 같지만 동일한값의 Object가 들어갈수 없음

  @override
  Widget build(BuildContext context) {
    final randomWord = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text("naming App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SavedList(saved :_saved))).then((value){
                    setState(() {

                    });
              });
            },
          )
        ],
      ),
      body: _bulidList(),
    );
  }

  Widget _bulidList() {
    return ListView.builder(itemBuilder: (context, index) {
      //0, 2, 4, 6, 8 = real items
      //1, 3 , 5, 7, 9 = dividers
      if (index.isOdd) {
        //index가 홀수면
        return Divider();
      }
      var readIndex = index ~/ 2;
      if (readIndex >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[readIndex]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool aleradySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, textScaleFactor: 1.5),
      trailing: Icon(aleradySaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink),
      onTap: () {
        setState(() {
          //이걸 넣음으로써 state를 재실행해줌
          if (aleradySaved)
            _saved.remove(pair); //true
          else
            _saved.add(pair); //false
          print(_saved.toString());
        });
      },
    );
  }
}
