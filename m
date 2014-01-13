Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/15] android/tester: Add get remote UUIDS property success test case
Date: Mon, 13 Jan 2014 18:12:30 +0100
Message-Id: <1389633161-11357-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389633161-11357-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds remote UUIDS property success test case.
---
 android/android-tester.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 674d3f6..a4dac42 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1337,6 +1337,27 @@ static const struct generic_data
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static struct priority_property remote_getprop_uuids_props[] = {
+	{
+	.prop.type = BT_PROPERTY_UUIDS,
+	.prop.val = NULL,
+	.prop.len = 0,
+	},
+};
+
+static const struct generic_data
+				bluetooth_remote_getprop_uuids_success_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_get_property_device_found_cb,
+	.expected_hal_cb.remote_device_properties_cb =
+			remote_test_device_properties_cb,
+	.expected_cb_count = 3,
+	.expected_properties_num = 1,
+	.expected_properties = remote_getprop_uuids_props,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -1868,6 +1889,15 @@ static void test_remote_getprop_bdname__success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_remote_getprop_uuids_success(const void *test_data)
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
@@ -2479,6 +2509,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_remote_getprop_bdname__success, teardown);
 
+	test_bredrle("Bluetooth RemDev Get UUIDS - Success",
+				&bluetooth_remote_getprop_uuids_success_test,
+				setup_enabled_adapter,
+				test_remote_getprop_uuids_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

