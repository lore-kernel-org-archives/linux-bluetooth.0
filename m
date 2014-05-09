Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 14/15] android/tester-ng: Add setprop scanmode conn success tc
Date: Fri,  9 May 2014 16:42:47 +0200
Message-Id: <1399646568-20742-14-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds scan mode set property to connectable success test case.
---
 android/android-tester-ng.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index 2100ce8..cd7a28c 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -1099,6 +1099,14 @@ static bt_property_t setprop_scanmode_conn_disc_prop = {
 	.len = sizeof(bt_scan_mode_t),
 };
 
+static bt_scan_mode_t test_setprop_scanmode_conn = BT_SCAN_MODE_CONNECTABLE;
+
+static bt_property_t setprop_scanmode_conn_prop = {
+	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.val = &test_setprop_scanmode_conn,
+	.len = sizeof(bt_scan_mode_t),
+};
+
 static void bt_set_scanmode_property(bt_property_t *mode)
 {
 	struct test_data *data = tester_get_data();
@@ -1116,6 +1124,11 @@ static void bt_set_scanmode_conn_discov_action(void)
 	bt_set_scanmode_property(&setprop_scanmode_conn_disc_prop);
 }
 
+static void bt_set_scanmode_conn_action(void)
+{
+	bt_set_scanmode_property(&setprop_scanmode_conn_prop);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1288,6 +1301,25 @@ static struct step bluetooth_setprop_scanmode_conn_disc_success_steps[] = {
 	}
 };
 
+static struct step bluetooth_setprop_scanmode_conn_success_steps[] = {
+	{
+	.action_result.status = BT_STATUS_SUCCESS,
+	.action = bluetooth_enable_action,
+	},
+	{
+	.callback = CB_BT_ADAPTER_STATE_CHANGED,
+	.callback_result.state = BT_STATE_ON,
+	},
+	{
+	.action_result.status = BT_STATUS_SUCCESS,
+	.action = bt_set_scanmode_conn_action,
+	},
+	{
+	.callback = CB_BT_ADAPTER_PROPERTIES,
+	.callback_result.properties = &setprop_scanmode_conn_prop,
+	}
+};
+
 static struct step gatt_register_client_success_steps[] = {
 	{
 	.action_result.status = BT_STATUS_SUCCESS,
@@ -1374,6 +1406,10 @@ int main(int argc, char *argv[])
 			bluetooth_setprop_scanmode_conn_disc_success_steps,
 			setup, generic_test_function, teardown);
 
+	test_bredrle("Bluetooth Set SCAN_MODE CONN - Success",
+			bluetooth_setprop_scanmode_conn_success_steps,
+			setup, generic_test_function, teardown);
+
 	test_bredrle("Socket Init", dummy_steps, setup_socket,
 					generic_test_function, teardown);
 
-- 
1.9.2

