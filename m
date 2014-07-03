Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/19] android/tester-ng: Add double enable success test case
Date: Thu,  3 Jul 2014 18:00:10 +0200
Message-Id: <1404403222-26911-8-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-bluetooth.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index d9f26a8..5022da4 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -46,6 +46,26 @@ static struct test_case bluetooth_enable_success_tc = {
 	.step_num = get_test_case_step_num(bluetooth_enable_success_steps),
 };
 
+static struct step bluetooth_enable_success2_steps[] = {
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
+		.action = bluetooth_enable_action,
+	},
+};
+static struct test_case bluetooth_enable_success2_tc = {
+	.step = bluetooth_enable_success2_steps,
+	.title = "Bluetooth Enable - Success 2",
+	.step_num = get_test_case_step_num(bluetooth_enable_success2_steps),
+};
+
 struct queue *get_bluetooth_tests(void)
 {
 	list = queue_new();
@@ -56,6 +76,9 @@ struct queue *get_bluetooth_tests(void)
 	if (!queue_push_tail(list, &bluetooth_enable_success_tc))
 		return NULL;
 
+	if (!queue_push_tail(list, &bluetooth_enable_success2_tc))
+		return NULL;
+
 	return list;
 }
 
-- 
1.9.3

