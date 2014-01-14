Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/15] android/tester: Add get device SERVREC property fail test case
Date: Tue, 14 Jan 2014 14:54:41 +0100
Message-Id: <1389707686-30766-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389707686-30766-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389707686-30766-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds device SERVICE RECORD property fail test case.
---
 android/android-tester.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index b7309e7..8eddf2a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1463,6 +1463,31 @@ static const struct generic_data bt_dev_getprop_bdaddr_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
+static bt_service_record_t remote_getprop_servrec_val = {
+	.uuid = { {0x00} },
+	.channel = 12,
+	.name = "bt_name",
+};
+
+static struct priority_property remote_getprop_servrec_props[] = {
+	{
+	.prop.type = BT_PROPERTY_SERVICE_RECORD,
+	.prop.val = &remote_getprop_servrec_val,
+	.prop.len = sizeof(remote_getprop_servrec_val),
+	},
+};
+
+static const struct generic_data bt_dev_getprop_servrec_fail_test = {
+	.expected_hal_cb.discovery_state_changed_cb =
+					remote_discovery_state_changed_cb,
+	.expected_hal_cb.device_found_cb = remote_get_property_device_found_cb,
+	.expected_hal_cb.remote_device_properties_cb =
+					remote_test_device_properties_cb,
+	.expected_cb_count = 3,
+	.expected_properties = remote_getprop_servrec_props,
+	.expected_adapter_status = BT_STATUS_FAIL,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -2048,6 +2073,15 @@ static void test_dev_getprop_bdaddr_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_dev_getprop_servrec_fail(const void *test_data)
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
@@ -2689,6 +2723,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_dev_getprop_bdaddr_fail, teardown);
 
+	test_bredrle("Bluetooth Device Get SERVICE_RECORD - Fail",
+				&bt_dev_getprop_servrec_fail_test,
+				setup_enabled_adapter,
+				test_dev_getprop_servrec_fail, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

