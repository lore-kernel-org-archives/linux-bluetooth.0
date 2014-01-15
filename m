Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/12] android/tester: Add set device SERVICE_RECORD prop fail test case
Date: Wed, 15 Jan 2014 13:17:05 +0100
Message-Id: <1389788228-32195-9-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389788228-32195-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds set device SERVICE RECORD property fail test case.
---
 android/android-tester.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 06ed997..69e477c 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1835,6 +1835,29 @@ static const struct generic_data bt_dev_setprop_bdaddr_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static bt_service_record_t remote_setprop_servrec_val = {
+	.uuid = { {0x00} },
+	.channel = 12,
+	.name = "bt_name",
+};
+
+static struct priority_property remote_setprop_servrec_props[] = {
+	{
+	.prop.type = BT_PROPERTY_SERVICE_RECORD,
+	.prop.val = &remote_setprop_servrec_val,
+	.prop.len = sizeof(remote_setprop_servrec_val),
+	},
+};
+
+static const struct generic_data bt_dev_setprop_servrec_fail_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_setprop_fail_device_found_cb,
+	.expected_cb_count = 3,
+	.expected_properties = remote_setprop_servrec_props,
+	.expected_adapter_status = BT_STATUS_FAIL,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2546,6 +2569,15 @@ static void test_dev_setprop_bdaddr_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_setprop_servrec_fail(const void *test_data)
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
@@ -3258,6 +3290,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_dev_setprop_bdaddr_fail, teardown);
 
+	test_bredrle("Bluetooth Device Set SERVICE_RECORD - Fail",
+				&bt_dev_setprop_servrec_fail_test,
+				setup_enabled_adapter,
+				test_dev_setprop_servrec_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

