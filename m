Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 36/40] android/gatt: Add write_cb to GATT server
Date: Tue, 29 Apr 2014 18:47:25 +0200
Message-Id: <1398790049-30303-37-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Write callback is now attached to characteristics and descriptors
registered by Android app.

Transaction id is generated and stored in gatt_app together with request
data(device ptr, cmd opcode etc).

This patch also make sure that application id is registered in GATT db
as user_data. This is needed to dispatch ATT request from remote device.
---
 android/gatt.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 616649f..dfd0690 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -82,6 +82,11 @@ struct gatt_app {
 
 	/* Valid for client applications */
 	struct queue *notifications;
+
+	/* Transaction data valid for server application */
+	gatt_db_complete_func_t gatt_db_complete_cb;
+	int32_t pend_trans_id;
+	struct req_data *data;
 };
 
 struct element_id {
@@ -3284,9 +3289,100 @@ struct req_data {
 	struct gatt_device *dev;
 	uint8_t opcode;
 
+	bool write_prep;
+	bool write_need_resp;
+	bool write_exec;
+
 	bool long_read;
 };
 
+static void send_gatt_response(uint8_t opcode, uint16_t handle,
+					uint16_t offset, uint8_t status,
+					uint16_t len, const uint8_t *data,
+					void *req_data,
+					gatt_db_complete_func_t cb)
+{
+	uint16_t length;
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+
+	if (!status) {
+		length = enc_error_resp(opcode, handle, status, pdu,
+								sizeof(pdu));
+		cb(req_data, pdu, length);
+	}
+	/* TODO: Send responses for other commands */
+}
+
+static void write_cb(uint16_t handle, uint16_t offset,
+						const uint8_t *value,
+						size_t len, void *req_data,
+						gatt_db_complete_func_t cb,
+						void *user_data)
+{
+	struct hal_ev_gatt_server_request_exec_write write_exec_ev;
+	struct hal_ev_gatt_server_request_write write_ev;
+	struct req_data *data = req_data;
+	struct gatt_device *dev = data->dev;
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
+	conn = find_conn(&dev->bdaddr, app->id);
+	if (!conn) {
+		error("gatt: write_cb, cound not found connection");
+		goto failed;
+	}
+
+	/* Store the request data, complete callback and transaction id */
+	app->pend_trans_id = trans_id++;
+	app->data = data;
+	app->gatt_db_complete_cb = cb;
+
+	if (data->write_exec) {
+		memset(&write_exec_ev, 0, sizeof(write_exec_ev));
+
+		bdaddr2android(&dev->bdaddr, write_exec_ev.bdaddr);
+		write_exec_ev.conn_id = conn->id;
+		write_exec_ev.trans_id = app->pend_trans_id;
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_SERVER_REQUEST_EXEC_WRITE,
+					sizeof(write_exec_ev), &write_exec_ev);
+	} else {
+		memset(&write_ev, 0, sizeof(write_ev));
+
+		bdaddr2android(&dev->bdaddr, write_exec_ev.bdaddr);
+		write_ev.attr_handle = handle;
+		write_ev.offset = offset;
+
+		write_ev.conn_id = conn->id;
+		write_ev.trans_id = app->pend_trans_id;
+
+		write_ev.is_prep = data->write_prep;
+		write_ev.need_rsp = data->write_need_resp;
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
+	send_gatt_response(data->opcode, handle, 0, ATT_ECODE_UNLIKELY, 0,
+							NULL, data, cb);
+}
+
 static void handle_server_add_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_characteristic *cmd = buf;
@@ -3294,12 +3390,13 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
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
@@ -3307,11 +3404,13 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 
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
@@ -3320,7 +3419,7 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 failed:
 	ev.srvc_handle = cmd->service_handle;
 	ev.status = status;
-	ev.server_if = cmd->server_if;
+	ev.server_if = app_id;
 	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
 	memcpy(ev.uuid, cmd->uuid, sizeof(cmd->uuid));
 
@@ -3338,12 +3437,13 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
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
@@ -3351,17 +3451,19 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 
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
@@ -3930,6 +4032,7 @@ static uint8_t write_request(const uint8_t *cmd, uint16_t cmd_len,
 			free(req_data);
 			return ATT_ECODE_INVALID_PDU;
 		}
+		req_data->write_need_resp = true;
 		break;
 	case ATT_OP_PREP_WRITE_REQ:
 		len = dec_prep_write_req(cmd, cmd_len, &handle, &offset,
@@ -3938,6 +4041,7 @@ static uint8_t write_request(const uint8_t *cmd, uint16_t cmd_len,
 			free(req_data);
 			return ATT_ECODE_INVALID_PDU;
 		}
+		req_data->write_prep = true;
 		break;
 	case ATT_OP_EXEC_WRITE_REQ:
 		len = dec_exec_write_req(cmd, cmd_len, value);
@@ -3945,6 +4049,7 @@ static uint8_t write_request(const uint8_t *cmd, uint16_t cmd_len,
 			return ATT_ECODE_INVALID_PDU;
 
 		vlen = 1;
+		req_data->write_exec = true;
 		break;
 	default:
 		error("gatt: Unexpected write type 0x02%x", cmd[0]);
-- 
1.8.4

