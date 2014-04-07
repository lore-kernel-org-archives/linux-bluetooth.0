Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] android/gatt: Fix sending notification for register gatt client
Date: Mon,  7 Apr 2014 14:05:19 +0200
Message-Id: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds missing send notification in case of errors for gatt
client registration. In case of error status GATT_FAILURE with given in
cmd UUID is send in notification.
---
 android/gatt.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4f0a656..3628642 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -413,6 +413,8 @@ static void handle_client_register(const void *buf, uint16_t len)
 
 	DBG("");
 
+	memset(&ev, 0, sizeof(ev));
+
 	if (queue_find(gatt_clients, match_client_by_uuid, &cmd->uuid)) {
 		error("gatt: client uuid is already on list");
 		status = HAL_STATUS_FAILED;
@@ -422,12 +424,10 @@ static void handle_client_register(const void *buf, uint16_t len)
 	client = new0(struct gatt_client, 1);
 	if (!client) {
 		error("gatt: cannot allocate memory for registering client");
-		status = HAL_STATUS_FAILED;
+		status = HAL_STATUS_NOMEM;
 		goto failed;
 	}
 
-	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
-
 	client->notifications = queue_new();
 	if (!client->notifications) {
 		error("gatt: couldn't allocate notifications queue");
@@ -436,22 +436,34 @@ static void handle_client_register(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	client->id = client_cnt++;
+	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
 
-	queue_push_head(gatt_clients, client);
+	client->id = client_cnt++;
 
-	status = HAL_STATUS_SUCCESS;
+	if (!queue_push_head(gatt_clients, client)) {
+		error("gatt: Cannot push client on the list");
+		destroy_gatt_client(client);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	ev.status = GATT_SUCCESS;
 	ev.client_if = client->id;
-	memcpy(ev.app_uuid, client->uuid, sizeof(client->uuid));
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	if (status != HAL_STATUS_SUCCESS)
+		ev.status = GATT_FAILURE;
+
+	/* We should send notification with given in cmd UUID */
+	memcpy(ev.app_uuid, cmd->uuid, sizeof(ev.app_uuid));
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 			HAL_EV_GATT_CLIENT_REGISTER_CLIENT, sizeof(ev), &ev);
 
-failed:
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_OP_GATT_CLIENT_REGISTER, status);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
+									status);
 }
 
 static void handle_client_unregister(const void *buf, uint16_t len)
-- 
1.9.1

