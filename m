Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] android/tester: put gatt callback declaration in right place
Date: Mon,  8 Dec 2014 11:35:05 +0100
Message-Id: <1418034908-1742-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1418034908-1742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418034908-1742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Gatt callback declaration should be defined after their definitions.
This is the adopted style.
---
 android/tester-main.c | 86 +++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 8f3bc3c..429838d 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1650,6 +1650,27 @@ static void gattc_notif_cb(int conn_id, btgatt_notify_params_t *p_data)
 	schedule_callback_verification(step);
 }
 
+static const btgatt_client_callbacks_t btgatt_client_callbacks = {
+	.register_client_cb = gattc_register_client_cb,
+	.scan_result_cb = gattc_scan_result_cb,
+	.open_cb = gattc_connect_cb,
+	.close_cb = gattc_disconnect_cb,
+	.search_complete_cb = gattc_search_complete_cb,
+	.search_result_cb = gattc_search_result_cb,
+	.get_characteristic_cb = gattc_get_characteristic_cb,
+	.get_descriptor_cb = gattc_get_descriptor_cb,
+	.get_included_service_cb = gattc_get_included_service_cb,
+	.register_for_notification_cb = gattc_register_for_notification_cb,
+	.notify_cb = gattc_notif_cb,
+	.read_characteristic_cb = gattc_read_characteristic_cb,
+	.write_characteristic_cb = gattc_write_characteristic_cb,
+	.read_descriptor_cb = gattc_read_descriptor_cb,
+	.write_descriptor_cb = gattc_write_descriptor_cb,
+	.execute_write_cb = NULL,
+	.read_remote_rssi_cb = NULL,
+	.listen_cb = gattc_listen_cb
+};
+
 static void gatts_register_server_cb(int status, int server_if,
 							bt_uuid_t *app_uuid)
 {
@@ -1862,6 +1883,28 @@ static void gatts_request_write_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
 	schedule_callback_verification(step);
 }
 
+static const btgatt_server_callbacks_t btgatt_server_callbacks = {
+	.register_server_cb = gatts_register_server_cb,
+	.connection_cb = gatts_connection_cb,
+	.service_added_cb = gatts_service_added_cb,
+	.included_service_added_cb = gatts_included_service_added_cb,
+	.characteristic_added_cb = gatts_characteristic_added_cb,
+	.descriptor_added_cb = gatts_descriptor_added_cb,
+	.service_started_cb = gatts_service_started_cb,
+	.service_stopped_cb = gatts_service_stopped_cb,
+	.service_deleted_cb = gatts_service_deleted_cb,
+	.request_read_cb = gatts_request_read_cb,
+	.request_write_cb = gatts_request_write_cb,
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
 static void pan_control_state_cb(btpan_control_state_t state, int local_role,
 					bt_status_t error, const char *ifname)
 {
@@ -1989,49 +2032,6 @@ static btrc_callbacks_t btavrcp_callbacks = {
 	.get_element_attr_cb = avrcp_get_element_attr_cb,
 };
 
-static const btgatt_client_callbacks_t btgatt_client_callbacks = {
-	.register_client_cb = gattc_register_client_cb,
-	.scan_result_cb = gattc_scan_result_cb,
-	.open_cb = gattc_connect_cb,
-	.close_cb = gattc_disconnect_cb,
-	.search_complete_cb = gattc_search_complete_cb,
-	.search_result_cb = gattc_search_result_cb,
-	.get_characteristic_cb = gattc_get_characteristic_cb,
-	.get_descriptor_cb = gattc_get_descriptor_cb,
-	.get_included_service_cb = gattc_get_included_service_cb,
-	.register_for_notification_cb = gattc_register_for_notification_cb,
-	.notify_cb = gattc_notif_cb,
-	.read_characteristic_cb = gattc_read_characteristic_cb,
-	.write_characteristic_cb = gattc_write_characteristic_cb,
-	.read_descriptor_cb = gattc_read_descriptor_cb,
-	.write_descriptor_cb = gattc_write_descriptor_cb,
-	.execute_write_cb = NULL,
-	.read_remote_rssi_cb = NULL,
-	.listen_cb = gattc_listen_cb
-};
-
-static const btgatt_server_callbacks_t btgatt_server_callbacks = {
-	.register_server_cb = gatts_register_server_cb,
-	.connection_cb = gatts_connection_cb,
-	.service_added_cb = gatts_service_added_cb,
-	.included_service_added_cb = gatts_included_service_added_cb,
-	.characteristic_added_cb = gatts_characteristic_added_cb,
-	.descriptor_added_cb = gatts_descriptor_added_cb,
-	.service_started_cb = gatts_service_started_cb,
-	.service_stopped_cb = gatts_service_stopped_cb,
-	.service_deleted_cb = gatts_service_deleted_cb,
-	.request_read_cb = gatts_request_read_cb,
-	.request_write_cb = gatts_request_write_cb,
-	.request_exec_write_cb = NULL,
-	.response_confirmation_cb = NULL
-};
-
-static const btgatt_callbacks_t btgatt_callbacks = {
-	.size = sizeof(btgatt_callbacks),
-	.client = &btgatt_client_callbacks,
-	.server = &btgatt_server_callbacks
-};
-
 static bool setup_base(struct test_data *data)
 {
 	const hw_module_t *module;
-- 
1.9.3

