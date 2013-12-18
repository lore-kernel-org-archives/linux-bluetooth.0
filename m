Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] android/tester: Add UUIDS set prop fail test case
Date: Wed, 18 Dec 2013 10:53:09 +0100
Message-Id: <1387360393-853-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds UUIDS set property fail test case due to only get
possibility.
---
 android/android-tester.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 92e6080..0025f20 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -596,6 +596,18 @@ static const struct generic_data bluetooth_getprop_bdname_success_test = {
 	.expected_property.len = 17
 };
 
+static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
+			0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00 };
+
+static const struct generic_data bluetooth_setprop_uuid_invalid_test = {
+	.expected_hal_callbacks = {ADAPTER_TEST_END},
+	.expected_adapter_status = BT_STATUS_FAIL,
+	.expected_property.type = BT_PROPERTY_UUIDS,
+	.expected_property.val = &setprop_uuids,
+	.expected_property.len = sizeof(setprop_uuids)
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -973,6 +985,19 @@ static void test_getprop_bdname_success(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_uuid_invalid(const void *test_data)
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
@@ -1028,6 +1053,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_getprop_bdname_success, teardown);
 
+	test_bredrle("Set UUID - Invalid",
+					&bluetooth_setprop_uuid_invalid_test,
+					setup_enabled_adapter,
+					test_setprop_uuid_invalid, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

