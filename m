Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] android/tester: Add SCAN_MODE=NONE set prop done test case
Date: Tue, 31 Dec 2013 15:46:31 +0100
Message-Id: <1388501191-5377-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1388501191-5377-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1388501191-5377-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds SCAN_MODE property set to NONE - done test case.

SCAN_MODE at startup is set to NONE. Bluez return status - done when
requested status is the same as was.
---
 android/android-tester.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 5467aff..04fa811 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -900,6 +900,17 @@ static const struct generic_data bluetooth_getprop_bondeddev_success_test = {
 	.expected_property.len = 0,
 };
 
+static bt_scan_mode_t setprop_scanmode_none = BT_SCAN_MODE_NONE;
+
+static const struct generic_data bluetooth_setprop_scanmode_none_done_test = {
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
+	.expected_adapter_status = BT_STATUS_DONE,
+	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.expected_property.val = &setprop_scanmode_none,
+	.expected_property.len = sizeof(setprop_scanmode_none),
+};
+
 static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_hal_cb.discovery_state_changed_cb =
 						discovery_start_success_cb,
@@ -1353,6 +1364,19 @@ static void test_getprop_bondeddev_success(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_scanmode_none_done(const void *test_data)
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
 static void test_discovery_start_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1957,6 +1981,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_getprop_bondeddev_success, teardown);
 
+	test_bredrle("Bluetooth Set SCAN_MODE NONE - Done",
+				&bluetooth_setprop_scanmode_none_done_test,
+				setup_enabled_adapter,
+				test_setprop_scanmode_none_done, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
-- 
1.8.5.2

