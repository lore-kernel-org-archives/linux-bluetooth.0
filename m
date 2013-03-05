Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/6] avdtp: Remove user data from avdtp_session_state_cb
Date: Tue, 5 Mar 2013 15:59:51 +0100
Message-ID: <1362495595-17492-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1362495595-17492-1-git-send-email-szymon.janc@tieto.com>
References: <1362495595-17492-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All users pass NULL as user data so there is no need to keep that.
---
 profiles/audio/avdtp.c  | 6 ++----
 profiles/audio/avdtp.h  | 5 ++---
 profiles/audio/device.c | 6 ++----
 profiles/audio/sink.c   | 6 ++----
 profiles/audio/source.c | 6 ++----
 5 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index e4921b5..bd73572 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -357,7 +357,6 @@ struct stream_callback {
 struct avdtp_state_callback {
 	avdtp_session_state_cb cb;
 	struct audio_device *dev;
-	void *user_data;
 	unsigned int id;
 };
 
@@ -732,7 +731,7 @@ static void avdtp_set_state(struct avdtp *session,
 		if (dev != cb->dev)
 			continue;
 
-		cb->cb(dev, session, old_state, new_state, cb->user_data);
+		cb->cb(dev, session, old_state, new_state);
 	}
 }
 
@@ -3924,7 +3923,7 @@ void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc)
 }
 
 unsigned int avdtp_add_state_cb(struct audio_device *dev,
-				avdtp_session_state_cb cb, void *user_data)
+				avdtp_session_state_cb cb)
 {
 	struct avdtp_state_callback *state_cb;
 	static unsigned int id = 0;
@@ -3932,7 +3931,6 @@ unsigned int avdtp_add_state_cb(struct audio_device *dev,
 	state_cb = g_new(struct avdtp_state_callback, 1);
 	state_cb->cb = cb;
 	state_cb->dev = dev;
-	state_cb->user_data = user_data;
 	state_cb->id = ++id;
 
 	avdtp_callbacks = g_slist_append(avdtp_callbacks, state_cb);
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 437ee03..4e6a597 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -119,8 +119,7 @@ struct avdtp_media_codec_capability {
 typedef void (*avdtp_session_state_cb) (struct audio_device *dev,
 					struct avdtp *session,
 					avdtp_session_state_t old_state,
-					avdtp_session_state_t new_state,
-					void *user_data);
+					avdtp_session_state_t new_state);
 
 typedef void (*avdtp_stream_state_cb) (struct avdtp_stream *stream,
 					avdtp_state_t old_state,
@@ -261,7 +260,7 @@ struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 						struct avdtp_stream *stream);
 
 unsigned int avdtp_add_state_cb(struct audio_device *dev,
-				avdtp_session_state_cb cb, void *user_data);
+				avdtp_session_state_cb cb);
 
 gboolean avdtp_remove_state_cb(unsigned int id);
 
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 67ff697..8d5e10f 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -226,8 +226,7 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 
 static void device_avdtp_cb(struct audio_device *dev, struct avdtp *session,
 				avdtp_session_state_t old_state,
-				avdtp_session_state_t new_state,
-				void *user_data)
+				avdtp_session_state_t new_state)
 {
 	if (!dev->control)
 		return;
@@ -315,8 +314,7 @@ struct audio_device *audio_device_register(struct btd_device *device)
 	if (sink_callback_id == 0)
 		sink_callback_id = sink_add_state_cb(device_sink_cb, NULL);
 
-	dev->priv->avdtp_callback_id = avdtp_add_state_cb(dev, device_avdtp_cb,
-									NULL);
+	dev->priv->avdtp_callback_id = avdtp_add_state_cb(dev, device_avdtp_cb);
 
 	if (avctp_callback_id == 0)
 		avctp_callback_id = avctp_add_state_cb(device_avctp_cb, NULL);
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index de15eff..2bbd9ee 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -110,8 +110,7 @@ static void sink_set_state(struct audio_device *dev, sink_state_t new_state)
 static void avdtp_state_callback(struct audio_device *dev,
 					struct avdtp *session,
 					avdtp_session_state_t old_state,
-					avdtp_session_state_t new_state,
-					void *user_data)
+					avdtp_session_state_t new_state)
 {
 	struct sink *sink = dev->sink;
 
@@ -378,8 +377,7 @@ struct sink *sink_init(struct audio_device *dev)
 
 	sink->dev = dev;
 
-	sink->avdtp_callback_id = avdtp_add_state_cb(dev, avdtp_state_callback,
-									NULL);
+	sink->avdtp_callback_id = avdtp_add_state_cb(dev, avdtp_state_callback);
 
 	return sink;
 }
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 64fbe15..147a92c 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -111,8 +111,7 @@ static void source_set_state(struct audio_device *dev, source_state_t new_state)
 static void avdtp_state_callback(struct audio_device *dev,
 					struct avdtp *session,
 					avdtp_session_state_t old_state,
-					avdtp_session_state_t new_state,
-					void *user_data)
+					avdtp_session_state_t new_state)
 {
 	struct source *source = dev->source;
 
@@ -384,8 +383,7 @@ struct source *source_init(struct audio_device *dev)
 	source->dev = dev;
 
 	source->avdtp_callback_id = avdtp_add_state_cb(dev,
-							avdtp_state_callback,
-							NULL);
+							avdtp_state_callback);
 
 	return source;
 }
-- 
1.8.1.5

