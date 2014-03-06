Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/4] android/hal-gatt: Add Client Event handlers
Date: Thu,  6 Mar 2014 12:27:56 +0100
Message-Id: <1394105279-9165-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Call registered handlers with data received through IPC.
---
 android/hal-gatt.c | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 0e81a56..ce59f96 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -16,6 +16,7 @@
  */
 
 #include <stdbool.h>
+#include <string.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -29,96 +30,264 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
+static void gatt_id_from_hal(btgatt_gatt_id_t *to,
+						struct hal_gatt_gatt_id *from)
+{
+	memcpy(&to->uuid, from->uuid, sizeof(to->uuid));
+	to->inst_id = from->inst_id;
+}
+
+static void srvc_id_from_hal(btgatt_srvc_id_t *to,
+						struct hal_gatt_srvc_id *from)
+{
+	memcpy(&to->id.uuid, from->uuid, sizeof(to->id.uuid));
+	to->id.inst_id = from->inst_id;
+	to->is_primary = from->is_primary;
+}
+
 /* Client Event Handlers */
 
 static void handle_register_client(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_register_client *ev = buf;
 
+	if (cbs->client->register_client_cb)
+		cbs->client->register_client_cb(ev->status, ev->client_if,
+						(bt_uuid_t *) ev->app_uuid);
 }
 
 static void handle_scan_result(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_scan_result *ev = buf;
 
+	if (cbs->client->scan_result_cb)
+		cbs->client->scan_result_cb((bt_bdaddr_t *) ev->bda, ev->rssi,
+								ev->adv_data);
 }
 
 static void handle_connect(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_connect *ev = buf;
 
+	if (cbs->client->open_cb)
+		cbs->client->open_cb(ev->conn_id, ev->status, ev->client_if,
+						(bt_bdaddr_t *) ev->bda);
 }
 
 static void handle_disconnect(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_disconnect *ev = buf;
 
+	if (cbs->client->close_cb)
+		cbs->client->close_cb(ev->conn_id, ev->status, ev->client_if,
+						(bt_bdaddr_t *) ev->bda);
 }
 
 static void handle_search_complete(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_search_complete *ev = buf;
 
+	if (cbs->client->search_complete_cb)
+		cbs->client->search_complete_cb(ev->conn_id, ev->status);
 }
 
 static void handle_search_result(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_search_result *ev = buf;
+
+	btgatt_srvc_id_t srvc_id;
+	srvc_id_from_hal(&srvc_id, &ev->srvc_id);
 
+	if (cbs->client->search_result_cb)
+		cbs->client->search_result_cb(ev->conn_id, &srvc_id);
 }
 
 static void handle_get_characteristic(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_get_characteristic *ev = buf;
+	btgatt_gatt_id_t char_id;
+	btgatt_srvc_id_t srvc_id;
 
+	srvc_id_from_hal(&srvc_id, &ev->srvc_id);
+	gatt_id_from_hal(&char_id, &ev->char_id);
+
+	if (cbs->client->get_characteristic_cb)
+		cbs->client->get_characteristic_cb(ev->conn_id, ev->status,
+							&srvc_id, &char_id,
+							ev->char_prop);
 }
 
 static void handle_get_descriptor(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_get_descriptor *ev = buf;
+	btgatt_gatt_id_t descr_id;
+	btgatt_gatt_id_t char_id;
+	btgatt_srvc_id_t srvc_id;
+
+	srvc_id_from_hal(&srvc_id, &ev->srvc_id);
+	gatt_id_from_hal(&char_id, &ev->char_id);
+	gatt_id_from_hal(&descr_id, &ev->descr_id);
 
+	if (cbs->client->get_descriptor_cb)
+		cbs->client->get_descriptor_cb(ev->conn_id, ev->status,
+						&srvc_id, &char_id, &descr_id);
 }
 
 static void handle_get_included_service(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_get_inc_service *ev = buf;
+	btgatt_srvc_id_t srvc_id;
+	btgatt_srvc_id_t incl_srvc_id;
 
+	srvc_id_from_hal(&srvc_id, &ev->srvc_id);
+	srvc_id_from_hal(&incl_srvc_id, &ev->incl_srvc_id);
+
+	if (cbs->client->get_included_service_cb)
+		cbs->client->get_included_service_cb(ev->conn_id, ev->status,
+								&srvc_id,
+								&incl_srvc_id);
 }
 
 static void handle_register_for_notification(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_reg_for_notif *ev = buf;
+	btgatt_gatt_id_t char_id;
+	btgatt_srvc_id_t srvc_id;
+
+	srvc_id_from_hal(&srvc_id, &ev->srvc_id);
+	gatt_id_from_hal(&char_id, &ev->char_id);
 
+	if (cbs->client->register_for_notification_cb)
+		cbs->client->register_for_notification_cb(ev->conn_id,
+								ev->registered,
+								ev->status,
+								&srvc_id,
+								&char_id);
 }
 
 static void handle_notify(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_notify *ev = buf;
+	btgatt_notify_params_t params;
+
+	memset(&params, 0, sizeof(params));
+	memcpy(params.value, ev->value, ev->len);
+	memcpy(&params.bda, ev->bda, sizeof(params.bda));
+
+	srvc_id_from_hal(&params.srvc_id, &ev->srvc_id);
+	gatt_id_from_hal(&params.char_id, &ev->char_id);
+
+	params.len = ev->len;
+	params.is_notify = ev->is_notify;
 
+	if (cbs->client->notify_cb)
+		cbs->client->notify_cb(ev->conn_id, &params);
 }
 
 static void handle_read_characteristic(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_read_characteristic *ev = buf;
+	btgatt_read_params_t params;
 
+	memset(&params, 0, sizeof(params));
+
+	srvc_id_from_hal(&params.srvc_id, &ev->data.srvc_id);
+	gatt_id_from_hal(&params.char_id, &ev->data.char_id);
+	gatt_id_from_hal(&params.descr_id, &ev->data.descr_id);
+
+	memcpy(&params.value.value, ev->data.value, ev->data.len);
+
+	params.value_type = ev->data.value_type;
+	params.value.len = ev->data.len;
+	params.status = ev->data.status;
+
+	if (cbs->client->read_characteristic_cb)
+		cbs->client->read_characteristic_cb(ev->conn_id, ev->status,
+								&params);
 }
 
 static void handle_write_characteristic(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_write_characteristic *ev = buf;
+	btgatt_write_params_t params;
+
+	memset(&params, 0, sizeof(params));
+
+	srvc_id_from_hal(&params.srvc_id, &ev->data.srvc_id);
+	gatt_id_from_hal(&params.char_id, &ev->data.char_id);
+	gatt_id_from_hal(&params.descr_id, &ev->data.descr_id);
+
+	params.status = ev->data.status;
 
+	if (cbs->client->write_characteristic_cb)
+		cbs->client->write_characteristic_cb(ev->conn_id, ev->status,
+								&params);
 }
 
 static void handle_read_descriptor(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_read_descriptor *ev = buf;
+	btgatt_read_params_t params;
 
+	memset(&params, 0, sizeof(params));
+
+	srvc_id_from_hal(&params.srvc_id, &ev->data.srvc_id);
+	gatt_id_from_hal(&params.char_id, &ev->data.char_id);
+	gatt_id_from_hal(&params.descr_id, &ev->data.descr_id);
+
+	memcpy(&params.value.value, ev->data.value, ev->data.len);
+
+	params.value_type = ev->data.value_type;
+	params.value.len = ev->data.len;
+	params.status = ev->data.status;
+
+	if (cbs->client->read_descriptor_cb)
+		cbs->client->read_descriptor_cb(ev->conn_id, ev->status,
+								&params);
 }
 
 static void handle_write_descriptor(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_write_descriptor *ev = buf;
+	btgatt_write_params_t params;
+
+	memset(&params, 0, sizeof(params));
+
+	srvc_id_from_hal(&params.srvc_id, &ev->data.srvc_id);
+	gatt_id_from_hal(&params.char_id, &ev->data.char_id);
+	gatt_id_from_hal(&params.descr_id, &ev->data.descr_id);
+
+	params.status = ev->data.status;
 
+	if (cbs->client->write_descriptor_cb)
+		cbs->client->write_descriptor_cb(ev->conn_id, ev->status,
+								&params);
 }
 
 static void handle_execute_write(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_exec_write *ev = buf;
 
+	if (cbs->client->execute_write_cb)
+		cbs->client->execute_write_cb(ev->conn_id, ev->status);
 }
 
 static void handle_read_remote_rssi(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_read_remote_rssi *ev = buf;
 
+	if (cbs->client->read_remote_rssi_cb)
+		cbs->client->read_remote_rssi_cb(ev->client_if,
+						(bt_bdaddr_t *) ev->address,
+						ev->rssi, ev->status);
 }
 
 static void handle_listen(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_client_listen *ev = buf;
 
+	if (cbs->client->listen_cb)
+		cbs->client->listen_cb(ev->status, ev->server_if);
 }
 
 /* Server Event Handlers */
@@ -217,7 +386,7 @@ static const struct hal_ipc_handler ev_handlers[] = {
 			sizeof(struct hal_ev_gatt_client_read_characteristic)},
 	{handle_write_characteristic, false,
 			sizeof(struct hal_ev_gatt_client_write_characteristic)},
-	{handle_read_descriptor, false,
+	{handle_read_descriptor, true,
 			sizeof(struct hal_ev_gatt_client_read_descriptor)},
 	{handle_write_descriptor, false,
 			sizeof(struct hal_ev_gatt_client_write_descriptor)},
-- 
1.9.0

