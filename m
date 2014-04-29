Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 36/36] android/gatt: Add support for send indication
Date: Tue, 29 Apr 2014 03:15:07 +0200
Message-Id: <1398734107-4793-38-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch Android app can send indication to remote device
---
 android/gatt.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6368e2c..91a34e0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3666,10 +3666,38 @@ failed:
 
 static void handle_server_send_indication(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_send_indication *cmd = buf;
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	struct app_connection *conn;
+	uint8_t status;
+	uint16_t length;
+
 	DBG("");
 
+	conn = find_connection_by_id(cmd->conn_id);
+	if (!conn) {
+		error("gatt: Could not find connection");
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	if (cmd->confirm)
+		/* TODO: Add data to track confirmation for this request */
+		length = enc_indication(cmd->attribute_handle,
+					(uint8_t *)cmd->value, cmd->len,
+					pdu, sizeof(pdu));
+	else
+		length = enc_notification(cmd->attribute_handle,
+						(uint8_t *)cmd->value, cmd->len,
+						pdu, sizeof(pdu));
+
+	g_attrib_send(conn->device->attrib , 0, pdu, length, NULL, NULL , NULL);
+
+	status = HAL_STATUS_SUCCESS;
+
+reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_SEND_INDICATION, HAL_STATUS_FAILED);
+				HAL_OP_GATT_SERVER_SEND_INDICATION, status);
 }
 
 static void handle_server_send_response(const void *buf, uint16_t len)
-- 
1.8.4

