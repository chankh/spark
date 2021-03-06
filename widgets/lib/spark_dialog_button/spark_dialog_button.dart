// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library spark_widgets.spark_dialog_button;

import 'package:polymer/polymer.dart';

import '../common/spark_widget.dart';

// TODO(ussuri): SparkDialogButton originally derived from SparkButton. That
// worked fine in Dartium, however in dart2js version Polymer refused to see
// and apply such changes, while setting HTML attrs on a contained button here
// works. See original version under git tag 'before-button-hack-to-fix-states'.

@CustomTag('spark-dialog-button')
class SparkDialogButton extends SparkWidget {
  @published bool submit = false;
  @published bool cancel = false;
  @published bool dismiss = false;
  @published bool secondary = false;
  @published bool raised = false;
  @published bool disabled = false;

  SparkDialogButton.created() : super.created();

  @override
  void enteredView() {
    super.enteredView();

    // At most one of [submit] and [cancel] can be true.
    assert([submit, cancel, dismiss].where((e) => e == true).length <= 1);

    // spark-overlay analyzes all clicks and auto-closes if the clicked
    // element has [overlayToggle] attribute.
    setAttr('overlayToggle', submit || dismiss || cancel);
  }

  // TODO(ussuri): BUG #2252
  @override
  bool deliverChanges() {
    bool result = super.deliverChanges();
    SparkWidget widget = getShadowDomElement('spark-button');
    widget.setAttr('disabled', disabled);
    return result;
  }
}
