Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 03/17] dbus-common: Remove conn parameter from emit_property_changed
Date: Wed, 19 Sep 2012 12:22:05 +0200
Message-ID: <1348050139-27883-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Valid DBusConnection pointer is available static variable 'connection' so it's
it's redundant to pass it as function parameter.
---
 audio/control.c                    |  8 ++---
 audio/device.c                     |  2 +-
 audio/gateway.c                    |  6 ++--
 audio/headset.c                    | 18 +++++-----
 audio/sink.c                       | 10 +++---
 audio/source.c                     |  2 +-
 audio/transport.c                  |  8 ++---
 profiles/health/hdp.c              | 12 +++----
 profiles/input/device.c            | 10 +++---
 profiles/network/connection.c      | 12 +++----
 profiles/proximity/immalert.c      |  2 +-
 profiles/proximity/linkloss.c      |  2 +-
 profiles/proximity/monitor.c       | 21 +++++------
 profiles/sap/server.c              |  8 ++---
 profiles/thermometer/thermometer.c |  8 ++---
 src/adapter.c                      | 34 +++++++++---------
 src/dbus-common.c                  |  5 ++-
 src/dbus-common.h                  |  3 +-
 src/device.c                       | 72 ++++++++++++++++++--------------------
 19 files changed, 118 insertions(+), 125 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 5477c2d..02aea33 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -80,7 +80,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		g_dbus_emit_signal(dev->conn, dev->path,
 					AUDIO_CONTROL_INTERFACE,
 					"Disconnected", DBUS_TYPE_INVALID);
-		emit_property_changed(dev->conn, dev->path,
+		emit_property_changed(dev->path,
 					AUDIO_CONTROL_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &value);
 
@@ -97,9 +97,9 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		g_dbus_emit_signal(dev->conn, dev->path,
 				AUDIO_CONTROL_INTERFACE, "Connected",
 				DBUS_TYPE_INVALID);
-		emit_property_changed(dev->conn, dev->path,
-				AUDIO_CONTROL_INTERFACE, "Connected",
-				DBUS_TYPE_BOOLEAN, &value);
+		emit_property_changed(dev->path,
+					AUDIO_CONTROL_INTERFACE, "Connected",
+					DBUS_TYPE_BOOLEAN, &value);
 		break;
 	default:
 		return;
diff --git a/audio/device.c b/audio/device.c
index 4952b57..b93a294 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -280,7 +280,7 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 		g_dbus_send_message(dev->conn, reply);
 	}
 
-	emit_property_changed(dev->conn, dev->path,
+	emit_property_changed(dev->path,
 				AUDIO_INTERFACE, "State",
 				DBUS_TYPE_STRING, &state_str);
 }
diff --git a/audio/gateway.c b/audio/gateway.c
index 53094af..0fe29d1 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -129,9 +129,9 @@ static void change_state(struct audio_device *dev, gateway_state_t new_state)
 	old_state = gw->state;
 	gw->state = new_state;
 
-	emit_property_changed(dev->conn, dev->path,
-			AUDIO_GATEWAY_INTERFACE, "State",
-			DBUS_TYPE_STRING, &val);
+	emit_property_changed(dev->path,
+				AUDIO_GATEWAY_INTERFACE, "State",
+				DBUS_TYPE_STRING, &val);
 
 	for (l = gateway_callbacks; l != NULL; l = l->next) {
 		struct gateway_state_callback *cb = l->data;
diff --git a/audio/headset.c b/audio/headset.c
index 1ef6c49..3ded18e 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -988,7 +988,7 @@ static int headset_set_gain(struct audio_device *device, uint16_t gain, char typ
 				DBUS_TYPE_UINT16, &gain,
 				DBUS_TYPE_INVALID);
 
-	emit_property_changed(device->conn, device->path,
+	emit_property_changed(device->path,
 				AUDIO_HEADSET_INTERFACE, property,
 				DBUS_TYPE_UINT16, &gain);
 
@@ -2343,7 +2343,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		value = FALSE;
 		close_sco(dev);
 		headset_close_rfcomm(dev);
-		emit_property_changed(dev->conn, dev->path,
+		emit_property_changed(dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		g_dbus_emit_signal(dev->conn, dev->path,
@@ -2351,7 +2351,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					"Disconnected",
 					DBUS_TYPE_INVALID);
 		if (hs->state > HEADSET_STATE_CONNECTING) {
-			emit_property_changed(dev->conn, dev->path,
+			emit_property_changed(dev->path,
 					AUDIO_HEADSET_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &value);
 			telephony_device_disconnected(dev);
@@ -2359,14 +2359,14 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		active_devices = g_slist_remove(active_devices, dev);
 		break;
 	case HEADSET_STATE_CONNECTING:
-		emit_property_changed(dev->conn, dev->path,
+		emit_property_changed(dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		break;
 	case HEADSET_STATE_CONNECTED:
 		close_sco(dev);
 		if (hs->state != HEADSET_STATE_PLAY_IN_PROGRESS)
-			emit_property_changed(dev->conn, dev->path,
+			emit_property_changed(dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		if (hs->state < state) {
@@ -2379,7 +2379,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 						"Connected",
 						DBUS_TYPE_INVALID);
 			value = TRUE;
-			emit_property_changed(dev->conn, dev->path,
+			emit_property_changed(dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
 						DBUS_TYPE_BOOLEAN, &value);
@@ -2391,7 +2391,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 						AUDIO_HEADSET_INTERFACE,
 						"Stopped",
 						DBUS_TYPE_INVALID);
-			emit_property_changed(dev->conn, dev->path,
+			emit_property_changed(dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Playing",
 						DBUS_TYPE_BOOLEAN, &value);
@@ -2401,7 +2401,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		break;
 	case HEADSET_STATE_PLAYING:
 		value = TRUE;
-		emit_property_changed(dev->conn, dev->path,
+		emit_property_changed(dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 
@@ -2414,7 +2414,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		g_dbus_emit_signal(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "Playing",
 					DBUS_TYPE_INVALID);
-		emit_property_changed(dev->conn, dev->path,
+		emit_property_changed(dev->path,
 					AUDIO_HEADSET_INTERFACE, "Playing",
 					DBUS_TYPE_BOOLEAN, &value);
 
diff --git a/audio/sink.c b/audio/sink.c
index 53a0b80..6201d85 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -116,7 +116,7 @@ static void sink_set_state(struct audio_device *dev, sink_state_t new_state)
 
 	state_str = state2str(new_state);
 	if (state_str)
-		emit_property_changed(dev->conn, dev->path,
+		emit_property_changed(dev->path,
 					AUDIO_SINK_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 
@@ -147,7 +147,7 @@ static void avdtp_state_callback(struct audio_device *dev,
 			g_dbus_emit_signal(dev->conn, dev->path,
 					AUDIO_SINK_INTERFACE, "Disconnected",
 					DBUS_TYPE_INVALID);
-			emit_property_changed(dev->conn, dev->path,
+			emit_property_changed(dev->path,
 					AUDIO_SINK_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &value);
 		}
@@ -218,7 +218,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 						AUDIO_SINK_INTERFACE,
 						"Connected",
 						DBUS_TYPE_INVALID);
-			emit_property_changed(dev->conn, dev->path,
+			emit_property_changed(dev->path,
 						AUDIO_SINK_INTERFACE,
 						"Connected",
 						DBUS_TYPE_BOOLEAN, &value);
@@ -228,7 +228,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 						AUDIO_SINK_INTERFACE,
 						"Stopped",
 						DBUS_TYPE_INVALID);
-			emit_property_changed(dev->conn, dev->path,
+			emit_property_changed(dev->path,
 						AUDIO_SINK_INTERFACE,
 						"Playing",
 						DBUS_TYPE_BOOLEAN, &value);
@@ -239,7 +239,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		value = TRUE;
 		g_dbus_emit_signal(dev->conn, dev->path, AUDIO_SINK_INTERFACE,
 					"Playing", DBUS_TYPE_INVALID);
-		emit_property_changed(dev->conn, dev->path,
+		emit_property_changed(dev->path,
 					AUDIO_SINK_INTERFACE, "Playing",
 					DBUS_TYPE_BOOLEAN, &value);
 		sink_set_state(dev, SINK_STATE_PLAYING);
diff --git a/audio/source.c b/audio/source.c
index e4ba211..8e01666 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -110,7 +110,7 @@ static void source_set_state(struct audio_device *dev, source_state_t new_state)
 
 	state_str = state2str(new_state);
 	if (state_str)
-		emit_property_changed(dev->conn, dev->path,
+		emit_property_changed(dev->path,
 					AUDIO_SOURCE_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 
diff --git a/audio/transport.c b/audio/transport.c
index 281895e..6541fc1 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -203,7 +203,7 @@ static void transport_set_state(struct media_transport *transport,
 	str = state2str(state);
 
 	if (g_strcmp0(str, state2str(old_state)) != 0)
-		emit_property_changed(transport->conn, transport->path,
+		emit_property_changed(transport->path,
 					MEDIA_TRANSPORT_INTERFACE, "State",
 					DBUS_TYPE_STRING, &str);
 }
@@ -1168,7 +1168,7 @@ static void headset_nrec_changed(struct audio_device *dev, gboolean nrec,
 
 	DBG("");
 
-	emit_property_changed(transport->conn, transport->path,
+	emit_property_changed(transport->path,
 				MEDIA_TRANSPORT_INTERFACE, "NREC",
 				DBUS_TYPE_BOOLEAN, &nrec);
 }
@@ -1367,7 +1367,7 @@ void media_transport_update_delay(struct media_transport *transport,
 
 	a2dp->delay = delay;
 
-	emit_property_changed(transport->conn, transport->path,
+	emit_property_changed(transport->path,
 				MEDIA_TRANSPORT_INTERFACE, "Delay",
 				DBUS_TYPE_UINT16, &a2dp->delay);
 }
@@ -1388,7 +1388,7 @@ void media_transport_update_volume(struct media_transport *transport,
 
 	a2dp->volume = volume;
 
-	emit_property_changed(transport->conn, transport->path,
+	emit_property_changed(transport->path,
 				MEDIA_TRANSPORT_INTERFACE, "Volume",
 				DBUS_TYPE_UINT16, &a2dp->volume);
 }
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 5d62d35..351fe1e 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -977,9 +977,9 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 
 	dev->fr = hdp_channel_ref(chan);
 
-	emit_property_changed(dev->conn, device_get_path(dev->dev),
-					HEALTH_DEVICE, "MainChannel",
-					DBUS_TYPE_OBJECT_PATH, &dev->fr->path);
+	emit_property_changed(device_get_path(dev->dev),
+				HEALTH_DEVICE, "MainChannel",
+				DBUS_TYPE_OBJECT_PATH, &dev->fr->path);
 
 end:
 	hdp_channel_unref(dev->ndc);
@@ -1696,9 +1696,9 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 
 	dev->fr = hdp_channel_ref(hdp_chann);
 
-	emit_property_changed(dev->conn, device_get_path(dev->dev),
-					HEALTH_DEVICE, "MainChannel",
-					DBUS_TYPE_OBJECT_PATH, &dev->fr->path);
+	emit_property_changed(device_get_path(dev->dev),
+				HEALTH_DEVICE, "MainChannel",
+				DBUS_TYPE_OBJECT_PATH, &dev->fr->path);
 }
 
 static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 1954b34..dc3da80 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -147,8 +147,9 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	if ((cond & (G_IO_HUP | G_IO_ERR)) && idev->ctrl_watch)
 		g_io_channel_shutdown(chan, TRUE, NULL);
 
-	emit_property_changed(idev->conn, idev->path, INPUT_DEVICE_INTERFACE,
-				"Connected", DBUS_TYPE_BOOLEAN, &connected);
+	emit_property_changed(idev->path,
+				INPUT_DEVICE_INTERFACE, "Connected",
+				DBUS_TYPE_BOOLEAN, &connected);
 
 	device_remove_disconnect_watch(idev->device, idev->dc_id);
 	idev->dc_id = 0;
@@ -492,8 +493,9 @@ static int input_device_connected(struct input_device *idev)
 		return err;
 
 	connected = TRUE;
-	emit_property_changed(idev->conn, idev->path, INPUT_DEVICE_INTERFACE,
-				"Connected", DBUS_TYPE_BOOLEAN, &connected);
+	emit_property_changed(idev->path,
+				INPUT_DEVICE_INTERFACE, "Connected",
+				DBUS_TYPE_BOOLEAN, &connected);
 
 	idev->dc_id = device_add_disconnect_watch(idev->device, disconnect_cb,
 							idev, NULL);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index b81d5b5..178f51f 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -119,13 +119,13 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 	if (connection != NULL) {
 		gboolean connected = FALSE;
 		const char *property = "";
-		emit_property_changed(connection, nc->peer->path,
+		emit_property_changed(nc->peer->path,
 					NETWORK_PEER_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &connected);
-		emit_property_changed(connection, nc->peer->path,
+		emit_property_changed(nc->peer->path,
 					NETWORK_PEER_INTERFACE, "Interface",
 					DBUS_TYPE_STRING, &property);
-		emit_property_changed(connection, nc->peer->path,
+		emit_property_changed(nc->peer->path,
 					NETWORK_PEER_INTERFACE, "UUID",
 					DBUS_TYPE_STRING, &property);
 		device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
@@ -274,13 +274,13 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 			DBUS_TYPE_INVALID);
 
 	connected = TRUE;
-	emit_property_changed(connection, nc->peer->path,
+	emit_property_changed(nc->peer->path,
 				NETWORK_PEER_INTERFACE, "Connected",
 				DBUS_TYPE_BOOLEAN, &connected);
-	emit_property_changed(connection, nc->peer->path,
+	emit_property_changed(nc->peer->path,
 				NETWORK_PEER_INTERFACE, "Interface",
 				DBUS_TYPE_STRING, &pdev);
-	emit_property_changed(connection, nc->peer->path,
+	emit_property_changed(nc->peer->path,
 				NETWORK_PEER_INTERFACE, "UUID",
 				DBUS_TYPE_STRING, &uuid);
 
diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index ebd788a..59e4f12 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -136,7 +136,7 @@ static void imm_alert_emit_alert_signal(struct connected_device *condev,
 
 	DBG("alert %s remote %s", alert_level_str, path);
 
-	emit_property_changed(btd_get_dbus_connection(), path,
+	emit_property_changed(path,
 			PROXIMITY_REPORTER_INTERFACE, "ImmediateAlertLevel",
 			DBUS_TYPE_STRING, &alert_level_str);
 }
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index 37d1f86..659eaa8 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -137,7 +137,7 @@ static void link_loss_emit_alert_signal(struct connected_device *condev)
 
 	DBG("alert %s remote %s", alert_level_str, path);
 
-	emit_property_changed(btd_get_dbus_connection(), path,
+	emit_property_changed(path,
 			PROXIMITY_REPORTER_INTERFACE, "LinkLossAlertLevel",
 			DBUS_TYPE_STRING, &alert_level_str);
 }
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index a9de85b..a791916 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -160,7 +160,7 @@ static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("Link Loss Alert Level written");
 
-	emit_property_changed(btd_get_dbus_connection(), path,
+	emit_property_changed(path,
 				PROXIMITY_INTERFACE, "LinkLossAlertLevel",
 				DBUS_TYPE_STRING, &monitor->linklosslevel);
 }
@@ -289,10 +289,9 @@ static gboolean immediate_timeout(gpointer user_data)
 
 	g_free(monitor->immediatelevel);
 	monitor->immediatelevel = g_strdup("none");
-	emit_property_changed(btd_get_dbus_connection(),
-					path, PROXIMITY_INTERFACE,
-					"ImmediateAlertLevel", DBUS_TYPE_STRING,
-					&monitor->immediatelevel);
+	emit_property_changed(path,
+				PROXIMITY_INTERFACE, "ImmediateAlertLevel",
+				DBUS_TYPE_STRING, &monitor->immediatelevel);
 
 	return FALSE;
 }
@@ -305,9 +304,8 @@ static void immediate_written(gpointer user_data)
 	g_free(monitor->fallbacklevel);
 	monitor->fallbacklevel = NULL;
 
-	emit_property_changed(btd_get_dbus_connection(),
-				path, PROXIMITY_INTERFACE,
-				"ImmediateAlertLevel",
+	emit_property_changed(path,
+				PROXIMITY_INTERFACE, "ImmediateAlertLevel",
 				DBUS_TYPE_STRING, &monitor->immediatelevel);
 
 	monitor->immediateto = g_timeout_add_seconds(IMMEDIATE_TIMEOUT,
@@ -392,10 +390,9 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	g_free(monitor->immediatelevel);
 	monitor->immediatelevel = g_strdup("none");
-	emit_property_changed(btd_get_dbus_connection(),
-					path, PROXIMITY_INTERFACE,
-					"ImmediateAlertLevel", DBUS_TYPE_STRING,
-					&monitor->immediatelevel);
+	emit_property_changed(path,
+				PROXIMITY_INTERFACE, "ImmediateAlertLevel",
+				DBUS_TYPE_STRING, &monitor->immediatelevel);
 }
 
 static gboolean level_is_valid(const char *level)
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 78a63bf..fc3d83c 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -622,9 +622,9 @@ static void sap_set_connected(struct sap_server *server)
 {
 	gboolean connected = TRUE;
 
-	emit_property_changed(connection, server->path,
-					SAP_SERVER_INTERFACE,
-		"Connected", DBUS_TYPE_BOOLEAN, &connected);
+	emit_property_changed(server->path,
+				SAP_SERVER_INTERFACE, "Connected",
+				DBUS_TYPE_BOOLEAN, &connected);
 
 	server->conn->state = SAP_STATE_CONNECTED;
 }
@@ -1149,7 +1149,7 @@ static void sap_io_destroy(void *data)
 
 	if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS &&
 			conn->state != SAP_STATE_CONNECT_MODEM_BUSY)
-		emit_property_changed(connection, server->path,
+		emit_property_changed(server->path,
 					SAP_SERVER_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &connected);
 
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index f58e558..44043e8 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -265,7 +265,7 @@ static void change_property(struct thermometer *t, const char *name,
 			return;
 
 		t->intermediate = *intermediate;
-		emit_property_changed(t->conn, device_get_path(t->dev),
+		emit_property_changed(device_get_path(t->dev),
 					THERMOMETER_INTERFACE, name,
 					DBUS_TYPE_BOOLEAN, &t->intermediate);
 	} else if (g_strcmp0(name, "Interval") == 0) {
@@ -275,7 +275,7 @@ static void change_property(struct thermometer *t, const char *name,
 
 		t->has_interval = TRUE;
 		t->interval = *interval;
-		emit_property_changed(t->conn, device_get_path(t->dev),
+		emit_property_changed(device_get_path(t->dev),
 					THERMOMETER_INTERFACE, name,
 					DBUS_TYPE_UINT16, &t->interval);
 	} else if (g_strcmp0(name, "Maximum") == 0) {
@@ -284,7 +284,7 @@ static void change_property(struct thermometer *t, const char *name,
 			return;
 
 		t->max = *max;
-		emit_property_changed(t->conn, device_get_path(t->dev),
+		emit_property_changed(device_get_path(t->dev),
 					THERMOMETER_INTERFACE, name,
 					DBUS_TYPE_UINT16, &t->max);
 	} else if (g_strcmp0(name, "Minimum") == 0) {
@@ -293,7 +293,7 @@ static void change_property(struct thermometer *t, const char *name,
 			return;
 
 		t->min = *min;
-		emit_property_changed(t->conn, device_get_path(t->dev),
+		emit_property_changed(device_get_path(t->dev),
 					THERMOMETER_INTERFACE, name,
 					DBUS_TYPE_UINT16, &t->min);
 	} else
diff --git a/src/adapter.c b/src/adapter.c
index facfa23..2db3200 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -430,7 +430,7 @@ void btd_adapter_pairable_changed(struct btd_adapter *adapter,
 
 	write_device_pairable(&adapter->bdaddr, pairable);
 
-	emit_property_changed(connection, adapter->path,
+	emit_property_changed(adapter->path,
 				ADAPTER_INTERFACE, "Pairable",
 				DBUS_TYPE_BOOLEAN, &pairable);
 
@@ -654,7 +654,7 @@ static DBusMessage *set_discoverable_timeout(DBusConnection *conn,
 
 	path = dbus_message_get_path(msg);
 
-	emit_property_changed(conn, path,
+	emit_property_changed(path,
 				ADAPTER_INTERFACE, "DiscoverableTimeout",
 				DBUS_TYPE_UINT32, &timeout);
 
@@ -681,7 +681,7 @@ static DBusMessage *set_pairable_timeout(DBusConnection *conn,
 
 	path = dbus_message_get_path(msg);
 
-	emit_property_changed(conn, path,
+	emit_property_changed(path,
 				ADAPTER_INTERFACE, "PairableTimeout",
 				DBUS_TYPE_UINT32, &timeout);
 
@@ -711,7 +711,7 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint8_t *new_class)
 		attrib_gap_set(adapter, GATT_CHARAC_APPEARANCE, cls, 2);
 	}
 
-	emit_property_changed(connection, adapter->path,
+	emit_property_changed(adapter->path,
 				ADAPTER_INTERFACE, "Class",
 				DBUS_TYPE_UINT32, &class);
 }
@@ -724,8 +724,7 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 	g_free(adapter->name);
 	adapter->name = g_strdup(name);
 
-	if (connection)
-		emit_property_changed(connection, adapter->path,
+	emit_property_changed(adapter->path,
 					ADAPTER_INTERFACE, "Name",
 					DBUS_TYPE_STRING, &name);
 
@@ -2240,9 +2239,9 @@ void btd_adapter_start(struct btd_adapter *adapter)
 		adapter->mode = MODE_CONNECTABLE;
 
 	powered = TRUE;
-	emit_property_changed(connection, adapter->path,
-					ADAPTER_INTERFACE, "Powered",
-					DBUS_TYPE_BOOLEAN, &powered);
+	emit_property_changed(adapter->path,
+				ADAPTER_INTERFACE, "Powered",
+				DBUS_TYPE_BOOLEAN, &powered);
 
 	call_adapter_powered_callbacks(adapter, TRUE);
 
@@ -2363,22 +2362,23 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	}
 
 	if (adapter->scan_mode == (SCAN_PAGE | SCAN_INQUIRY))
-		emit_property_changed(connection, adapter->path,
+		emit_property_changed(adapter->path,
 					ADAPTER_INTERFACE, "Discoverable",
 					DBUS_TYPE_BOOLEAN, &prop_false);
 
 	if ((adapter->scan_mode & SCAN_PAGE) && adapter->pairable == TRUE)
-		emit_property_changed(connection, adapter->path,
+		emit_property_changed(adapter->path,
 					ADAPTER_INTERFACE, "Pairable",
 					DBUS_TYPE_BOOLEAN, &prop_false);
 
 	if (adapter->discovering)
-		emit_property_changed(connection, adapter->path,
+		emit_property_changed(adapter->path,
 					ADAPTER_INTERFACE, "Discovering",
 					DBUS_TYPE_BOOLEAN, &prop_false);
 
-	emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
-				"Powered", DBUS_TYPE_BOOLEAN, &prop_false);
+	emit_property_changed(adapter->path,
+				ADAPTER_INTERFACE, "Powered",
+				DBUS_TYPE_BOOLEAN, &prop_false);
 
 	adapter->discovering = FALSE;
 	adapter->scan_mode = SCAN_DISABLED;
@@ -2573,7 +2573,7 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 
 	adapter->discovering = discovering;
 
-	emit_property_changed(connection, path,
+	emit_property_changed(path,
 				ADAPTER_INTERFACE, "Discovering",
 				DBUS_TYPE_BOOLEAN, &discovering);
 
@@ -3053,11 +3053,11 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 
 	/* If page scanning gets toggled emit the Pairable property */
 	if ((adapter->scan_mode & SCAN_PAGE) != (scan_mode & SCAN_PAGE))
-		emit_property_changed(connection, adapter->path,
+		emit_property_changed(adapter->path,
 					ADAPTER_INTERFACE, "Pairable",
 					DBUS_TYPE_BOOLEAN, &pairable);
 
-	emit_property_changed(connection, path,
+	emit_property_changed(path,
 				ADAPTER_INTERFACE, "Discoverable",
 				DBUS_TYPE_BOOLEAN, &discoverable);
 
diff --git a/src/dbus-common.c b/src/dbus-common.c
index f7e9e8f..21395d9 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -118,8 +118,7 @@ void dict_append_array(DBusMessageIter *dict, const char *key, int type,
 	dbus_message_iter_close_container(dict, &entry);
 }
 
-dbus_bool_t emit_property_changed(DBusConnection *conn,
-					const char *path,
+dbus_bool_t emit_property_changed(const char *path,
 					const char *interface,
 					const char *name,
 					int type, void *value)
@@ -141,7 +140,7 @@ dbus_bool_t emit_property_changed(DBusConnection *conn,
 
 	append_variant(&iter, type, value);
 
-	return g_dbus_send_message(conn, signal);
+	return g_dbus_send_message(connection, signal);
 }
 
 dbus_bool_t emit_array_property_changed(DBusConnection *conn,
diff --git a/src/dbus-common.h b/src/dbus-common.h
index 127cf9c..ff130ff 100644
--- a/src/dbus-common.h
+++ b/src/dbus-common.h
@@ -29,8 +29,7 @@ void dict_append_entry(DBusMessageIter *dict,
 void dict_append_array(DBusMessageIter *dict, const char *key, int type,
 			void *val, int n_elements);
 
-dbus_bool_t emit_property_changed(DBusConnection *conn,
-					const char *path,
+dbus_bool_t emit_property_changed(const char *path,
 					const char *interface,
 					const char *name,
 					int type, void *value);
diff --git a/src/device.c b/src/device.c
index 278d721..b732cc6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -463,7 +463,7 @@ static DBusMessage *set_alias(DBusConnection *conn, DBusMessage *msg,
 	g_free(device->alias);
 	device->alias = g_str_equal(alias, "") ? NULL : g_strdup(alias);
 
-	emit_property_changed(conn, dbus_message_get_path(msg),
+	emit_property_changed(dbus_message_get_path(msg),
 				DEVICE_INTERFACE, "Alias",
 				DBUS_TYPE_STRING, &alias);
 
@@ -492,7 +492,7 @@ static DBusMessage *set_trust(DBusConnection *conn, DBusMessage *msg,
 
 	device->trusted = value;
 
-	emit_property_changed(conn, dbus_message_get_path(msg),
+	emit_property_changed(dbus_message_get_path(msg),
 				DEVICE_INTERFACE, "Trusted",
 				DBUS_TYPE_BOOLEAN, &value);
 
@@ -550,8 +550,9 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 
 	device_set_temporary(device, FALSE);
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Blocked",
-					DBUS_TYPE_BOOLEAN, &device->blocked);
+	emit_property_changed(device->path,
+				DEVICE_INTERFACE, "Blocked",
+				DBUS_TYPE_BOOLEAN, &device->blocked);
 
 	return 0;
 }
@@ -581,7 +582,7 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
 	if (!silent) {
-		emit_property_changed(conn, device->path,
+		emit_property_changed(device->path,
 					DEVICE_INTERFACE, "Blocked",
 					DBUS_TYPE_BOOLEAN, &device->blocked);
 		device_probe_profiles(device, device->uuids);
@@ -914,7 +915,7 @@ void device_add_connection(struct btd_device *device, DBusConnection *conn)
 
 	device->connected = TRUE;
 
-	emit_property_changed(conn, device->path,
+	emit_property_changed(device->path,
 					DEVICE_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &device->connected);
 }
@@ -945,9 +946,9 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
 	if (device_is_paired(device) && !device_is_bonded(device))
 		device_set_paired(device, FALSE);
 
-	emit_property_changed(conn, device->path,
-					DEVICE_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &device->connected);
+	emit_property_changed(device->path,
+				DEVICE_INTERFACE, "Connected",
+				DBUS_TYPE_BOOLEAN, &device->connected);
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
@@ -988,53 +989,49 @@ void device_remove_disconnect_watch(struct btd_device *device, guint id)
 
 static void device_set_vendor(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
-
 	if (device->vendor == value)
 		return;
 
 	device->vendor = value;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Vendor",
+	emit_property_changed(device->path,
+				DEVICE_INTERFACE, "Vendor",
 				DBUS_TYPE_UINT16, &value);
 }
 
 static void device_set_vendor_src(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
-
 	if (device->vendor_src == value)
 		return;
 
 	device->vendor_src = value;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE,
-				"VendorSource", DBUS_TYPE_UINT16, &value);
+	emit_property_changed(device->path,
+				DEVICE_INTERFACE, "VendorSource",
+				DBUS_TYPE_UINT16, &value);
 }
 
 static void device_set_product(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
-
 	if (device->product == value)
 		return;
 
 	device->product = value;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Product",
+	emit_property_changed(device->path,
+				DEVICE_INTERFACE, "Product",
 				DBUS_TYPE_UINT16, &value);
 }
 
 static void device_set_version(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
-
 	if (device->version == value)
 		return;
 
 	device->version = value;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Version",
+	emit_property_changed(device->path,
+				DEVICE_INTERFACE, "Version",
 				DBUS_TYPE_UINT16, &value);
 }
 
@@ -1106,21 +1103,19 @@ struct btd_device *device_create(DBusConnection *conn,
 
 void device_set_name(struct btd_device *device, const char *name)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
-
 	if (strncmp(name, device->name, MAX_NAME_LENGTH) == 0)
 		return;
 
 	strncpy(device->name, name, MAX_NAME_LENGTH);
 
-	emit_property_changed(conn, device->path,
+	emit_property_changed(device->path,
 				DEVICE_INTERFACE, "Name",
 				DBUS_TYPE_STRING, &name);
 
 	if (device->alias != NULL)
 		return;
 
-	emit_property_changed(conn, device->path,
+	emit_property_changed(device->path,
 				DEVICE_INTERFACE, "Alias",
 				DBUS_TYPE_STRING, &name);
 }
@@ -2344,8 +2339,6 @@ static void bonding_request_free(struct bonding_req *bonding)
 
 void device_set_paired(struct btd_device *device, gboolean value)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
-
 	if (device->paired == value)
 		return;
 
@@ -2355,7 +2348,8 @@ void device_set_paired(struct btd_device *device, gboolean value)
 
 	device->paired = value;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Paired",
+	emit_property_changed(device->path,
+				DEVICE_INTERFACE, "Paired",
 				DBUS_TYPE_BOOLEAN, &value);
 }
 
@@ -3075,15 +3069,16 @@ void btd_device_unref(struct btd_device *device)
 
 void device_set_class(struct btd_device *device, uint32_t value)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	const char *icon = class_to_icon(value);
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Class",
+	emit_property_changed(device->path,
+				DEVICE_INTERFACE, "Class",
 				DBUS_TYPE_UINT32, &value);
 
 	if (icon)
-		emit_property_changed(conn, device->path, DEVICE_INTERFACE,
-					"Icon", DBUS_TYPE_STRING, &icon);
+		emit_property_changed(device->path,
+					DEVICE_INTERFACE, "Icon",
+					DBUS_TYPE_STRING, &icon);
 }
 
 int device_get_appearance(struct btd_device *device, uint16_t *value)
@@ -3107,16 +3102,17 @@ int device_get_appearance(struct btd_device *device, uint16_t *value)
 
 void device_set_appearance(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	const char *icon = gap_appearance_to_icon(value);
 	bdaddr_t src;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE,
-				"Appearance", DBUS_TYPE_UINT16, &value);
+	emit_property_changed(device->path,
+				DEVICE_INTERFACE, "Appearance",
+				DBUS_TYPE_UINT16, &value);
 
 	if (icon)
-		emit_property_changed(conn, device->path, DEVICE_INTERFACE,
-					"Icon", DBUS_TYPE_STRING, &icon);
+		emit_property_changed(device->path,
+					DEVICE_INTERFACE, "Icon",
+					DBUS_TYPE_STRING, &icon);
 
 	adapter_get_address(device_get_adapter(device), &src);
 	write_remote_appearance(&src, &device->bdaddr, device->bdaddr_type,
-- 
1.7.11.3

