Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] android/tester: Add bdaddr get prop success test case
Date: Thu, 12 Dec 2013 18:14:34 +0100
Message-Id: <1386868475-9610-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1386868475-9610-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1386868475-9610-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds bdaddr set property success test case.
---
 android/android-tester.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 5b7082a..407bfbe 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -615,6 +615,14 @@ static const struct generic_data bluetooth_setprop_disctimeout_success_test = {
 	.expected_property.len = sizeof(test_setprop_disctimeout_val)
 };
 
+static const struct generic_data bluetooth_getprop_bdaddr_success_test = {
+	.expected_hal_callbacks = {adapter_prop_bdaddr, adapter_test_end},
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_BDADDR,
+	.expected_property.val = NULL,
+	.expected_property.len = sizeof(bt_bdaddr_t)
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -871,6 +879,19 @@ static void test_setprop_disctimeout_succes(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_getprop_bdaddr_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const bt_property_t prop = test->expected_property;
+	bt_status_t adapter_status;
+
+	init_test_conditions(data);
+
+	adapter_status = data->if_bluetooth->get_adapter_property(prop.type);
+	check_expected_status(adapter_status);
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -916,6 +937,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_setprop_disctimeout_succes, teardown);
 
+	test_bredrle("Test Get BDADDR - Success",
+					&bluetooth_getprop_bdaddr_success_test,
+					setup_enabled_adapter,
+					test_getprop_bdaddr_success, teardown);
+
 	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.4.2

