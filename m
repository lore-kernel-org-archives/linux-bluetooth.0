Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 7/7] android/gatt: Handle Server apps connections
Date: Mon, 28 Apr 2014 15:32:06 +0200
Message-Id: <1398691926-1777-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This handles server connections.
---
 android/gatt.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e775f19..e634aa6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -628,12 +628,29 @@ static void send_client_connection_notify(struct app_connection *connection,
 							sizeof(ev), &ev);
 }
 
+static void send_server_connection_notify(struct app_connection *connection,
+								bool connected)
+{
+	struct hal_ev_gatt_server_connection ev;
+
+	ev.server_if = connection->app->id;
+	ev.conn_id = connection->id;
+	ev.connected = connected;
+
+	bdaddr2android(&connection->device->bdaddr, &ev.bdaddr);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_EV_GATT_SERVER_CONNECTION, sizeof(ev), &ev);
+}
+
 static void send_app_disconnect_notify(struct app_connection *connection,
 								int32_t status)
 {
 	if (connection->app->type == APP_CLIENT)
 		send_client_disconnection_notify(connection, status);
-	/* TODO: handle APP_SERVER */
+	else
+		send_server_connection_notify(connection, status ? true :
+									false);
 }
 
 static void send_app_connect_notify(struct app_connection *connection,
@@ -641,7 +658,9 @@ static void send_app_connect_notify(struct app_connection *connection,
 {
 	if (connection->app->type == APP_CLIENT)
 		send_client_connection_notify(connection, status);
-	/* TODO: handle APP_SERVER */
+	else
+		send_server_connection_notify(connection, status ? false :
+									true);
 }
 
 static void disconnect_notify_by_device(void *data, void *user_data)
@@ -3125,18 +3144,35 @@ failed:
 
 static void handle_server_connect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_connect *cmd = buf;
+	uint8_t status;
+	bdaddr_t addr;
+
 	DBG("");
 
+	status = handle_connect(cmd->server_if, &addr, cmd->is_direct);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_CONNECT,
-							HAL_STATUS_FAILED);
+								status);
 }
 
 static void handle_server_disconnect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_disconnect *cmd = buf;
+	struct app_connection *conn;
+	uint8_t status;
+
 	DBG("");
 
+	/* TODO: should we care to match also bdaddr when conn_id is unique? */
+	conn = find_connection_by_id(cmd->conn_id);
+	if (conn)
+		trigger_disconnection(conn);
+
+	status = HAL_STATUS_SUCCESS;
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_DISCONNECT, HAL_STATUS_FAILED);
+					HAL_OP_GATT_SERVER_DISCONNECT, status);
 }
 
 static void handle_server_add_service(const void *buf, uint16_t len)
-- 
1.9.1

