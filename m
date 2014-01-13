Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/15] android/tester: Add get remote BONDED_DEV property fail test case
Date: Mon, 13 Jan 2014 18:12:38 +0100
Message-Id: <1389633161-11357-12-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds remote BONDED DEVICES property fail test case.
---
 android/android-tester.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2295e20..f4acbd1 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1520,6 +1520,26 @@ static const struct generic_data
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static struct priority_property remote_getprop_bondeddev_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.prop.val = NULL,
+	.prop.len = 0,
+	},
+};
+
+static const struct generic_data
+			bluetooth_remote_getprop_bonded_devices_fail_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_get_property_device_found_cb,
+	.expected_hal_cb.remote_device_properties_cb =
+					remote_test_device_properties_cb,
+	.expected_cb_count = 3,
+	.expected_properties = remote_getprop_bondeddev_props,
+	.expected_adapter_status = BT_STATUS_FAIL,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2123,6 +2143,15 @@ static void test_remote_getprop_scanmode_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_remote_getprop_bonded_devices_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	init_test_conditions(data);
+
+	data->if_bluetooth->start_discovery();
+}
+
 /* Test Socket HAL */
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -2774,6 +2803,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_remote_getprop_scanmode_fail, teardown);
 
+	test_bredrle("Bluetooth RemDev Get BONDED_DEVICES - Fail",
+			&bluetooth_remote_getprop_bonded_devices_fail_test,
+			setup_enabled_adapter,
+			test_remote_getprop_bonded_devices_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

