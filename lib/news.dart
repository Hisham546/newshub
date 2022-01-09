
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:newshub/models/article_model.dart';



class News{
  List<ArticleModel> news=[];
Future<void> getNewsApi()async{

  Response response=await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=f29021b85d8e4346b524e9736909de58"));

  var jsonData=jsonDecode(response.body);
  if(jsonData['status']=="ok"){
    jsonData["articles"].forEach((element){

      if(element["urlToImage"]!=null && element['description']!=null){
        ArticleModel articleModel=ArticleModel(
          title: element['title'],
          author: element["author"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],

        );
        news.add(articleModel);
      };

    });

  }
}
}