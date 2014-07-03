Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/19] android/tester-bluetooth: Add enable success test case
Date: Thu,  3 Jul 2014 18:00:08 +0200
Message-Id: <1404403222-26911-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds also enable action which enable bluetooth adapter.
---
 android/tester-bluetooth.c | 15 +++++++++++++++
 android/tester-main.c      | 11 +++++++++++
 android/tester-main.h      |  1 +
 3 files changed, 27 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index c912d7d..0f55d9e 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -30,6 +30,18 @@ static struct test_case bluetooth_init = {
 	.step_num = get_test_case_step_num(dummy_steps),
 };
 
+static struct step bluetooth_enable_success_steps[] = {
+	{
+		.action_result.status = BT_STATUS_SUCCESS,
+		.action = bluetooth_enable_action,
+	},
+};
+static struct test_case bluetooth_enable_success_tc = {
+	.step = bluetooth_enable_success_steps,
+	.title = "Bluetooth Enable - Success",
+	.step_num = get_test_case_step_num(bluetooth_enable_success_steps),
+};
+
 struct queue *get_bluetooth_tests(void)
 {
 	list = queue_new();
@@ -37,6 +49,9 @@ struct queue *get_bluetooth_tests(void)
 	if (!queue_push_tail(list, &bluetooth_init))
 		return NULL;
 
+	if (!queue_push_tail(list, &bluetooth_enable_success_tc))
+		return NULL;
+
 	return list;
 }
 
diff --git a/android/tester-main.c b/android/tester-main.c
index 51326f5..f49ce82 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -544,6 +544,17 @@ void dummy_action(void)
 	verify_step(&step, NULL);
 }
 
+void bluetooth_enable_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action_result.status = data->if_bluetooth->enable();
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index a4f2ed8..d79e4c5 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -91,3 +91,4 @@ void remove_bluetooth_tests(void);
 
 /* Actions */
 void dummy_action(void);
+void bluetooth_enable_action(void);
-- 
1.9.3

