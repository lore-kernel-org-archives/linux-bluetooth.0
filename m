Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/7] ndroid/gatt: Extract common code from client_connect
Date: Mon, 28 Apr 2014 15:32:05 +0200
Message-Id: <1398691926-1777-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Code extracted from client connect handler will be reused by server
connect handler
---
 android/gatt.c | 60 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 549bb30..e775f19 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1251,56 +1251,56 @@ static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id,
 								&conn_match);
 }
 
-static void handle_client_connect(const void *buf, uint16_t len)
+static uint8_t handle_connect(int32_t app_id, const bdaddr_t *addr,
+								bool is_direct)
 {
-	const struct hal_cmd_gatt_client_connect *cmd = buf;
 	struct app_connection conn_match;
 	struct app_connection *conn;
 	struct gatt_device *device;
-	struct gatt_app *client;
-	bdaddr_t addr;
-	uint8_t status;
+	struct gatt_app *app;
 
 	DBG("");
 
-	client = find_app_by_id(cmd->client_if);
-	if (!client) {
-		status = HAL_STATUS_FAILED;
-		goto reply;
-	}
-
-	android2bdaddr(&cmd->bdaddr, &addr);
+	app = find_app_by_id(app_id);
+	if (!app)
+		return HAL_STATUS_FAILED;
 
-	device = find_device_by_addr(&addr);
+	device = find_device_by_addr(addr);
 	if (!device) {
-		device = create_device(&addr);
-		if (!device) {
-			status = HAL_STATUS_FAILED;
-			goto reply;
-		}
+		device = create_device(addr);
+		if (!device)
+			return HAL_STATUS_FAILED;
 	}
 
 	conn_match.device = device;
-	conn_match.app = client;
+	conn_match.app = app;
 
 	conn = queue_find(app_connections, match_connection_by_device_and_app,
 								&conn_match);
 	if (!conn) {
-		conn = create_connection(device, client);
-		if (!conn) {
-			status = HAL_STATUS_NOMEM;
-			goto reply;
-		}
+		conn = create_connection(device, app);
+		if (!conn)
+			return HAL_STATUS_NOMEM;
 	}
 
-	if (!trigger_connection(conn)) {
-		status = HAL_STATUS_FAILED;
-		goto reply;
-	}
+	if (!trigger_connection(conn))
+		return HAL_STATUS_FAILED;
 
-	status = HAL_STATUS_SUCCESS;
+	return HAL_STATUS_SUCCESS;
+}
+
+static void handle_client_connect(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_connect *cmd = buf;
+	uint8_t status;
+	bdaddr_t addr;
+
+	DBG("");
+
+	android2bdaddr(&cmd->bdaddr, &addr);
+
+	status = handle_connect(cmd->client_if, &addr, cmd->is_direct);
 
-reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_CONNECT,
 								status);
 }
-- 
1.9.1

