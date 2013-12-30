Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] android/tester: Add TYPE_OF_DEVICE get prop success test case
Date: Mon, 30 Dec 2013 15:25:09 +0100
Message-Id: <1388413509-31265-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1388413509-31265-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1388413509-31265-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds TYPE_OF_DEVICE get property success test case.
---
 android/android-tester.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index c548e35..c89b97a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -844,6 +844,17 @@ static const struct generic_data bluetooth_getprop_cod_success_test = {
 	.expected_property.len = sizeof(getprop_cod),
 };
 
+static bt_device_type_t getprop_tod = BT_DEVICE_DEVTYPE_BREDR;
+
+static const struct generic_data bluetooth_getprop_tod_success_test = {
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_TYPE_OF_DEVICE,
+	.expected_property.val = &getprop_tod,
+	.expected_property.len = sizeof(getprop_tod),
+};
+
 static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_hal_cb.discovery_state_changed_cb =
 						discovery_start_success_cb,
@@ -1232,6 +1243,19 @@ static void test_getprop_cod_success(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_getprop_tod_success(const void *test_data)
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
 static void test_discovery_start_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1811,6 +1835,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_getprop_cod_success, teardown);
 
+	test_bredrle("Bluetooth Get TYPE_OF_DEVICE - Success",
+					&bluetooth_getprop_tod_success_test,
+					setup_enabled_adapter,
+					test_getprop_tod_success, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
-- 
1.8.4.2

