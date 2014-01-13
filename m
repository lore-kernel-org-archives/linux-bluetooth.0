Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/15] android/tester: Add get remote DISCTIMEOUT property fail test case
Date: Mon, 13 Jan 2014 18:12:39 +0100
Message-Id: <1389633161-11357-13-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds remote DISCOVERY TIMEOUT property fail test case.
---
 android/android-tester.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index f4acbd1..04329c2 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1540,6 +1540,28 @@ static const struct generic_data
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static uint32_t remote_getprop_disctimeout_val = 120;
+
+static struct priority_property remote_getprop_disctimeout_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.prop.val = &remote_getprop_disctimeout_val,
+	.prop.len = sizeof(remote_getprop_disctimeout_val),
+	},
+};
+
+static const struct generic_data
+			bluetooth_remote_getprop_disctimeout_fail_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_get_property_device_found_cb,
+	.expected_hal_cb.remote_device_properties_cb =
+					remote_test_device_properties_cb,
+	.expected_cb_count = 3,
+	.expected_properties = remote_getprop_disctimeout_props,
+	.expected_adapter_status = BT_STATUS_FAIL,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2152,6 +2174,15 @@ static void test_remote_getprop_bonded_devices_success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_remote_getprop_disctimeout_fail(const void *test_data)
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
@@ -2808,6 +2839,11 @@ int main(int argc, char *argv[])
 			setup_enabled_adapter,
 			test_remote_getprop_bonded_devices_success, teardown);
 
+	test_bredrle("Bluetooth RemDev Get DISCOVERY_TIMEOUT - Fail",
+				&bluetooth_remote_getprop_disctimeout_fail_test,
+				setup_enabled_adapter,
+				test_remote_getprop_disctimeout_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

