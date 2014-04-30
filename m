Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 34/38] android/gatt: Add write_cb to GATT server
Date: Wed, 30 Apr 2014 11:14:05 +0200
Message-Id: <1398849249-5868-35-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Write callback is now attached to characteristics and descriptors
registered by Android app.

Transaction id is generated and stored in gatt_app together with
att_opcode
---
 android/gatt.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b0795d1..5a1c9ce 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -74,6 +74,11 @@ typedef enum {
 	APP_SERVER,
 } gatt_app_type_t;
 
+struct pending_trans_data {
+	unsigned int id;
+	uint8_t opcode;
+};
+
 struct gatt_app {
 	int32_t id;
 	uint8_t uuid[16];
@@ -82,6 +87,9 @@ struct gatt_app {
 
 	/* Valid for client applications */
 	struct queue *notifications;
+
+	/* Transaction data valid for server application */
+	struct pending_trans_data trans_id;
 };
 
 struct element_id {
@@ -3280,6 +3288,103 @@ failed:
 				HAL_OP_GATT_SERVER_ADD_INC_SERVICE, status);
 }
 
+static void send_gatt_response(uint8_t opcode, uint16_t handle,
+					uint16_t offset, uint8_t status,
+					uint16_t len, const uint8_t *data,
+					bdaddr_t *bdaddr)
+{
+	struct gatt_device *dev;
+	uint16_t length;
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+
+	dev = find_device_by_addr(bdaddr);
+	if (!dev) {
+		error("gatt: send_gatt_response, could not find dev");
+		return;
+	}
+
+	if (!status) {
+		length = enc_error_resp(opcode, handle, status, pdu,
+								sizeof(pdu));
+		g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
+	}
+	/* TODO: Send responses for other commands */
+}
+
+static void set_trans_id(struct gatt_app *app, unsigned int id, int8_t opcode)
+{
+	app->trans_id.id = id;
+	app->trans_id.opcode = opcode;
+}
+
+static void write_cb(uint16_t handle, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t att_opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct hal_ev_gatt_server_request_exec_write write_exec_ev;
+	struct hal_ev_gatt_server_request_write write_ev;
+	struct gatt_app *app;
+	int32_t id = PTR_TO_INT(user_data);
+	static int32_t trans_id = 1;
+	struct app_connection *conn;
+
+	app = find_app_by_id(id);
+	if (!app) {
+		error("gatt: write_cb, cound not found app id");
+		goto failed;
+	}
+
+	conn = find_conn(bdaddr, app->id);
+	if (!conn) {
+		error("gatt: write_cb, cound not found connection");
+		goto failed;
+	}
+
+	/* Store the request data, complete callback and transaction id */
+	set_trans_id(app, trans_id++, att_opcode);
+
+	if (att_opcode == ATT_OP_EXEC_WRITE_REQ) {
+		memset(&write_exec_ev, 0, sizeof(write_exec_ev));
+
+
+		bdaddr2android(bdaddr, write_exec_ev.bdaddr);
+		write_exec_ev.conn_id = conn->id;
+		write_exec_ev.trans_id = app->trans_id.id;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_SERVER_REQUEST_EXEC_WRITE,
+					sizeof(write_exec_ev), &write_exec_ev);
+	} else {
+		memset(&write_ev, 0, sizeof(write_ev));
+
+		bdaddr2android(bdaddr, write_exec_ev.bdaddr);
+		write_ev.attr_handle = handle;
+		write_ev.offset = offset;
+
+		write_ev.conn_id = conn->id;
+		write_ev.trans_id = app->trans_id.id;
+
+		write_ev.is_prep =
+			att_opcode == ATT_OP_PREP_WRITE_REQ ? true : false;
+		write_ev.need_rsp =
+			att_opcode == ATT_OP_WRITE_REQ ? true : false;
+
+		write_ev.length = len;
+		memcpy(&write_ev.value, value, len);
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_SERVER_REQUEST_WRITE,
+					sizeof(write_ev), &write_ev);
+	}
+
+	return;
+
+failed:
+	send_gatt_response(att_opcode, handle, 0, ATT_ECODE_UNLIKELY, 0, NULL,
+								bdaddr);
+}
+
 static void handle_server_add_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_characteristic *cmd = buf;
@@ -3287,12 +3392,13 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 	struct gatt_app *server;
 	bt_uuid_t uuid;
 	uint8_t status;
+	int32_t app_id = cmd->server_if;
 
 	DBG("");
 
 	memset(&ev, 0, sizeof(ev));
 
-	server = find_app_by_id(cmd->server_if);
+	server = find_app_by_id(app_id);
 	if (!server) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -3300,11 +3406,13 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 
 	android2uuid(cmd->uuid, &uuid);
 
+	/*FIXME: Handle properties. Register callback if needed. */
 	ev.char_handle = gatt_db_add_characteristic(gatt_db,
 							cmd->service_handle,
 							&uuid, cmd->permissions,
 							cmd->properties,
-							NULL, NULL, NULL);
+							NULL, write_cb,
+							INT_TO_PTR(app_id));
 	if (!ev.char_handle)
 		status = HAL_STATUS_FAILED;
 	else
@@ -3313,7 +3421,7 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 failed:
 	ev.srvc_handle = cmd->service_handle;
 	ev.status = status;
-	ev.server_if = cmd->server_if;
+	ev.server_if = app_id;
 	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
 	memcpy(ev.uuid, cmd->uuid, sizeof(cmd->uuid));
 
@@ -3331,12 +3439,13 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 	struct gatt_app *server;
 	bt_uuid_t uuid;
 	uint8_t status;
+	int32_t app_id = cmd->server_if;
 
 	DBG("");
 
 	memset(&ev, 0, sizeof(ev));
 
-	server = find_app_by_id(cmd->server_if);
+	server = find_app_by_id(app_id);
 	if (!server) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -3344,17 +3453,19 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 
 	android2uuid(cmd->uuid, &uuid);
 
+	/*FIXME: Handle properties. Register callback if needed. */
 	ev.descr_handle = gatt_db_add_char_descriptor(gatt_db,
 							cmd->service_handle,
 							&uuid, cmd->permissions,
-							NULL, NULL, NULL);
+							NULL, write_cb,
+							INT_TO_PTR(app_id));
 	if (!ev.descr_handle)
 		status = HAL_STATUS_FAILED;
 	else
 		status = HAL_STATUS_SUCCESS;
 
 failed:
-	ev.server_if = cmd->server_if;
+	ev.server_if = app_id;
 	ev.srvc_handle = cmd->service_handle;
 	memcpy(ev.uuid, cmd->uuid, sizeof(cmd->uuid));
 	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
-- 
1.8.4

