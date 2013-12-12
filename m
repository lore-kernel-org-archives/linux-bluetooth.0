Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] android/tester: Add scan mode set prop success test case
Date: Thu, 12 Dec 2013 18:14:32 +0100
Message-Id: <1386868475-9610-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1386868475-9610-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1386868475-9610-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds scan mode set property success test case.
---
 android/android-tester.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index dcc0e33..d2c0e2f 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -40,6 +40,9 @@
 			adapter_prop_uuids, adapter_prop_cod, \
 			adapter_prop_scan_mode, adapter_prop_disc_timeout
 
+static bt_scan_mode_t test_setprop_scanmode_val =
+					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
+
 /*
  * those are assigned to HAL methods and callbacks, we use ID later
  * on mapped in switch-case due to different functions prototypes.
@@ -594,6 +597,15 @@ static const struct generic_data bluetooth_setprop_bdname_success_test = {
 	.expected_property.len = 11
 };
 
+static const struct generic_data bluetooth_setprop_scanmode_success_test = {
+	.expected_hal_callbacks = {adapter_prop_scan_mode,
+				adapter_prop_scan_mode, adapter_test_end},
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.expected_property.val = &test_setprop_scanmode_val,
+	.expected_property.len = sizeof(bt_scan_mode_t)
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -824,6 +836,19 @@ static void test_setprop_bdname_success(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_scanmode_succes(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -859,6 +884,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_setprop_bdname_success, teardown);
 
+	test_bredrle("Test Set SCAN_MODE - Success",
+				&bluetooth_setprop_scanmode_success_test,
+				setup_enabled_adapter,
+				test_setprop_scanmode_succes, teardown);
+
 	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

