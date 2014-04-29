Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 01/40] android/gatt: Rename listen_clients to listen_apps
Date: Tue, 29 Apr 2014 18:46:50 +0200
Message-Id: <1398790049-30303-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is because on this list there will be also servers id
---
 android/gatt.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4775ecc..f9eff30 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -152,7 +152,7 @@ static struct queue *gatt_apps = NULL;
 static struct queue *gatt_devices = NULL;
 static struct queue *app_connections = NULL;
 
-static struct queue *listen_clients = NULL;
+static struct queue *listen_apps = NULL;
 
 static void bt_le_discovery_stop_cb(void);
 
@@ -1380,7 +1380,7 @@ static void set_advertising_cb(uint8_t status, void *user_data)
 	 * 2. Stop succeed
 	 */
 	if ((l->start && status) || (!l->start && !status))
-		queue_remove(listen_clients, INT_TO_PTR(l->client_id));
+		queue_remove(listen_apps, INT_TO_PTR(l->client_id));
 
 	free(l);
 }
@@ -1401,7 +1401,7 @@ static void handle_client_listen(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	listening_client = queue_find(listen_clients, match_by_value,
+	listening_client = queue_find(listen_apps, match_by_value,
 						INT_TO_PTR(cmd->client_if));
 	/* Start listening */
 	if (cmd->start) {
@@ -1410,7 +1410,7 @@ static void handle_client_listen(const void *buf, uint16_t len)
 			goto reply;
 		}
 
-		if (!queue_push_tail(listen_clients,
+		if (!queue_push_tail(listen_apps,
 						INT_TO_PTR(cmd->client_if))) {
 			error("gatt: Could not put client on listen queue");
 			status = HAL_STATUS_FAILED;
@@ -1418,7 +1418,7 @@ static void handle_client_listen(const void *buf, uint16_t len)
 		}
 
 		/* If listen is already on just return success*/
-		if (queue_length(listen_clients) > 1) {
+		if (queue_length(listen_apps) > 1) {
 			status = HAL_STATUS_SUCCESS;
 			goto reply;
 		}
@@ -1435,8 +1435,8 @@ static void handle_client_listen(const void *buf, uint16_t len)
 		 * In case there is more listening clients don't stop
 		 * advertising
 		 */
-		if (queue_length(listen_clients) > 1) {
-			queue_remove(listen_clients,
+		if (queue_length(listen_apps) > 1) {
+			queue_remove(listen_apps,
 						INT_TO_PTR(cmd->client_if));
 			status = HAL_STATUS_SUCCESS;
 			goto reply;
@@ -3503,9 +3503,9 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	gatt_devices = queue_new();
 	gatt_apps = queue_new();
 	app_connections = queue_new();
-	listen_clients = queue_new();
+	listen_apps = queue_new();
 
-	if (!gatt_devices || !gatt_apps || !listen_clients ||
+	if (!gatt_devices || !gatt_apps || !listen_apps ||
 							!app_connections) {
 		error("gatt: Failed to allocate memory for queues");
 
@@ -3518,8 +3518,8 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		queue_destroy(app_connections, NULL);
 		app_connections = NULL;
 
-		queue_destroy(listen_clients, NULL);
-		listen_clients = NULL;
+		queue_destroy(listen_apps, NULL);
+		listen_apps = NULL;
 
 		return false;
 	}
@@ -3550,6 +3550,6 @@ void bt_gatt_unregister(void)
 	queue_destroy(gatt_devices, destroy_device);
 	gatt_devices = NULL;
 
-	queue_destroy(listen_clients, NULL);
-	listen_clients = NULL;
+	queue_destroy(listen_apps, NULL);
+	listen_apps = NULL;
 }
-- 
1.8.4

