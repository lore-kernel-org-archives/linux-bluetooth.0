Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 2/8] sink: Generalize disconnection function
Date: Thu, 15 Nov 2012 08:27:34 +0100
Message-Id: <1352964460-8531-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the function for a more general usage other than full device
disconnection. Besides, return error code instead of a boolean.
---
 profiles/audio/device.c |  4 ++--
 profiles/audio/sink.c   | 20 ++++++++++----------
 profiles/audio/sink.h   |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 811ed75..09a1ed7 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -203,7 +203,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 		avrcp_disconnect(dev);
 
 	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
-		sink_disconnect(dev->sink);
+		sink_disconnect(dev, TRUE);
 	else
 		priv->disconnecting = FALSE;
 }
@@ -390,7 +390,7 @@ static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
-		sink_disconnect(dev->sink);
+		sink_disconnect(dev, TRUE);
 	else {
 		dbus_message_unref(priv->dc_req);
 		priv->dc_req = NULL;
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index e769917..7a08960 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -604,12 +604,15 @@ gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 	return TRUE;
 }
 
-gboolean sink_disconnect(struct sink *sink)
+int sink_disconnect(struct audio_device *dev, gboolean shutdown)
 {
+	struct sink *sink = dev->sink;
+
 	if (!sink->session)
-		return FALSE;
+		return -ENOTCONN;
 
-	avdtp_set_device_disconnect(sink->session, TRUE);
+	if (shutdown)
+		avdtp_set_device_disconnect(sink->session, TRUE);
 
 	/* cancel pending connect */
 	if (sink->connect) {
@@ -623,20 +626,17 @@ gboolean sink_disconnect(struct sink *sink)
 		avdtp_unref(sink->session);
 		sink->session = NULL;
 
-		return TRUE;
+		return 0;
 	}
 
 	/* disconnect already ongoing */
 	if (sink->disconnect)
-		return TRUE;
+		return -EBUSY;
 
 	if (!sink->stream)
-		return FALSE;
-
-	if (avdtp_close(sink->session, sink->stream, FALSE) < 0)
-		return FALSE;
+		return -ENOTCONN;
 
-	return TRUE;
+	return avdtp_close(sink->session, sink->stream, FALSE);
 }
 
 unsigned int sink_add_state_cb(sink_state_cb cb, void *user_data)
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index edac364..426d83f 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -46,4 +46,4 @@ sink_state_t sink_get_state(struct audio_device *dev);
 gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean sink_setup_stream(struct sink *sink, struct avdtp *session);
-gboolean sink_disconnect(struct sink *sink);
+int sink_disconnect(struct audio_device *dev, gboolean shutdown);
-- 
1.7.11.7

