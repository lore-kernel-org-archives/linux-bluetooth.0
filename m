Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 15/19] android/tester-bluetooth: Add disable success test case
Date: Thu,  3 Jul 2014 18:00:18 +0200
Message-Id: <1404403222-26911-16-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also adds disable action.
---
 android/tester-bluetooth.c | 27 +++++++++++++++++++++++++++
 android/tester-main.c      | 11 +++++++++++
 android/tester-main.h      |  1 +
 3 files changed, 39 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index e89011f..8289b85 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -108,6 +108,30 @@ static struct test_case bluetooth_enable_success2_tc = {
 	.step_num = get_test_case_step_num(bluetooth_enable_success2_steps),
 };
 
+static struct step bluetooth_disable_success_steps[] = {
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
+		.action = bluetooth_disable_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_STATE_CHANGED,
+		.callback_result.state = BT_STATE_OFF,
+	},
+};
+static struct test_case bluetooth_disable_success_tc = {
+	.step = bluetooth_disable_success_steps,
+	.title = "Bluetooth Disable - Success",
+	.step_num = get_test_case_step_num(bluetooth_disable_success_steps),
+};
+
 struct queue *get_bluetooth_tests(void)
 {
 	list = queue_new();
@@ -121,6 +145,9 @@ struct queue *get_bluetooth_tests(void)
 	if (!queue_push_tail(list, &bluetooth_enable_success2_tc))
 		return NULL;
 
+	if (!queue_push_tail(list, &bluetooth_disable_success_tc))
+		return NULL;
+
 	return list;
 }
 
diff --git a/android/tester-main.c b/android/tester-main.c
index 4a81b3c..c8a399d 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -871,6 +871,17 @@ void bluetooth_enable_action(void)
 	verify_step(&step, NULL);
 }
 
+void bluetooth_disable_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action_result.status = data->if_bluetooth->disable();
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index aaeada7..be28b55 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -184,3 +184,4 @@ void remove_gatt_tests(void);
 /* Actions */
 void dummy_action(void);
 void bluetooth_enable_action(void);
+void bluetooth_disable_action(void);
-- 
1.9.3

