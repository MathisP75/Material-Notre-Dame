// FLUTTER / DART / THIRD-PARTIES
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// VIEW
import 'package:notredame/ui/views/about_view.dart';

import '../../helpers.dart';

void main() {
  group('AboutView - ', () {
    setUp(() async {});

    tearDown(() {});

    group('UI - ', () {
      testWidgets('has 6 images and 2 texts and 1 row', (WidgetTester tester) async {
        await tester.pumpWidget(localizedWidget(
            child: AboutView()));
        await tester.pumpAndSettle();

        final image = find.byType(Image);
        expect(image, findsNWidgets(6));

        final text = find.byType(Text);
        expect(text, findsNWidgets(2));

        final row = find.byType(Row);
        expect(row, findsOneWidget);
      });

      group("golden - ", () {
        testWidgets("default view (no events)", (WidgetTester tester) async {
          tester.binding.window.physicalSizeTestValue = const Size(800, 1410);

          await tester.pumpWidget(localizedWidget(child: AboutView()));
          await tester.pumpAndSettle();

          await expectLater(find.byType(AboutView),
              matchesGoldenFile(goldenFilePath("aboutView_1")));
        });
      });
    });
  });
}