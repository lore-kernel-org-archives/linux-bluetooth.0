Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/5] android/tester: Add discovery timeout set prop success test case
Date: Fri, 13 Dec 2013 13:44:23 +0100
Message-Id: <1386938665-7179-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1386938665-7179-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1386938665-7179-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds discovery timeout set property success test case.
---
 android/android-tester.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index fc521a4..369af31 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -43,6 +43,7 @@
 
 static bt_scan_mode_t test_setprop_scanmode_val =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
+static uint32_t test_setprop_disctimeout_val = 120;
 
 /*
  * those are assigned to HAL methods and callbacks, we use ID later
@@ -589,6 +590,14 @@ static const struct generic_data bluetooth_setprop_scanmode_success_test = {
 	.expected_property.len = sizeof(bt_scan_mode_t)
 };
 
+static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
+	.expected_hal_callbacks = {adapter_prop_disc_timeout, adapter_test_end},
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.expected_property.val = &test_setprop_disctimeout_val,
+	.expected_property.len = sizeof(test_setprop_disctimeout_val)
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -832,6 +841,19 @@ static void test_setprop_scanmode_succes(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_disctimeout_succes(const void *test_data)
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
@@ -872,6 +894,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_setprop_scanmode_succes, teardown);
 
+	test_bredrle("Test Set DISCOVERY_TIMEOUT - Success",
+				&bluetooth_setprop_disctimeout_success_test,
+				setup_enabled_adapter,
+				test_setprop_disctimeout_succes, teardown);
+
 	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

