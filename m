Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 37/40] android/gatt: Add read_cb for GATT Server
Date: Tue, 29 Apr 2014 18:47:26 +0200
Message-Id: <1398790049-30303-38-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch attach read callback to descriptors and characteristics
registered by Android app.
---
 android/gatt.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index dfd0690..03ff1f3 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3313,6 +3313,55 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle,
 	/* TODO: Send responses for other commands */
 }
 
+static void read_cb(uint16_t handle, uint16_t offset, void *req_data,
+						gatt_db_complete_func_t cb,
+						void *user_data)
+{
+	struct hal_ev_gatt_server_request_read ev;
+	struct req_data *data = req_data;
+	struct gatt_device *dev = data->dev;
+	struct gatt_app *app;
+	struct app_connection *conn;
+	int32_t id = PTR_TO_INT(user_data);
+	static int32_t trans_id = 1;
+
+	app = find_app_by_id(id);
+	if (!app) {
+		error("gatt: read_cb, cound not found app id");
+		goto failed;
+	}
+
+	conn = find_conn(&dev->bdaddr, app->id);
+	if (!conn) {
+		error("gatt: read_cb, cound not found connection");
+		goto failed;
+	}
+
+	memset(&ev, 0, sizeof(ev));
+
+	/* Store the request data, complete callback and transaction id */
+	app->data = req_data;
+	app->gatt_db_complete_cb = cb;
+	app->pend_trans_id = trans_id++;
+
+	bdaddr2android(&dev->bdaddr, ev.bdaddr);
+	ev.conn_id = conn->id;
+	ev.attr_handle = handle;
+	ev.offset = offset;
+	ev.is_long = data->long_read;
+	ev.trans_id = app->pend_trans_id;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_SERVER_REQUEST_READ,
+					sizeof(ev), &ev);
+
+	return;
+
+failed:
+	send_gatt_response(data->opcode, handle, 0, ATT_ECODE_UNLIKELY, 0,
+							NULL, data, cb);
+}
+
 static void write_cb(uint16_t handle, uint16_t offset,
 						const uint8_t *value,
 						size_t len, void *req_data,
@@ -3409,7 +3458,7 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 							cmd->service_handle,
 							&uuid, cmd->permissions,
 							cmd->properties,
-							NULL, write_cb,
+							read_cb, write_cb,
 							INT_TO_PTR(app_id));
 	if (!ev.char_handle)
 		status = HAL_STATUS_FAILED;
@@ -3455,7 +3504,7 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 	ev.descr_handle = gatt_db_add_char_descriptor(gatt_db,
 							cmd->service_handle,
 							&uuid, cmd->permissions,
-							NULL, write_cb,
+							read_cb, write_cb,
 							INT_TO_PTR(app_id));
 	if (!ev.descr_handle)
 		status = HAL_STATUS_FAILED;
-- 
1.8.4

