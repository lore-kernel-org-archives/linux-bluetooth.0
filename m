Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 09/15] android/tester-ng: Add basic GATT init test
Date: Fri,  9 May 2014 16:42:42 +0200
Message-Id: <1399646568-20742-9-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

---
 android/android-tester-ng.c | 153 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 1 deletion(-)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index 57c93da..2c4aa21 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -40,6 +40,9 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
+#include <hardware/bt_gatt.h>
+#include <hardware/bt_gatt_client.h>
+#include <hardware/bt_gatt_server.h>
 
 /*
  * NOTICE:
@@ -58,7 +61,42 @@ typedef enum {
 	CB_BT_ACL_STATE_CHANGED,
 	CB_BT_THREAD_EVT,
 	CB_BT_DUT_MODE_RECV,
-	CB_BT_LE_TEST_MODE
+	CB_BT_LE_TEST_MODE,
+
+	/* GATT CLIENT */
+	CB_GATTC_REGISTER_CLIENT,
+	CB_GATTC_SCAN_RESULT,
+	CB_GATTC_OPEN,
+	CB_GATTC_CLOSE,
+	CB_GATTC_SEARCH_COMPLETE,
+	CB_GATTC_SEARCH_RESULT,
+	CB_GATTC_GET_CHARACTERISTIC,
+	CB_GATTC_GET_DESCRIPTOR,
+	CB_GATTC_GET_INCLUDED_SERVICE,
+	CB_GATTC_REGISTER_FOR_NOTIFICATION,
+	CB_GATTC_NOTIFY,
+	CB_GATTC_READ_CHARACTERISTIC,
+	CB_GATTC_WRITE_CHARACTERISTIC,
+	CB_GATTC_READ_DESCRIPTOR,
+	CB_GATTC_WRITE_DESCRIPTOR,
+	CB_GATTC_EXECUTE_WRITE,
+	CB_GATTC_READ_REMOTE_RSSI,
+	CB_GATTC_LISTEN,
+
+	/* GATT SERVER */
+	CB_GATTS_REGISTER_SERVER,
+	CB_GATTS_CONNECTION,
+	CB_GATTS_SERVICE_ADDED,
+	CB_GATTS_INCLUDED_SERVICE_ADDED,
+	CB_GATTS_CHARACTERISTIC_ADDED,
+	CB_GATTS_DESCRIPTOR_ADDED,
+	CB_GATTS_SERVICE_STARTED,
+	CB_GATTS_SERVICE_STOPPED,
+	CB_GATTS_SERVICE_DELETED,
+	CB_GATTS_REQUEST_READ,
+	CB_GATTS_REQUEST_WRITE,
+	CB_GATTS_REQUEST_EXEC_WRITE,
+	CB_GATTS_RESPONSE_CONFIRMATION,
 } expected_bt_callback_t;
 
 /*
@@ -68,6 +106,10 @@ typedef enum {
  */
 struct bt_callback_data {
 	bt_state_t state;
+	bt_status_t status;
+
+	bt_uuid_t gatt_app_uuid;
+	int32_t gatt_client_id;
 };
 
 /*
@@ -103,6 +145,7 @@ struct test_data {
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
 	const bthh_interface_t *if_hid;
+	const btgatt_interface_t *if_gatt;
 
 	const void *test_data;
 	struct queue *steps;
@@ -467,6 +510,26 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
+	if (exp->callback_result.status && (exp->callback_result.status !=
+						step->callback_result.status)) {
+		tester_debug("Callback status don't match");
+		return false;
+	}
+
+	if (exp->callback_result.gatt_client_id &&
+					(exp->callback_result.gatt_client_id !=
+					step->callback_result.gatt_client_id)) {
+		tester_debug("Gatt client id don't match");
+		return false;
+	}
+
+	if (memcmp(&exp->callback_result.gatt_app_uuid,
+				&step->callback_result.gatt_app_uuid,
+				sizeof(exp->callback_result.gatt_app_uuid))) {
+		tester_debug("Gatt app uuid don't match");
+		return false;
+	}
+
 	return true;
 }
 
@@ -593,6 +656,49 @@ static bthh_callbacks_t bthh_callbacks = {
 	.virtual_unplug_cb = NULL
 };
 
+static const btgatt_client_callbacks_t btgatt_client_callbacks = {
+	.register_client_cb = NULL,
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
 static bool setup_base(struct test_data *data)
 {
 	const hw_module_t *module;
@@ -741,6 +847,43 @@ static void setup_hidhost(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_gatt(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	const void *gatt;
+
+	if (!setup_base(data)){
+		tester_setup_failed();
+		return;
+	}
+
+	status = data->if_bluetooth->init(&bt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_bluetooth = NULL;
+		tester_setup_failed();
+		return;
+	}
+
+	gatt = data->if_bluetooth->get_profile_interface(BT_PROFILE_GATT_ID);
+	if (!gatt) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_gatt = gatt;
+
+	status = data->if_gatt->init(&btgatt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_gatt = NULL;
+
+		tester_setup_failed();
+		return;
+	}
+
+	tester_setup_complete();
+}
+
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -748,6 +891,11 @@ static void teardown(const void *test_data)
 	queue_destroy(data->steps, NULL);
 	data->steps = NULL;
 
+	if (data->if_gatt) {
+		data->if_gatt->cleanup();
+		data->if_gatt = NULL;
+	}
+
 	if (data->if_hid) {
 		data->if_hid->cleanup();
 		data->if_hid = NULL;
@@ -927,5 +1075,8 @@ int main(int argc, char *argv[])
 	test_bredrle("HIDHost Init", dummy_steps, setup_hidhost,
 					generic_test_function, teardown);
 
+	test_bredrle("GATT Init", dummy_steps, setup_gatt,
+					generic_test_function, teardown);
+
 	return tester_run();
 }
-- 
1.9.2

