Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 1/8] audio: Trivial function renames
Date: Thu, 15 Nov 2012 08:27:33 +0100
Message-Id: <1352964460-8531-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Rename functions to be consistent with the rest of the code.
---
 profiles/audio/device.c |  4 ++--
 profiles/audio/sink.c   | 10 +++++-----
 profiles/audio/sink.h   |  2 +-
 profiles/audio/source.c | 10 +++++-----
 profiles/audio/source.h |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index df57d81..811ed75 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -203,7 +203,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 		avrcp_disconnect(dev);
 
 	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
-		sink_shutdown(dev->sink);
+		sink_disconnect(dev->sink);
 	else
 		priv->disconnecting = FALSE;
 }
@@ -390,7 +390,7 @@ static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
-		sink_shutdown(dev->sink);
+		sink_disconnect(dev->sink);
 	else {
 		dbus_message_unref(priv->dc_req);
 		priv->dc_req = NULL;
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 2e63579..e769917 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -390,7 +390,7 @@ gboolean sink_setup_stream(struct sink *sink, struct avdtp *session)
 	return TRUE;
 }
 
-static DBusMessage *sink_connect(DBusConnection *conn,
+static DBusMessage *connect_sink(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
 	struct audio_device *dev = data;
@@ -423,7 +423,7 @@ static DBusMessage *sink_connect(DBusConnection *conn,
 	return NULL;
 }
 
-static DBusMessage *sink_disconnect(DBusConnection *conn,
+static DBusMessage *disconnect_sink(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct audio_device *device = data;
@@ -489,8 +489,8 @@ static DBusMessage *sink_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable sink_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, sink_connect) },
-	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, sink_disconnect) },
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, connect_sink) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, disconnect_sink) },
 	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				sink_get_properties) },
@@ -604,7 +604,7 @@ gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 	return TRUE;
 }
 
-gboolean sink_shutdown(struct sink *sink)
+gboolean sink_disconnect(struct sink *sink)
 {
 	if (!sink->session)
 		return FALSE;
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index 4fea5ba..edac364 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -46,4 +46,4 @@ sink_state_t sink_get_state(struct audio_device *dev);
 gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean sink_setup_stream(struct sink *sink, struct avdtp *session);
-gboolean sink_shutdown(struct sink *sink);
+gboolean sink_disconnect(struct sink *sink);
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 1d0c74a..38cb822 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -379,7 +379,7 @@ gboolean source_setup_stream(struct source *source, struct avdtp *session)
 	return TRUE;
 }
 
-static DBusMessage *source_connect(DBusConnection *conn,
+static DBusMessage *connect_source(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
 	struct audio_device *dev = data;
@@ -412,7 +412,7 @@ static DBusMessage *source_connect(DBusConnection *conn,
 	return NULL;
 }
 
-static DBusMessage *source_disconnect(DBusConnection *conn,
+static DBusMessage *disconnect_source(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct audio_device *device = data;
@@ -478,8 +478,8 @@ static DBusMessage *source_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable source_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, source_connect) },
-	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, source_disconnect) },
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, connect_source) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, disconnect_source) },
 	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				source_get_properties) },
@@ -593,7 +593,7 @@ gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 	return TRUE;
 }
 
-gboolean source_shutdown(struct source *source)
+gboolean source_disconnect(struct source *source)
 {
 	if (!source->stream)
 		return FALSE;
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 695bded..49a8d64 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -47,4 +47,4 @@ source_state_t source_get_state(struct audio_device *dev);
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean source_setup_stream(struct source *source, struct avdtp *session);
-gboolean source_shutdown(struct source *source);
+gboolean source_disconnect(struct source *source);
-- 
1.7.11.7

