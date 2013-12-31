Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] android/tester: Add DISCOVERY_TIMEOUT get prop success test case
Date: Tue, 31 Dec 2013 15:46:28 +0100
Message-Id: <1388501191-5377-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1388501191-5377-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1388501191-5377-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds DISCOVERY_TIMEOUT get property success test case.
---
 android/android-tester.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index d831f74..f02d4ac 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -866,6 +866,17 @@ static const struct generic_data bluetooth_getprop_scanmode_success_test = {
 	.expected_property.len = sizeof(getprop_scanmode),
 };
 
+static uint32_t getprop_disctimeout_val = 120;
+
+static const struct generic_data bluetooth_getprop_disctimeout_success_test = {
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
+	.expected_property.val = &getprop_disctimeout_val,
+	.expected_property.len = sizeof(getprop_disctimeout_val),
+};
+
 static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_hal_cb.discovery_state_changed_cb =
 						discovery_start_success_cb,
@@ -1280,6 +1291,19 @@ static void test_getprop_scanmode_success(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_getprop_disctimeout_success(const void *test_data)
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
@@ -1869,6 +1893,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_getprop_scanmode_success, teardown);
 
+	test_bredrle("Bluetooth Get DISCOVERY_TIMEOUT - Success",
+				&bluetooth_getprop_disctimeout_success_test,
+				setup_enabled_adapter,
+				test_getprop_disctimeout_success, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
-- 
1.8.5.2

