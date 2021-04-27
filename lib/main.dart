import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
  debugShowCheckedModeBanner:
  false;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.deepOrange[300],
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  final _suggestions = <WordPair>[]; // NEW
  final _saved = <WordPair>{};
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'CourierPrime',
                  ),
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            backgroundColor: Color(0xFFfEF2D4),
            // Add 6 lines from here...
            appBar: AppBar(
              //      backgroundColor: Color(0xFFfF7F50),
              title: TypewriterAnimatedTextKit(
                  text: ['Saved Suggestions'],
                  textStyle: TextStyle(
                    fontFamily: 'CourierPrime',
                    color: Color(0xFFfEF2D4),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  //final _biggerFont = const TextStyle(fontSize: 18, fontFamily: 'CourierPrime');
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);
    return Scaffold(
      backgroundColor: Color(0xFFfEF2D4),
      // Add from here...
      appBar: AppBar(
        //backgroundColor: Color(0xFFfF7F50),
        title: TypewriterAnimatedTextKit(
            text: ['Startup Name Generator'],
            textStyle: TextStyle(
              fontFamily: 'CourierPrime',
              color: Color(0xFFfEF2D4),
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            )),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row
          // in the ListView.
          if (i.isOdd) {
            return Divider();
          }

          // The syntax "i ~/ 2" divides i by 2 and returns an
          // integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings
          // in the ListView,minus the divider widgets.
          final int index = i ~/ 2;
          // If you've reached the end of the available word
          // pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'CourierPrime',
        ),
      ),
      trailing: Icon(
        // NEW from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // NEW lines from here...

        final player = AudioCache();
        player.play('button-16.wav');

        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
