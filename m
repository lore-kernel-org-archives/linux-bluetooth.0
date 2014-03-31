Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2] android/gatt: Use proper GATT status
Date: Mon, 31 Mar 2014 11:04:45 +0200
Message-Id: <1396256685-23786-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces GATT_SUCCESS and GATT_FAILURE status codes
according to Android API. This patch also fixes event status codes.
---
 android/gatt.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e361506..3ffb8c6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -48,6 +48,9 @@
 #include "attrib/gatt.h"
 #include "btio/btio.h"
 
+#define GATT_SUCCESS	0x00000000
+#define GATT_FAILURE	0x00000101
+
 struct gatt_client {
 	int32_t id;
 	uint8_t uuid[16];
@@ -343,7 +346,7 @@ static void handle_client_register(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 
-	ev.status = status;
+	ev.status = GATT_SUCCESS;
 	ev.client_if = client->id;
 	memcpy(ev.app_uuid, client->uuid, sizeof(client->uuid));
 
@@ -390,13 +393,13 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 	if (status) {
 		error("gatt: Discover all primary services failed: %s",
 							att_ecode2str(status));
-		ev.status = HAL_STATUS_FAILED;
+		ev.status = GATT_FAILURE;
 		goto done;
 	}
 
 	if (!services) {
 		info("gatt: No primary services found");
-		ev.status = HAL_STATUS_SUCCESS;
+		ev.status = GATT_SUCCESS;
 		goto done;
 	}
 
@@ -448,7 +451,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 					sizeof(ev_res), &ev_res);
 	}
 
-	ev.status = HAL_STATUS_SUCCESS;
+	ev.status = GATT_SUCCESS;
 
 done:
 	ev.conn_id = dev->conn_id;
@@ -496,7 +499,7 @@ static void client_disconnect_notify(void *data, void *user_data)
 	struct gatt_device *dev = user_data;
 	int32_t id = PTR_TO_INT(data);
 
-	send_client_disconnect_notify(id, dev, HAL_STATUS_SUCCESS);
+	send_client_disconnect_notify(id, dev, GATT_SUCCESS);
 }
 
 static bool is_device_wating_for_connect(const bdaddr_t *addr,
@@ -612,7 +615,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	struct hal_ev_gatt_client_connect ev;
 	GAttrib *attrib;
 	static uint32_t conn_id = 0;
-	uint8_t status;
+	int32_t status;
 
 	/* Take device from conn waiting queue */
 	dev = queue_remove_if(conn_wait_queue, match_dev_by_bdaddr, addr);
@@ -630,14 +633,14 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	if (gerr) {
 		error("gatt: connection failed %s", gerr->message);
-		status = HAL_STATUS_FAILED;
+		status = GATT_FAILURE;
 		goto reply;
 	}
 
 	attrib = g_attrib_new(io);
 	if (!attrib) {
 		error("gatt: unable to create new GAttrib instance");
-		status = HAL_STATUS_FAILED;
+		status = GATT_FAILURE;
 		goto reply;
 	}
 
@@ -650,11 +653,11 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (!queue_push_tail(conn_list, dev)) {
 		error("gatt: Cannot push dev on conn_list");
 		connection_cleanup(dev);
-		status = HAL_STATUS_FAILED;
+		status = GATT_FAILURE;
 		goto reply;
 	}
 
-	status = HAL_STATUS_SUCCESS;
+	status = GATT_SUCCESS;
 	goto reply;
 
 reply:
@@ -932,7 +935,7 @@ reply:
 		struct hal_ev_gatt_client_connect ev;
 
 		ev.conn_id = dev->conn_id;
-		ev.status = HAL_STATUS_SUCCESS;
+		ev.status = GATT_SUCCESS;
 		ev.client_if = cmd->client_if;
 		bdaddr2android(&addr, &ev.bda);
 
@@ -982,7 +985,7 @@ reply:
 	 * If this is last client, this is still OK to do because on connect
 	 * request we do le scan and wait until remote device start
 	 * advertisement */
-	send_client_disconnect_notify(cmd->client_if, dev, HAL_STATUS_SUCCESS);
+	send_client_disconnect_notify(cmd->client_if, dev, GATT_SUCCESS);
 
 	/* If there is more clients just return */
 	if (!queue_isempty(dev->clients))
@@ -1087,7 +1090,7 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 		bt_uuid_t included_uuid;
 
 		ev.conn_id = device->conn_id;
-		ev.status = HAL_STATUS_SUCCESS;
+		ev.status = GATT_SUCCESS;
 
 		ev.srvc_id.inst_id = 0;
 		uuid2android(&uuid, ev.srvc_id.uuid);
@@ -1103,7 +1106,7 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 
 	/* Android expects notification with error status in the end */
 	ev.conn_id = device->conn_id;
-	ev.status = HAL_STATUS_FAILED;
+	ev.status = GATT_FAILURE;
 	ev.srvc_id.inst_id = 0;
 	uuid2android(&uuid, ev.srvc_id.uuid);
 
@@ -1176,7 +1179,7 @@ static void send_client_char_notify(const struct characteristic *ch,
 	struct hal_ev_gatt_client_get_characteristic ev;
 
 	memset(&ev, 0, sizeof(ev));
-	ev.status = ch ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+	ev.status = ch ? GATT_SUCCESS : GATT_FAILURE;
 
 	if (ch) {
 		ev.char_prop = ch->ch.properties;
@@ -1453,6 +1456,7 @@ static void handle_client_register_for_notification(const void *buf,
 	struct service *service;
 	int32_t conn_id = 0;
 	uint8_t status;
+	int32_t gatt_status;
 	bdaddr_t addr;
 
 	DBG("");
@@ -1547,8 +1551,9 @@ static void handle_client_register_for_notification(const void *buf,
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	send_register_for_notification_ev(conn_id, 1, status, &cmd->srvc_id,
-								&cmd->char_id);
+	gatt_status  = status ? GATT_SUCCESS : GATT_FAILURE;
+	send_register_for_notification_ev(conn_id, 1, gatt_status,
+						&cmd->srvc_id, &cmd->char_id);
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION,
 				status);
@@ -1563,6 +1568,7 @@ static void handle_client_deregister_for_notification(const void *buf,
 	struct gatt_device *dev;
 	int32_t conn_id = 0;
 	uint8_t status;
+	int32_t gatt_status;
 	bdaddr_t addr;
 
 	DBG("");
@@ -1598,8 +1604,9 @@ static void handle_client_deregister_for_notification(const void *buf,
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	send_register_for_notification_ev(conn_id, 0, status, &cmd->srvc_id,
-								&cmd->char_id);
+	gatt_status  = status ? GATT_SUCCESS : GATT_FAILURE;
+	send_register_for_notification_ev(conn_id, 0, gatt_status,
+						&cmd->srvc_id, &cmd->char_id);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION,
-- 
1.9.0

