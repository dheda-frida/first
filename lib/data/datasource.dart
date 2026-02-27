import 'dart:convert';
import 'package:advicely/data/model.dart';
import 'package:http/http.dart' as http;

Future<Conseil> genererConseil() async {
  final uri = Uri.parse("https://api.api-ninjas.com/v1/advice");

  final reponse = await http.get(
    uri,
    headers: {"X-Api-Key": "eZE98cdWP7t0RJdDQcyL0fd3ZYO5wgcEBV0q1QkU"},
  );

  final json = jsonDecode(utf8.decode(reponse.bodyBytes)) as Map;
  return Conseil.fromJSON(json);
}

Future<String> traduireEnFrancais(String texte) async {
  final query = Uri.encodeComponent(texte);

  final uri = Uri.parse(
    "https://api.mymemory.translated.net/get?q=$query&langpair=en|fr",
  );

  final reponse = await http.get(uri);

  if (reponse.statusCode == 200) {
    final json = jsonDecode(reponse.body);
    return json["responseData"]["translatedText"];
  } else {
    throw Exception("Erreur traduction");
  }
}
