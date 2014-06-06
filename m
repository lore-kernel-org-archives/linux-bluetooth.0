Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 01/13] android/gatt: Rename app connection handling function
Date: Fri,  6 Jun 2014 15:46:14 +0200
Message-Id: <1402062386-4632-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These are handling app connections thus we should make this clear by
proper naming.
---
 android/gatt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 3fd88fa..a1570fd 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -843,7 +843,7 @@ static void device_unref(struct gatt_device *device)
 	destroy_device(device);
 }
 
-static void destroy_connection(void *data)
+static void destroy_app_connection(void *data)
 {
 	struct app_connection *conn = data;
 
@@ -867,7 +867,7 @@ static void device_disconnect_clients(struct gatt_device *dev)
 
 	/* Remove all clients by given device's */
 	queue_remove_all(app_connections, match_connection_by_device, dev,
-							destroy_connection);
+							destroy_app_connection);
 }
 
 static void send_client_primary_notify(void *data, void *user_data)
@@ -1341,7 +1341,7 @@ static struct gatt_device *create_device(const bdaddr_t *addr)
 	return device_ref(dev);
 }
 
-static struct app_connection *create_connection(struct gatt_device *device,
+static struct app_connection *create_app_connection(struct gatt_device *device,
 						struct gatt_app *app)
 {
 	struct app_connection *new_conn;
@@ -1381,7 +1381,7 @@ static void trigger_disconnection(struct app_connection *connection)
 	if (queue_remove(app_connections, connection))
 			send_app_disconnect_notify(connection, GATT_SUCCESS);
 
-	destroy_connection(connection);
+	destroy_app_connection(connection);
 }
 
 static void app_disconnect_devices(struct gatt_app *client)
@@ -1510,7 +1510,7 @@ static uint8_t handle_connect(int32_t app_id, const bdaddr_t *addr)
 	conn = queue_find(app_connections, match_connection_by_device_and_app,
 								&conn_match);
 	if (!conn) {
-		conn = create_connection(device, app);
+		conn = create_app_connection(device, app);
 		if (!conn)
 			return HAL_STATUS_NOMEM;
 	}
@@ -5500,7 +5500,7 @@ static void create_listen_connections(void *data, void *user_data)
 
 	app = find_app_by_id(id);
 	if (app)
-		create_connection(dev, app);
+		create_app_connection(dev, app);
 }
 
 static void connect_confirm(GIOChannel *io, void *user_data)
@@ -5960,7 +5960,7 @@ void bt_gatt_unregister(void)
 	queue_destroy(gatt_apps, destroy_gatt_app);
 	gatt_apps = NULL;
 
-	queue_destroy(app_connections, destroy_connection);
+	queue_destroy(app_connections, destroy_app_connection);
 	app_connections = NULL;
 
 	queue_destroy(gatt_devices, destroy_device);
-- 
2.0.0

