Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 16/19] android/tester-bluetooth: Add bdname set success tc
Date: Thu,  3 Jul 2014 18:00:19 +0200
Message-Id: <1404403222-26911-17-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds handling of property check and bdname set property success
test case. Android tester framework is enhanced by set bd name action.
Test data is enchanced by user step data which can be used inside test
case step.
---
 android/tester-bluetooth.c | 37 +++++++++++++++++++++++++++++++++++++
 android/tester-main.c      | 22 ++++++++++++++++++++++
 android/tester-main.h      |  4 ++++
 3 files changed, 63 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 8289b85..f071910 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -132,6 +132,40 @@ static struct test_case bluetooth_disable_success_tc = {
 	.step_num = get_test_case_step_num(bluetooth_disable_success_steps),
 };
 
+static char test_set_bdname[] = "test_bdname_set";
+
+static bt_property_t setprop_bdname_prop = {
+	.type = BT_PROPERTY_BDNAME,
+	.val = test_set_bdname,
+	.len = sizeof(test_set_bdname) - 1,
+};
+
+static struct step bluetooth_setprop_bdname_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_ON,
+	},
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.set_data = &setprop_bdname_prop,
+		.action = bt_set_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &setprop_bdname_prop,
+	}
+};
+static struct test_case bluetooth_setprop_bdname_success_tc = {
+	.step = bluetooth_setprop_bdname_success_steps,
+	.title = "Bluetooth Set BDNAME - Success",
+	.step_num =
+		get_test_case_step_num(bluetooth_setprop_bdname_success_steps),
+};
+
 struct queue *get_bluetooth_tests(void)
 {
 	list = queue_new();
@@ -148,6 +182,9 @@ struct queue *get_bluetooth_tests(void)
 	if (!queue_push_tail(list, &bluetooth_disable_success_tc))
 		return NULL;
 
+	if (!queue_push_tail(list, &bluetooth_setprop_bdname_success_tc))
+		return NULL;
+
 	return list;
 }
 
diff --git a/android/tester-main.c b/android/tester-main.c
index c8a399d..8a1f6ed 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -882,6 +882,28 @@ void bluetooth_disable_action(void)
 	verify_step(&step, NULL);
 }
 
+void bt_set_property_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step step;
+	struct step *current_data_step = queue_peek_head(data->steps);
+	bt_property_t *prop;
+
+	if (!current_data_step->set_data) {
+		tester_debug("BT property not set for step");
+		tester_test_failed();
+		return;
+	}
+
+	prop = (bt_property_t *)current_data_step->set_data;
+
+	memset(&step, 0, sizeof(step));
+	step.action_result.status = data->if_bluetooth->set_adapter_property(
+									prop);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index be28b55..a740f6b 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -169,6 +169,9 @@ struct step {
 
 	expected_bt_callback_t callback;
 	struct bt_callback_data callback_result;
+
+	void *set_data;
+	int set_data_len;
 };
 
 /* Get, remove test cases API */
@@ -185,3 +188,4 @@ void remove_gatt_tests(void);
 void dummy_action(void);
 void bluetooth_enable_action(void);
 void bluetooth_disable_action(void);
+void bt_set_property_action(void);
-- 
1.9.3

