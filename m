Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 18/19] Android/tester-bluetooth: Add disc_timeout set success tc
Date: Thu,  3 Jul 2014 18:00:21 +0200
Message-Id: <1404403222-26911-19-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds discovery timeout set property success test case.
---
 android/tester-bluetooth.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index bff6ea9..56518ea 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -201,6 +201,40 @@ static struct test_case bluetooth_setprop_scanmode_success_tc = {
 				bluetooth_setprop_scanmode_success_steps),
 };
 
+static uint32_t test_setprop_disctimeout_val = 600;
+
+static bt_property_t setprop_disctimeout_prop = {
+	.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.val = &test_setprop_disctimeout_val,
+	.len = sizeof(test_setprop_disctimeout_val),
+};
+
+static struct step bluetooth_setprop_disctimeout_success_steps[] = {
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
+		.set_data = &setprop_disctimeout_prop,
+		.action = bt_set_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = NULL,
+	},
+};
+static struct test_case bluetooth_setprop_disctimeout_success_tc = {
+	.step = bluetooth_setprop_disctimeout_success_steps,
+	.title = "Bluetooth Set DISCOVERY_TIMEOUT - Success",
+	.step_num = get_test_case_step_num(
+				bluetooth_setprop_disctimeout_success_steps),
+};
+
 struct queue *get_bluetooth_tests(void)
 {
 	list = queue_new();
@@ -223,6 +257,9 @@ struct queue *get_bluetooth_tests(void)
 	if (!queue_push_tail(list, &bluetooth_setprop_scanmode_success_tc))
 		return NULL;
 
+	if (!queue_push_tail(list, &bluetooth_setprop_disctimeout_success_tc))
+		return NULL;
+
 	return list;
 }
 
-- 
1.9.3

