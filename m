Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] android/tester: Add SERVICE_RECORD set prop fail test case
Date: Wed, 18 Dec 2013 10:53:13 +0100
Message-Id: <1387360393-853-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387360393-853-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387360393-853-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds SERVICE_RECORD set property fail test case due to only
get possibility.
---
 android/android-tester.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 9bae94d..3d439de 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -638,6 +638,21 @@ static const struct generic_data bluetooth_setprop_remote_rssi_invalid_test = {
 	.expected_property.len = sizeof(setprop_remote_rssi)
 };
 
+static bt_service_record_t setprop_remote_service = {
+	.uuid = { {0x00} },
+	.channel = 12,
+	.name = "bt_name"
+};
+
+static const struct generic_data
+			bluetooth_setprop_service_record_invalid_test = {
+	.expected_hal_callbacks = {ADAPTER_TEST_END},
+	.expected_adapter_status = BT_STATUS_FAIL,
+	.expected_property.type = BT_PROPERTY_SERVICE_RECORD,
+	.expected_property.val = &setprop_remote_service,
+	.expected_property.len = sizeof(setprop_remote_service)
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -1067,6 +1082,19 @@ static void test_setprop_rssi_invalid(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_service_record_invalid(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t *prop = &test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	check_expected_status(adapter_status);
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -1142,6 +1170,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_setprop_rssi_invalid, teardown);
 
+	test_bredrle("Set SERVICE_RECORD - Invalid",
+				&bluetooth_setprop_service_record_invalid_test,
+				setup_enabled_adapter,
+				test_setprop_service_record_invalid, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

