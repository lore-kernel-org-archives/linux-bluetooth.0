Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] android/tester: Add BONDED_DEVICES set prop fail test case
Date: Mon, 30 Dec 2013 15:25:07 +0100
Message-Id: <1388413509-31265-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1388413509-31265-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1388413509-31265-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds BONDED_DEVICES set property fail test case due to only
get possibility.
---
 android/android-tester.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 358c58b..15f427c 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -821,6 +821,18 @@ static const struct generic_data
 	.expected_property.len = sizeof(setprop_scanmode_connectable),
 };
 
+static bt_bdaddr_t setprop_bonded_devices = {
+	.address = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 },
+};
+
+static const struct generic_data
+			bluetooth_setprop_bonded_devices_invalid_test = {
+	.expected_adapter_status = BT_STATUS_FAIL,
+	.set_property.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
+	.set_property.val = &setprop_bonded_devices,
+	.set_property.len = sizeof(setprop_bonded_devices),
+};
+
 static const struct generic_data bluetooth_discovery_start_success_test = {
 	.expected_hal_cb.discovery_state_changed_cb =
 						discovery_start_success_cb,
@@ -1183,6 +1195,19 @@ static void test_setprop_scanmode_connectable_success(const void *test_data)
 	check_expected_status(adapter_status);
 }
 
+static void test_setprop_bonded_devices_invalid(const void *test_data)
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
@@ -1752,6 +1777,11 @@ int main(int argc, char *argv[])
 			setup_enabled_adapter,
 			test_setprop_scanmode_connectable_success, teardown);
 
+	test_bredrle("Bluetooth Set BONDED_DEVICES - Invalid",
+				&bluetooth_setprop_bonded_devices_invalid_test,
+				setup_enabled_adapter,
+				test_setprop_bonded_devices_invalid, teardown);
+
 	test_bredrle("Bluetooth BREDR Discovery Start - Success",
 				&bluetooth_discovery_start_success_test,
 				setup_enabled_adapter,
-- 
1.8.4.2

