Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] android/tester: Add unregister client success test case
Date: Mon,  7 Apr 2014 14:05:22 +0200
Message-Id: <1396872323-19162-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds unregister client success test case
---
 android/android-tester.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 986c26f..9e782c9 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -4495,6 +4495,19 @@ static void gatt_fail_register_client_cb(int status, int client_if,
 	}
 }
 
+static void le_unreg_register_client_cb(int status, int client_if,
+							bt_uuid_t *app_uuid)
+{
+	struct test_data *data = tester_get_data();
+	int32_t gatt_status;
+
+	gatt_status = data->if_gatt->client->unregister_client(client_if);
+
+	check_expected_gatt_status(gatt_status);
+	data->cb_count--;
+	check_cb_count();
+}
+
 static gboolean gattc_register_client(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -4535,6 +4548,12 @@ static const struct gatt_generic_data bt_gatt_register_client_fail = {
 	.expected_gatt_status = GATT_FAILURE,
 };
 
+static const struct gatt_generic_data bt_gatt_unregister_client = {
+	.expected_c_hal_cb.register_client_cb = le_unreg_register_client_cb,
+	.expected_gatt_status = GATT_SUCCESS,
+	.expected_cb_count = 1,
+};
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = NULL,
@@ -4641,6 +4660,15 @@ static void test_gatt_register_client_fail(const void *test_data)
 	data->if_gatt->client->register_client(&register_client_uuid_val);
 }
 
+static void test_gatt_unregister_client(const void *test_data)
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
@@ -5084,5 +5112,9 @@ int main(int argc, char *argv[])
 			&bt_gatt_register_client_fail, setup_gatt_enabled,
 			test_gatt_register_client_fail, teardown);
 
+	test_bredrle("Bluetooth GATT - Unregister Client",
+				&bt_gatt_unregister_client, setup_gatt_enabled,
+				test_gatt_unregister_client, teardown);
+
 	return tester_run();
 }
-- 
1.9.1

