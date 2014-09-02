Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 10/16] android/gatt: Move find_conn up in the file
Date: Tue,  2 Sep 2014 12:09:55 +0200
Message-Id: <1409652601-28689-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 31a535c..2e978b9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1358,6 +1358,33 @@ static void send_app_connect_notifications(void *data, void *user_data)
 		send_app_connect_notify(conn, con_data->status);
 }
 
+static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id)
+{
+	struct app_connection conn_match;
+	struct gatt_device *dev = NULL;
+	struct gatt_app *app;
+
+	/* Check if app is registered */
+	app = find_app_by_id(app_id);
+	if (!app) {
+		error("gatt: Client id %d not found", app_id);
+		return NULL;
+	}
+
+	/* Check if device is known */
+	dev = find_device_by_addr(addr);
+	if (!dev) {
+		error("gatt: Client id %d not found", app_id);
+		return NULL;
+	}
+
+	conn_match.device = dev;
+	conn_match.app = app;
+
+	return queue_find(app_connections, match_connection_by_device_and_app,
+								&conn_match);
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1902,33 +1929,6 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
-static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id)
-{
-	struct app_connection conn_match;
-	struct gatt_device *dev = NULL;
-	struct gatt_app *app;
-
-	/* Check if app is registered */
-	app = find_app_by_id(app_id);
-	if (!app) {
-		error("gatt: Client id %d not found", app_id);
-		return NULL;
-	}
-
-	/* Check if device is known */
-	dev = find_device_by_addr(addr);
-	if (!dev) {
-		error("gatt: Client id %d not found", app_id);
-		return NULL;
-	}
-
-	conn_match.device = dev;
-	conn_match.app = app;
-
-	return queue_find(app_connections, match_connection_by_device_and_app,
-								&conn_match);
-}
-
 static uint8_t handle_connect(int32_t app_id, const bdaddr_t *addr)
 {
 	struct app_connection conn_match;
-- 
1.8.4

