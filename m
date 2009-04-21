Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: root <root@forrest.sh.intel.com>
Subject: [PATCH] re-use the sco_server initiated by audio plugin
Date: Tue, 21 Apr 2009 17:20:53 +0800
Message-Id: <1240305653-21666-1-git-send-email-forrest.zhao@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: root <root@forrest.sh.intel.com>

---
 audio/gateway.c |   63 ++++++++++++++++++++++++++++---------------------------
 audio/gateway.h |    6 +++++
 audio/main.c    |   38 ++++++++++++++++++++++----------
 3 files changed, 64 insertions(+), 43 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 73e5a12..b49b13f 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -101,10 +101,10 @@ struct indicator {
 };
 
 struct gateway {
+	gateway_state_t state;
 	GIOChannel *rfcomm;
 	guint rfcomm_watch_id;
 	GIOChannel *sco;
-	GIOChannel *sco_server;
 	gateway_stream_cb_t sco_start_cb;
 	void *sco_start_cb_data;
 	DBusMessage *connect_message;
@@ -559,32 +559,24 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 	gw->rfcomm = chan;
 
 	if (establish_service_level_conn(dev->gateway)) {
-		GIOChannel *sco_server = bt_io_listen(BT_IO_SCO, sco_connect_cb,
-					NULL, dev, NULL, NULL,
-					BT_IO_OPT_SOURCE_BDADDR, &dev->src,
-					BT_IO_OPT_INVALID);
+		gboolean value = TRUE;
 
-		if (sco_server) {
-			gboolean value = TRUE;
-			debug("%s: Connected to %s", dev->path, gw_addr);
-			rfcomm_start_watch(dev);
-			gw->sco_server = sco_server;
-			if (conn_mes) {
-				DBusMessage *reply =
+		debug("%s: Connected to %s", dev->path, gw_addr);
+		rfcomm_start_watch(dev);
+		if (conn_mes) {
+			DBusMessage *reply =
 				dbus_message_new_method_return(conn_mes);
-				dbus_connection_send(dev->conn, reply, NULL);
-				dbus_message_unref(reply);
-				dbus_message_unref(conn_mes);
-				gw->connect_message = NULL;
-			}
+			dbus_connection_send(dev->conn, reply, NULL);
+			dbus_message_unref(reply);
+			dbus_message_unref(conn_mes);
+			gw->connect_message = NULL;
+		}
 
-			emit_property_changed(dev->conn, dev->path,
-					AUDIO_GATEWAY_INTERFACE,
-					"Connected", DBUS_TYPE_BOOLEAN,	&value);
-			return;
-		} else
-			error("%s: Failed to setup SCO server socket",
-						dev->path);
+		gw->state = GATEWAY_STATE_CONNECTED;
+		emit_property_changed(dev->conn, dev->path,
+				AUDIO_GATEWAY_INTERFACE,
+				"Connected", DBUS_TYPE_BOOLEAN,	&value);
+		return;
 	} else
 		error("%s: Failed to establish service layer connection to %s",
 			dev->path, gw_addr);
@@ -1061,13 +1053,15 @@ struct gateway *gateway_init(struct audio_device *dev)
 	gw->indies = NULL;
 	gw->is_dialing = FALSE;
 	gw->call_active = FALSE;
+	gw->state = GATEWAY_STATE_DISCONNECTED;
 	return gw;
 
 }
 
 gboolean gateway_is_connected(struct audio_device *dev)
 {
-	return (dev && dev->gateway && dev->gateway->rfcomm);
+	return (dev && dev->gateway &&
+			dev->gateway->state == GATEWAY_STATE_CONNECTED);
 }
 
 int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
@@ -1081,6 +1075,18 @@ int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 	return 0;
 }
 
+int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
+{
+	struct gateway *gw = dev->gateway;
+
+	if (gw->sco)
+		return -EISCONN;
+
+	gw->sco = g_io_channel_ref(io);
+
+	return 0;
+}
+
 void gateway_start_service(struct audio_device *device)
 {
 	rfcomm_connect_cb(device->gateway->rfcomm, NULL, device);
@@ -1096,7 +1102,6 @@ int gateway_close(struct audio_device *device)
 	struct gateway *gw = device->gateway;
 	GIOChannel *rfcomm = gw->rfcomm;
 	GIOChannel *sco = gw->sco;
-	GIOChannel *sco_server = gw->sco_server;
 	gboolean value = FALSE;
 
 	g_slist_foreach(gw->indies, (GFunc) indicator_slice_free, NULL);
@@ -1115,11 +1120,7 @@ int gateway_close(struct audio_device *device)
 		gw->sco_start_cb_data = NULL;
 	}
 
-	if (sco_server) {
-		g_io_channel_close(sco_server);
-		g_io_channel_unref(sco_server);
-		gw->sco_server = NULL;
-	}
+	gw->state = GATEWAY_STATE_DISCONNECTED;
 
 	emit_property_changed(device->conn, device->path,
 				AUDIO_GATEWAY_INTERFACE,
diff --git a/audio/gateway.h b/audio/gateway.h
index 7acad46..e539469 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -27,10 +27,16 @@
 #define DEFAULT_HSP_HS_CHANNEL 6
 #define DEFAULT_HFP_HS_CHANNEL 7
 
+typedef enum {
+	GATEWAY_STATE_DISCONNECTED,
+	GATEWAY_STATE_CONNECTED
+} gateway_state_t;
+
 typedef void (*gateway_stream_cb_t) (struct audio_device *dev, void *user_data);
 struct gateway *gateway_init(struct audio_device *device);
 gboolean gateway_is_connected(struct audio_device *dev);
 int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *chan);
+int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
 void gateway_start_service(struct audio_device *device);
 gboolean gateway_request_stream(struct audio_device *dev,
 			gateway_stream_cb_t cb, void *user_data);
diff --git a/audio/main.c b/audio/main.c
index 565c83b..7911697 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -45,6 +45,7 @@
 #include "unix.h"
 #include "headset.h"
 #include "manager.h"
+#include "gateway.h"
 
 static GIOChannel *sco_server = NULL;
 
@@ -94,24 +95,37 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
 	if (!device)
 		goto drop;
 
-	if (headset_get_state(device) < HEADSET_STATE_CONNECTED) {
-		debug("Refusing SCO from non-connected headset");
+	if (device->headset) {
+		if (headset_get_state(device) < HEADSET_STATE_CONNECTED) {
+			debug("Refusing SCO from non-connected headset");
+			goto drop;
+		}
+
+		if (!get_hfp_active(device)) {
+			error("Refusing non-HFP SCO connect attempt from %s",
+									addr);
+			goto drop;
+		}
+
+		if (headset_connect_sco(device, chan) < 0)
+			goto drop;
+
+		headset_set_state(device, HEADSET_STATE_PLAYING);
+	} else if (device->gateway) {
+		if (!gateway_is_connected(device)) {
+			debug("Refusing SCO from non-connected AG");
+			goto drop;
+		}
+
+		if (gateway_connect_sco(device, chan) < 0)
+			goto drop;
+	} else
 		goto drop;
-	}
-
-	if (!get_hfp_active(device)) {
-		error("Refusing non-HFP SCO connect attempt from %s", addr);
-		goto drop;
-	}
 
 	sk = g_io_channel_unix_get_fd(chan);
 	fcntl(sk, F_SETFL, 0);
 
-	if (headset_connect_sco(device, chan) < 0)
-		goto drop;
-
 	debug("Accepted SCO connection from %s", addr);
-	headset_set_state(device, HEADSET_STATE_PLAYING);
 
 	return;
 
-- 
1.5.4.5

