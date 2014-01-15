Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/12] android/tester: Add set device RSSI prop fail test case
Date: Wed, 15 Jan 2014 13:17:02 +0100
Message-Id: <1389788228-32195-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds set device RSSI property fail test case.
---
 android/android-tester.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index ecf0594..81fb1e6 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1776,6 +1776,25 @@ static const struct generic_data bt_dev_setprop_tod_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static int32_t remote_setprop_rssi_val = -60;
+
+static struct priority_property remote_setprop_rssi_props[] = {
+	{
+	.prop.type = BT_PROPERTY_REMOTE_RSSI,
+	.prop.val = &remote_setprop_rssi_val,
+	.prop.len = sizeof(remote_setprop_rssi_val),
+	},
+};
+
+static const struct generic_data bt_dev_setprop_rssi_fail_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_setprop_fail_device_found_cb,
+	.expected_cb_count = 3,
+	.expected_properties = remote_setprop_rssi_props,
+	.expected_adapter_status = BT_STATUS_FAIL,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2460,6 +2479,15 @@ static void test_dev_setprop_tod_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_setprop_rssi_fail(const void *test_data)
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
@@ -3157,6 +3185,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_dev_setprop_tod_fail, teardown);
 
+	test_bredrle("Bluetooth Device Set RSSI - Fail",
+				&bt_dev_setprop_rssi_fail_test,
+				setup_enabled_adapter,
+				test_dev_setprop_rssi_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

