Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 12/15] android/tester: Add get device BONDED_DEV property fail test case
Date: Tue, 14 Jan 2014 14:54:43 +0100
Message-Id: <1389707686-30766-12-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389707686-30766-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389707686-30766-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds device BONDED DEVICES property fail test case.
---
 android/android-tester.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index a9f57e5..2192cc4 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1509,6 +1509,25 @@ static const struct generic_data bt_dev_getprop_scanmode_fail_test = {
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
+static const struct generic_data bt_dev_getprop_bondeddev_fail_test = {
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
@@ -2112,6 +2131,15 @@ static void test_dev_getprop_scanmode_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_getprop_bondeddev_fail(const void *test_data)
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
@@ -2763,6 +2791,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_dev_getprop_scanmode_fail, teardown);
 
+	test_bredrle("Bluetooth Device Get BONDED_DEVICES - Fail",
+				&bt_dev_getprop_bondeddev_fail_test,
+				setup_enabled_adapter,
+				test_dev_getprop_bondeddev_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

