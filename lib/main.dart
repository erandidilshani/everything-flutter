import 'package:everything_flutter/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'helpers/service_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ScreenScaler _scaler = ScreenScaler();

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: HttpLink(
        uri: "https://everythingflutter.iconicto.com/graphql",
      ) as Link,
      cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
    ),
  );

  ThemeData _buildThemeData() {
    return ThemeData(
      primaryColor: Color(0xFF6589F1),
      accentColor: Color(0xFF5FDED6),
      fontFamily: 'TTCommons',
      textTheme: TextTheme(
        title: TextStyle(
          fontSize: _scaler.getTextSize(22),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Everything Flutter',
        theme: _buildThemeData(),
        // home: TestPage(),

        // initialRoute: SplashScreen.route,
        routes: RouteHandler().routes,
      ),
    );
  }
}
