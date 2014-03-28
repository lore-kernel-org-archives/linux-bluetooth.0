Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 7/7] android/gatt: Add deregister_for_notification implementation
Date: Fri, 28 Mar 2014 11:49:22 +0100
Message-Id: <1396003762-9350-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will unregister handlers for notification and indications
and remove notification_data from client's list.
---
 android/gatt.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 75c555c..e361506 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1557,11 +1557,53 @@ failed:
 static void handle_client_deregister_for_notification(const void *buf,
 								uint16_t len)
 {
+	const struct hal_cmd_gatt_client_deregister_for_notification *cmd = buf;
+	struct notification_data *notification, notif;
+	struct gatt_client *client;
+	struct gatt_device *dev;
+	int32_t conn_id = 0;
+	uint8_t status;
+	bdaddr_t addr;
+
 	DBG("");
 
+	client = find_client_by_id(cmd->client_if);
+	if (!client) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	android2bdaddr(&cmd->bdaddr, &addr);
+
+	dev = find_device(&addr);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	conn_id = dev->conn_id;
+	memcpy(&notif.ch, &cmd->char_id, sizeof(notif.ch));
+	memcpy(&notif.service, &cmd->srvc_id, sizeof(notif.service));
+	notif.dev = dev;
+
+	notification = queue_find(client->notifications,
+						match_notification, &notif);
+	if (!notification) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	unregister_notification(notification);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	send_register_for_notification_ev(conn_id, 0, status, &cmd->srvc_id,
+								&cmd->char_id);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION,
-				HAL_STATUS_FAILED);
+				status);
 }
 
 static void handle_client_read_remote_rssi(const void *buf, uint16_t len)
-- 
1.8.3.1

