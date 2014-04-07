Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] android/tester: Add unregister client fail test case
Date: Mon,  7 Apr 2014 14:05:23 +0200
Message-Id: <1396872323-19162-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds unregister client fail test case. Test case try to unregister
not registered client handled by client_if.
---
 android/android-tester.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 9e782c9..ef65ec6 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -4508,6 +4508,19 @@ static void le_unreg_register_client_cb(int status, int client_if,
 	check_cb_count();
 }
 
+static void gatt_unreg_register_client_fail_cb(int status, int client_if,
+							bt_uuid_t *app_uuid)
+{
+	struct test_data *data = tester_get_data();
+	int32_t gatt_status;
+
+	gatt_status = data->if_gatt->client->unregister_client(++client_if);
+
+	check_expected_gatt_status(gatt_status);
+	data->cb_count--;
+	check_cb_count();
+}
+
 static gboolean gattc_register_client(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -4554,6 +4567,12 @@ static const struct gatt_generic_data bt_gatt_unregister_client = {
 	.expected_cb_count = 1,
 };
 
+static const struct gatt_generic_data bt_gatt_unregister_client_fail = {
+	.expected_c_hal_cb.register_client_cb =
+					gatt_unreg_register_client_fail_cb,
+	.expected_gatt_status = BT_STATUS_FAIL,
+};
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = NULL,
@@ -4669,6 +4688,15 @@ static void test_gatt_unregister_client(const void *test_data)
 	data->if_gatt->client->register_client(&register_client_uuid_val);
 }
 
+static void test_gatt_unregister_client_fail(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	init_gatt_test_conditions(data);
+
+	data->if_gatt->client->register_client(&register_client_uuid_val);
+}
+
 #define test_bredr(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -5116,5 +5144,9 @@ int main(int argc, char *argv[])
 				&bt_gatt_unregister_client, setup_gatt_enabled,
 				test_gatt_unregister_client, teardown);
 
+	test_bredrle("Bluetooth GATT - Unregister Client Fail",
+			&bt_gatt_unregister_client_fail, setup_gatt_enabled,
+			test_gatt_unregister_client_fail, teardown);
+
 	return tester_run();
 }
-- 
1.9.1

