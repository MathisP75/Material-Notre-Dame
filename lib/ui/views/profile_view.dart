// FLUTTER / DART / THIRD-PARTIES
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// VIEW-MODEL
import 'package:notredame/core/viewmodels/profile_viewmodel.dart';

// SERVICES
import 'package:notredame/core/services/analytics_service.dart';

// WIDGETS
import 'package:notredame/ui/widgets/student_program.dart';

// UTILS
import 'package:notredame/ui/utils/loading.dart';
import 'package:notredame/ui/utils/app_theme.dart';

// OTHER
import 'package:notredame/locator.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  @override
  void initState() {
    super.initState();

    _analyticsService.logEvent("ProfileView", "Opened");
  }

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<ProfileViewModel>.reactive(
          viewModelBuilder: () => ProfileViewModel(intl: AppIntl.of(context)),
          builder: (context, model, child) {
            return RefreshIndicator(
              onRefresh: () => model.refresh(),
              child: Stack(
                children: [
                  ListView(padding: EdgeInsets.zero, children: [
                    ListTile(
                      title: Text(
                        AppIntl.of(context).profile_student_status_title,
                        style: const TextStyle(color: AppTheme.etsLightRed),
                      ),
                    ),
                    ListTile(
                      title: Text(AppIntl.of(context).profile_balance),
                      trailing: Text(model.profileStudent.balance),
                    ),
                    const Divider(
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    ListTile(
                      title: Text(
                        AppIntl.of(context).profile_personal_information_title,
                        style: const TextStyle(color: AppTheme.etsLightRed),
                      ),
                    ),
                    ListTile(
                      title: Text(AppIntl.of(context).profile_first_name),
                      trailing: Text(model.profileStudent.firstName),
                    ),
                    ListTile(
                      title: Text(AppIntl.of(context).profile_last_name),
                      trailing: Text(model.profileStudent.lastName),
                    ),
                    ListTile(
                        title: Text(AppIntl.of(context).profile_permanent_code),
                        trailing: Text(model.profileStudent.permanentCode)),
                    ListTile(
                        title: Text(
                            AppIntl.of(context).login_prompt_universal_code),
                        trailing: Text(model.universalAccessCode)),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      reverse: true,
                      physics: const ScrollPhysics(),
                      itemCount: model.programList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StudentProgram(model.programList[index]);
                      },
                    ),
                  ]),
                  if (model.isBusy)
                    buildLoading(isInteractionLimitedWhileLoading: false)
                  else
                    const SizedBox()
                ],
              ),
            );
          });
}
