Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 11/16] android/gatt: Notify apps interested in autoconnect about connection
Date: Tue,  2 Sep 2014 12:09:56 +0200
Message-Id: <1409652601-28689-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that application interested in auto connect for
particular devices, will be notified about new connections.
---
 android/gatt.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2e978b9..94a65cb 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1385,6 +1385,21 @@ static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id)
 								&conn_match);
 }
 
+static void create_app_connection(void *data, void *user_data)
+{
+	struct gatt_device *dev = user_data;
+	struct gatt_app *app;
+
+	app = find_app_by_id(PTR_TO_INT(data));
+	if (!app)
+		return;
+
+	DBG("Autoconnect application id=%d", app->id);
+
+	if (!find_conn(&dev->bdaddr, PTR_TO_INT(data)))
+		create_connection(dev, app);
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1431,7 +1446,8 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	device_set_state(dev, DEVICE_CONNECTED);
 
-	bt_auto_connect_remove(&dev->bdaddr);
+	if (queue_isempty(dev->autoconnect_apps))
+		bt_auto_connect_remove(&dev->bdaddr);
 
 	/* Send exchange mtu request as we assume being client and server */
 	/* TODO: Dont exchange mtu if no client apps */
@@ -1456,6 +1472,12 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	status = GATT_SUCCESS;
 
 reply:
+	/*
+	 * Make sure there are app_connections for all apps interested in auto
+	 * connect to that device
+	 */
+	queue_foreach(dev->autoconnect_apps, create_app_connection, dev);
+
 	if (!dev->conn_cnt) {
 		struct app_connection *conn;
 
-- 
1.8.4

