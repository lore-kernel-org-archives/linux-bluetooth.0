Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 07/10] android/tester-bluetooth: Add set scan mode success case
Date: Tue, 15 Jul 2014 10:24:56 +0200
Message-Id: <1405412699-6358-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-bluetooth.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index ce777b0..a8eecb6 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -527,6 +527,41 @@ static struct test_case bluetooth_setprop_bonded_dev_fail_tc = {
 				bluetooth_setprop_bonded_dev_fail_steps),
 };
 
+static bt_scan_mode_t setprop_scan_mode_conn_val = BT_SCAN_MODE_CONNECTABLE;
+
+static bt_property_t setprop_scan_mode_conn_prop = {
+	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.val = &setprop_scan_mode_conn_val,
+	.len = sizeof(setprop_scan_mode_conn_val),
+};
+
+static struct step bluetooth_setprop_scan_mode_conn_success_steps[] = {
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
+		.set_data = &setprop_scan_mode_conn_prop,
+		.action = bt_set_property_action,
+	},
+	{
+		.callback = CB_BT_ADAPTER_PROPERTIES,
+		.callback_result.properties = &setprop_scan_mode_conn_prop,
+		.callback_result.num_properties = 1,
+	},
+};
+static struct test_case bluetooth_setprop_scan_mode_conn_success_tc = {
+	.step = bluetooth_setprop_scan_mode_conn_success_steps,
+	.title = "Bluetooth Set SCAN_MODE_CONNECTABLE - SUCCESS",
+	.step_num = get_test_case_step_num(
+				bluetooth_setprop_scan_mode_conn_success_steps),
+};
+
 static struct test_case *test_cases[] = {
 	&bluetooth_init,
 	&bluetooth_enable_success_tc,
@@ -544,6 +579,7 @@ static struct test_case *test_cases[] = {
 	&bluetooth_setprop_srvc_record_fail_tc,
 	&bluetooth_setprop_bdaddr_fail_tc,
 	&bluetooth_setprop_bonded_dev_fail_tc,
+	&bluetooth_setprop_scan_mode_conn_success_tc,
 };
 
 struct queue *get_bluetooth_tests(void)
-- 
1.9.1

