Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 35/38] android/gatt: Add read_cb for GATT Server
Date: Wed, 30 Apr 2014 11:14:06 +0200
Message-Id: <1398849249-5868-36-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch attach read callback to descriptors and characteristics
registered by Android app.
---
 android/gatt.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5a1c9ce..6164044 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3317,6 +3317,50 @@ static void set_trans_id(struct gatt_app *app, unsigned int id, int8_t opcode)
 	app->trans_id.opcode = opcode;
 }
 
+static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
+					bdaddr_t *bdaddr, void *user_data)
+{
+	struct hal_ev_gatt_server_request_read ev;
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
+	conn = find_conn(bdaddr, app->id);
+	if (!conn) {
+		error("gatt: read_cb, cound not found connection");
+		goto failed;
+	}
+
+	memset(&ev, 0, sizeof(ev));
+
+	/* Store the request data, complete callback and transaction id */
+	set_trans_id(app, trans_id++, att_opcode);
+
+	bdaddr2android(bdaddr, ev.bdaddr);
+	ev.conn_id = conn->id;
+	ev.attr_handle = handle;
+	ev.offset = offset;
+	ev.is_long = att_opcode == ATT_OP_READ_BLOB_REQ ? true : false;
+	ev.trans_id = app->trans_id.id;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_SERVER_REQUEST_READ,
+					sizeof(ev), &ev);
+
+	return;
+
+failed:
+	send_gatt_response(att_opcode, handle, 0, ATT_ECODE_UNLIKELY, 0,
+							NULL, bdaddr);
+}
+
 static void write_cb(uint16_t handle, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t att_opcode, bdaddr_t *bdaddr,
@@ -3411,7 +3455,7 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 							cmd->service_handle,
 							&uuid, cmd->permissions,
 							cmd->properties,
-							NULL, write_cb,
+							read_cb, write_cb,
 							INT_TO_PTR(app_id));
 	if (!ev.char_handle)
 		status = HAL_STATUS_FAILED;
@@ -3457,7 +3501,7 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
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

