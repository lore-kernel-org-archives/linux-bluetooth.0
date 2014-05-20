Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Use connect_confirm on incoming connection
Date: Tue, 20 May 2014 10:43:32 +0200
Message-Id: <1400575412-544-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is in order to reuse connect_cb for incoming and outgoing
connections. Also it makes code cleaner.
---
 android/gatt.c | 47 +++++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8e0d72a..d402a31 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -991,8 +991,10 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		return;
 	}
 
-	g_io_channel_unref(dev->att_io);
-	dev->att_io = NULL;
+	if (dev->att_io) {
+		g_io_channel_unref(dev->att_io);
+		dev->att_io = NULL;
+	}
 
 	if (gerr) {
 		error("gatt: connection failed %s", gerr->message);
@@ -4794,21 +4796,15 @@ static void create_listen_connections(void *data, void *user_data)
 		create_connection(dev, app);
 }
 
-static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
+static void connect_confirm(GIOChannel *io, void *user_data)
 {
 	struct gatt_device *dev;
 	uint8_t dst_type;
 	bdaddr_t dst;
-	struct connect_data data;
+	GError *gerr = NULL;
 
 	DBG("");
 
-	if (gerr) {
-		error("gatt: %s", gerr->message);
-		g_error_free(gerr);
-		return;
-	}
-
 	bt_io_get(io, &gerr,
 			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_DEST_TYPE, &dst_type,
@@ -4825,7 +4821,7 @@ static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
 		dev = create_device(&dst);
 		if (!dev) {
 			error("gatt: Could not create device");
-			return;
+			goto drop;
 		}
 
 		dev->bdaddr_type = dst_type;
@@ -4836,32 +4832,23 @@ static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
 			ba2str(&dst, addr);
 			info("gatt: Rejecting incoming connection from %s",
 									addr);
-			return;
+			goto drop;
 		}
 	}
 
-	dev->attrib = g_attrib_new(io);
-	if (!dev->attrib) {
-		error("gatt: unable to create new GAttrib instance");
-		destroy_device(dev);
-		return;
+	if (!bt_io_accept(io, connect_cb, device_ref(dev), NULL, NULL)) {
+		error("gatt: failed to accept connection");
+		device_unref(dev);
+		goto drop;
 	}
-	dev->watch_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-							disconnected_cb, dev);
 
 	queue_foreach(listen_apps, create_listen_connections, dev);
+	device_set_state(dev, DEVICE_CONNECT_READY);
 
-	data.dev = dev;
-	data.status = GATT_SUCCESS;
-	device_set_state(dev, DEVICE_CONNECTED);
-
-	queue_foreach(app_connections, send_app_connect_notifications, &data);
+	return;
 
-	dev->server_id = g_attrib_register(dev->attrib, GATTRIB_ALL_REQS,
-						GATTRIB_ALL_HANDLES,
-						att_handler, dev, NULL);
-	if (dev->server_id == 0)
-		error("gatt: Could not attach to server");
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
 }
 
 struct gap_srvc_handles {
@@ -5132,7 +5119,7 @@ static bool start_listening_io(void)
 	GError *gerr = NULL;
 
 	/* For now only listen on BLE */
-	listening_io = bt_io_listen(connect_event, NULL,
+	listening_io = bt_io_listen(NULL, connect_confirm,
 					&listening_io, NULL, &gerr,
 					BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
 					BT_IO_OPT_CID, ATT_CID,
-- 
1.8.4

