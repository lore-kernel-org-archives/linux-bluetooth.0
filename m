Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 4/8] source: Expose internal connection API
Date: Thu, 15 Nov 2012 08:27:36 +0100
Message-Id: <1352964460-8531-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Separate the D-Bus code from the internal connection handling code,
exposing an internal API in case some internal codepath/plugin is
interested in using it.
---
 profiles/audio/device.h |   3 +
 profiles/audio/source.c | 160 ++++++++++++++++++++++++------------------------
 profiles/audio/source.h |   4 +-
 3 files changed, 87 insertions(+), 80 deletions(-)

diff --git a/profiles/audio/device.h b/profiles/audio/device.h
index f0d178d..0801cda 100644
--- a/profiles/audio/device.h
+++ b/profiles/audio/device.h
@@ -22,6 +22,7 @@
  *
  */
 
+struct audio_device;
 struct source;
 struct control;
 struct target;
@@ -30,6 +31,8 @@ struct headset;
 struct gateway;
 struct dev_priv;
 
+typedef void (*audio_device_cb) (struct audio_device *dev, int err, void *data);
+
 struct audio_device {
 	struct btd_device *btd_dev;
 
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 9981d79..163f5b9 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -53,7 +53,8 @@
 #define STREAM_SETUP_RETRY_TIMER 2
 
 struct pending_request {
-	DBusMessage *msg;
+	audio_device_cb cb;
+	void *cb_data;
 	unsigned int id;
 };
 
@@ -152,10 +153,12 @@ static void avdtp_state_callback(struct audio_device *dev,
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
 
@@ -177,15 +180,12 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	switch (new_state) {
 	case AVDTP_STATE_IDLE:
 		if (source->disconnect) {
-			DBusMessage *reply;
 			struct pending_request *p;
 
 			p = source->disconnect;
 			source->disconnect = NULL;
 
-			reply = dbus_message_new_method_return(p->msg);
-			g_dbus_send_message(btd_get_dbus_connection(), reply);
-			pending_request_free(dev, p);
+			pending_request_free(dev, p, 0);
 		}
 
 		if (source->session) {
@@ -211,35 +211,24 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	source->stream_state = new_state;
 }
 
-static void error_failed(DBusMessage *msg,
-							const char *desc)
-{
-	DBusMessage *reply = btd_error_failed(msg, desc);
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
-}
-
 static gboolean stream_setup_retry(gpointer user_data)
 {
 	struct source *source = user_data;
 	struct pending_request *pending = source->connect;
+	int err;
 
 	source->retry_id = 0;
 
 	if (source->stream_state >= AVDTP_STATE_OPEN) {
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
 
 	source->connect = NULL;
-	pending_request_free(source->dev, pending);
+	pending_request_free(source->dev, pending, err);
 
 	return FALSE;
 }
@@ -258,14 +247,8 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	if (stream) {
 		DBG("Stream successfully created");
 
-		if (pending->msg) {
-			DBusMessage *reply;
-			reply = dbus_message_new_method_return(pending->msg);
-			g_dbus_send_message(btd_get_dbus_connection(), reply);
-		}
-
 		source->connect = NULL;
-		pending_request_free(source->dev, pending);
+		pending_request_free(source->dev, pending, 0);
 
 		return;
 	}
@@ -279,10 +262,8 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 							stream_setup_retry,
 							source);
 	} else {
-		if (pending->msg)
-			error_failed(pending->msg, "Stream setup failed");
 		source->connect = NULL;
-		pending_request_free(source->dev, pending);
+		pending_request_free(source->dev, pending, -EIO);
 		DBG("Stream setup failed : %s", avdtp_strerror(err));
 	}
 }
@@ -309,9 +290,7 @@ static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
 	return;
 
 failed:
-	if (pending->msg)
-		error_failed(pending->msg, "Stream setup failed");
-	pending_request_free(source->dev, pending);
+	pending_request_free(source->dev, pending, -EIO);
 	source->connect = NULL;
 	avdtp_unref(source->session);
 	source->session = NULL;
@@ -352,9 +331,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	return;
 
 failed:
-	if (pending->msg)
-		error_failed(pending->msg, "Stream setup failed");
-	pending_request_free(source->dev, pending);
+	pending_request_free(source->dev, pending, -EIO);
 	source->connect = NULL;
 	avdtp_unref(source->session);
 	source->session = NULL;
@@ -379,69 +356,84 @@ gboolean source_setup_stream(struct source *source, struct avdtp *session)
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
 static DBusMessage *connect_source(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
 	struct audio_device *dev = data;
+	int err;
+
+	err = source_connect(dev, generic_cb, msg);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	dbus_message_ref(msg);
+
+	return NULL;
+}
+
+int source_connect(struct audio_device *dev, audio_device_cb cb, void *data)
+{
 	struct source *source = dev->source;
 	struct pending_request *pending;
 
 	if (!source->session)
 		source->session = avdtp_get(&dev->src, &dev->dst);
 
-	if (!source->session)
-		return btd_error_failed(msg, "Unable to get a session");
+	if (!source->session) {
+		DBG("Unable to get a session");
+		return -EIO;
+	}
 
 	if (source->connect || source->disconnect)
-		return btd_error_busy(msg);
+		return -EBUSY;
 
 	if (source->stream_state >= AVDTP_STATE_OPEN)
-		return btd_error_already_connected(msg);
+		return -EALREADY;
 
-	if (!source_setup_stream(source, NULL))
-		return btd_error_failed(msg, "Failed to create a stream");
+	if (!source_setup_stream(source, NULL)) {
+		DBG("Failed to create a stream");
+		return -EIO;
+	}
 
 	dev->auto_connect = FALSE;
 
 	pending = source->connect;
-
-	pending->msg = dbus_message_ref(msg);
+	pending->cb = cb;
+	pending->cb_data = data;
 
 	DBG("stream creation in progress");
 
-	return NULL;
+	return 0;
 }
 
 static DBusMessage *disconnect_source(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	struct audio_device *device = data;
-	struct source *source = device->source;
-	struct pending_request *pending;
+	struct audio_device *dev = data;
 	int err;
 
-	if (!source->session)
-		return btd_error_not_connected(msg);
-
-	if (source->connect || source->disconnect)
-		return btd_error_busy(msg);
-
-	if (source->stream_state < AVDTP_STATE_OPEN) {
-		DBusMessage *reply = dbus_message_new_method_return(msg);
-		if (!reply)
-			return NULL;
-		avdtp_unref(source->session);
-		source->session = NULL;
-		return reply;
-	}
-
-	err = avdtp_close(source->session, source->stream, FALSE);
+	err = source_disconnect(dev, FALSE, generic_cb, msg);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
-	pending = g_new0(struct pending_request, 1);
-	pending->msg = dbus_message_ref(msg);
-	source->disconnect = pending;
+	dbus_message_ref(msg);
 
 	return NULL;
 }
@@ -504,10 +496,10 @@ static void source_free(struct audio_device *dev)
 		avdtp_unref(source->session);
 
 	if (source->connect)
-		pending_request_free(dev, source->connect);
+		pending_request_free(dev, source->connect, -ECANCELED);
 
 	if (source->disconnect)
-		pending_request_free(dev, source->disconnect);
+		pending_request_free(dev, source->disconnect, -ECANCELED);
 
 	if (source->retry_id)
 		g_source_remove(source->retry_id);
@@ -593,9 +585,13 @@ gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 	return TRUE;
 }
 
-int source_disconnect(struct audio_device *dev, gboolean shutdown)
+int source_disconnect(struct audio_device *dev, gboolean shutdown,
+						audio_device_cb cb, void *data)
 {
-	struct source *source = dev->source;
+	struct audio_device *device = data;
+	struct source *source = device->source;
+	struct pending_request *pending;
+	int err;
 
 	if (!source->session)
 		return -ENOTCONN;
@@ -607,10 +603,7 @@ int source_disconnect(struct audio_device *dev, gboolean shutdown)
 	if (source->connect) {
 		struct pending_request *pending = source->connect;
 
-		if (pending->msg)
-			error_failed(pending->msg, "Stream setup failed");
-
-		pending_request_free(source->dev, pending);
+		pending_request_free(source->dev, pending, -ECANCELED);
 		source->connect = NULL;
 
 		avdtp_unref(source->session);
@@ -626,7 +619,16 @@ int source_disconnect(struct audio_device *dev, gboolean shutdown)
 	if (!source->stream)
 		return -ENOTCONN;
 
-	return avdtp_close(source->session, source->stream, FALSE);
+	err = avdtp_close(source->session, source->stream, FALSE);
+	if (err < 0)
+		return err;
+
+	pending = g_new0(struct pending_request, 1);
+	pending->cb = cb;
+	pending->cb_data = data;
+	source->disconnect = pending;
+
+	return 0;
 }
 
 unsigned int source_add_state_cb(source_state_cb cb, void *user_data)
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 3406754..2d382b5 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -44,7 +44,9 @@ struct source *source_init(struct audio_device *dev);
 void source_unregister(struct audio_device *dev);
 gboolean source_is_active(struct audio_device *dev);
 source_state_t source_get_state(struct audio_device *dev);
+int source_connect(struct audio_device *dev, audio_device_cb cb, void *data);
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean source_setup_stream(struct source *source, struct avdtp *session);
-int source_disconnect(struct audio_device *dev, gboolean shutdown);
+int source_disconnect(struct audio_device *dev, gboolean shutdown,
+						audio_device_cb cb, void *data);
-- 
1.7.11.7

