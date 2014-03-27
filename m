Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 07/11] android/gatt: Add notifications list to gatt_client
Date: Thu, 27 Mar 2014 22:13:05 +0100
Message-Id: <1395954789-32459-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will be used for storing informations about registered handlers.
These handlers will be registered for both ATT_OP_HANDLE_NOTIFY
and ATT_OP_HANDLE_IND. Added also new function to destroy gatt_client.
---
 android/gatt.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index e35b099..2cd0731 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -51,6 +51,7 @@
 struct gatt_client {
 	int32_t id;
 	uint8_t uuid[16];
+	struct queue *notifications;
 };
 
 struct element_id {
@@ -70,6 +71,16 @@ struct service {
 	struct queue *chars;
 };
 
+struct notification_data {
+	struct hal_gatt_srvc_id service;
+	struct hal_gatt_gatt_id ch;
+	struct gatt_client *client;
+	struct gatt_device *dev;
+	guint notif_id;
+	guint ind_id;
+	int ref;
+};
+
 struct gatt_device {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
@@ -216,6 +227,16 @@ static void destroy_device(void *data)
 	free(dev);
 }
 
+static void destroy_gatt_client(void *data)
+{
+	struct gatt_client *client = data;
+
+	if (client->notifications)
+		queue_destroy(client->notifications, free);
+
+	free(client);
+}
+
 static void handle_client_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_register *cmd = buf;
@@ -247,6 +268,14 @@ static void handle_client_register(const void *buf, uint16_t len)
 
 	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
 
+	client->notifications = queue_new();
+	if (!client->notifications) {
+		error("gatt: couldn't allocate notifications queue");
+		destroy_gatt_client(client);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
 	client->id = client_cnt++;
 
 	queue_push_head(gatt_clients, client);
@@ -281,7 +310,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	free(cl);
+	destroy_gatt_client(cl);
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-- 
1.8.3.1

