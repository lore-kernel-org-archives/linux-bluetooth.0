Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] android/tester: Add SCAN_MODE=CONNECTABLE set prop success test case
Date: Mon, 30 Dec 2013 15:25:06 +0100
Message-Id: <1388413509-31265-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1388413509-31265-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1388413509-31265-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds SCAN_MODE property set to CONNECTABLE - success test case.
---
 android/android-tester.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index d7ebc02..358c58b 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -809,6 +809,18 @@ static const struct generic_data bluetooth_setprop_bdaddr_invalid_test = {
 	.set_property.len = sizeof(setprop_bdaddr),
 };
 
+static bt_scan_mode_t setprop_scanmode_connectable = BT_SCAN_MODE_CONNECTABLE;
+
+static const struct generic_data
+			bluetooth_setprop_scanmode_connectable_success_test = {
+	.expected_hal_cb.adapter_properties_cb = getprop_success_cb,
+	.expected_cb_count = 1,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_property.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.expected_property.val = &setprop_scanmode_connectable,
+	.expected_property.len = sizeof(setprop_scanmode_connectable),
+};
+
 static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_hal_cb.discovery_state_changed_cb =
 						discovery_start_success_cb,
@@ -1158,6 +1170,19 @@ static void test_setprop_bdaddr_invalid(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_scanmode_connectable_success(const void *test_data)
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
 static void test_discovery_start_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1722,6 +1747,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_setprop_bdaddr_invalid, teardown);
 
+	test_bredrle("Bluetooth Set SCAN_MODE CONNECTABLE - Success",
+			&bluetooth_setprop_scanmode_connectable_success_test,
+			setup_enabled_adapter,
+			test_setprop_scanmode_connectable_success, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
-- 
1.8.4.2

