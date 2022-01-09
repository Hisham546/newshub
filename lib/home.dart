import 'package:flutter/material.dart';
import 'package:newshub/Article_view.dart';
import 'package:newshub/models/article_model.dart';

import 'news.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<ArticleModel> articles=<ArticleModel>[];
  bool  _loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getNews();
  }
  getNews()async{
    News newsClass=News();
    await newsClass.getNewsApi();
    articles=newsClass.news;
    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
       title: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text('India',style: TextStyle(color: Colors.blue),),
           Text('News',style: TextStyle(color: Colors.black),)
         ],
       ),centerTitle: true,
      ),
      body: _loading?Center(
        child: Container(
          child: CircularProgressIndicator(),
        )
      ):

      Container(
        padding: EdgeInsets.only(top:16),
        child: ListView.builder(
            itemCount: articles.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context,index){
              return BlogTile(imageUrl: articles[index].urlToImage!,
                  title: articles[index].title!,
                  desc: articles[index].description!,
                  url:articles[index].url!
              );

            }),
      )

    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl,title,desc,url;
  BlogTile({required this.imageUrl,required this.title,required this.desc,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl:url)));
      },
      child:Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl)),
              Text(title,style: TextStyle(
                  fontSize: 17,
                  color:Colors.black87,
                  fontWeight: FontWeight.w500
              ),),
              SizedBox(
                height: 8,

              ),
              Text(desc,style: TextStyle(
                fontSize: 17,color: Colors.black54,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}