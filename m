Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 3/4] Remove unnecessary disconnect callback from sink.c
Date: Wed, 22 Sep 2010 16:35:20 +0300
Message-Id: <1285162521-21997-3-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1285162521-21997-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1285162521-21997-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Headsets for proper disconnecting need to disconnect profiles in specified
order(by ex. disconnect a2dp, then sink and hfp at the end). Instead of
adding separate callbacks for disconnecting each profile, now adding only
one callback in audio/device.c for calling audio disconnect functions in
correct order.
---
 audio/sink.c |   29 -----------------------------
 1 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/audio/sink.c b/audio/sink.c
index 67cffee..eb90c21 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -61,7 +61,6 @@ struct sink {
 	struct avdtp *session;
 	struct avdtp_stream *stream;
 	unsigned int cb_id;
-	guint dc_id;
 	guint retry_id;
 	avdtp_session_state_t session_state;
 	avdtp_state_t stream_state;
@@ -140,11 +139,6 @@ static void avdtp_state_callback(struct audio_device *dev,
 			emit_property_changed(dev->conn, dev->path,
 					AUDIO_SINK_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &value);
-			if (sink->dc_id) {
-				device_remove_disconnect_watch(dev->btd_dev,
-								sink->dc_id);
-				sink->dc_id = 0;
-			}
 		}
 		sink_set_state(dev, SINK_STATE_DISCONNECTED);
 		break;
@@ -171,17 +165,6 @@ static void pending_request_free(struct audio_device *dev,
 	g_free(pending);
 }
 
-static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
-				void *user_data)
-{
-	struct audio_device *device = user_data;
-	struct sink *sink = device->sink;
-
-	DBG("Sink: disconnect %s", device->path);
-
-	avdtp_close(sink->session, sink->stream, TRUE);
-}
-
 static void stream_state_changed(struct avdtp_stream *stream,
 					avdtp_state_t old_state,
 					avdtp_state_t new_state,
@@ -209,12 +192,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 			pending_request_free(dev, p);
 		}
 
-		if (sink->dc_id) {
-			device_remove_disconnect_watch(dev->btd_dev,
-							sink->dc_id);
-			sink->dc_id = 0;
-		}
-
 		if (sink->session) {
 			avdtp_unref(sink->session);
 			sink->session = NULL;
@@ -234,9 +211,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 						AUDIO_SINK_INTERFACE,
 						"Connected",
 						DBUS_TYPE_BOOLEAN, &value);
-			sink->dc_id = device_add_disconnect_watch(dev->btd_dev,
-								disconnect_cb,
-								dev, NULL);
 		} else if (old_state == AVDTP_STATE_STREAMING) {
 			value = FALSE;
 			g_dbus_emit_signal(dev->conn, dev->path,
@@ -601,9 +575,6 @@ static void sink_free(struct audio_device *dev)
 		avdtp_stream_remove_cb(sink->session, sink->stream,
 					sink->cb_id);
 
-	if (sink->dc_id)
-		device_remove_disconnect_watch(dev->btd_dev, sink->dc_id);
-
 	if (sink->session)
 		avdtp_unref(sink->session);
 
-- 
1.7.0.4

