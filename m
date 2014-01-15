Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/12] android/tester: Add set device BDADDR prop fail test case
Date: Wed, 15 Jan 2014 13:17:04 +0100
Message-Id: <1389788228-32195-8-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds set device BDADDR property fail test case.
---
 android/android-tester.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 3109966..06ed997 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1814,6 +1814,27 @@ static const struct generic_data bt_dev_setprop_timpestamp_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static bt_bdaddr_t remote_setprop_bdaddr_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x00, 0x00, 0x00 }
+};
+
+static struct priority_property remote_setprop_bdaddr_props[] = {
+	{
+	.prop.type = BT_PROPERTY_BDADDR,
+	.prop.val = &remote_setprop_bdaddr_val,
+	.prop.len = sizeof(remote_setprop_bdaddr_val),
+	},
+};
+
+static const struct generic_data bt_dev_setprop_bdaddr_fail_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_setprop_fail_device_found_cb,
+	.expected_cb_count = 3,
+	.expected_properties = remote_setprop_bdaddr_props,
+	.expected_adapter_status = BT_STATUS_FAIL,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2516,6 +2537,15 @@ static void test_dev_setprop_timestamp_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_setprop_bdaddr_fail(const void *test_data)
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
@@ -3223,6 +3253,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_dev_setprop_timestamp_fail, teardown);
 
+	test_bredrle("Bluetooth Device Set BDADDR - Fail",
+				&bt_dev_setprop_bdaddr_fail_test,
+				setup_enabled_adapter,
+				test_dev_setprop_bdaddr_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

