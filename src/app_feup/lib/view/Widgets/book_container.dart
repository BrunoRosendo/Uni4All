import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uni/model/entities/book.dart';
import 'package:uni/utils/methods.dart';
import 'package:uni/view/Widgets/row_container.dart';

enum BookContainerType { searchResult, reservation }

class BookContainer extends StatelessWidget {
  final Book book;
  final BookContainerType type;

  BookContainer({Key key, @required this.book, @required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyValue = '${book.toString()}-book';
    return Container(
        key: Key(keyValue),
        margin: EdgeInsets.fromLTRB(12, 4, 12, 0),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: RowContainer(
              color: Theme.of(context).backgroundColor,
              child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: IntrinsicHeight(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      book.imageURL == null
                          ? Image.asset('assets/images/book_placeholder.png',
                              width: hs(70, context),
                              height: vs(105, context),
                              fit: BoxFit.fill)
                    // TODO: Sould we use FileImage like general_page_view?
                          : Image.network(
                              book.imageURL,
                              width: hs(70, context),
                              height: vs(105, context),
                              fit: BoxFit.fill,
                            ),
                      buildBookContainerBody(context)
                    ],
                  )))),
        ));
  }

  Widget buildBookContainerBody(BuildContext context) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 5),
                Text(book.author,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .apply(fontSizeDelta: -2)),
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          book.getUnitsText(),
                          style: book.unitsAvailable > 1
                              ? Theme.of(context).textTheme.bodyText2
                              : Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .apply(color: Colors.red[700]),
                        ),
                      ),
                      buildBookTypesContainer(context)
                    ]))
              ],
            )));
  }

  Widget buildBookTypesContainer(BuildContext context) {
    final List<Widget> iconList = [];
    if (book.hasPhysicalVersion) {
      iconList.add(Icon(Icons.menu_book));
      if (book.hasDigitalVersion) iconList.add(SizedBox(width: 3));
    }

    if (book.hasDigitalVersion) iconList.add(Icon(Icons.file_download));

    return Container(
      alignment: Alignment.bottomRight,
      child: Row(
        children: iconList,
      ),
    );
  }
}
