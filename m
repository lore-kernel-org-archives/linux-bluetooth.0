Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/12] android/tester: Add set device BONDED_DEV prop fail test case
Date: Wed, 15 Jan 2014 13:17:07 +0100
Message-Id: <1389788228-32195-11-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds set device BONDED DEVICES property fail test case.
---
 android/android-tester.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index e3c39ce..378d319 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1877,6 +1877,27 @@ static const struct generic_data bt_dev_setprop_scanmode_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static bt_bdaddr_t remote_setprop_bondeddev_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x00, 0x00, 0x00 }
+};
+
+static struct priority_property remote_setprop_bondeddev_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.prop.val = &remote_setprop_bondeddev_val,
+	.prop.len = sizeof(remote_setprop_bondeddev_val),
+	},
+};
+
+static const struct generic_data bt_dev_setprop_bondeddev_fail_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_setprop_fail_device_found_cb,
+	.expected_cb_count = 3,
+	.expected_properties = remote_setprop_bondeddev_props,
+	.expected_adapter_status = BT_STATUS_FAIL,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2606,6 +2627,15 @@ static void test_dev_setprop_scanmode_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_setprop_bondeddev_fail(const void *test_data)
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
@@ -3328,6 +3358,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_dev_setprop_scanmode_fail, teardown);
 
+	test_bredrle("Bluetooth Device Set BONDED_DEVICES - Fail",
+				&bt_dev_setprop_bondeddev_fail_test,
+				setup_enabled_adapter,
+				test_dev_setprop_bondeddev_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

