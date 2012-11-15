Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 5/8] sink: Expose internal connection API
Date: Thu, 15 Nov 2012 08:27:37 +0100
Message-Id: <1352964460-8531-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Separate the D-Bus code from the internal connection handling code,
exposing an internal API in case some internal codepath/plugin is
interested in using it.
---
 profiles/audio/device.c |   4 +-
 profiles/audio/sink.c   | 159 ++++++++++++++++++++++++------------------------
 profiles/audio/sink.h   |   4 +-
 3 files changed, 86 insertions(+), 81 deletions(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 09a1ed7..56239a4 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -203,7 +203,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 		avrcp_disconnect(dev);
 
 	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
-		sink_disconnect(dev, TRUE);
+		sink_disconnect(dev, TRUE, NULL, NULL);
 	else
 		priv->disconnecting = FALSE;
 }
@@ -390,7 +390,7 @@ static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
-		sink_disconnect(dev, TRUE);
+		sink_disconnect(dev, TRUE, NULL, NULL);
 	else {
 		dbus_message_unref(priv->dc_req);
 		priv->dc_req = NULL;
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 7a08960..c3278cb 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -52,7 +52,8 @@
 #define STREAM_SETUP_RETRY_TIMER 2
 
 struct pending_request {
-	DBusMessage *msg;
+	audio_device_cb cb;
+	void *cb_data;
 	unsigned int id;
 };
 
@@ -161,10 +162,12 @@ static void avdtp_state_callback(struct audio_device *dev,
 }
 
 static void pending_request_free(struct audio_device *dev,
-					struct pending_request *pending)
+					struct pending_request *pending,
+					int err)
 {
-	if (pending->msg)
-		dbus_message_unref(pending->msg);
+	if (pending->cb)
+		pending->cb(dev, err, pending->cb_data);
+
 	if (pending->id)
 		a2dp_cancel(dev, pending->id);
 
@@ -177,7 +180,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 					struct avdtp_error *err,
 					void *user_data)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	struct audio_device *dev = user_data;
 	struct sink *sink = dev->sink;
 
@@ -187,15 +189,12 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	switch (new_state) {
 	case AVDTP_STATE_IDLE:
 		if (sink->disconnect) {
-			DBusMessage *reply;
 			struct pending_request *p;
 
 			p = sink->disconnect;
 			sink->disconnect = NULL;
 
-			reply = dbus_message_new_method_return(p->msg);
-			g_dbus_send_message(conn, reply);
-			pending_request_free(dev, p);
+			pending_request_free(dev, p, 0);
 		}
 
 		if (sink->session) {
@@ -221,34 +220,24 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	sink->stream_state = new_state;
 }
 
-static void error_failed(DBusMessage *msg, const char *desc)
-{
-	DBusMessage *reply = btd_error_failed(msg, desc);
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
-}
-
 static gboolean stream_setup_retry(gpointer user_data)
 {
 	struct sink *sink = user_data;
 	struct pending_request *pending = sink->connect;
+	int err;
 
 	sink->retry_id = 0;
 
 	if (sink->stream_state >= AVDTP_STATE_OPEN) {
 		DBG("Stream successfully created, after XCASE connect:connect");
-		if (pending->msg) {
-			DBusMessage *reply;
-			reply = dbus_message_new_method_return(pending->msg);
-			g_dbus_send_message(btd_get_dbus_connection(), reply);
-		}
+		err = 0;
 	} else {
 		DBG("Stream setup failed, after XCASE connect:connect");
-		if (pending->msg)
-			error_failed(pending->msg, "Stream setup failed");
+		err = -EIO;
 	}
 
 	sink->connect = NULL;
-	pending_request_free(sink->dev, pending);
+	pending_request_free(sink->dev, pending, err);
 
 	return FALSE;
 }
@@ -267,14 +256,8 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	if (stream) {
 		DBG("Stream successfully created");
 
-		if (pending->msg) {
-			DBusMessage *reply;
-			reply = dbus_message_new_method_return(pending->msg);
-			g_dbus_send_message(btd_get_dbus_connection(), reply);
-		}
-
 		sink->connect = NULL;
-		pending_request_free(sink->dev, pending);
+		pending_request_free(sink->dev, pending, 0);
 
 		return;
 	}
@@ -288,11 +271,8 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 							stream_setup_retry,
 							sink);
 	} else {
-		if (pending->msg)
-			error_failed(pending->msg, "Stream setup failed");
 		sink->connect = NULL;
-		pending_request_free(sink->dev, pending);
-		DBG("Stream setup failed : %s", avdtp_strerror(err));
+		pending_request_free(sink->dev, pending, -EIO);
 	}
 }
 
@@ -314,9 +294,7 @@ static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
 	return;
 
 failed:
-	if (pending->msg)
-		error_failed(pending->msg, "Stream setup failed");
-	pending_request_free(sink->dev, pending);
+	pending_request_free(sink->dev, pending, -EIO);
 	sink->connect = NULL;
 	avdtp_unref(sink->session);
 	sink->session = NULL;
@@ -363,9 +341,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	return;
 
 failed:
-	if (pending->msg)
-		error_failed(pending->msg, "Stream setup failed");
-	pending_request_free(sink->dev, pending);
+	pending_request_free(sink->dev, pending, -EIO);
 	sink->connect = NULL;
 	avdtp_unref(sink->session);
 	sink->session = NULL;
@@ -390,69 +366,85 @@ gboolean sink_setup_stream(struct sink *sink, struct avdtp *session)
 	return TRUE;
 }
 
+static void generic_cb(struct audio_device *dev, int err, void *data)
+{
+	DBusMessage *msg = data;
+	DBusMessage *reply;
+
+	if (err < 0) {
+		reply = btd_error_failed(msg, strerror(-err));
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+		dbus_message_unref(msg);
+		return;
+	}
+
+	g_dbus_send_reply(btd_get_dbus_connection(), msg, DBUS_TYPE_INVALID);
+
+	dbus_message_unref(msg);
+}
+
 static DBusMessage *connect_sink(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
 	struct audio_device *dev = data;
+	int err;
+
+	err = sink_connect(dev, generic_cb, msg);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	dbus_message_ref(msg);
+
+	return NULL;
+}
+
+int sink_connect(struct audio_device *dev, audio_device_cb cb, void *data)
+{
 	struct sink *sink = dev->sink;
 	struct pending_request *pending;
 
 	if (!sink->session)
 		sink->session = avdtp_get(&dev->src, &dev->dst);
 
-	if (!sink->session)
-		return btd_error_failed(msg, "Unable to get a session");
+	if (!sink->session) {
+		DBG("Unable to get a session");
+		return -EIO;
+	}
 
 	if (sink->connect || sink->disconnect)
-		return btd_error_busy(msg);
+		return -EBUSY;
 
 	if (sink->stream_state >= AVDTP_STATE_OPEN)
-		return btd_error_already_connected(msg);
+		return -EALREADY;
 
-	if (!sink_setup_stream(sink, NULL))
-		return btd_error_failed(msg, "Failed to create a stream");
+	if (!sink_setup_stream(sink, NULL)) {
+		DBG("Failed to create a stream");
+		return -EIO;
+	}
 
 	dev->auto_connect = FALSE;
 
 	pending = sink->connect;
 
-	pending->msg = dbus_message_ref(msg);
+	pending->cb = cb;
+	pending->cb_data = data;
 
 	DBG("stream creation in progress");
 
-	return NULL;
+	return 0;
 }
 
 static DBusMessage *disconnect_sink(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	struct audio_device *device = data;
-	struct sink *sink = device->sink;
-	struct pending_request *pending;
+	struct audio_device *dev = data;
 	int err;
 
-	if (!sink->session)
-		return btd_error_not_connected(msg);
-
-	if (sink->connect || sink->disconnect)
-		return btd_error_busy(msg);
-
-	if (sink->stream_state < AVDTP_STATE_OPEN) {
-		DBusMessage *reply = dbus_message_new_method_return(msg);
-		if (!reply)
-			return NULL;
-		avdtp_unref(sink->session);
-		sink->session = NULL;
-		return reply;
-	}
-
-	err = avdtp_close(sink->session, sink->stream, FALSE);
+	err = sink_disconnect(dev, FALSE, generic_cb, msg);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
-	pending = g_new0(struct pending_request, 1);
-	pending->msg = dbus_message_ref(msg);
-	sink->disconnect = pending;
+	dbus_message_ref(msg);
 
 	return NULL;
 }
@@ -515,10 +507,10 @@ static void sink_free(struct audio_device *dev)
 		avdtp_unref(sink->session);
 
 	if (sink->connect)
-		pending_request_free(dev, sink->connect);
+		pending_request_free(dev, sink->connect, -ECANCELED);
 
 	if (sink->disconnect)
-		pending_request_free(dev, sink->disconnect);
+		pending_request_free(dev, sink->disconnect, -ECANCELED);
 
 	if (sink->retry_id)
 		g_source_remove(sink->retry_id);
@@ -604,9 +596,13 @@ gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 	return TRUE;
 }
 
-int sink_disconnect(struct audio_device *dev, gboolean shutdown)
+int sink_disconnect(struct audio_device *dev, gboolean shutdown,
+						audio_device_cb cb, void *data)
 {
-	struct sink *sink = dev->sink;
+	struct audio_device *device = data;
+	struct sink *sink = device->sink;
+	struct pending_request *pending;
+	int err;
 
 	if (!sink->session)
 		return -ENOTCONN;
@@ -618,9 +614,7 @@ int sink_disconnect(struct audio_device *dev, gboolean shutdown)
 	if (sink->connect) {
 		struct pending_request *pending = sink->connect;
 
-		if (pending->msg)
-			error_failed(pending->msg, "Stream setup failed");
-		pending_request_free(sink->dev, pending);
+		pending_request_free(sink->dev, pending, -ECANCELED);
 		sink->connect = NULL;
 
 		avdtp_unref(sink->session);
@@ -636,7 +630,16 @@ int sink_disconnect(struct audio_device *dev, gboolean shutdown)
 	if (!sink->stream)
 		return -ENOTCONN;
 
-	return avdtp_close(sink->session, sink->stream, FALSE);
+	err = avdtp_close(sink->session, sink->stream, FALSE);
+	if (err < 0)
+		return err;
+
+	pending = g_new0(struct pending_request, 1);
+	pending->cb = cb;
+	pending->cb_data = data;
+	sink->disconnect = pending;
+
+	return 0;
 }
 
 unsigned int sink_add_state_cb(sink_state_cb cb, void *user_data)
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index 426d83f..38098f2 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -43,7 +43,9 @@ struct sink *sink_init(struct audio_device *dev);
 void sink_unregister(struct audio_device *dev);
 gboolean sink_is_active(struct audio_device *dev);
 sink_state_t sink_get_state(struct audio_device *dev);
+int sink_connect(struct audio_device *dev, audio_device_cb cb, void *data);
 gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean sink_setup_stream(struct sink *sink, struct avdtp *session);
-int sink_disconnect(struct audio_device *dev, gboolean shutdown);
+int sink_disconnect(struct audio_device *dev, gboolean shutdown,
+						audio_device_cb cb, void *data);
-- 
1.7.11.7

