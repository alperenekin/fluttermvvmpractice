import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttermvvmmobx/features/post/viewmodel/post_view_model.dart';

class PostView extends StatelessWidget {
  final _viewModel = PostViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarr(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.getAllPosts();
        },
      ),
      body: Center(
        child: Observer(builder: (_) {
          return buildListView();
        }),
      ),
    );
  }

  ListView buildListView() {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: _viewModel.posts.length,
        itemBuilder: (context, index) {
          return buildListTileCard(index);
        });
  }

  ListTile buildListTileCard(int index) {
    return ListTile(
      title: Text(_viewModel.posts[index].title),
      subtitle: Text(_viewModel.posts[index].body),
      trailing: Text(_viewModel.posts[index].userId.toString()),
    );
  }

  AppBar buildAppBarr() {
    return AppBar(
        title: Text("App"),
        leading: Observer(builder: (_) {
          return Visibility(
            visible: _viewModel.isServiceRequestLoading,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
              Colors.white,
            )),
          );
        }));
  }
}
