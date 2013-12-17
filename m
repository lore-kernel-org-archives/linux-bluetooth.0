Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] android/tester: Add TOD set prop fail test case
Date: Tue, 17 Dec 2013 13:37:52 +0100
Message-Id: <1387283874-29721-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds TYPE_OF_DEVICE set property fail test case due to only
get possibility.
---
 android/android-tester.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index a6f66c2..4923a6c 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -618,6 +618,16 @@ static const struct generic_data bluetooth_setprop_cod_invalid_test = {
 	.expected_property.len = sizeof(uint32_t)
 };
 
+static bt_device_type_t setprop_type_of_device = BT_DEVICE_DEVTYPE_BREDR;
+
+static const struct generic_data bluetooth_setprop_tod_invalid_test = {
+	.expected_hal_callbacks = {ADAPTER_TEST_END},
+	.expected_adapter_status = BT_STATUS_FAIL,
+	.expected_property.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.expected_property.val = &setprop_type_of_device,
+	.expected_property.len = sizeof(bt_device_type_t)
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -1021,6 +1031,19 @@ static void test_setprop_cod_invalid(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_tod_invalid(const void *test_data)
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
@@ -1086,6 +1109,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_setprop_cod_invalid, teardown);
 
+	test_bredrle("Set TYPE_OF_DEVICE - Invalid",
+					&bluetooth_setprop_tod_invalid_test,
+					setup_enabled_adapter,
+					test_setprop_tod_invalid, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

