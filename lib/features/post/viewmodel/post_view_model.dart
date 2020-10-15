import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttermvvmmobx/features/post/model/post.dart';
import 'package:mobx/mobx.dart';
part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase with Store {
  @observable
  List<Post> posts = [];
  final url = "https://jsonplaceholder.typicode.com/posts";

  @observable
  bool isServiceRequestLoading = false;

  @action
  Future<void> getAllPosts() async {
    print("get");
    changeRequest();
    final response = await Dio().get(url);
    if(response.statusCode == HttpStatus.ok){
      final body = response.data as List;
      posts = body.map((e) => Post.fromJson(e)).toList();
    }
    changeRequest();
  }

  @action
  void changeRequest(){
    isServiceRequestLoading = !isServiceRequestLoading;
  }
}