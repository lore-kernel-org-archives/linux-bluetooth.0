Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/15] android/tester-ng: Add proprerty check and bdname set success test case
Date: Fri,  9 May 2014 16:42:45 +0200
Message-Id: <1399646568-20742-12-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds handling of property check, bdname set property success test
case.
---
 android/android-tester-ng.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index 7c59ee1..9351994 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -1070,6 +1070,26 @@ static void gattc_register_client_action(void)
 	verify_step(&step, NULL);
 }
 
+static char test_set_bdname[] = "test_bdname_set";
+
+static bt_property_t setprop_bdname_prop = {
+	.type = BT_PROPERTY_BDNAME,
+	.val = test_set_bdname,
+	.len = sizeof(test_set_bdname) - 1,
+};
+
+static void bt_set_bdname_property_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action_result.status = data->if_bluetooth->set_adapter_property(
+							&setprop_bdname_prop);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1204,6 +1224,25 @@ static struct step bluetooth_disable_success_steps[] = {
 	},
 };
 
+static struct step bluetooth_setprop_bdname_success_steps[] = {
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
+	.action = bt_set_bdname_property_action,
+	},
+	{
+	.callback = CB_BT_ADAPTER_PROPERTIES,
+	.callback_result.properties = &setprop_bdname_prop,
+	}
+};
+
 static struct step gatt_register_client_success_steps[] = {
 	{
 	.action_result.status = BT_STATUS_SUCCESS,
@@ -1282,6 +1321,10 @@ int main(int argc, char *argv[])
 					bluetooth_disable_success_steps, setup,
 					generic_test_function, teardown);
 
+	test_bredrle("Bluetooth Set BDNAME - Success",
+					bluetooth_setprop_bdname_success_steps,
+					setup, generic_test_function, teardown);
+
 	test_bredrle("Socket Init", dummy_steps, setup_socket,
 					generic_test_function, teardown);
 
-- 
1.9.2

