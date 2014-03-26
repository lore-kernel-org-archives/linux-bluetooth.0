Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/gatt: Add deregister_for_notification implementation
Date: Wed, 26 Mar 2014 15:37:20 +0100
Message-Id: <1395844640-11602-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1395844640-11602-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395844640-11602-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will unregister handlers for notification and indications
and remove notification_data from client's list.
---
 android/gatt.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index c2d05d2..12a883b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1389,11 +1389,60 @@ failed:
 static void handle_client_deregister_for_notification(const void *buf,
 								uint16_t len)
 {
+	const struct hal_cmd_gatt_client_deregister_for_notification *cmd = buf;
+	struct notification_data *notification, notif;
+	struct gatt_client *client;
+	struct gatt_device *dev;
+	int32_t conn_id = 0;
+	char addr_str[18];
+	uint8_t status;
+	bdaddr_t addr;
+
 	DBG("");
 
+	client = queue_find(gatt_clients, match_client_by_id,
+						INT_TO_PTR(cmd->client_if));
+	if (!client) {
+		error("gatt: couldn't deregister: client not registered");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	android2bdaddr((bdaddr_t *)&cmd->bdaddr, &addr);
+	ba2str(&addr, addr_str);
+
+	dev = queue_find(conn_list, match_dev_by_bdaddr, &addr);
+	if (!dev) {
+		error("gatt: couldn't deregister: device %s not found",
+								addr_str);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	memcpy(&notif.ch, &cmd->char_id, sizeof(notif.ch));
+	memcpy(&notif.service, &cmd->srvc_id, sizeof(notif.service));
+	notif.dev = dev;
+
+	notification = queue_find(client->notifications,
+						match_notification, &notif);
+
+	if (!notification) {
+		error("gatt: couldn't deregister: notification not registered");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	unregister_notification(notification);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	client_register_for_notif_cb(conn_id, 0, status, &cmd->srvc_id,
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

