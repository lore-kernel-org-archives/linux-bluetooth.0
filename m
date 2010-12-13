Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] audio: use btd_error_failed()
Date: Mon, 13 Dec 2010 19:33:05 -0200
Message-Id: <1292275987-13799-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-8-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-4-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-5-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-6-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-7-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-8-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c   |    6 ++----
 audio/device.c    |   14 +++++---------
 audio/gateway.c   |   11 +++++------
 audio/headset.c   |   18 +++++-------------
 audio/sink.c      |    9 +++------
 audio/source.c    |    9 +++------
 audio/transport.c |    7 +------
 7 files changed, 24 insertions(+), 50 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 98b6682..75c0b51 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -1021,8 +1021,7 @@ static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
 
 	err = avctp_send_passthrough(control, VOL_UP_OP);
 	if (err < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 
 	return dbus_message_new_method_return(msg);
 }
@@ -1047,8 +1046,7 @@ static DBusMessage *volume_down(DBusConnection *conn, DBusMessage *msg,
 
 	err = avctp_send_passthrough(control, VOL_DOWN_OP);
 	if (err < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 
 	return dbus_message_new_method_return(msg);
 }
diff --git a/audio/device.c b/audio/device.c
index fe7aed4..e38e598 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -271,10 +271,9 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 		if (new_state == AUDIO_STATE_CONNECTED)
 			reply = dbus_message_new_method_return(priv->conn_req);
 		else
-			reply = g_dbus_create_error(priv->conn_req,
-							ERROR_INTERFACE
-							".ConnectFailed",
-							"Connecting failed");
+			reply = btd_error_failed(priv->conn_req,
+							"Connect Failed");
+
 		dbus_message_unref(priv->conn_req);
 		priv->conn_req = NULL;
 		g_dbus_send_message(dev->conn, reply);
@@ -532,8 +531,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 		struct avdtp *session = avdtp_get(&dev->src, &dev->dst);
 
 		if (!session)
-			return g_dbus_create_error(msg, ERROR_INTERFACE
-					".Failed",
+			return btd_error_failed(msg,
 					"Failed to get AVDTP session");
 
 		sink_setup_stream(dev->sink, session);
@@ -543,9 +541,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	/* The previous calls should cause a call to the state callback to
 	 * indicate AUDIO_STATE_CONNECTING */
 	if (priv->state != AUDIO_STATE_CONNECTING)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-				".ConnectFailed",
-				"Headset connect failed");
+		return btd_error_failed(msg, "Connect Failed");
 
 	priv->conn_req = dbus_message_ref(msg);
 
diff --git a/audio/gateway.c b/audio/gateway.c
index 05b9ff7..4d38be7 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -247,8 +247,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 	if (ret)
 		reply = dbus_message_new_method_return(gw->msg);
 	else
-		reply = g_dbus_create_error(gw->msg, ERROR_INTERFACE ".Failed",
-					"Can not pass file descriptor");
+		reply = btd_error_failed(gw->msg, "Can't pass file descriptor");
 
 	g_dbus_send_message(dev->conn, reply);
 
@@ -365,15 +364,15 @@ static DBusMessage *ag_connect(DBusConnection *conn, DBusMessage *msg,
 {
 	struct audio_device *au_dev = (struct audio_device *) data;
 	struct gateway *gw = au_dev->gateway;
+	int err;
 
 	if (!gw->agent)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
 				".Failed", "Agent not assigned");
 
-	if (get_records(au_dev) < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".ConnectAttemptFailed",
-					"Connect Attempt Failed");
+	err = get_records(au_dev);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
 
 	gw->msg = dbus_message_ref(msg);
 
diff --git a/audio/headset.c b/audio/headset.c
index 18fd866..34b2b89 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1709,13 +1709,8 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	device->auto_connect = FALSE;
 
 	err = rfcomm_connect(device, NULL, NULL, NULL);
-	if (err == -ECONNREFUSED)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAllowed",
-						"Too many connected devices");
-	else if (err < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".ConnectAttemptFailed",
-						"Connect Attempt Failed");
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
 
 	hs->auto_dc = FALSE;
 
@@ -1747,8 +1742,7 @@ static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
 	err = headset_send(hs, "\r\nRING\r\n");
 	if (err < 0) {
 		dbus_message_unref(reply);
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 	}
 
 	ring_timer_cb(NULL);
@@ -1815,8 +1809,7 @@ static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
 
 	err = sco_connect(device, NULL, NULL, NULL);
 	if (err < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 
 	hs->pending->msg = dbus_message_ref(msg);
 
@@ -1900,8 +1893,7 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 		err = headset_send(hs, "\r\n+VG%c=%u\r\n", type, gain);
 		if (err < 0) {
 			dbus_message_unref(reply);
-			return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(-err));
+			return btd_error_failed(msg, strerror(-err));
 		}
 	}
 
diff --git a/audio/sink.c b/audio/sink.c
index 176a4ed..5746c55 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -435,8 +435,7 @@ static DBusMessage *sink_connect(DBusConnection *conn,
 		sink->session = avdtp_get(&dev->src, &dev->dst);
 
 	if (!sink->session)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"Unable to get a session");
+		return btd_error_failed(msg, "Unable to get a session");
 
 	if (sink->connect || sink->disconnect)
 		return btd_error_busy(msg);
@@ -445,8 +444,7 @@ static DBusMessage *sink_connect(DBusConnection *conn,
 		return btd_error_already_connected(msg);
 
 	if (!sink_setup_stream(sink, NULL))
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"Failed to create a stream");
+		return btd_error_failed(msg, "Failed to create a stream");
 
 	dev->auto_connect = FALSE;
 
@@ -485,8 +483,7 @@ static DBusMessage *sink_disconnect(DBusConnection *conn,
 
 	err = avdtp_close(sink->session, sink->stream, FALSE);
 	if (err < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 
 	pending = g_new0(struct pending_request, 1);
 	pending->conn = dbus_connection_ref(conn);
diff --git a/audio/source.c b/audio/source.c
index c106eaa..29ceb0f 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -386,8 +386,7 @@ static DBusMessage *source_connect(DBusConnection *conn,
 		source->session = avdtp_get(&dev->src, &dev->dst);
 
 	if (!source->session)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"Unable to get a session");
+		return btd_error_failed(msg, "Unable to get a session");
 
 	if (source->connect || source->disconnect)
 		return btd_error_busy(msg);
@@ -396,8 +395,7 @@ static DBusMessage *source_connect(DBusConnection *conn,
 		return btd_error_already_connected(msg);
 
 	if (!source_setup_stream(source, NULL))
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"Failed to create a stream");
+		return btd_error_failed(msg, "Failed to create a stream");
 
 	dev->auto_connect = FALSE;
 
@@ -436,8 +434,7 @@ static DBusMessage *source_disconnect(DBusConnection *conn,
 
 	err = avdtp_close(source->session, source->stream, FALSE);
 	if (err < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 
 	pending = g_new0(struct pending_request, 1);
 	pending->conn = dbus_connection_ref(conn);
diff --git a/audio/transport.c b/audio/transport.c
index e2ee400..bdec157 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -93,11 +93,6 @@ struct media_transport {
 					DBusMessageIter *value);
 };
 
-static inline DBusMessage *error_failed(DBusMessage *msg, const char *desc)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "%s", desc);
-}
-
 void media_transport_remove(struct media_transport *transport)
 {
 	char *path;
@@ -572,7 +567,7 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	if (err < 0) {
 		if (err == -EINVAL)
 			return btd_error_invalid_args(msg);
-		return error_failed(msg, strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 	}
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-- 
1.7.3.2

