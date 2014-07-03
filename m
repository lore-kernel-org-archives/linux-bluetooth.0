Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 17/19] Android/tester-bluetooth: Add scan_mode set success tc
Date: Thu,  3 Jul 2014 18:00:20 +0200
Message-Id: <1404403222-26911-18-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds scan_mode set property success test case.
---
 android/tester-bluetooth.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index f071910..bff6ea9 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -166,6 +166,41 @@ static struct test_case bluetooth_setprop_bdname_success_tc = {
 		get_test_case_step_num(bluetooth_setprop_bdname_success_steps),
 };
 
+static bt_scan_mode_t test_setprop_scanmode_val =
+					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
+
+static bt_property_t setprop_scanmode_prop = {
+	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.val = &test_setprop_scanmode_val,
+	.len = sizeof(bt_scan_mode_t),
+};
+
+static struct step bluetooth_setprop_scanmode_success_steps[] = {
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
+		.set_data = &setprop_scanmode_prop,
+		.action = bt_set_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &setprop_scanmode_prop,
+	},
+};
+static struct test_case bluetooth_setprop_scanmode_success_tc = {
+	.step = bluetooth_setprop_scanmode_success_steps,
+	.title = "Bluetooth Set SCAN_MODE - Success",
+	.step_num = get_test_case_step_num(
+				bluetooth_setprop_scanmode_success_steps),
+};
+
 struct queue *get_bluetooth_tests(void)
 {
 	list = queue_new();
@@ -185,6 +220,9 @@ struct queue *get_bluetooth_tests(void)
 	if (!queue_push_tail(list, &bluetooth_setprop_bdname_success_tc))
 		return NULL;
 
+	if (!queue_push_tail(list, &bluetooth_setprop_scanmode_success_tc))
+		return NULL;
+
 	return list;
 }
 
-- 
1.9.3

