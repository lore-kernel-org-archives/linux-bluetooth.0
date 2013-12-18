Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] android/tester: Add COD set prop fail test case
Date: Wed, 18 Dec 2013 10:53:10 +0100
Message-Id: <1387360393-853-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387360393-853-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387360393-853-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds CLASS_OF_DEVICE set property fail test case due to only
get possibility.
---
 android/android-tester.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 0025f20..345d5c6 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -608,6 +608,16 @@ static const struct generic_data bluetooth_setprop_uuid_invalid_test = {
 	.expected_property.len = sizeof(setprop_uuids)
 };
 
+static uint32_t setprop_class_of_device = 0;
+
+static const struct generic_data bluetooth_setprop_cod_invalid_test = {
+	.expected_hal_callbacks = {ADAPTER_TEST_END},
+	.expected_adapter_status = BT_STATUS_FAIL,
+	.expected_property.type = BT_PROPERTY_CLASS_OF_DEVICE,
+	.expected_property.val = &setprop_class_of_device,
+	.expected_property.len = sizeof(setprop_class_of_device)
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -998,6 +1008,19 @@ static void test_setprop_uuid_invalid(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_cod_invalid(const void *test_data)
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
@@ -1058,6 +1081,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_setprop_uuid_invalid, teardown);
 
+	test_bredrle("Set CLASS_OF_DEVICE - Invalid",
+					&bluetooth_setprop_cod_invalid_test,
+					setup_enabled_adapter,
+					test_setprop_cod_invalid, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

