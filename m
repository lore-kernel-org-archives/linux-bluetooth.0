Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/4] android/hal-gatt: Add Server Event handlers
Date: Thu,  6 Mar 2014 12:27:58 +0100
Message-Id: <1394105279-9165-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Call registered handlers with data received through IPC.
---
 android/hal-gatt.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 83b6303..37c0191 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -309,67 +309,135 @@ static void handle_listen(void *buf, uint16_t len)
 
 static void handle_register_server(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_register *ev = buf;
 
+	if (cbs->server->register_server_cb)
+		cbs->server->register_server_cb(ev->status, ev->server_if,
+						(bt_uuid_t *) &ev->uuid);
 }
 
 static void handle_connection(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_connection *ev = buf;
 
+	if (cbs->server->connection_cb)
+		cbs->server->connection_cb(ev->conn_id, ev->server_if,
+						ev->connected,
+						(bt_bdaddr_t *) &ev->bdaddr);
 }
 
 static void handle_service_added(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_service_added *ev = buf;
+	btgatt_srvc_id_t srvc_id;
+
+	srvc_id_from_hal(&srvc_id, &ev->srvc_id);
 
+	if (cbs->server->service_added_cb)
+		cbs->server->service_added_cb(ev->status, ev->server_if,
+						&srvc_id, ev->srvc_handle);
 }
 
 static void handle_included_service_added(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_inc_srvc_added *ev = buf;
 
+	if (cbs->server->included_service_added_cb)
+		cbs->server->included_service_added_cb(ev->status,
+							ev->server_if,
+							ev->srvc_handle,
+							ev->incl_srvc_handle);
 }
 
 static void handle_characteristic_added(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_characteristic_added *ev = buf;
 
+	if (cbs->server->characteristic_added_cb)
+		cbs->server->characteristic_added_cb(ev->status, ev->server_if,
+							(bt_uuid_t *) &ev->uuid,
+							ev->srvc_handle,
+							ev->char_handle);
 }
 
 static void handle_descriptor_added(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_descriptor_added *ev = buf;
 
+	if (cbs->server->descriptor_added_cb)
+		cbs->server->descriptor_added_cb(ev->status, ev->server_if,
+							(bt_uuid_t *) &ev->uuid,
+							ev->srvc_handle,
+							ev->descr_handle);
 }
 
 static void handle_service_started(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_service_started *ev = buf;
 
+	if (cbs->server->service_started_cb)
+		cbs->server->service_started_cb(ev->status, ev->server_if,
+							ev->srvc_handle);
 }
 
 static void handle_service_stopped(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_service_stopped *ev = buf;
 
+	if (cbs->server->service_stopped_cb)
+		cbs->server->service_stopped_cb(ev->status, ev->server_if,
+							ev->srvc_handle);
 }
 
 static void handle_service_deleted(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_service_deleted *ev = buf;
 
+	if (cbs->server->service_deleted_cb)
+		cbs->server->service_deleted_cb(ev->status, ev->server_if,
+							ev->srvc_handle);
 }
 
 static void handle_request_read(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_request_read *ev = buf;
 
+	if (cbs->server->request_read_cb)
+		cbs->server->request_read_cb(ev->conn_id, ev->trans_id,
+						(bt_bdaddr_t *) &ev->bdaddr,
+						ev->attr_handle, ev->offset,
+						ev->is_long);
 }
 
 static void handle_request_write(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_request_write *ev = buf;
 
+	if (cbs->server->request_write_cb)
+		cbs->server->request_write_cb(ev->conn_id, ev->trans_id,
+						(bt_bdaddr_t *) ev->bdaddr,
+						ev->attr_handle, ev->offset,
+						ev->length, ev->need_rsp,
+						ev->is_prep, ev->value);
 }
 
 static void handle_request_exec_write(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_request_exec_write *ev = buf;
+
+	if (cbs->server->request_exec_write_cb)
+		cbs->server->request_exec_write_cb(ev->conn_id, ev->trans_id,
+						(bt_bdaddr_t *) ev->bdaddr,
+						ev->exec_write);
 
 }
 
 static void handle_response_confirmation(void *buf, uint16_t len)
 {
+	struct hal_ev_gatt_server_rsp_confirmation *ev = buf;
 
+	if (cbs->server->response_confirmation_cb)
+		cbs->server->response_confirmation_cb(ev->status, ev->handle);
 }
 
 /* handlers will be called from notification thread context,
-- 
1.9.0

