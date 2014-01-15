Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/12] android/tester: Add set device SCAN_MODE prop fail test case
Date: Wed, 15 Jan 2014 13:17:06 +0100
Message-Id: <1389788228-32195-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds set device SCAN MODE property fail test case.
---
 android/android-tester.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 69e477c..e3c39ce 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1858,6 +1858,25 @@ static const struct generic_data bt_dev_setprop_servrec_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static bt_scan_mode_t remote_setprop_scanmode_val = BT_SCAN_MODE_CONNECTABLE;
+
+static struct priority_property remote_setprop_scanmode_props[] = {
+	{
+	.prop.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.prop.val = &remote_setprop_scanmode_val,
+	.prop.len = sizeof(remote_setprop_scanmode_val),
+	},
+};
+
+static const struct generic_data bt_dev_setprop_scanmode_fail_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_setprop_fail_device_found_cb,
+	.expected_cb_count = 3,
+	.expected_properties = remote_setprop_scanmode_props,
+	.expected_adapter_status = BT_STATUS_FAIL,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2578,6 +2597,15 @@ static void test_dev_setprop_servrec_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_setprop_scanmode_fail(const void *test_data)
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
@@ -3295,6 +3323,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_dev_setprop_servrec_fail, teardown);
 
+	test_bredrle("Bluetooth Device Set SCAN_MODE - Fail",
+				&bt_dev_setprop_scanmode_fail_test,
+				setup_enabled_adapter,
+				test_dev_setprop_scanmode_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

