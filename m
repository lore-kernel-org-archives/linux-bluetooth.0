Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/15] android/tester: Add get device TOD property success test case
Date: Tue, 14 Jan 2014 14:54:37 +0100
Message-Id: <1389707686-30766-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389707686-30766-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389707686-30766-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds device TOD property success test case.
---
 android/android-tester.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index c72b297..a63ed32 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1376,6 +1376,28 @@ static const struct generic_data bt_dev_getprop_cod_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static bt_device_type_t remote_getprop_tod_val = BT_DEVICE_DEVTYPE_BREDR;
+
+static struct priority_property remote_getprop_tod_props[] = {
+	{
+	.prop.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.prop.val = &remote_getprop_tod_val,
+	.prop.len = sizeof(remote_getprop_tod_val),
+	},
+};
+
+static const struct generic_data bt_dev_getprop_tod_success_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_get_property_device_found_cb,
+	.expected_hal_cb.remote_device_properties_cb =
+					remote_test_device_properties_cb,
+	.expected_cb_count = 3,
+	.expected_properties_num = 1,
+	.expected_properties = remote_getprop_tod_props,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -1925,6 +1947,15 @@ static void test_dev_getprop_cod_success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_getprop_tod_success(const void *test_data)
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
@@ -2546,6 +2577,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_dev_getprop_cod_success, teardown);
 
+	test_bredrle("Bluetooth Device Get TOD - Success",
+					&bt_dev_getprop_tod_success_test,
+					setup_enabled_adapter,
+					test_dev_getprop_tod_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

