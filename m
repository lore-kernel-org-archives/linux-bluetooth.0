Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] android/tester: Add bdname get prop success test case
Date: Thu, 12 Dec 2013 18:14:35 +0100
Message-Id: <1386868475-9610-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1386868475-9610-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1386868475-9610-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds bdname set property success test case. First bdname is set and
then is read.
---
 android/android-tester.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 407bfbe..280870a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -623,6 +623,15 @@ static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
 	.expected_property.len = sizeof(bt_bdaddr_t)
 };
 
+static const struct generic_data bluetooth_getprop_bdname_success_test = {
+	.expected_hal_callbacks = {adapter_prop_bdname, adapter_prop_bdname,
+							adapter_test_end},
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_BDNAME,
+	.expected_property.val = "test_bdname_setget",
+	.expected_property.len = 17
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -892,6 +901,22 @@ static void test_getprop_bdaddr_success(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_getprop_bdname_success(const void *test_data)
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
+
+	adapter_status = data->if_bluetooth->get_adapter_property((*prop).type);
+	check_expected_status(adapter_status);
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -942,6 +967,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_getprop_bdaddr_success, teardown);
 
+	test_bredrle("Test Get BDNAME - Success",
+					&bluetooth_getprop_bdname_success_test,
+					setup_enabled_adapter,
+					test_getprop_bdname_success, teardown);
+
 	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

