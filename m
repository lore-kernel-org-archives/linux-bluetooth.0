Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 4/5] android/gatt: Add support for write execute
Date: Thu, 17 Apr 2014 13:57:47 +0200
Message-Id: <1397735868-19092-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for write execute. There is possible to write or
cancel all prepared data
---
 android/gatt.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 281f520..3f37a44 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2633,12 +2633,58 @@ failed:
 				HAL_OP_GATT_CLIENT_WRITE_DESCRIPTOR, status);
 }
 
+static void send_client_write_execute_notify(int32_t id, int32_t status)
+{
+	struct hal_ev_gatt_client_exec_write ev;
+
+	ev.conn_id = id;
+	ev.status = status;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_CLIENT_EXEC_WRITE,
+					sizeof(ev), &ev);
+}
+
+static void write_execute_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	send_client_write_execute_notify(PTR_TO_INT(user_data), status);
+}
+
 static void handle_client_execute_write(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_execute_write *cmd = buf;
+	struct gatt_device *dev;
+	uint8_t status;
+	uint8_t flags;
+
 	DBG("");
 
+	dev = queue_find(conn_list, match_dev_by_conn_id,
+						INT_TO_PTR(cmd->conn_id));
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	flags = cmd->execute ? ATT_WRITE_ALL_PREP_WRITES :
+						ATT_CANCEL_ALL_PREP_WRITES;
+
+	if (!gatt_execute_write(dev->attrib, flags, write_execute_cb,
+						INT_TO_PTR(cmd->conn_id))) {
+		error("gatt: Could not send execute write");
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_EXECUTE_WRITE, HAL_STATUS_FAILED);
+			HAL_OP_GATT_CLIENT_EXECUTE_WRITE, status);
+
+	/* In case of early error send also notification.*/
+	if (status != HAL_STATUS_SUCCESS)
+		send_client_write_execute_notify(cmd->conn_id, GATT_FAILURE);
 }
 
 static void handle_notification(const uint8_t *pdu, uint16_t len,
-- 
1.8.4

