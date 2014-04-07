Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] android/tester: Add register client fail test case
Date: Mon,  7 Apr 2014 14:05:21 +0200
Message-Id: <1396872323-19162-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds register client fail test case. Test case try to register
client with already registered UUID.
---
 android/android-tester.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index f6f82ad..986c26f 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -4475,6 +4475,26 @@ static void gatt_register_client_cb(int status, int client_if,
 	check_cb_count();
 }
 
+static void gatt_fail_register_client_cb(int status, int client_if,
+							bt_uuid_t *app_uuid)
+{
+	struct test_data *data = tester_get_data();
+
+	if (data->cb_count == 2) {
+		data->if_gatt->client->register_client(
+						&register_client_uuid_val);
+		data->cb_count--;
+		check_cb_count();
+		return;
+	}
+
+	if (data->cb_count == 1) {
+		check_expected_gatt_status(status);
+		data->cb_count--;
+		check_cb_count();
+	}
+}
+
 static gboolean gattc_register_client(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -4509,6 +4529,12 @@ static const struct gatt_generic_data bt_gatt_register_client = {
 	.expected_gatt_status = GATT_SUCCESS,
 };
 
+static const struct gatt_generic_data bt_gatt_register_client_fail = {
+	.expected_c_hal_cb.register_client_cb = gatt_fail_register_client_cb,
+	.expected_cb_count = 2,
+	.expected_gatt_status = GATT_FAILURE,
+};
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = NULL,
@@ -4606,6 +4632,15 @@ static void test_gatt_register_client(const void *test_data)
 	data->if_gatt->client->register_client(&register_client_uuid_val);
 }
 
+static void test_gatt_register_client_fail(const void *test_data)
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
@@ -5045,5 +5080,9 @@ int main(int argc, char *argv[])
 				&bt_gatt_register_client, setup_gatt_enabled,
 				test_gatt_register_client, teardown);
 
+	test_bredrle("Bluetooth GATT - Register Client - Fail",
+			&bt_gatt_register_client_fail, setup_gatt_enabled,
+			test_gatt_register_client_fail, teardown);
+
 	return tester_run();
 }
-- 
1.9.1

