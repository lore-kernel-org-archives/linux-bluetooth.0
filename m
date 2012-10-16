Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/8] audio: Remove path from struct audio_device
Date: Tue, 16 Oct 2012 12:12:54 +0200
Message-ID: <1350382379-30489-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
References: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

struct audio_device is holding a reference to btd_device and path can
be easily taken from it when needed.

---
NOTE:
src and dst can also be removed but this require a bit more work and is not
included in this patch

 audio/control.c   |   23 +++++++++++--------
 audio/device.c    |   26 +++++++++------------
 audio/device.h    |    5 ++--
 audio/gateway.c   |   16 +++++++++----
 audio/headset.c   |   66 ++++++++++++++++++++++++++++++-----------------------
 audio/manager.c   |   10 ++++----
 audio/sink.c      |   17 +++++++-------
 audio/source.c    |   13 ++++++-----
 audio/transport.c |    9 +++++---
 9 files changed, 102 insertions(+), 83 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 8bb085a..37b027b 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -46,6 +46,9 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
+#include "../src/adapter.h"
+#include "../src/device.h"
+
 #include "log.h"
 #include "error.h"
 #include "device.h"
@@ -70,6 +73,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 {
 	DBusConnection *conn = btd_get_dbus_connection();
 	struct control *control = dev->control;
+	const char *path = device_get_path(dev->btd_dev);
 
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
@@ -94,10 +98,9 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (old_state != AVCTP_STATE_CONNECTED)
 			break;
 
-		g_dbus_emit_signal(conn, dev->path,
-					AUDIO_CONTROL_INTERFACE,
+		g_dbus_emit_signal(conn, path, AUDIO_CONTROL_INTERFACE,
 					"Disconnected", DBUS_TYPE_INVALID);
-		g_dbus_emit_property_changed(conn, dev->path,
+		g_dbus_emit_property_changed(conn, path,
 					AUDIO_CONTROL_INTERFACE, "Connected");
 
 		break;
@@ -116,10 +119,10 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			control->connect = NULL;
 		}
 
-		g_dbus_emit_signal(conn, dev->path,
+		g_dbus_emit_signal(conn, path,
 				AUDIO_CONTROL_INTERFACE, "Connected",
 				DBUS_TYPE_INVALID);
-		g_dbus_emit_property_changed(conn, dev->path,
+		g_dbus_emit_property_changed(conn, path,
 					AUDIO_CONTROL_INTERFACE, "Connected");
 		break;
 	default:
@@ -298,7 +301,7 @@ static void path_unregister(void *data)
 	struct control *control = dev->control;
 
 	DBG("Unregistered interface %s on path %s",
-		AUDIO_CONTROL_INTERFACE, dev->path);
+		AUDIO_CONTROL_INTERFACE, device_get_path(dev->btd_dev));
 
 	if (control->session)
 		avctp_disconnect(control->session);
@@ -315,7 +318,8 @@ static void path_unregister(void *data)
 
 void control_unregister(struct audio_device *dev)
 {
-	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						device_get_path(dev->btd_dev),
 						AUDIO_CONTROL_INTERFACE);
 }
 
@@ -329,7 +333,8 @@ struct control *control_init(struct audio_device *dev, GSList *uuids)
 {
 	struct control *control;
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					device_get_path(dev->btd_dev),
 					AUDIO_CONTROL_INTERFACE,
 					control_methods, control_signals,
 					control_properties, dev,
@@ -337,7 +342,7 @@ struct control *control_init(struct audio_device *dev, GSList *uuids)
 		return NULL;
 
 	DBG("Registered interface %s on path %s",
-		AUDIO_CONTROL_INTERFACE, dev->path);
+		AUDIO_CONTROL_INTERFACE, device_get_path(dev->btd_dev));
 
 	control = g_new0(struct control, 1);
 
diff --git a/audio/device.c b/audio/device.c
index be63031..aee4161 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -117,7 +117,6 @@ static void device_free(struct audio_device *dev)
 
 	btd_device_unref(dev->btd_dev);
 
-	g_free(dev->path);
 	g_free(dev);
 }
 
@@ -266,7 +265,7 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 		g_dbus_send_message(conn, reply);
 	}
 
-	emit_property_changed(dev->path,
+	emit_property_changed(device_get_path(dev->btd_dev),
 				AUDIO_INTERFACE, "State",
 				DBUS_TYPE_STRING, &state_str);
 }
@@ -619,35 +618,31 @@ static const GDBusSignalTable dev_signals[] = {
 };
 
 struct audio_device *audio_device_register(struct btd_device *device,
-					const char *path, const bdaddr_t *src,
-					const bdaddr_t *dst)
+							const bdaddr_t *src,
+							const bdaddr_t *dst)
 {
 	struct audio_device *dev;
 
-	if (!path)
-		return NULL;
-
 	dev = g_new0(struct audio_device, 1);
 
 	dev->btd_dev = btd_device_ref(device);
-	dev->path = g_strdup(path);
 	bacpy(&dev->dst, dst);
 	bacpy(&dev->src, src);
 	dev->priv = g_new0(struct dev_priv, 1);
 	dev->priv->state = AUDIO_STATE_DISCONNECTED;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					dev->path, AUDIO_INTERFACE,
-					dev_methods, dev_signals, NULL,
-					dev, NULL)) {
+					device_get_path(dev->btd_dev),
+					AUDIO_INTERFACE, dev_methods,
+					dev_signals, NULL, dev, NULL)) {
 		error("Unable to register %s on %s", AUDIO_INTERFACE,
-								dev->path);
+						device_get_path(dev->btd_dev));
 		device_free(dev);
 		return NULL;
 	}
 
 	DBG("Registered interface %s on path %s", AUDIO_INTERFACE,
-								dev->path);
+						device_get_path(dev->btd_dev));
 
 	if (sink_callback_id == 0)
 		sink_callback_id = sink_add_state_cb(device_sink_cb, NULL);
@@ -714,8 +709,9 @@ void audio_device_unregister(struct audio_device *device)
 	if (device->control)
 		control_unregister(device);
 
-	g_dbus_unregister_interface(btd_get_dbus_connection(), device->path,
-						AUDIO_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					device_get_path(device->btd_dev),
+					AUDIO_INTERFACE);
 
 	device_free(device);
 }
diff --git a/audio/device.h b/audio/device.h
index 2b92528..1e2cac1 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -33,7 +33,6 @@ struct dev_priv;
 struct audio_device {
 	struct btd_device *btd_dev;
 
-	char *path;
 	bdaddr_t src;
 	bdaddr_t dst;
 
@@ -53,8 +52,8 @@ struct audio_device {
 };
 
 struct audio_device *audio_device_register(struct btd_device *device,
-					const char *path, const bdaddr_t *src,
-					const bdaddr_t *dst);
+							const bdaddr_t *src,
+							const bdaddr_t *dst);
 
 void audio_device_unregister(struct audio_device *device);
 
diff --git a/audio/gateway.c b/audio/gateway.c
index b4d96f0..2d5b4aa 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -42,6 +42,9 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include "../src/adapter.h"
+#include "../src/device.h"
+
 #include "sdp-client.h"
 #include "device.h"
 #include "gateway.h"
@@ -135,7 +138,7 @@ static void change_state(struct audio_device *dev, gateway_state_t new_state)
 	old_state = gw->state;
 	gw->state = new_state;
 
-	emit_property_changed(dev->path,
+	emit_property_changed(device_get_path(dev->btd_dev),
 				AUDIO_GATEWAY_INTERFACE, "State",
 				DBUS_TYPE_STRING, &val);
 
@@ -649,7 +652,8 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 
 	gateway_close(device);
 	ba2str(&device->dst, gw_addr);
-	DBG("Disconnected from %s, %s", gw_addr, device->path);
+	DBG("Disconnected from %s, %s", gw_addr,
+					device_get_path(device->btd_dev));
 
 	return reply;
 }
@@ -779,7 +783,7 @@ static void path_unregister(void *data)
 	struct audio_device *dev = data;
 
 	DBG("Unregistered interface %s on path %s",
-		AUDIO_GATEWAY_INTERFACE, dev->path);
+		AUDIO_GATEWAY_INTERFACE, device_get_path(dev->btd_dev));
 
 	gateway_close(dev);
 
@@ -792,13 +796,15 @@ void gateway_unregister(struct audio_device *dev)
 	if (dev->gateway->agent)
 		agent_disconnect(dev, dev->gateway->agent);
 
-	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						device_get_path(dev->btd_dev),
 						AUDIO_GATEWAY_INTERFACE);
 }
 
 struct gateway *gateway_init(struct audio_device *dev)
 {
-	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					device_get_path(dev->btd_dev),
 					AUDIO_GATEWAY_INTERFACE,
 					gateway_methods, gateway_signals,
 					NULL, dev, path_unregister))
diff --git a/audio/headset.c b/audio/headset.c
index c822e35..5e42a61 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -582,7 +582,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
-	DBG("SCO socket opened for headset %s", dev->path);
+	DBG("SCO socket opened for headset %s", device_get_path(dev->btd_dev));
 
 	sk = g_io_channel_unix_get_fd(chan);
 
@@ -802,7 +802,8 @@ static int key_press(struct audio_device *device, const char *buf)
 	if (strlen(buf) < 9)
 		return -EINVAL;
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), device->path,
+	g_dbus_emit_signal(btd_get_dbus_connection(),
+			device_get_path(device->btd_dev),
 			AUDIO_HEADSET_INTERFACE, "AnswerRequested",
 			DBUS_TYPE_INVALID);
 
@@ -847,7 +848,8 @@ int telephony_terminate_call_rsp(void *telephony_device,
 	if (err != CME_ERROR_NONE)
 		return telephony_generic_rsp(telephony_device, err);
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), device->path,
+	g_dbus_emit_signal(btd_get_dbus_connection(),
+			device_get_path(device->btd_dev),
 			AUDIO_HEADSET_INTERFACE, "CallTerminated",
 			DBUS_TYPE_INVALID);
 
@@ -982,12 +984,13 @@ static int headset_set_gain(struct audio_device *device, uint16_t gain, char typ
 		return -EINVAL;
 	}
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), device->path,
+	g_dbus_emit_signal(btd_get_dbus_connection(),
+				device_get_path(device->btd_dev),
 				AUDIO_HEADSET_INTERFACE, name,
 				DBUS_TYPE_UINT16, &gain,
 				DBUS_TYPE_INVALID);
 
-	emit_property_changed(device->path,
+	emit_property_changed(device_get_path(device->btd_dev),
 				AUDIO_HEADSET_INTERFACE, property,
 				DBUS_TYPE_UINT16, &gain);
 
@@ -1401,7 +1404,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	g_io_add_watch(chan, G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
 			(GIOFunc) rfcomm_io_cb, dev);
 
-	DBG("%s: Connected to %s", dev->path, hs_address);
+	DBG("%s: Connected to %s", device_get_path(dev->btd_dev), hs_address);
 
 	hs->slc = g_new0(struct headset_slc, 1);
 	hs->slc->sp_gain = 15;
@@ -1619,8 +1622,8 @@ static int rfcomm_connect(struct audio_device *dev, headset_stream_cb_t cb,
 
 	ba2str(&dev->dst, address);
 
-	DBG("%s: Connecting to %s channel %d", dev->path, address,
-		hs->rfcomm_ch);
+	DBG("%s: Connecting to %s channel %d", device_get_path(dev->btd_dev),
+						address, hs->rfcomm_ch);
 
 	hs->tmp_rfcomm = bt_io_connect(headset_connect_cb, dev,
 					NULL, &err,
@@ -1686,7 +1689,8 @@ static DBusMessage *hs_disconnect(DBusConnection *conn, DBusMessage *msg,
 
 	headset_shutdown(device);
 	ba2str(&device->dst, hs_address);
-	info("Disconnected from %s, %s", hs_address, device->path);
+	info("Disconnected from %s, %s", hs_address,
+					device_get_path(device->btd_dev));
 
 	return dbus_message_new_method_return(msg);
 
@@ -2024,15 +2028,16 @@ static void path_unregister(void *data)
 	}
 
 	DBG("Unregistered interface %s on path %s",
-		AUDIO_HEADSET_INTERFACE, dev->path);
+		AUDIO_HEADSET_INTERFACE, device_get_path(dev->btd_dev));
 
 	headset_free(dev);
 }
 
 void headset_unregister(struct audio_device *dev)
 {
-	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
-		AUDIO_HEADSET_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						device_get_path(dev->btd_dev),
+						AUDIO_HEADSET_INTERFACE);
 }
 
 struct headset *headset_init(struct audio_device *dev, GSList *uuids,
@@ -2046,7 +2051,8 @@ struct headset *headset_init(struct audio_device *dev, GSList *uuids,
 
 	headset_update(dev, hs, uuids);
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					device_get_path(dev->btd_dev),
 					AUDIO_HEADSET_INTERFACE,
 					headset_methods, headset_signals, NULL,
 					dev, path_unregister)) {
@@ -2055,7 +2061,7 @@ struct headset *headset_init(struct audio_device *dev, GSList *uuids,
 	}
 
 	DBG("Registered interface %s on path %s", AUDIO_HEADSET_INTERFACE,
-								dev->path);
+						device_get_path(dev->btd_dev));
 
 	return hs;
 }
@@ -2341,15 +2347,16 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		value = FALSE;
 		close_sco(dev);
 		headset_close_rfcomm(dev);
-		emit_property_changed(dev->path,
+		emit_property_changed(device_get_path(dev->btd_dev),
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
-		g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
+		g_dbus_emit_signal(btd_get_dbus_connection(),
+					device_get_path(dev->btd_dev),
 					AUDIO_HEADSET_INTERFACE,
 					"Disconnected",
 					DBUS_TYPE_INVALID);
 		if (hs->state > HEADSET_STATE_CONNECTING) {
-			emit_property_changed(dev->path,
+			emit_property_changed(device_get_path(dev->btd_dev),
 					AUDIO_HEADSET_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &value);
 			telephony_device_disconnected(dev);
@@ -2357,14 +2364,14 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		active_devices = g_slist_remove(active_devices, dev);
 		break;
 	case HEADSET_STATE_CONNECTING:
-		emit_property_changed(dev->path,
+		emit_property_changed(device_get_path(dev->btd_dev),
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		break;
 	case HEADSET_STATE_CONNECTED:
 		close_sco(dev);
 		if (hs->state != HEADSET_STATE_PLAY_IN_PROGRESS)
-			emit_property_changed(dev->path,
+			emit_property_changed(device_get_path(dev->btd_dev),
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		if (hs->state < state) {
@@ -2372,12 +2379,13 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 				slc->inband_ring = TRUE;
 			else
 				slc->inband_ring = FALSE;
-			g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
+			g_dbus_emit_signal(btd_get_dbus_connection(),
+						device_get_path(dev->btd_dev),
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
 						DBUS_TYPE_INVALID);
 			value = TRUE;
-			emit_property_changed(dev->path,
+			emit_property_changed(device_get_path(dev->btd_dev),
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
 						DBUS_TYPE_BOOLEAN, &value);
@@ -2385,11 +2393,12 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 			telephony_device_connected(dev);
 		} else if (hs->state == HEADSET_STATE_PLAYING) {
 			value = FALSE;
-			g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
+			g_dbus_emit_signal(btd_get_dbus_connection(),
+						device_get_path(dev->btd_dev),
 						AUDIO_HEADSET_INTERFACE,
 						"Stopped",
 						DBUS_TYPE_INVALID);
-			emit_property_changed(dev->path,
+			emit_property_changed(device_get_path(dev->btd_dev),
 						AUDIO_HEADSET_INTERFACE,
 						"Playing",
 						DBUS_TYPE_BOOLEAN, &value);
@@ -2399,7 +2408,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		break;
 	case HEADSET_STATE_PLAYING:
 		value = TRUE;
-		emit_property_changed(dev->path,
+		emit_property_changed(device_get_path(dev->btd_dev),
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 
@@ -2409,10 +2418,11 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					G_IO_ERR | G_IO_NVAL,
 					(GIOFunc) sco_cb, dev);
 
-		g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
+		g_dbus_emit_signal(btd_get_dbus_connection(),
+					device_get_path(dev->btd_dev),
 					AUDIO_HEADSET_INTERFACE, "Playing",
 					DBUS_TYPE_INVALID);
-		emit_property_changed(dev->path,
+		emit_property_changed(device_get_path(dev->btd_dev),
 					AUDIO_HEADSET_INTERFACE, "Playing",
 					DBUS_TYPE_BOOLEAN, &value);
 
@@ -2425,8 +2435,8 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 
 	hs->state = state;
 
-	DBG("State changed %s: %s -> %s", dev->path, str_state[old_state],
-		str_state[state]);
+	DBG("State changed %s: %s -> %s", device_get_path(dev->btd_dev),
+				str_state[old_state], str_state[state]);
 
 	for (l = headset_callbacks; l != NULL; l = l->next) {
 		struct headset_state_callback *cb = l->data;
diff --git a/audio/manager.c b/audio/manager.c
index b052009..4ea61bf 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -435,7 +435,7 @@ static void gateway_auth_cb(DBusError *derr, void *user_data)
 
 		ba2str(&device->dst, ag_address);
 		DBG("Accepted AG connection from %s for %s",
-			ag_address, device->path);
+			ag_address, device_get_path(device->btd_dev));
 
 		gateway_start_service(device);
 	}
@@ -1240,7 +1240,8 @@ GSList *manager_find_devices(const char *path,
 	for (l = devices; l != NULL; l = l->next) {
 		struct audio_device *dev = l->data;
 
-		if ((path && (strcmp(path, "")) && strcmp(dev->path, path)))
+		if ((path && (strcmp(path, "")) &&
+				strcmp(device_get_path(dev->btd_dev), path)))
 			continue;
 
 		if ((src && bacmp(src, BDADDR_ANY)) && bacmp(&dev->src, src))
@@ -1304,7 +1305,6 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 	char addr[18];
-	const char *path;
 
 	dev = manager_find_device(NULL, src, dst, NULL, FALSE);
 	if (dev)
@@ -1330,9 +1330,7 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 		return NULL;
 	}
 
-	path = device_get_path(device);
-
-	dev = audio_device_register(device, path, src, dst);
+	dev = audio_device_register(device, src, dst);
 	if (!dev)
 		return NULL;
 
diff --git a/audio/sink.c b/audio/sink.c
index d45185c..2e63579 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -114,12 +114,12 @@ static void sink_set_state(struct audio_device *dev, sink_state_t new_state)
 
 	state_str = state2str(new_state);
 	if (state_str)
-		emit_property_changed(dev->path,
+		emit_property_changed(device_get_path(dev->btd_dev),
 					AUDIO_SINK_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 
-	DBG("State changed %s: %s -> %s", dev->path, str_state[old_state],
-		str_state[new_state]);
+	DBG("State changed %s: %s -> %s", device_get_path(dev->btd_dev),
+				str_state[old_state], str_state[new_state]);
 
 	for (l = sink_callbacks; l != NULL; l = l->next) {
 		struct sink_state_callback *cb = l->data;
@@ -532,29 +532,30 @@ static void path_unregister(void *data)
 	struct audio_device *dev = data;
 
 	DBG("Unregistered interface %s on path %s",
-		AUDIO_SINK_INTERFACE, dev->path);
+			AUDIO_SINK_INTERFACE, device_get_path(dev->btd_dev));
 
 	sink_free(dev);
 }
 
 void sink_unregister(struct audio_device *dev)
 {
-	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
-		AUDIO_SINK_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+			device_get_path(dev->btd_dev), AUDIO_SINK_INTERFACE);
 }
 
 struct sink *sink_init(struct audio_device *dev)
 {
 	struct sink *sink;
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					device_get_path(dev->btd_dev),
 					AUDIO_SINK_INTERFACE,
 					sink_methods, sink_signals, NULL,
 					dev, path_unregister))
 		return NULL;
 
 	DBG("Registered interface %s on path %s",
-		AUDIO_SINK_INTERFACE, dev->path);
+			AUDIO_SINK_INTERFACE, device_get_path(dev->btd_dev));
 
 	if (avdtp_callback_id == 0)
 		avdtp_callback_id = avdtp_add_state_cb(avdtp_state_callback,
diff --git a/audio/source.c b/audio/source.c
index e111954..1d0c74a 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -108,7 +108,7 @@ static void source_set_state(struct audio_device *dev, source_state_t new_state)
 
 	state_str = state2str(new_state);
 	if (state_str)
-		emit_property_changed(dev->path,
+		emit_property_changed(device_get_path(dev->btd_dev),
 					AUDIO_SOURCE_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 
@@ -521,29 +521,30 @@ static void path_unregister(void *data)
 	struct audio_device *dev = data;
 
 	DBG("Unregistered interface %s on path %s",
-		AUDIO_SOURCE_INTERFACE, dev->path);
+			AUDIO_SOURCE_INTERFACE, device_get_path(dev->btd_dev));
 
 	source_free(dev);
 }
 
 void source_unregister(struct audio_device *dev)
 {
-	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
-						AUDIO_SOURCE_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+			device_get_path(dev->btd_dev), AUDIO_SOURCE_INTERFACE);
 }
 
 struct source *source_init(struct audio_device *dev)
 {
 	struct source *source;
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					device_get_path(dev->btd_dev),
 					AUDIO_SOURCE_INTERFACE,
 					source_methods, source_signals, NULL,
 					dev, path_unregister))
 		return NULL;
 
 	DBG("Registered interface %s on path %s",
-					AUDIO_SOURCE_INTERFACE, dev->path);
+			AUDIO_SOURCE_INTERFACE, device_get_path(dev->btd_dev));
 
 	if (avdtp_callback_id == 0)
 		avdtp_callback_id = avdtp_add_state_cb(avdtp_state_callback,
diff --git a/audio/transport.c b/audio/transport.c
index daafff8..46ab0a7 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -34,6 +34,7 @@
 #include <gdbus.h>
 
 #include "../src/adapter.h"
+#include "../src/device.h"
 #include "../src/dbus-common.h"
 
 #include "log.h"
@@ -1040,6 +1041,7 @@ void transport_get_properties(struct media_transport *transport,
 	const char *uuid;
 	uint8_t codec;
 	const char *state;
+	const char *path;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -1047,8 +1049,8 @@ void transport_get_properties(struct media_transport *transport,
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
 	/* Device */
-	dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH,
-						&transport->device->path);
+	path = device_get_path(transport->device->btd_dev);
+	dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH, &path);
 
 	uuid = media_endpoint_get_uuid(transport->endpoint);
 	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
@@ -1265,7 +1267,8 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 	transport->configuration = g_new(uint8_t, size);
 	memcpy(transport->configuration, configuration, size);
 	transport->size = size;
-	transport->path = g_strdup_printf("%s/fd%d", device->path, fd++);
+	transport->path = g_strdup_printf("%s/fd%d",
+				device_get_path(device->btd_dev), fd++);
 	transport->fd = -1;
 
 	uuid = media_endpoint_get_uuid(endpoint);
-- 
1.7.9.5

