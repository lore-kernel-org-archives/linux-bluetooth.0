Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/9] android/tester-ng: Add start discovery success cases
Date: Thu, 17 Jul 2014 10:29:52 +0200
Message-Id: <1405585796-12301-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-bluetooth.c | 15 +++++++++++++++
 android/tester-main.c      | 22 +++++++++++++++++++++-
 android/tester-main.h      |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index d65917d..ea59a57 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -329,6 +329,21 @@ static struct test_case test_cases[] = {
 						&prop_test_scan_mode_none),
 		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_none, 1),
 	),
+	TEST_CASE("Bluetooth BR/EDR Discovery Start - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+	),
+	TEST_CASE("Bluetooth BR/EDR Discovery Start - Done",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+	),
 };
 
 struct queue *get_bluetooth_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 7f52083..eb588d1 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -575,13 +575,23 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 	schedule_callback_call(step);
 }
 
+static void discovery_state_changed_cb(bt_discovery_state_t state)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_BT_DISCOVERY_STATE_CHANGED;
+	step->callback_result.state = state;
+
+	schedule_callback_call(step);
+}
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
 	.adapter_properties_cb = adapter_properties_cb,
 	.remote_device_properties_cb = NULL,
 	.device_found_cb = NULL,
-	.discovery_state_changed_cb = NULL,
+	.discovery_state_changed_cb = discovery_state_changed_cb,
 	.pin_request_cb = NULL,
 	.ssp_request_cb = NULL,
 	.bond_state_changed_cb = NULL,
@@ -933,6 +943,16 @@ void bt_get_property_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_start_discovery_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step step;
+
+	step.action_result.status = data->if_bluetooth->start_discovery();
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index 066615a..9e40907 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -217,3 +217,4 @@ void bluetooth_enable_action(void);
 void bluetooth_disable_action(void);
 void bt_set_property_action(void);
 void bt_get_property_action(void);
+void bt_start_discovery_action(void);
-- 
1.9.1

