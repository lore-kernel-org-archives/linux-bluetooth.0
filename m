Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 10/17] audio: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:12 +0200
Message-ID: <1348050139-27883-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes redundant references and function parameters for
DBusConnection object and uses btd_get_dbus_connection() call wherever
such object is needed instead.

Pointer returned by this call is guaranteed to be valid for entire
bluetoothd lifetime and thus do not need to be refcounted.
---
 audio/a2dp.c             |  9 +------
 audio/a2dp.h             |  2 +-
 audio/avrcp.c            |  2 +-
 audio/avrcp.h            |  2 +-
 audio/control.c          |  9 ++++---
 audio/device.c           | 20 ++++++--------
 audio/device.h           |  4 +--
 audio/gateway.c          | 20 +++++++-------
 audio/headset.c          | 50 +++++++++++++++++------------------
 audio/main.c             | 15 +----------
 audio/manager.c          | 21 ++++-----------
 audio/manager.h          |  3 +--
 audio/media.c            | 69 +++++++++++++++++++-----------------------------
 audio/media.h            |  2 +-
 audio/sink.c             | 44 +++++++++++++-----------------
 audio/source.c           | 28 ++++++++------------
 audio/telephony-dummy.c  | 17 +++++-------
 audio/telephony-maemo5.c | 51 +++++++++++++++++------------------
 audio/telephony-maemo6.c | 36 +++++++++++--------------
 audio/telephony-ofono.c  | 25 +++++++++---------
 audio/transport.c        | 43 +++++++++++++-----------------
 audio/transport.h        |  3 +--
 22 files changed, 194 insertions(+), 281 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 64b37e7..fd1c494 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -102,8 +102,6 @@ struct a2dp_setup {
 	int ref;
 };
 
-static DBusConnection *connection = NULL;
-
 struct a2dp_server {
 	bdaddr_t src;
 	GSList *sinks;
@@ -1168,7 +1166,7 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
 	return NULL;
 }
 
-int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
+int a2dp_register(const bdaddr_t *src, GKeyFile *config)
 {
 	gboolean source = TRUE, sink = FALSE;
 	gboolean delay_reporting = FALSE;
@@ -1206,8 +1204,6 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 	}
 
 proceed:
-	if (!connection)
-		connection = dbus_connection_ref(conn);
 
 	server = find_server(servers, src);
 	if (!server) {
@@ -1278,9 +1274,6 @@ void a2dp_unregister(const bdaddr_t *src)
 
 	if (servers)
 		return;
-
-	dbus_connection_unref(connection);
-	connection = NULL;
 }
 
 struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
diff --git a/audio/a2dp.h b/audio/a2dp.h
index deab3b8..736bc66 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -64,7 +64,7 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 					struct avdtp_error *err,
 					void *user_data);
 
-int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
+int a2dp_register(const bdaddr_t *src, GKeyFile *config);
 void a2dp_unregister(const bdaddr_t *src);
 
 struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 27be7e8..7258e7a 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1270,7 +1270,7 @@ void avrcp_disconnect(struct audio_device *dev)
 	avctp_disconnect(session);
 }
 
-int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
+int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 {
 	sdp_record_t *record;
 	gboolean tmp, master = TRUE;
diff --git a/audio/avrcp.h b/audio/avrcp.h
index bf11a6c..d94a050 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -88,7 +88,7 @@ struct avrcp_player_cb {
 							void *user_data);
 };
 
-int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
+int avrcp_register(const bdaddr_t *src, GKeyFile *config);
 void avrcp_unregister(const bdaddr_t *src);
 
 gboolean avrcp_connect(struct audio_device *dev);
diff --git a/audio/control.c b/audio/control.c
index 02aea33..896bc48 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -66,6 +66,7 @@ struct control {
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 				avctp_state_t new_state, void *user_data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct control *control = dev->control;
 	gboolean value;
 
@@ -77,7 +78,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			break;
 
 		value = FALSE;
-		g_dbus_emit_signal(dev->conn, dev->path,
+		g_dbus_emit_signal(conn, dev->path,
 					AUDIO_CONTROL_INTERFACE,
 					"Disconnected", DBUS_TYPE_INVALID);
 		emit_property_changed(dev->path,
@@ -94,7 +95,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		break;
 	case AVCTP_STATE_CONNECTED:
 		value = TRUE;
-		g_dbus_emit_signal(dev->conn, dev->path,
+		g_dbus_emit_signal(conn, dev->path,
 				AUDIO_CONTROL_INTERFACE, "Connected",
 				DBUS_TYPE_INVALID);
 		emit_property_changed(dev->path,
@@ -233,7 +234,7 @@ static void path_unregister(void *data)
 
 void control_unregister(struct audio_device *dev)
 {
-	g_dbus_unregister_interface(dev->conn, dev->path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
 						AUDIO_CONTROL_INTERFACE);
 }
 
@@ -247,7 +248,7 @@ struct control *control_init(struct audio_device *dev, GSList *uuids)
 {
 	struct control *control;
 
-	if (!g_dbus_register_interface(dev->conn, dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
 					AUDIO_CONTROL_INTERFACE,
 					control_methods, control_signals, NULL,
 					dev, path_unregister))
diff --git a/audio/device.c b/audio/device.c
index b93a294..99d6512 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -106,9 +106,6 @@ static void device_free(struct audio_device *dev)
 {
 	struct dev_priv *priv = dev->priv;
 
-	if (dev->conn)
-		dbus_connection_unref(dev->conn);
-
 	btd_device_unref(dev->btd_dev);
 
 	if (priv) {
@@ -230,6 +227,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 
 static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct dev_priv *priv = dev->priv;
 	const char *state_str;
 	DBusMessage *reply = NULL;
@@ -263,7 +261,7 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 			reply = dbus_message_new_method_return(priv->dc_req);
 			dbus_message_unref(priv->dc_req);
 			priv->dc_req = NULL;
-			g_dbus_send_message(dev->conn, reply);
+			g_dbus_send_message(conn, reply);
 		}
 		priv->disconnecting = FALSE;
 	}
@@ -277,7 +275,7 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 
 		dbus_message_unref(priv->conn_req);
 		priv->conn_req = NULL;
-		g_dbus_send_message(dev->conn, reply);
+		g_dbus_send_message(conn, reply);
 	}
 
 	emit_property_changed(dev->path,
@@ -632,14 +630,13 @@ static const GDBusSignalTable dev_signals[] = {
 	{ }
 };
 
-struct audio_device *audio_device_register(DBusConnection *conn,
-					struct btd_device *device,
+struct audio_device *audio_device_register(struct btd_device *device,
 					const char *path, const bdaddr_t *src,
 					const bdaddr_t *dst)
 {
 	struct audio_device *dev;
 
-	if (!conn || !path)
+	if (!path)
 		return NULL;
 
 	dev = g_new0(struct audio_device, 1);
@@ -648,12 +645,11 @@ struct audio_device *audio_device_register(DBusConnection *conn,
 	dev->path = g_strdup(path);
 	bacpy(&dev->dst, dst);
 	bacpy(&dev->src, src);
-	dev->conn = dbus_connection_ref(conn);
 	dev->priv = g_new0(struct dev_priv, 1);
 	dev->priv->state = AUDIO_STATE_DISCONNECTED;
 
-	if (!g_dbus_register_interface(dev->conn, dev->path,
-					AUDIO_INTERFACE,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					dev->path, AUDIO_INTERFACE,
 					dev_methods, dev_signals, NULL,
 					dev, NULL)) {
 		error("Unable to register %s on %s", AUDIO_INTERFACE,
@@ -730,7 +726,7 @@ void audio_device_unregister(struct audio_device *device)
 	if (device->control)
 		control_unregister(device);
 
-	g_dbus_unregister_interface(device->conn, device->path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(), device->path,
 						AUDIO_INTERFACE);
 
 	device_free(device);
diff --git a/audio/device.h b/audio/device.h
index 75f1da9..f9b868f 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -33,7 +33,6 @@ struct dev_priv;
 struct audio_device {
 	struct btd_device *btd_dev;
 
-	DBusConnection *conn;
 	char *path;
 	bdaddr_t src;
 	bdaddr_t dst;
@@ -52,8 +51,7 @@ struct audio_device {
 	struct dev_priv *priv;
 };
 
-struct audio_device *audio_device_register(DBusConnection *conn,
-					struct btd_device *device,
+struct audio_device *audio_device_register(struct btd_device *device,
 					const char *path, const bdaddr_t *src,
 					const bdaddr_t *dst);
 
diff --git a/audio/gateway.c b/audio/gateway.c
index 0fe29d1..45b25a1 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -159,7 +159,7 @@ static void agent_disconnect(struct audio_device *dev, struct hf_agent *agent)
 	msg = dbus_message_new_method_call(agent->name, agent->path,
 			"org.bluez.HandsfreeAgent", "Release");
 
-	g_dbus_send_message(dev->conn, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 }
 
 static gboolean agent_sendfd(struct hf_agent *agent, int fd,
@@ -177,7 +177,7 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
 					DBUS_TYPE_UINT16, &gw->version,
 					DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(dev->conn, msg,
+	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), msg,
 							&call, -1) == FALSE) {
 		dbus_message_unref(msg);
 		return FALSE;
@@ -308,6 +308,7 @@ done:
 static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 				gpointer user_data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct audio_device *dev = user_data;
 	struct gateway *gw = dev->gateway;
 	DBusMessage *reply;
@@ -338,7 +339,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 	else
 		reply = btd_error_failed(gw->msg, "Can't pass file descriptor");
 
-	g_dbus_send_message(dev->conn, reply);
+	g_dbus_send_message(conn, reply);
 
 	return;
 
@@ -346,7 +347,7 @@ fail:
 	if (gw->msg) {
 		DBusMessage *reply;
 		reply = btd_error_failed(gw->msg, "Connect failed");
-		g_dbus_send_message(dev->conn, reply);
+		g_dbus_send_message(conn, reply);
 	}
 
 	gateway_close(dev);
@@ -514,7 +515,7 @@ fail:
 	if (gw->msg) {
 		DBusMessage *reply = btd_error_failed(gw->msg,
 					gerr ? gerr->message : strerror(-err));
-		g_dbus_send_message(dev->conn, reply);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
 	}
 
 	gateway_close(dev);
@@ -597,9 +598,6 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 	DBusMessage *reply = NULL;
 	char gw_addr[18];
 
-	if (!device->conn)
-		return NULL;
-
 	if (!gw->rfcomm)
 		return btd_error_not_connected(msg);
 
@@ -706,7 +704,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 	if (strcmp(gw->agent->path, path) != 0)
 		return btd_error_does_not_exist(msg);
 
-	g_dbus_remove_watch(device->conn, gw->agent->watch);
+	g_dbus_remove_watch(conn, gw->agent->watch);
 
 	agent_free(gw->agent);
 	gw->agent = NULL;
@@ -752,13 +750,13 @@ void gateway_unregister(struct audio_device *dev)
 	if (dev->gateway->agent)
 		agent_disconnect(dev, dev->gateway->agent);
 
-	g_dbus_unregister_interface(dev->conn, dev->path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
 						AUDIO_GATEWAY_INTERFACE);
 }
 
 struct gateway *gateway_init(struct audio_device *dev)
 {
-	if (!g_dbus_register_interface(dev->conn, dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
 					AUDIO_GATEWAY_INTERFACE,
 					gateway_methods, gateway_signals,
 					NULL, dev, path_unregister))
diff --git a/audio/headset.c b/audio/headset.c
index 3ded18e..c822e35 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -186,12 +186,11 @@ struct event {
 
 static GSList *headset_callbacks = NULL;
 
-static void error_connect_failed(DBusConnection *conn, DBusMessage *msg,
-								int err)
+static void error_connect_failed(DBusMessage *msg, int err)
 {
 	DBusMessage *reply = btd_error_failed(msg,
 			err < 0 ? strerror(-err) : "Connect failed");
-	g_dbus_send_message(conn, reply);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
 static int rfcomm_connect(struct audio_device *device, headset_stream_cb_t cb,
@@ -571,7 +570,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		if (p != NULL) {
 			p->err = -errno;
 			if (p->msg)
-				error_connect_failed(dev->conn, p->msg, p->err);
+				error_connect_failed(p->msg, p->err);
 			pending_connect_finalize(dev);
 		}
 
@@ -594,7 +593,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		if (p->msg) {
 			DBusMessage *reply;
 			reply = dbus_message_new_method_return(p->msg);
-			g_dbus_send_message(dev->conn, reply);
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
 		}
 
 		pending_connect_finalize(dev);
@@ -672,7 +671,7 @@ static void hfp_slc_complete(struct audio_device *dev)
 	if (p->target_state == HEADSET_STATE_CONNECTED) {
 		if (p->msg) {
 			DBusMessage *reply = dbus_message_new_method_return(p->msg);
-			g_dbus_send_message(dev->conn, reply);
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
 		}
 		pending_connect_finalize(dev);
 		return;
@@ -681,7 +680,7 @@ static void hfp_slc_complete(struct audio_device *dev)
 	p->err = sco_connect(dev, NULL, NULL, NULL);
 	if (p->err < 0) {
 		if (p->msg)
-			error_connect_failed(dev->conn, p->msg, p->err);
+			error_connect_failed(p->msg, p->err);
 		pending_connect_finalize(dev);
 	}
 }
@@ -803,7 +802,7 @@ static int key_press(struct audio_device *device, const char *buf)
 	if (strlen(buf) < 9)
 		return -EINVAL;
 
-	g_dbus_emit_signal(device->conn, device->path,
+	g_dbus_emit_signal(btd_get_dbus_connection(), device->path,
 			AUDIO_HEADSET_INTERFACE, "AnswerRequested",
 			DBUS_TYPE_INVALID);
 
@@ -848,7 +847,7 @@ int telephony_terminate_call_rsp(void *telephony_device,
 	if (err != CME_ERROR_NONE)
 		return telephony_generic_rsp(telephony_device, err);
 
-	g_dbus_emit_signal(device->conn, device->path,
+	g_dbus_emit_signal(btd_get_dbus_connection(), device->path,
 			AUDIO_HEADSET_INTERFACE, "CallTerminated",
 			DBUS_TYPE_INVALID);
 
@@ -983,7 +982,7 @@ static int headset_set_gain(struct audio_device *device, uint16_t gain, char typ
 		return -EINVAL;
 	}
 
-	g_dbus_emit_signal(device->conn, device->path,
+	g_dbus_emit_signal(btd_get_dbus_connection(), device->path,
 				AUDIO_HEADSET_INTERFACE, name,
 				DBUS_TYPE_UINT16, &gain,
 				DBUS_TYPE_INVALID);
@@ -1424,7 +1423,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	if (p && p->msg) {
 		DBusMessage *reply = dbus_message_new_method_return(p->msg);
-		g_dbus_send_message(dev->conn, reply);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
 	}
 
 	pending_connect_finalize(dev);
@@ -1433,7 +1432,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 failed:
 	if (p && p->msg)
-		error_connect_failed(dev->conn, p->msg, p->err);
+		error_connect_failed(p->msg, p->err);
 	pending_connect_finalize(dev);
 	if (hs->rfcomm)
 		headset_set_state(dev, HEADSET_STATE_CONNECTED);
@@ -1493,7 +1492,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 							strerror(-err), -err);
 		p->err = -err;
 		if (p->msg)
-			error_connect_failed(dev->conn, p->msg, p->err);
+			error_connect_failed(p->msg, p->err);
 		goto failed;
 	}
 
@@ -1542,7 +1541,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		error("Unable to connect: %s (%d)", strerror(-err), -err);
 		p->err = -err;
 		if (p->msg != NULL)
-			error_connect_failed(dev->conn, p->msg, p->err);
+			error_connect_failed(p->msg, p->err);
 		goto failed;
 	}
 
@@ -1554,7 +1553,7 @@ failed_not_supported:
 		return;
 	if (p->msg) {
 		DBusMessage *reply = btd_error_not_supported(p->msg);
-		g_dbus_send_message(dev->conn, reply);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
 	}
 failed:
 	p->svclass = 0;
@@ -1798,8 +1797,7 @@ static DBusMessage *hs_cancel_call(DBusConnection *conn,
 	return reply;
 }
 
-static DBusMessage *hs_set_gain(DBusConnection *conn,
-				DBusMessage *msg,
+static DBusMessage *hs_set_gain(DBusMessage *msg,
 				void *data, uint16_t gain,
 				char type)
 {
@@ -1910,14 +1908,14 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
 			return btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &gain);
-		return hs_set_gain(conn, msg, data, gain,
+		return hs_set_gain(msg, data, gain,
 					HEADSET_GAIN_SPEAKER);
 	} else if (g_str_equal("MicrophoneGain", property)) {
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
 			return btd_error_invalid_args(msg);
 
 		dbus_message_iter_get_basic(&sub, &gain);
-		return hs_set_gain(conn, msg, data, gain,
+		return hs_set_gain(msg, data, gain,
 					HEADSET_GAIN_MICROPHONE);
 	}
 
@@ -2033,7 +2031,7 @@ static void path_unregister(void *data)
 
 void headset_unregister(struct audio_device *dev)
 {
-	g_dbus_unregister_interface(dev->conn, dev->path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
 		AUDIO_HEADSET_INTERFACE);
 }
 
@@ -2048,7 +2046,7 @@ struct headset *headset_init(struct audio_device *dev, GSList *uuids,
 
 	headset_update(dev, hs, uuids);
 
-	if (!g_dbus_register_interface(dev->conn, dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
 					AUDIO_HEADSET_INTERFACE,
 					headset_methods, headset_signals, NULL,
 					dev, path_unregister)) {
@@ -2346,7 +2344,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		emit_property_changed(dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
-		g_dbus_emit_signal(dev->conn, dev->path,
+		g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
 					AUDIO_HEADSET_INTERFACE,
 					"Disconnected",
 					DBUS_TYPE_INVALID);
@@ -2374,7 +2372,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 				slc->inband_ring = TRUE;
 			else
 				slc->inband_ring = FALSE;
-			g_dbus_emit_signal(dev->conn, dev->path,
+			g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
 						DBUS_TYPE_INVALID);
@@ -2387,7 +2385,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 			telephony_device_connected(dev);
 		} else if (hs->state == HEADSET_STATE_PLAYING) {
 			value = FALSE;
-			g_dbus_emit_signal(dev->conn, dev->path,
+			g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Stopped",
 						DBUS_TYPE_INVALID);
@@ -2411,7 +2409,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					G_IO_ERR | G_IO_NVAL,
 					(GIOFunc) sco_cb, dev);
 
-		g_dbus_emit_signal(dev->conn, dev->path,
+		g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
 					AUDIO_HEADSET_INTERFACE, "Playing",
 					DBUS_TYPE_INVALID);
 		emit_property_changed(dev->path,
@@ -2590,7 +2588,7 @@ void headset_shutdown(struct audio_device *dev)
 	struct pending_connect *p = dev->headset->pending;
 
 	if (p && p->msg)
-		error_connect_failed(dev->conn, p->msg, ECANCELED);
+		error_connect_failed(p->msg, ECANCELED);
 
 	pending_connect_finalize(dev);
 	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
diff --git a/audio/main.c b/audio/main.c
index a88f163..f7bb32a 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -142,20 +142,14 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-static DBusConnection *connection;
-
 static int audio_init(void)
 {
 	GKeyFile *config;
 	gboolean enable_sco;
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-
 	config = load_config_file(CONFIGDIR "/audio.conf");
 
-	if (audio_manager_init(connection, config, &enable_sco) < 0)
+	if (audio_manager_init(config, &enable_sco) < 0)
 		goto failed;
 
 	if (!enable_sco)
@@ -174,11 +168,6 @@ static int audio_init(void)
 failed:
 	audio_manager_exit();
 
-	if (connection) {
-		dbus_connection_unref(connection);
-		connection = NULL;
-	}
-
 	return -EIO;
 }
 
@@ -191,8 +180,6 @@ static void audio_exit(void)
 	}
 
 	audio_manager_exit();
-
-	dbus_connection_unref(connection);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(audio, VERSION,
diff --git a/audio/manager.c b/audio/manager.c
index 3b105ed..fbfe00f 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -85,7 +85,6 @@ struct audio_adapter {
 
 static gboolean auto_connect = TRUE;
 static int max_connected_headsets = 1;
-static DBusConnection *connection = NULL;
 static GKeyFile *config = NULL;
 static GSList *adapters = NULL;
 static GSList *devices = NULL;
@@ -964,7 +963,7 @@ static int a2dp_server_probe(struct btd_adapter *adapter)
 
 	adapter_get_address(adapter, &src);
 
-	err = a2dp_register(connection, &src, config);
+	err = a2dp_register(&src, config);
 	if (err < 0)
 		audio_adapter_unref(adp);
 
@@ -1003,7 +1002,7 @@ static int avrcp_server_probe(struct btd_adapter *adapter)
 
 	adapter_get_address(adapter, &src);
 
-	err = avrcp_register(connection, &src, config);
+	err = avrcp_register(&src, config);
 	if (err < 0)
 		audio_adapter_unref(adp);
 
@@ -1042,7 +1041,7 @@ static int media_server_probe(struct btd_adapter *adapter)
 
 	adapter_get_address(adapter, &src);
 
-	err = media_register(connection, path, &src);
+	err = media_register(path, &src);
 	if (err < 0)
 		audio_adapter_unref(adp);
 
@@ -1114,16 +1113,13 @@ static struct btd_adapter_driver media_driver = {
 	.remove	= media_server_remove,
 };
 
-int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
-							gboolean *enable_sco)
+int audio_manager_init(GKeyFile *conf, gboolean *enable_sco)
 {
 	char **list;
 	int i;
 	gboolean b;
 	GError *err = NULL;
 
-	connection = dbus_connection_ref(conn);
-
 	if (!conf)
 		goto proceed;
 
@@ -1206,13 +1202,6 @@ proceed:
 
 void audio_manager_exit(void)
 {
-	/* Bail out early if we haven't been initialized */
-	if (connection == NULL)
-		return;
-
-	dbus_connection_unref(connection);
-	connection = NULL;
-
 	if (config) {
 		g_key_file_free(config);
 		config = NULL;
@@ -1337,7 +1326,7 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 
 	path = device_get_path(device);
 
-	dev = audio_device_register(connection, device, path, src, dst);
+	dev = audio_device_register(device, path, src, dst);
 	if (!dev)
 		return NULL;
 
diff --git a/audio/manager.h b/audio/manager.h
index 300142d..08d814f 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -32,8 +32,7 @@ struct enabled_interfaces {
 	gboolean media_player;
 };
 
-int audio_manager_init(DBusConnection *conn, GKeyFile *config,
-							gboolean *enable_sco);
+int audio_manager_init(GKeyFile *config, gboolean *enable_sco);
 void audio_manager_exit(void);
 
 struct audio_device *manager_find_device(const char *path,
diff --git a/audio/media.c b/audio/media.c
index e4a7684..c88afc0 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -59,7 +59,6 @@
 struct media_adapter {
 	bdaddr_t		src;		/* Adapter address */
 	char			*path;		/* Adapter path */
-	DBusConnection		*conn;		/* Adapter connection */
 	GSList			*endpoints;	/* Endpoints list */
 	GSList			*players;	/* Players list */
 };
@@ -147,8 +146,6 @@ static void media_endpoint_cancel_all(struct media_endpoint *endpoint)
 
 static void media_endpoint_destroy(struct media_endpoint *endpoint)
 {
-	struct media_adapter *adapter = endpoint->adapter;
-
 	DBG("sender=%s path=%s", endpoint->sender, endpoint->path);
 
 	if (endpoint->hs_watch)
@@ -162,7 +159,7 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 	g_slist_free_full(endpoint->transports,
 				(GDestroyNotify) media_transport_destroy);
 
-	g_dbus_remove_watch(adapter->conn, endpoint->watch);
+	g_dbus_remove_watch(btd_get_dbus_connection(), endpoint->watch);
 	g_free(endpoint->capabilities);
 	g_free(endpoint->sender);
 	g_free(endpoint->path);
@@ -209,12 +206,9 @@ static void headset_setconf_cb(struct media_endpoint *endpoint, void *ret,
 static void clear_configuration(struct media_endpoint *endpoint,
 					struct media_transport *transport)
 {
-	DBusConnection *conn;
 	DBusMessage *msg;
 	const char *path;
 
-	conn = endpoint->adapter->conn;
-
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
 						MEDIA_ENDPOINT_INTERFACE,
 						"ClearConfiguration");
@@ -226,7 +220,7 @@ static void clear_configuration(struct media_endpoint *endpoint,
 	path = media_transport_get_path(transport);
 	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID);
-	g_dbus_send_message(conn, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 done:
 	endpoint->transports = g_slist_remove(endpoint->transports, transport);
 	media_transport_destroy(transport);
@@ -307,8 +301,7 @@ done:
 	endpoint_request_free(request);
 }
 
-static gboolean media_endpoint_async_call(DBusConnection *conn,
-					DBusMessage *msg,
+static gboolean media_endpoint_async_call(DBusMessage *msg,
 					struct media_endpoint *endpoint,
 					media_endpoint_cb_t cb,
 					void *user_data,
@@ -319,7 +312,8 @@ static gboolean media_endpoint_async_call(DBusConnection *conn,
 	request = g_new0(struct endpoint_request, 1);
 
 	/* Timeout should be less than avdtp request timeout (4 seconds) */
-	if (dbus_connection_send_with_reply(conn, msg, &request->call,
+	if (dbus_connection_send_with_reply(btd_get_dbus_connection(),
+						msg, &request->call,
 						REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		g_free(request);
@@ -351,11 +345,8 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
 						void *user_data,
 						GDestroyNotify destroy)
 {
-	DBusConnection *conn;
 	DBusMessage *msg;
 
-	conn = endpoint->adapter->conn;
-
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
 						MEDIA_ENDPOINT_INTERFACE,
 						"SelectConfiguration");
@@ -368,8 +359,7 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
 					&capabilities, length,
 					DBUS_TYPE_INVALID);
 
-	return media_endpoint_async_call(conn, msg, endpoint, cb, user_data,
-								destroy);
+	return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
 }
 
 static gint transport_device_cmp(gconstpointer data, gconstpointer user_data)
@@ -404,7 +394,6 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 					void *user_data,
 					GDestroyNotify destroy)
 {
-	DBusConnection *conn;
 	DBusMessage *msg;
 	const char *path;
 	DBusMessageIter iter;
@@ -415,9 +404,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	if (transport != NULL)
 		return FALSE;
 
-	conn = endpoint->adapter->conn;
-
-	transport = media_transport_create(conn, endpoint, device,
+	transport = media_transport_create(endpoint, device,
 						configuration, size);
 	if (transport == NULL)
 		return FALSE;
@@ -440,8 +427,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 
 	transport_get_properties(transport, &iter);
 
-	return media_endpoint_async_call(conn, msg, endpoint, cb, user_data,
-								destroy);
+	return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
 }
 
 static void release_endpoint(struct media_endpoint *endpoint)
@@ -464,7 +450,7 @@ static void release_endpoint(struct media_endpoint *endpoint)
 		return;
 	}
 
-	g_dbus_send_message(endpoint->adapter->conn, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 done:
 	media_endpoint_remove(endpoint);
@@ -787,9 +773,9 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 		return NULL;
 	}
 
-	endpoint->watch = g_dbus_add_disconnect_watch(adapter->conn, sender,
-						media_endpoint_exit, endpoint,
-						NULL);
+	endpoint->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
+						sender, media_endpoint_exit,
+						endpoint, NULL);
 
 	adapter->endpoints = g_slist_append(adapter->endpoints, endpoint);
 	info("Endpoint registered: sender=%s path=%s", sender, path);
@@ -975,11 +961,12 @@ static void release_player(struct media_player *mp)
 		return;
 	}
 
-	g_dbus_send_message(mp->adapter->conn, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 }
 
 static void media_player_free(gpointer data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct media_player *mp = data;
 	struct media_adapter *adapter = mp->adapter;
 
@@ -988,9 +975,9 @@ static void media_player_free(gpointer data)
 		release_player(mp);
 	}
 
-	g_dbus_remove_watch(adapter->conn, mp->watch);
-	g_dbus_remove_watch(adapter->conn, mp->property_watch);
-	g_dbus_remove_watch(adapter->conn, mp->track_watch);
+	g_dbus_remove_watch(conn, mp->watch);
+	g_dbus_remove_watch(conn, mp->property_watch);
+	g_dbus_remove_watch(conn, mp->track_watch);
 
 	if (mp->track)
 		g_hash_table_unref(mp->track);
@@ -1233,7 +1220,6 @@ static int get_setting(uint8_t attr, void *user_data)
 static int set_setting(uint8_t attr, uint8_t val, void *user_data)
 {
 	struct media_player *mp = user_data;
-	struct media_adapter *adapter = mp->adapter;
 	const char *property, *value;
 	guint attr_uint = attr;
 	DBusMessage *msg;
@@ -1267,7 +1253,7 @@ static int set_setting(uint8_t attr, uint8_t val, void *user_data)
 	dbus_message_iter_append_basic(&var, DBUS_TYPE_STRING, &value);
 	dbus_message_iter_close_container(&iter, &var);
 
-	g_dbus_send_message(adapter->conn, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -1678,6 +1664,7 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 						const char *path,
 						int *err)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct media_player *mp;
 
 	mp = g_new0(struct media_player, 1);
@@ -1686,15 +1673,15 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 	mp->path = g_strdup(path);
 	mp->timer = g_timer_new();
 
-	mp->watch = g_dbus_add_disconnect_watch(adapter->conn, sender,
+	mp->watch = g_dbus_add_disconnect_watch(conn, sender,
 						media_player_exit, mp,
 						NULL);
-	mp->property_watch = g_dbus_add_signal_watch(adapter->conn, sender,
+	mp->property_watch = g_dbus_add_signal_watch(conn, sender,
 						path, MEDIA_PLAYER_INTERFACE,
 						"PropertyChanged",
 						property_changed,
 						mp, NULL);
-	mp->track_watch = g_dbus_add_signal_watch(adapter->conn, sender,
+	mp->track_watch = g_dbus_add_signal_watch(conn, sender,
 						path, MEDIA_PLAYER_INTERFACE,
 						"TrackChanged",
 						track_changed,
@@ -1846,24 +1833,22 @@ static void path_free(void *data)
 	while (adapter->players)
 		media_player_destroy(adapter->players->data);
 
-	dbus_connection_unref(adapter->conn);
-
 	adapters = g_slist_remove(adapters, adapter);
 
 	g_free(adapter->path);
 	g_free(adapter);
 }
 
-int media_register(DBusConnection *conn, const char *path, const bdaddr_t *src)
+int media_register(const char *path, const bdaddr_t *src)
 {
 	struct media_adapter *adapter;
 
 	adapter = g_new0(struct media_adapter, 1);
-	adapter->conn = dbus_connection_ref(conn);
 	bacpy(&adapter->src, src);
 	adapter->path = g_strdup(path);
 
-	if (!g_dbus_register_interface(conn, path, MEDIA_INTERFACE,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					path, MEDIA_INTERFACE,
 					media_methods, NULL, NULL,
 					adapter, path_free)) {
 		error("D-Bus failed to register %s path", path);
@@ -1884,8 +1869,8 @@ void media_unregister(const char *path)
 		struct media_adapter *adapter = l->data;
 
 		if (g_strcmp0(path, adapter->path) == 0) {
-			g_dbus_unregister_interface(adapter->conn, path,
-							MEDIA_INTERFACE);
+			g_dbus_unregister_interface(btd_get_dbus_connection(),
+						path, MEDIA_INTERFACE);
 			return;
 		}
 	}
diff --git a/audio/media.h b/audio/media.h
index 84fc1bc..82b9694 100644
--- a/audio/media.h
+++ b/audio/media.h
@@ -27,7 +27,7 @@ struct media_endpoint;
 typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
 					void *ret, int size, void *user_data);
 
-int media_register(DBusConnection *conn, const char *path, const bdaddr_t *src);
+int media_register(const char *path, const bdaddr_t *src);
 void media_unregister(const char *path);
 
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
diff --git a/audio/sink.c b/audio/sink.c
index 6201d85..4eb2c61 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -52,7 +52,6 @@
 #define STREAM_SETUP_RETRY_TIMER 2
 
 struct pending_request {
-	DBusConnection *conn;
 	DBusMessage *msg;
 	unsigned int id;
 };
@@ -68,7 +67,6 @@ struct sink {
 	sink_state_t state;
 	struct pending_request *connect;
 	struct pending_request *disconnect;
-	DBusConnection *conn;
 };
 
 struct sink_state_callback {
@@ -144,7 +142,7 @@ static void avdtp_state_callback(struct audio_device *dev,
 	case AVDTP_SESSION_STATE_DISCONNECTED:
 		if (sink->state != SINK_STATE_CONNECTING) {
 			gboolean value = FALSE;
-			g_dbus_emit_signal(dev->conn, dev->path,
+			g_dbus_emit_signal(btd_get_dbus_connection(), dev->path,
 					AUDIO_SINK_INTERFACE, "Disconnected",
 					DBUS_TYPE_INVALID);
 			emit_property_changed(dev->path,
@@ -166,8 +164,6 @@ static void avdtp_state_callback(struct audio_device *dev,
 static void pending_request_free(struct audio_device *dev,
 					struct pending_request *pending)
 {
-	if (pending->conn)
-		dbus_connection_unref(pending->conn);
 	if (pending->msg)
 		dbus_message_unref(pending->msg);
 	if (pending->id)
@@ -182,6 +178,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 					struct avdtp_error *err,
 					void *user_data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct audio_device *dev = user_data;
 	struct sink *sink = dev->sink;
 	gboolean value;
@@ -199,7 +196,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 			sink->disconnect = NULL;
 
 			reply = dbus_message_new_method_return(p->msg);
-			g_dbus_send_message(p->conn, reply);
+			g_dbus_send_message(conn, reply);
 			pending_request_free(dev, p);
 		}
 
@@ -214,7 +211,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		if (old_state == AVDTP_STATE_CONFIGURED &&
 				sink->state == SINK_STATE_CONNECTING) {
 			value = TRUE;
-			g_dbus_emit_signal(dev->conn, dev->path,
+			g_dbus_emit_signal(conn, dev->path,
 						AUDIO_SINK_INTERFACE,
 						"Connected",
 						DBUS_TYPE_INVALID);
@@ -224,7 +221,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 						DBUS_TYPE_BOOLEAN, &value);
 		} else if (old_state == AVDTP_STATE_STREAMING) {
 			value = FALSE;
-			g_dbus_emit_signal(dev->conn, dev->path,
+			g_dbus_emit_signal(conn, dev->path,
 						AUDIO_SINK_INTERFACE,
 						"Stopped",
 						DBUS_TYPE_INVALID);
@@ -237,8 +234,9 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		break;
 	case AVDTP_STATE_STREAMING:
 		value = TRUE;
-		g_dbus_emit_signal(dev->conn, dev->path, AUDIO_SINK_INTERFACE,
-					"Playing", DBUS_TYPE_INVALID);
+		g_dbus_emit_signal(conn, dev->path,
+					AUDIO_SINK_INTERFACE, "Playing",
+					DBUS_TYPE_INVALID);
 		emit_property_changed(dev->path,
 					AUDIO_SINK_INTERFACE, "Playing",
 					DBUS_TYPE_BOOLEAN, &value);
@@ -254,11 +252,10 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	sink->stream_state = new_state;
 }
 
-static void error_failed(DBusConnection *conn, DBusMessage *msg,
-							const char *desc)
+static void error_failed(DBusMessage *msg, const char *desc)
 {
 	DBusMessage *reply = btd_error_failed(msg, desc);
-	g_dbus_send_message(conn, reply);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
 static gboolean stream_setup_retry(gpointer user_data)
@@ -273,12 +270,12 @@ static gboolean stream_setup_retry(gpointer user_data)
 		if (pending->msg) {
 			DBusMessage *reply;
 			reply = dbus_message_new_method_return(pending->msg);
-			g_dbus_send_message(pending->conn, reply);
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
 		}
 	} else {
 		DBG("Stream setup failed, after XCASE connect:connect");
 		if (pending->msg)
-			error_failed(pending->conn, pending->msg, "Stream setup failed");
+			error_failed(pending->msg, "Stream setup failed");
 	}
 
 	sink->connect = NULL;
@@ -304,7 +301,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 		if (pending->msg) {
 			DBusMessage *reply;
 			reply = dbus_message_new_method_return(pending->msg);
-			g_dbus_send_message(pending->conn, reply);
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
 		}
 
 		sink->connect = NULL;
@@ -323,7 +320,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 							sink);
 	} else {
 		if (pending->msg)
-			error_failed(pending->conn, pending->msg, "Stream setup failed");
+			error_failed(pending->msg, "Stream setup failed");
 		sink->connect = NULL;
 		pending_request_free(sink->dev, pending);
 		DBG("Stream setup failed : %s", avdtp_strerror(err));
@@ -349,7 +346,7 @@ static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 failed:
 	if (pending->msg)
-		error_failed(pending->conn, pending->msg, "Stream setup failed");
+		error_failed(pending->msg, "Stream setup failed");
 	pending_request_free(sink->dev, pending);
 	sink->connect = NULL;
 	avdtp_unref(sink->session);
@@ -398,7 +395,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 
 failed:
 	if (pending->msg)
-		error_failed(pending->conn, pending->msg, "Stream setup failed");
+		error_failed(pending->msg, "Stream setup failed");
 	pending_request_free(sink->dev, pending);
 	sink->connect = NULL;
 	avdtp_unref(sink->session);
@@ -450,7 +447,6 @@ static DBusMessage *sink_connect(DBusConnection *conn,
 
 	pending = sink->connect;
 
-	pending->conn = dbus_connection_ref(conn);
 	pending->msg = dbus_message_ref(msg);
 
 	DBG("stream creation in progress");
@@ -486,7 +482,6 @@ static DBusMessage *sink_disconnect(DBusConnection *conn,
 		return btd_error_failed(msg, strerror(-err));
 
 	pending = g_new0(struct pending_request, 1);
-	pending->conn = dbus_connection_ref(conn);
 	pending->msg = dbus_message_ref(msg);
 	sink->disconnect = pending;
 
@@ -588,7 +583,7 @@ static void path_unregister(void *data)
 
 void sink_unregister(struct audio_device *dev)
 {
-	g_dbus_unregister_interface(dev->conn, dev->path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
 		AUDIO_SINK_INTERFACE);
 }
 
@@ -596,7 +591,7 @@ struct sink *sink_init(struct audio_device *dev)
 {
 	struct sink *sink;
 
-	if (!g_dbus_register_interface(dev->conn, dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
 					AUDIO_SINK_INTERFACE,
 					sink_methods, sink_signals, NULL,
 					dev, path_unregister))
@@ -664,8 +659,7 @@ gboolean sink_shutdown(struct sink *sink)
 		struct pending_request *pending = sink->connect;
 
 		if (pending->msg)
-			error_failed(pending->conn, pending->msg,
-							"Stream setup failed");
+			error_failed(pending->msg, "Stream setup failed");
 		pending_request_free(sink->dev, pending);
 		sink->connect = NULL;
 
diff --git a/audio/source.c b/audio/source.c
index 8e01666..41aedd2 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -53,7 +53,6 @@
 #define STREAM_SETUP_RETRY_TIMER 2
 
 struct pending_request {
-	DBusConnection *conn;
 	DBusMessage *msg;
 	unsigned int id;
 };
@@ -69,7 +68,6 @@ struct source {
 	source_state_t state;
 	struct pending_request *connect;
 	struct pending_request *disconnect;
-	DBusConnection *conn;
 };
 
 struct source_state_callback {
@@ -148,8 +146,6 @@ static void avdtp_state_callback(struct audio_device *dev,
 static void pending_request_free(struct audio_device *dev,
 					struct pending_request *pending)
 {
-	if (pending->conn)
-		dbus_connection_unref(pending->conn);
 	if (pending->msg)
 		dbus_message_unref(pending->msg);
 	if (pending->id)
@@ -180,7 +176,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 			source->disconnect = NULL;
 
 			reply = dbus_message_new_method_return(p->msg);
-			g_dbus_send_message(p->conn, reply);
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
 			pending_request_free(dev, p);
 		}
 
@@ -207,11 +203,11 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	source->stream_state = new_state;
 }
 
-static void error_failed(DBusConnection *conn, DBusMessage *msg,
+static void error_failed(DBusMessage *msg,
 							const char *desc)
 {
 	DBusMessage *reply = btd_error_failed(msg, desc);
-	g_dbus_send_message(conn, reply);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
 static gboolean stream_setup_retry(gpointer user_data)
@@ -226,12 +222,12 @@ static gboolean stream_setup_retry(gpointer user_data)
 		if (pending->msg) {
 			DBusMessage *reply;
 			reply = dbus_message_new_method_return(pending->msg);
-			g_dbus_send_message(pending->conn, reply);
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
 		}
 	} else {
 		DBG("Stream setup failed, after XCASE connect:connect");
 		if (pending->msg)
-			error_failed(pending->conn, pending->msg, "Stream setup failed");
+			error_failed(pending->msg, "Stream setup failed");
 	}
 
 	source->connect = NULL;
@@ -257,7 +253,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 		if (pending->msg) {
 			DBusMessage *reply;
 			reply = dbus_message_new_method_return(pending->msg);
-			g_dbus_send_message(pending->conn, reply);
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
 		}
 
 		source->connect = NULL;
@@ -276,7 +272,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 							source);
 	} else {
 		if (pending->msg)
-			error_failed(pending->conn, pending->msg, "Stream setup failed");
+			error_failed(pending->msg, "Stream setup failed");
 		source->connect = NULL;
 		pending_request_free(source->dev, pending);
 		DBG("Stream setup failed : %s", avdtp_strerror(err));
@@ -306,7 +302,7 @@ static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 failed:
 	if (pending->msg)
-		error_failed(pending->conn, pending->msg, "Stream setup failed");
+		error_failed(pending->msg, "Stream setup failed");
 	pending_request_free(source->dev, pending);
 	source->connect = NULL;
 	avdtp_unref(source->session);
@@ -349,7 +345,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 
 failed:
 	if (pending->msg)
-		error_failed(pending->conn, pending->msg, "Stream setup failed");
+		error_failed(pending->msg, "Stream setup failed");
 	pending_request_free(source->dev, pending);
 	source->connect = NULL;
 	avdtp_unref(source->session);
@@ -401,7 +397,6 @@ static DBusMessage *source_connect(DBusConnection *conn,
 
 	pending = source->connect;
 
-	pending->conn = dbus_connection_ref(conn);
 	pending->msg = dbus_message_ref(msg);
 
 	DBG("stream creation in progress");
@@ -437,7 +432,6 @@ static DBusMessage *source_disconnect(DBusConnection *conn,
 		return btd_error_failed(msg, strerror(-err));
 
 	pending = g_new0(struct pending_request, 1);
-	pending->conn = dbus_connection_ref(conn);
 	pending->msg = dbus_message_ref(msg);
 	source->disconnect = pending;
 
@@ -526,7 +520,7 @@ static void path_unregister(void *data)
 
 void source_unregister(struct audio_device *dev)
 {
-	g_dbus_unregister_interface(dev->conn, dev->path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(), dev->path,
 						AUDIO_SOURCE_INTERFACE);
 }
 
@@ -534,7 +528,7 @@ struct source *source_init(struct audio_device *dev)
 {
 	struct source *source;
 
-	if (!g_dbus_register_interface(dev->conn, dev->path,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), dev->path,
 					AUDIO_SOURCE_INTERFACE,
 					source_methods, source_signals, NULL,
 					dev, path_unregister))
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 2f89139..d1bbfd5 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -33,6 +33,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
+#include "dbus-common.h"
 #include "log.h"
 #include "telephony.h"
 #include "error.h"
@@ -40,8 +41,6 @@
 #define TELEPHONY_DUMMY_IFACE "org.bluez.TelephonyTest"
 #define TELEPHONY_DUMMY_PATH "/org/bluez/test"
 
-static DBusConnection *connection = NULL;
-
 static const char *chld_str = "0,1,1x,2,2x,3,4";
 static char *subscriber_number = NULL;
 static char *active_call_number = NULL;
@@ -199,7 +198,7 @@ void telephony_voice_dial_req(void *telephony_device, gboolean enable)
 	DBG("telephony-dummy: got %s voice dial request",
 			enable ? "enable" : "disable");
 
-	g_dbus_emit_signal(connection, TELEPHONY_DUMMY_PATH,
+	g_dbus_emit_signal(btd_get_dbus_connection(), TELEPHONY_DUMMY_PATH,
 			TELEPHONY_DUMMY_IFACE, "VoiceDial",
 			DBUS_TYPE_INVALID);
 
@@ -417,9 +416,8 @@ int telephony_init(void)
 
 	DBG("");
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-
-	if (g_dbus_register_interface(connection, TELEPHONY_DUMMY_PATH,
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+					TELEPHONY_DUMMY_PATH,
 					TELEPHONY_DUMMY_IFACE,
 					dummy_methods, dummy_signals,
 					NULL, NULL, NULL) == FALSE) {
@@ -438,10 +436,9 @@ void telephony_exit(void)
 {
 	DBG("");
 
-	g_dbus_unregister_interface(connection, TELEPHONY_DUMMY_PATH,
-						TELEPHONY_DUMMY_IFACE);
-	dbus_connection_unref(connection);
-	connection = NULL;
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					TELEPHONY_DUMMY_PATH,
+					TELEPHONY_DUMMY_IFACE);
 
 	telephony_deinit();
 }
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 8a00296..deb64e4 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -36,6 +36,7 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
+#include "dbus-common.h"
 #include "log.h"
 #include "telephony.h"
 #include "error.h"
@@ -188,8 +189,6 @@ static struct {
 	.operator_name = NULL,
 };
 
-static DBusConnection *connection = NULL;
-
 static GSList *calls = NULL;
 
 /* Reference count for determining the call indicator status */
@@ -322,7 +321,7 @@ static int release_conference(void)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -340,7 +339,7 @@ static int release_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -358,7 +357,7 @@ static int answer_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -376,7 +375,7 @@ static int split_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -393,7 +392,7 @@ static int unhold_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -410,7 +409,7 @@ static int hold_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -427,7 +426,7 @@ static int swap_calls(void)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -444,7 +443,7 @@ static int create_conference(void)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -461,7 +460,7 @@ static int call_transfer(void)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -585,6 +584,7 @@ static int send_method_call(const char *dest, const char *path,
 				DBusPendingCallNotifyFunction cb,
 				void *user_data, int type, ...)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	DBusMessage *msg;
 	DBusPendingCall *call;
 	va_list args;
@@ -606,11 +606,11 @@ static int send_method_call(const char *dest, const char *path,
 	va_end(args);
 
 	if (!cb) {
-		g_dbus_send_message(connection, msg);
+		g_dbus_send_message(conn, msg);
 		return 0;
 	}
 
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+	if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
 		error("Sending %s failed", method);
 		dbus_message_unref(msg);
 		return -EIO;
@@ -1759,7 +1759,7 @@ static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
 			"path='%s',"
 			"interface='org.freedesktop.Hal.Device',"
 			"member='PropertyModified'", path);
-	dbus_bus_add_match(connection, match_string, NULL);
+	dbus_bus_add_match(btd_get_dbus_connection(), match_string, NULL);
 
 	hal_get_integer(path, "battery.charge_level.last_full", &battchg_last);
 	hal_get_integer(path, "battery.charge_level.current", &battchg_cur);
@@ -2031,6 +2031,7 @@ static DBusHandlerResult signal_filter(DBusConnection *conn,
 
 int telephony_init(void)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	const char *battery_cap = "battery";
 	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
 				AG_FEATURE_INBAND_RINGTONE |
@@ -2040,21 +2041,19 @@ int telephony_init(void)
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
 				AG_FEATURE_THREE_WAY_CALLING;
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-
-	if (!dbus_connection_add_filter(connection, signal_filter,
+	if (!dbus_connection_add_filter(conn, signal_filter,
 						NULL, NULL))
 		error("Can't add signal filter");
 
-	dbus_bus_add_match(connection,
+	dbus_bus_add_match(conn,
 			"type=signal,interface=" CSD_CALL_INTERFACE, NULL);
-	dbus_bus_add_match(connection,
+	dbus_bus_add_match(conn,
 			"type=signal,interface=" CSD_CALL_INSTANCE, NULL);
-	dbus_bus_add_match(connection,
+	dbus_bus_add_match(conn,
 			"type=signal,interface=" CSD_CALL_CONFERENCE, NULL);
-	dbus_bus_add_match(connection,
+	dbus_bus_add_match(conn,
 			"type=signal,interface=" NETWORK_INTERFACE, NULL);
-	dbus_bus_add_match(connection,
+	dbus_bus_add_match(conn,
 				"type=signal,interface=" SSC_DBUS_IFACE
 				",member=modem_state_changed_ind", NULL);
 
@@ -2066,7 +2065,7 @@ int telephony_init(void)
 	generate_flag_file(NONE_FLAG_FILE);
 	callerid = callerid_from_file();
 
-	if (!g_dbus_register_interface(connection, TELEPHONY_MAEMO_PATH,
+	if (!g_dbus_register_interface(conn, TELEPHONY_MAEMO_PATH,
 			TELEPHONY_MAEMO_INTERFACE, telephony_maemo_methods,
 			NULL, NULL, NULL, NULL)) {
 		error("telephony-maemo interface %s init failed on path %s",
@@ -2096,10 +2095,8 @@ void telephony_exit(void)
 	g_slist_free(calls);
 	calls = NULL;
 
-	dbus_connection_remove_filter(connection, signal_filter, NULL);
-
-	dbus_connection_unref(connection);
-	connection = NULL;
+	dbus_connection_remove_filter(btd_get_dbus_connection(),
+							signal_filter, NULL);
 
 	telephony_deinit();
 }
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 0727ffe..d000a2a 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -38,6 +38,7 @@
 
 #include <bluetooth/sdp.h>
 
+#include "dbus-common.h"
 #include "log.h"
 #include "telephony.h"
 #include "error.h"
@@ -163,8 +164,6 @@ struct pending_req {
 
 static int get_property(const char *iface, const char *prop);
 
-static DBusConnection *connection = NULL;
-
 static GSList *calls = NULL;
 static GSList *watches = NULL;
 static GSList *pending = NULL;
@@ -233,6 +232,7 @@ static int send_method_call(const char *dest, const char *path,
 				DBusPendingCallNotifyFunction cb,
 				void *user_data, int type, ...)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	DBusMessage *msg;
 	DBusPendingCall *call;
 	va_list args;
@@ -255,11 +255,11 @@ static int send_method_call(const char *dest, const char *path,
 	va_end(args);
 
 	if (!cb) {
-		g_dbus_send_message(connection, msg);
+		g_dbus_send_message(conn, msg);
 		return 0;
 	}
 
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+	if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
 		error("Sending %s failed", method);
 		dbus_message_unref(msg);
 		return -EIO;
@@ -351,7 +351,7 @@ static int release_conference(void)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -369,7 +369,7 @@ static int release_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -387,7 +387,7 @@ static int answer_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -460,7 +460,7 @@ static int split_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -477,7 +477,7 @@ static int unhold_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -494,7 +494,7 @@ static int hold_call(struct csd_call *call)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -511,7 +511,7 @@ static int swap_calls(void)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -528,7 +528,7 @@ static int create_conference(void)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -545,7 +545,7 @@ static int call_transfer(void)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 	return 0;
 }
@@ -2059,7 +2059,8 @@ static void add_watch(const char *sender, const char *path,
 {
 	guint watch;
 
-	watch = g_dbus_add_signal_watch(connection, sender, path, interface,
+	watch = g_dbus_add_signal_watch(btd_get_dbus_connection(),
+					sender, path, interface,
 					member, signal_filter, NULL, NULL);
 
 	watches = g_slist_prepend(watches, GUINT_TO_POINTER(watch));
@@ -2129,8 +2130,6 @@ int telephony_init(void)
 
 	DBG("");
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-
 	add_watch(NULL, NULL, CSD_CALL_INTERFACE, NULL);
 	add_watch(NULL, NULL, CSD_CALL_INSTANCE, NULL);
 	add_watch(NULL, NULL, CSD_CALL_CONFERENCE, NULL);
@@ -2168,7 +2167,7 @@ int telephony_init(void)
 
 static void remove_watch(gpointer data)
 {
-	g_dbus_remove_watch(connection, GPOINTER_TO_UINT(data));
+	g_dbus_remove_watch(btd_get_dbus_connection(), GPOINTER_TO_UINT(data));
 }
 
 void telephony_exit(void)
@@ -2193,8 +2192,5 @@ void telephony_exit(void)
 	g_slist_free_full(watches, remove_watch);
 	watches = NULL;
 
-	dbus_connection_unref(connection);
-	connection = NULL;
-
 	telephony_deinit();
 }
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 961fedd..f962c7e 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -37,6 +37,7 @@
 
 #include <bluetooth/sdp.h>
 
+#include "dbus-common.h"
 #include "log.h"
 #include "telephony.h"
 
@@ -55,7 +56,6 @@ struct voice_call {
 	guint watch;
 };
 
-static DBusConnection *connection = NULL;
 static char *modem_obj_path = NULL;
 static char *last_dialed_number = NULL;
 static GSList *calls = NULL;
@@ -207,6 +207,7 @@ static int send_method_call(const char *dest, const char *path,
                                 DBusPendingCallNotifyFunction cb,
                                 void *user_data, int type, ...)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	DBusMessage *msg;
 	DBusPendingCall *call;
 	va_list args;
@@ -228,11 +229,11 @@ static int send_method_call(const char *dest, const char *path,
 	va_end(args);
 
 	if (!cb) {
-		g_dbus_send_message(connection, msg);
+		g_dbus_send_message(conn, msg);
 		return 0;
 	}
 
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+	if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
 		error("Sending %s failed", method);
 		dbus_message_unref(msg);
 		return -EIO;
@@ -656,7 +657,7 @@ static void call_free(void *data)
 	if (vc->status == CALL_STATUS_INCOMING)
 		telephony_calling_stopped_ind();
 
-	g_dbus_remove_watch(connection, vc->watch);
+	g_dbus_remove_watch(btd_get_dbus_connection(), vc->watch);
 	g_free(vc->obj_path);
 	g_free(vc->number);
 	g_free(vc);
@@ -742,7 +743,8 @@ static struct voice_call *call_new(const char *path, DBusMessageIter *properties
 
 	vc = g_new0(struct voice_call, 1);
 	vc->obj_path = g_strdup(path);
-	vc->watch = g_dbus_add_signal_watch(connection, NULL, path,
+	vc->watch = g_dbus_add_signal_watch(btd_get_dbus_connection(),
+					NULL, path,
 					OFONO_VC_INTERFACE, "PropertyChanged",
 					handle_vc_property_changed, vc, NULL);
 
@@ -1470,7 +1472,8 @@ static void add_watch(const char *sender, const char *path,
 {
 	guint watch;
 
-	watch = g_dbus_add_signal_watch(connection, sender, path, interface,
+	watch = g_dbus_add_signal_watch(btd_get_dbus_connection(),
+					sender, path, interface,
 					member, function, NULL, NULL);
 
 	watches = g_slist_prepend(watches, GUINT_TO_POINTER(watch));
@@ -1557,8 +1560,6 @@ int telephony_init(void)
 	int ret;
 	guint watch;
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-
 	add_watch(OFONO_BUS_NAME, NULL, OFONO_MODEM_INTERFACE,
 			"PropertyChanged", handle_modem_property_changed);
 	add_watch(OFONO_BUS_NAME, NULL, OFONO_NETWORKREG_INTERFACE,
@@ -1572,7 +1573,8 @@ int telephony_init(void)
 	add_watch(OFONO_BUS_NAME, NULL, OFONO_VCMANAGER_INTERFACE,
 			"CallRemoved", handle_vcmanager_call_removed);
 
-	watch = g_dbus_add_service_watch(connection, OFONO_BUS_NAME,
+	watch = g_dbus_add_service_watch(btd_get_dbus_connection(),
+						OFONO_BUS_NAME,
 						handle_service_connect,
 						handle_service_disconnect,
 						NULL, NULL);
@@ -1601,7 +1603,7 @@ int telephony_init(void)
 
 static void remove_watch(gpointer data)
 {
-	g_dbus_remove_watch(connection, GPOINTER_TO_UINT(data));
+	g_dbus_remove_watch(btd_get_dbus_connection(), GPOINTER_TO_UINT(data));
 }
 
 static void pending_free(void *data)
@@ -1630,8 +1632,5 @@ void telephony_exit(void)
 	g_slist_free_full(pending, pending_free);
 	pending = NULL;
 
-	dbus_connection_unref(connection);
-	connection = NULL;
-
 	telephony_deinit();
 }
diff --git a/audio/transport.c b/audio/transport.c
index 6541fc1..aed9f9a 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -97,7 +97,6 @@ struct headset_transport {
 };
 
 struct media_transport {
-	DBusConnection		*conn;
 	char			*path;		/* Transport object path */
 	struct audio_device	*device;	/* Transport device */
 	struct media_endpoint	*endpoint;	/* Transport endpoint */
@@ -225,7 +224,7 @@ void media_transport_destroy(struct media_transport *transport)
 		source_remove_state_cb(transport->source_watch);
 
 	path = g_strdup(transport->path);
-	g_dbus_unregister_interface(transport->conn, path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 						MEDIA_TRANSPORT_INTERFACE);
 
 	g_free(path);
@@ -245,8 +244,7 @@ static struct media_request *media_request_create(DBusMessage *msg, guint id)
 	return req;
 }
 
-static void media_request_reply(struct media_request *req,
-						DBusConnection *conn, int err)
+static void media_request_reply(struct media_request *req, int err)
 {
 	DBusMessage *reply;
 
@@ -260,7 +258,7 @@ static void media_request_reply(struct media_request *req,
 						ERROR_INTERFACE ".Failed",
 						"%s", strerror(err));
 
-	g_dbus_send_message(conn, reply);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
 static gboolean media_transport_release(struct media_transport *transport,
@@ -317,12 +315,12 @@ static void media_transport_remove(struct media_transport *transport,
 
 	/* Reply if owner has a pending request */
 	if (owner->pending)
-		media_request_reply(owner->pending, transport->conn, EIO);
+		media_request_reply(owner->pending, EIO);
 
 	transport->owners = g_slist_remove(transport->owners, owner);
 
 	if (owner->watch)
-		g_dbus_remove_watch(transport->conn, owner->watch);
+		g_dbus_remove_watch(btd_get_dbus_connection(), owner->watch);
 
 	media_owner_free(owner);
 
@@ -379,7 +377,7 @@ static void a2dp_resume_complete(struct avdtp *session,
 	if ((owner->lock & TRANSPORT_LOCK_WRITE) == 0)
 		omtu = 0;
 
-	ret = g_dbus_send_reply(transport->conn, req->msg,
+	ret = g_dbus_send_reply(btd_get_dbus_connection(), req->msg,
 						DBUS_TYPE_UNIX_FD, &fd,
 						DBUS_TYPE_UINT16, &imtu,
 						DBUS_TYPE_UINT16, &omtu,
@@ -435,7 +433,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 	/* Release always succeeds */
 	if (owner->pending) {
 		owner->pending->id = 0;
-		media_request_reply(owner->pending, transport->conn, 0);
+		media_request_reply(owner->pending, 0);
 		media_owner_remove(owner);
 	}
 
@@ -499,7 +497,7 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 	if ((owner->lock & TRANSPORT_LOCK_WRITE) == 0)
 		omtu = 0;
 
-	ret = g_dbus_send_reply(transport->conn, req->msg,
+	ret = g_dbus_send_reply(btd_get_dbus_connection(), req->msg,
 						DBUS_TYPE_UNIX_FD, &fd,
 						DBUS_TYPE_UINT16, &imtu,
 						DBUS_TYPE_UINT16, &omtu,
@@ -545,7 +543,7 @@ static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 	/* Release always succeeds */
 	if (owner->pending) {
 		owner->pending->id = 0;
-		media_request_reply(owner->pending, transport->conn, 0);
+		media_request_reply(owner->pending, 0);
 		media_owner_remove(owner);
 	}
 
@@ -615,7 +613,7 @@ static void gateway_resume_complete(struct audio_device *dev, GError *err,
 	if ((owner->lock & TRANSPORT_LOCK_WRITE) == 0)
 		omtu = 0;
 
-	ret = g_dbus_send_reply(transport->conn, req->msg,
+	ret = g_dbus_send_reply(btd_get_dbus_connection(), req->msg,
 						DBUS_TYPE_UNIX_FD, &fd,
 						DBUS_TYPE_UINT16, &imtu,
 						DBUS_TYPE_UINT16, &omtu,
@@ -662,7 +660,7 @@ static gboolean gateway_suspend_complete(gpointer user_data)
 	/* Release always succeeds */
 	if (owner->pending) {
 		owner->pending->id = 0;
-		media_request_reply(owner->pending, transport->conn, 0);
+		media_request_reply(owner->pending, 0);
 		media_owner_remove(owner);
 	}
 
@@ -736,13 +734,13 @@ static void media_transport_add(struct media_transport *transport,
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 	transport->owners = g_slist_append(transport->owners, owner);
 	owner->transport = transport;
-	owner->watch = g_dbus_add_disconnect_watch(transport->conn, owner->name,
+	owner->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
+							owner->name,
 							media_owner_exit,
 							owner, NULL);
 }
 
-static struct media_owner *media_owner_create(DBusConnection *conn,
-						DBusMessage *msg,
+static struct media_owner *media_owner_create(DBusMessage *msg,
 						transport_lock_t lock)
 {
 	struct media_owner *owner;
@@ -814,7 +812,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	if (media_transport_acquire(transport, lock) == FALSE)
 		return btd_error_not_authorized(msg);
 
-	owner = media_owner_create(conn, msg, lock);
+	owner = media_owner_create(msg, lock);
 	id = transport->resume(transport, owner);
 	if (id == 0) {
 		media_transport_release(transport, lock);
@@ -1153,9 +1151,6 @@ static void media_transport_free(void *data)
 	if (transport->destroy != NULL)
 		transport->destroy(transport->data);
 
-	if (transport->conn)
-		dbus_connection_unref(transport->conn);
-
 	g_free(transport->configuration);
 	g_free(transport->path);
 	g_free(transport);
@@ -1259,8 +1254,7 @@ static void source_state_changed(struct audio_device *dev,
 		transport_update_playing(transport, FALSE);
 }
 
-struct media_transport *media_transport_create(DBusConnection *conn,
-						struct media_endpoint *endpoint,
+struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 						struct audio_device *device,
 						uint8_t *configuration,
 						size_t size)
@@ -1270,7 +1264,6 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 	static int fd = 0;
 
 	transport = g_new0(struct media_transport, 1);
-	transport->conn = dbus_connection_ref(conn);
 	transport->device = device;
 	transport->endpoint = endpoint;
 	transport->configuration = g_new(uint8_t, size);
@@ -1336,8 +1329,8 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 	} else
 		goto fail;
 
-	if (g_dbus_register_interface(transport->conn, transport->path,
-				MEDIA_TRANSPORT_INTERFACE,
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+				transport->path, MEDIA_TRANSPORT_INTERFACE,
 				transport_methods, transport_signals, NULL,
 				transport, media_transport_free) == FALSE) {
 		error("Could not register transport %s", transport->path);
diff --git a/audio/transport.h b/audio/transport.h
index d20c327..a6b71e5 100644
--- a/audio/transport.h
+++ b/audio/transport.h
@@ -24,8 +24,7 @@
 
 struct media_transport;
 
-struct media_transport *media_transport_create(DBusConnection *conn,
-						struct media_endpoint *endpoint,
+struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 						struct audio_device *device,
 						uint8_t *configuration,
 						size_t size);
-- 
1.7.11.3

