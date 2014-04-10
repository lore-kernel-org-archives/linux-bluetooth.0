Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/5] android/gatt: Move functions up in the file
Date: Thu, 10 Apr 2014 17:30:03 +0200
Message-Id: <1397143805-17809-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move send_client_disconnect_notify connection_cleanup and
put_device_on_disc_list up in the file

This is needed by following patch
---
 android/gatt.c | 84 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 3483f5d..6368317 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -480,6 +480,41 @@ failed:
 					HAL_OP_GATT_CLIENT_REGISTER, status);
 }
 
+static void connection_cleanup(struct gatt_device *device)
+{
+	if (device->watch_id) {
+		g_source_remove(device->watch_id);
+		device->watch_id = 0;
+	}
+
+	if (device->att_io) {
+		g_io_channel_shutdown(device->att_io, FALSE, NULL);
+		g_io_channel_unref(device->att_io);
+		device->att_io = NULL;
+	}
+
+	if (device->attrib) {
+		GAttrib *attrib = device->attrib;
+		device->attrib = NULL;
+		g_attrib_cancel_all(attrib);
+		g_attrib_unref(attrib);
+	}
+}
+
+static void send_client_disconnect_notify(int32_t id, struct gatt_device *dev,
+								uint8_t status)
+{
+	struct hal_ev_gatt_client_disconnect ev;
+
+	ev.client_if = id;
+	ev.conn_id = dev->conn_id;
+	ev.status = status;
+	bdaddr2android(&dev->bdaddr, &ev.bda);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
+}
+
 static void send_client_connect_notify(int32_t id, struct gatt_device *dev,
 								int32_t status)
 {
@@ -505,6 +540,13 @@ static void remove_client_from_device_list(void *data, void *user_data)
 	queue_remove_if(dev->clients, match_by_value, user_data);
 }
 
+static void put_device_on_disc_list(struct gatt_device *dev)
+{
+	dev->conn_id = 0;
+	queue_remove_all(dev->clients, NULL, NULL, NULL);
+	queue_push_tail(disc_dev_list, dev);
+}
+
 static void remove_client_from_devices(int32_t id)
 {
 	DBG("");
@@ -684,41 +726,6 @@ done:
 	send_client_all_primary(gatt_status, dev->services, dev->conn_id);
 }
 
-static void connection_cleanup(struct gatt_device *device)
-{
-	if (device->watch_id) {
-		g_source_remove(device->watch_id);
-		device->watch_id = 0;
-	}
-
-	if (device->att_io) {
-		g_io_channel_shutdown(device->att_io, FALSE, NULL);
-		g_io_channel_unref(device->att_io);
-		device->att_io = NULL;
-	}
-
-	if (device->attrib) {
-		GAttrib *attrib = device->attrib;
-		device->attrib = NULL;
-		g_attrib_cancel_all(attrib);
-		g_attrib_unref(attrib);
-	}
-}
-
-static void send_client_disconnect_notify(int32_t id, struct gatt_device *dev,
-								uint8_t status)
-{
-	struct hal_ev_gatt_client_disconnect ev;
-
-	ev.client_if = id;
-	ev.conn_id = dev->conn_id;
-	ev.status = status;
-	bdaddr2android(&dev->bdaddr, &ev.bda);
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
-}
-
 static void client_disconnect_notify(void *data, void *user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -782,13 +789,6 @@ connect:
 	bt_le_discovery_stop(bt_le_discovery_stop_cb);
 }
 
-static void put_device_on_disc_list(struct gatt_device *dev)
-{
-	dev->conn_id = 0;
-	queue_remove_all(dev->clients, NULL, NULL, NULL);
-	queue_push_tail(disc_dev_list, dev);
-}
-
 static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-- 
1.8.4

