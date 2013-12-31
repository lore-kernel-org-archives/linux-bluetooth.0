Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] android/tester: Add UUIDS get prop success test case
Date: Tue, 31 Dec 2013 15:46:29 +0100
Message-Id: <1388501191-5377-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1388501191-5377-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1388501191-5377-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds UUIDS get property success test case.
---
 android/android-tester.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index f02d4ac..ae6959b 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -877,6 +877,20 @@ static const struct generic_data bluetooth_getprop_disctimeout_success_test = {
 	.expected_property.len = sizeof(getprop_disctimeout_val),
 };
 
+static bt_uuid_t getprop_uuids = {
+	.uu = { 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
+					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB },
+};
+
+static const struct generic_data bluetooth_getprop_uuids_success_test = {
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_UUIDS,
+	.expected_property.val = &getprop_uuids,
+	.expected_property.len = sizeof(getprop_uuids),
+};
+
 static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_hal_cb.discovery_state_changed_cb =
 						discovery_start_success_cb,
@@ -1304,6 +1318,19 @@ static void test_getprop_disctimeout_success(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_getprop_uuids_success(const void *test_data)
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
@@ -1898,6 +1925,11 @@ int main(int argc, char *argv[])
 				setup_enabled_adapter,
 				test_getprop_disctimeout_success, teardown);
 
+	test_bredrle("Bluetooth Get UUIDS - Success",
+					&bluetooth_getprop_uuids_success_test,
+					setup_enabled_adapter,
+					test_getprop_uuids_success, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
-- 
1.8.5.2

