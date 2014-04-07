Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] android/tester: Add register client success test case
Date: Mon,  7 Apr 2014 14:05:20 +0200
Message-Id: <1396872323-19162-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds register client success test case along with setup for gatt
test case routines.
---
 android/android-tester.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index e7a8280..f6f82ad 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -42,6 +42,7 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
+#include <hardware/bt_gatt.h>
 
 #include "utils.h"
 
@@ -81,6 +82,13 @@ struct hidhost_generic_data {
 	int expected_report_size;
 };
 
+struct gatt_generic_data {
+	int32_t expected_gatt_status;
+	int expected_cb_count;
+	btgatt_client_callbacks_t expected_c_hal_cb;
+	btgatt_server_callbacks_t expected_s_hal_cb;
+};
+
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
@@ -100,6 +108,7 @@ struct test_data {
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
 	const bthh_interface_t *if_hid;
+	const btgatt_interface_t *if_gatt;
 
 	int conditions_left;
 
@@ -133,6 +142,10 @@ struct bt_cb_data {
 
 	int num;
 	bt_property_t *props;
+
+	int client_if;
+	bt_uuid_t app_uuid;
+	int gatt_status;
 };
 
 struct hh_cb_data {
@@ -314,6 +327,15 @@ static void expected_cb_count_init(struct test_data *data)
 	check_cb_count();
 }
 
+static void expected_gatt_cb_count_init(struct test_data *data)
+{
+	const struct gatt_generic_data *test_data = data->test_data;
+
+	data->cb_count = test_data->expected_cb_count;
+
+	check_cb_count();
+}
+
 static void mgmt_cb_init(struct test_data *data)
 {
 	const struct generic_data *test_data = data->test_data;
@@ -334,6 +356,14 @@ static void expected_status_init(struct test_data *data)
 		data->conditions_left--;
 }
 
+static void expected_gatt_status_init(struct test_data *data)
+{
+	const struct gatt_generic_data *test_data = data->test_data;
+
+	if (test_data->expected_gatt_status == BT_STATUS_NOT_EXPECTED)
+		data->conditions_left--;
+}
+
 static void test_property_init(struct test_data *data)
 {
 	const struct generic_data *test_data = data->test_data;
@@ -363,6 +393,16 @@ static void init_test_conditions(struct test_data *data)
 	test_property_init(data);
 }
 
+static void init_gatt_test_conditions(struct test_data *data)
+{
+	data->test_checks_valid = true;
+
+	data->conditions_left = 2;
+
+	expected_gatt_cb_count_init(data);
+	expected_gatt_status_init(data);
+}
+
 static void check_expected_status(uint8_t status)
 {
 	struct test_data *data = tester_get_data();
@@ -375,6 +415,18 @@ static void check_expected_status(uint8_t status)
 		tester_test_failed();
 }
 
+static void check_expected_gatt_status(int32_t status)
+{
+	struct test_data *data = tester_get_data();
+	const struct gatt_generic_data *test_data = data->test_data;
+
+	if (test_data->expected_gatt_status == status) {
+		data->conditions_left--;
+		test_update_state();
+	} else
+		tester_test_failed();
+}
+
 static int locate_property(gconstpointer expected_data,
 						gconstpointer received_prop)
 {
@@ -2609,6 +2661,11 @@ static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
+	if (data->if_gatt) {
+		data->if_gatt->cleanup();
+		data->if_gatt = NULL;
+	}
+
 	if (data->if_hid) {
 		data->if_hid->cleanup();
 		data->if_hid = NULL;
@@ -4392,6 +4449,163 @@ static void test_hidhost_get_report(const void *test_data)
 		tester_test_failed();
 }
 
+/* GATT test */
+
+#define GATT_SUCCESS	0x00000000
+#define GATT_FAILURE	0x00000101
+
+static bt_uuid_t register_client_uuid_val = {
+	.uu = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99,
+		0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff },
+};
+
+static void gatt_register_client_cb(int status, int client_if,
+							bt_uuid_t *app_uuid)
+{
+	struct test_data *data = tester_get_data();
+
+	if (memcmp(app_uuid->uu, &register_client_uuid_val.uu,
+							sizeof(bt_uuid_t))) {
+		tester_test_failed();
+		return;
+	}
+
+	check_expected_gatt_status(status);
+	data->cb_count--;
+	check_cb_count();
+}
+
+static gboolean gattc_register_client(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct gatt_generic_data *test = data->test_data;
+	struct bt_cb_data *cb_data = user_data;
+
+	if (data->test_checks_valid &&
+				test->expected_c_hal_cb.register_client_cb)
+		test->expected_c_hal_cb.register_client_cb(
+				cb_data->gatt_status, cb_data->client_if,
+				&cb_data->app_uuid);
+
+	g_free(cb_data);
+	return FALSE;
+}
+
+static void gattc_register_client_cb(int status, int client_if,
+							bt_uuid_t *app_uuid)
+{
+	struct bt_cb_data *cb_data = g_new0(struct bt_cb_data, 1);
+
+	cb_data->gatt_status = status;
+	cb_data->client_if = client_if;
+	cb_data->app_uuid = *app_uuid;
+
+	g_idle_add(gattc_register_client, cb_data);
+}
+
+static const struct gatt_generic_data bt_gatt_register_client = {
+	.expected_c_hal_cb.register_client_cb = gatt_register_client_cb,
+	.expected_cb_count = 1,
+	.expected_gatt_status = GATT_SUCCESS,
+};
+
+static const btgatt_client_callbacks_t btgatt_client_callbacks = {
+	.register_client_cb = gattc_register_client_cb,
+	.scan_result_cb = NULL,
+	.open_cb = NULL,
+	.close_cb = NULL,
+	.search_complete_cb = NULL,
+	.search_result_cb = NULL,
+	.get_characteristic_cb = NULL,
+	.get_descriptor_cb = NULL,
+	.get_included_service_cb = NULL,
+	.register_for_notification_cb = NULL,
+	.notify_cb = NULL,
+	.read_characteristic_cb = NULL,
+	.write_characteristic_cb = NULL,
+	.read_descriptor_cb = NULL,
+	.write_descriptor_cb = NULL,
+	.execute_write_cb = NULL,
+	.read_remote_rssi_cb = NULL,
+	.listen_cb = NULL
+};
+
+static const btgatt_server_callbacks_t btgatt_server_callbacks = {
+	.register_server_cb = NULL,
+	.connection_cb = NULL,
+	.service_added_cb = NULL,
+	.included_service_added_cb = NULL,
+	.characteristic_added_cb = NULL,
+	.descriptor_added_cb = NULL,
+	.service_started_cb = NULL,
+	.service_stopped_cb = NULL,
+	.service_deleted_cb = NULL,
+	.request_read_cb = NULL,
+	.request_write_cb = NULL,
+	.request_exec_write_cb = NULL,
+	.response_confirmation_cb = NULL
+};
+
+static const btgatt_callbacks_t btgatt_callbacks = {
+	.size = sizeof(btgatt_callbacks),
+	.client = &btgatt_client_callbacks,
+	.server = &btgatt_server_callbacks
+};
+
+static bool setup_gatt(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	const void *gatt;
+
+	if (!setup(data))
+		return false;
+
+	status = data->if_bluetooth->init(&bt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_bluetooth = NULL;
+		return false;
+	}
+
+	gatt = data->if_bluetooth->get_profile_interface(BT_PROFILE_GATT_ID);
+	if (!gatt)
+		return false;
+
+	data->if_gatt = gatt;
+
+	status = data->if_gatt->init(&btgatt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_gatt = NULL;
+		return false;
+	}
+
+	return true;
+}
+
+static void setup_gatt_enabled(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+
+	if (!setup_gatt(test_data)) {
+		tester_setup_failed();
+		return;
+	}
+
+	status = data->if_bluetooth->enable();
+	if (status != BT_STATUS_SUCCESS)
+		tester_setup_failed();
+}
+
+static void test_gatt_register_client(const void *test_data)
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
@@ -4826,5 +5040,10 @@ int main(int argc, char *argv[])
 	test_bredrle("HIDHost SendData Success",
 				NULL, setup_hidhost_connect,
 				test_hidhost_send_data, teardown);
+
+	test_bredrle("Bluetooth GATT - Register Client",
+				&bt_gatt_register_client, setup_gatt_enabled,
+				test_gatt_register_client, teardown);
+
 	return tester_run();
 }
-- 
1.9.1

