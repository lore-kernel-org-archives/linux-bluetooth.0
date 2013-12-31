Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] android/tester: Add SCAN_MODE get prop success test case
Date: Tue, 31 Dec 2013 15:46:27 +0100
Message-Id: <1388501191-5377-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds SCAN_MODE get property success test case.
---
 android/android-tester.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index c89b97a..d831f74 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -855,6 +855,17 @@ static const struct generic_data bluetooth_getprop_tod_success_test = {
 	.expected_property.len = sizeof(getprop_tod),
 };
 
+static bt_scan_mode_t getprop_scanmode = BT_SCAN_MODE_NONE;
+
+static const struct generic_data bluetooth_getprop_scanmode_success_test = {
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.expected_property.val = &getprop_scanmode,
+	.expected_property.len = sizeof(getprop_scanmode),
+};
+
 static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_hal_cb.discovery_state_changed_cb =
 						discovery_start_success_cb,
@@ -1256,6 +1267,19 @@ static void test_getprop_tod_success(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_getprop_scanmode_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t prop = test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->get_adapter_property(prop.type);
+	check_expected_status(adapter_status);
+}
+
 static void test_discovery_start_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1840,6 +1864,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_getprop_tod_success, teardown);
 
+	test_bredrle("Bluetooth Get SCAN_MODE - Success",
+				&bluetooth_getprop_scanmode_success_test,
+				setup_enabled_adapter,
+				test_getprop_scanmode_success, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
-- 
1.8.5.2

