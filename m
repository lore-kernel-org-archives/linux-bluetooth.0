Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/9] android/tester-ng: Replace action result with status
Date: Fri, 18 Jul 2014 11:50:16 +0200
Message-Id: <1405677021-18877-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Action (HAL api call) result is always status or file descriptor.
Integer value is enough to hold both so it replaced the truct.
---
 android/tester-main.c | 20 ++++++++++----------
 android/tester-main.h | 13 +++----------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index f5ac281..dde04b9 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -407,7 +407,7 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
-	if (exp->action_result.status != step->action_result.status) {
+	if (exp->action_status != step->action_status) {
 		tester_debug("Action status don't match");
 		return false;
 	}
@@ -916,10 +916,10 @@ static void emu_connectable_complete(uint16_t opcode, uint8_t status,
 
 	if (status) {
 		tester_warn("Emulated remote setup failed.");
-		step.action_result.status = BT_STATUS_FAIL;
+		step.action_status = BT_STATUS_FAIL;
 	} else {
 		tester_warn("Emulated remote setup done.");
-		step.action_result.status = BT_STATUS_SUCCESS;
+		step.action_status = BT_STATUS_SUCCESS;
 	}
 
 	verify_step(&step, NULL);
@@ -956,7 +956,7 @@ void bluetooth_enable_action(void)
 	struct step step;
 
 	memset(&step, 0, sizeof(step));
-	step.action_result.status = data->if_bluetooth->enable();
+	step.action_status = data->if_bluetooth->enable();
 
 	verify_step(&step, NULL);
 }
@@ -967,7 +967,7 @@ void bluetooth_disable_action(void)
 	struct step step;
 
 	memset(&step, 0, sizeof(step));
-	step.action_result.status = data->if_bluetooth->disable();
+	step.action_status = data->if_bluetooth->disable();
 
 	verify_step(&step, NULL);
 }
@@ -988,7 +988,7 @@ void bt_set_property_action(void)
 	prop = (bt_property_t *)current_data_step->set_data;
 
 	memset(&step, 0, sizeof(step));
-	step.action_result.status = data->if_bluetooth->set_adapter_property(
+	step.action_status = data->if_bluetooth->set_adapter_property(
 									prop);
 
 	verify_step(&step, NULL);
@@ -1010,7 +1010,7 @@ void bt_get_property_action(void)
 	prop = (bt_property_t *)current_data_step->set_data;
 
 	memset(&step, 0, sizeof(step));
-	step.action_result.status = data->if_bluetooth->get_adapter_property(
+	step.action_status = data->if_bluetooth->get_adapter_property(
 								prop->type);
 
 	verify_step(&step, NULL);
@@ -1021,7 +1021,7 @@ void bt_start_discovery_action(void)
 	struct test_data *data = tester_get_data();
 	struct step step;
 
-	step.action_result.status = data->if_bluetooth->start_discovery();
+	step.action_status = data->if_bluetooth->start_discovery();
 
 	verify_step(&step, NULL);
 }
@@ -1032,7 +1032,7 @@ void bt_cancel_discovery_action(void)
 	struct step step;
 
 	memset(&step, 0, sizeof(step));
-	step.action_result.status = data->if_bluetooth->cancel_discovery();
+	step.action_status = data->if_bluetooth->cancel_discovery();
 
 	verify_step(&step, NULL);
 }
@@ -1050,7 +1050,7 @@ void bt_get_device_props_action(void)
 	}
 
 	memset(&step, 0, sizeof(step));
-	step.action_result.status =
+	step.action_status =
 		data->if_bluetooth->get_remote_device_properties(
 						current_data_step->set_data);
 
diff --git a/android/tester-main.h b/android/tester-main.h
index b81487d..920f82c 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -57,13 +57,13 @@
 	}
 
 #define ACTION_SUCCESS(act_fun, data_set) { \
-		.action_result.status = BT_STATUS_SUCCESS, \
+		.action_status = BT_STATUS_SUCCESS, \
 		.action = act_fun, \
 		.set_data = data_set, \
 	}
 
 #define ACTION_FAIL(act_fun, data_set) { \
-		.action_result.status = BT_STATUS_FAIL, \
+		.action_status = BT_STATUS_FAIL, \
 		.action = act_fun, \
 		.set_data = data_set, \
 	}
@@ -174,13 +174,6 @@ struct test_data {
 };
 
 /*
- * Struct of data to check within step action.
- */
-struct bt_action_data {
-	uint8_t status;
-};
-
-/*
  * Callback data structure should be enhanced with data
  * returned by callbacks. It's used for test case step
  * matching with expected step data.
@@ -198,7 +191,7 @@ struct bt_callback_data {
  */
 struct step {
 	void (*action)(void);
-	struct bt_action_data action_result;
+	int action_status;
 
 	expected_bt_callback_t callback;
 	struct bt_callback_data callback_result;
-- 
1.9.1

