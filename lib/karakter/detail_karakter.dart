import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharDetail extends StatefulWidget {
  final String name;
  CharDetail({
    required this.name,
  });

  // const CharDetail({Key? key}) : super(key: key);
  @override
  State<CharDetail> createState() => _CharDetailState();
}

class Skill {
  final String skillTalents;
  // final String skillTalents;
  Skill({
    required this.skillTalents,
    // required this.skillTalents
  });

  factory Skill.fromJson(String json) {
    return Skill(
      skillTalents: json,
      // skillTalents: json
    );
  }
}

class _CharDetailState extends State<CharDetail> {
  Map<String, dynamic>? charData;
  List<dynamic> skillTalents = [''];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.genshin.dev/characters/${widget.name}'));
      if (response.statusCode == 200) {
        setState(() {
          charData = json.decode(response.body);
          skillTalents = charData!['skillTalents'];
          isLoading = false;
        });
      } else {
        throw Exception(
            'Failed to load character data. Error: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Failed to load character data. Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'Detail ${charData!['name']}',
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : charData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.network(
                        'https://api.genshin.dev/characters/${widget.name}/gacha-splash',
                        height: 200,
                        // fit: BoxFit.fill,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://api.genshin.dev/nations/${charData!['nation'].toLowerCase()}/icon',
                              height: 30,
                            ),
                            Image.network(
                              'https://api.genshin.dev/elements/${charData!['vision'].toLowerCase()}/icon',
                              height: 30,
                            ),
                            Text(
                              charData!['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            charData!['rarity'],
                            (index) => Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${charData!['affiliation']}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 18),
                      Text(
                        '${charData!['description']}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 18),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        // scrollDirection: Axis.vertical,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  'https://api.genshin.dev/characters/${widget.name}/talent-na',
                                  // fit: BoxFit.cover,
                                  height: 70,
                                ),
                                SizedBox(height: 70),
                                Image.network(
                                  'https://api.genshin.dev/characters/${widget.name}/talent-na',
                                  // fit: BoxFit.cover,
                                  height: 70,
                                ),
                              ],
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    skillTalents[0]['description'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    // textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 50),
                                  Text(
                                    skillTalents[1]['description'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text('Failed to load weapon data.'),
                ),
    );
  }
}
