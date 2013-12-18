Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] android/tester: Add RSSI set prop fail test case
Date: Wed, 18 Dec 2013 10:53:12 +0100
Message-Id: <1387360393-853-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387360393-853-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387360393-853-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds RSSI set property fail test case due to be only remote device
property.
---
 android/android-tester.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2f2bbff..9bae94d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -628,6 +628,16 @@ static const struct generic_data bluetooth_setprop_tod_invalid_test = {
 	.expected_property.len = sizeof(setprop_type_of_device)
 };
 
+static int32_t setprop_remote_rssi = 0;
+
+static const struct generic_data bluetooth_setprop_remote_rssi_invalid_test = {
+	.expected_hal_callbacks = {ADAPTER_TEST_END},
+	.expected_adapter_status = BT_STATUS_FAIL,
+	.expected_property.type = BT_PROPERTY_REMOTE_RSSI,
+	.expected_property.val = &setprop_remote_rssi,
+	.expected_property.len = sizeof(setprop_remote_rssi)
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -1044,6 +1054,19 @@ static void test_setprop_tod_invalid(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_rssi_invalid(const void *test_data)
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
@@ -1114,6 +1137,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_setprop_tod_invalid, teardown);
 
+	test_bredrle("Set REMOTE_RSSI - Invalid",
+				&bluetooth_setprop_remote_rssi_invalid_test,
+				setup_enabled_adapter,
+				test_setprop_rssi_invalid, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

