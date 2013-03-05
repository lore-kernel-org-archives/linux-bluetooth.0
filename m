Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 5/6] sink: Register state callback for specified audio device
Date: Tue, 5 Mar 2013 15:59:54 +0100
Message-ID: <1362495595-17492-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1362495595-17492-1-git-send-email-szymon.janc@tieto.com>
References: <1362495595-17492-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

State callback will now be registered and called for specified device
only. This will allow for more cleaner callback register/unregister
in roles code.

Fix following valgrind reports:

16 bytes in 1 blocks are still reachable in loss record 42 of 219
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E93FC2: g_slist_append (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x41F31D: sink_add_state_cb (sink.c:456)
   by 0x41DD67: audio_device_register (device.c:314)
   by 0x416ECA: manager_get_audio_device (manager.c:491)
   by 0x4171A8: a2dp_sink_probe (manager.c:131)
   by 0x46A801: dev_probe (device.c:2347)
   by 0x468C9E: btd_profile_foreach (profile.c:599)
   by 0x46BB95: device_probe_profiles (device.c:2423)
   by 0x461438: load_devices (adapter.c:2549)

24 bytes in 1 blocks are still reachable in loss record 56 of 219
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x41F2F2: sink_add_state_cb (sink.c:451)
   by 0x41DD67: audio_device_register (device.c:314)
   by 0x416ECA: manager_get_audio_device (manager.c:491)
   by 0x4171A8: a2dp_sink_probe (manager.c:131)
   by 0x46A801: dev_probe (device.c:2347)
   by 0x468C9E: btd_profile_foreach (profile.c:599)
   by 0x46BB95: device_probe_profiles (device.c:2423)
   by 0x461438: load_devices (adapter.c:2549)
   by 0x465066: read_info_complete (adapter.c:5514)
   by 0x471381: request_complete (mgmt.c:221)
---
 profiles/audio/device.c    | 9 ++++-----
 profiles/audio/sink.c      | 9 ++++++++-
 profiles/audio/sink.h      | 3 ++-
 profiles/audio/transport.c | 5 +----
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index bca4bbd..907221d 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -82,10 +82,9 @@ struct dev_priv {
 
 	unsigned int avdtp_callback_id;
 	unsigned int avctp_callback_id;
+	unsigned int sink_callback_id;
 };
 
-static unsigned int sink_callback_id = 0;
-
 static void device_free(struct audio_device *dev)
 {
 	struct dev_priv *priv = dev->priv;
@@ -101,6 +100,7 @@ static void device_free(struct audio_device *dev)
 
 		avdtp_remove_state_cb(priv->avdtp_callback_id);
 		avctp_remove_state_cb(priv->avctp_callback_id);
+		sink_remove_state_cb(priv->sink_callback_id);
 
 		g_free(priv);
 	}
@@ -310,9 +310,8 @@ struct audio_device *audio_device_register(struct btd_device *device)
 	dev->priv = g_new0(struct dev_priv, 1);
 	dev->priv->state = AUDIO_STATE_DISCONNECTED;
 
-	if (sink_callback_id == 0)
-		sink_callback_id = sink_add_state_cb(device_sink_cb, NULL);
-
+	dev->priv->sink_callback_id = sink_add_state_cb(dev, device_sink_cb,
+									NULL);
 	dev->priv->avdtp_callback_id = avdtp_add_state_cb(dev, device_avdtp_cb);
 	dev->priv->avctp_callback_id = avctp_add_state_cb(dev, device_avctp_cb);
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 2bbd9ee..f023307 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -69,6 +69,7 @@ struct sink {
 
 struct sink_state_callback {
 	sink_state_cb cb;
+	struct audio_device *dev;
 	void *user_data;
 	unsigned int id;
 };
@@ -95,6 +96,10 @@ static void sink_set_state(struct audio_device *dev, sink_state_t new_state)
 
 	for (l = sink_callbacks; l != NULL; l = l->next) {
 		struct sink_state_callback *cb = l->data;
+
+		if (cb->dev != dev)
+			continue;
+
 		cb->cb(dev, old_state, new_state, cb->user_data);
 	}
 
@@ -443,13 +448,15 @@ int sink_disconnect(struct audio_device *dev, gboolean shutdown)
 	return avdtp_close(sink->session, sink->stream, FALSE);
 }
 
-unsigned int sink_add_state_cb(sink_state_cb cb, void *user_data)
+unsigned int sink_add_state_cb(struct audio_device *dev, sink_state_cb cb,
+								void *user_data)
 {
 	struct sink_state_callback *state_cb;
 	static unsigned int id = 0;
 
 	state_cb = g_new(struct sink_state_callback, 1);
 	state_cb->cb = cb;
+	state_cb->dev = dev;
 	state_cb->user_data = user_data;
 	state_cb->id = ++id;
 
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index fc7ed92..ba0dde8 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -36,7 +36,8 @@ typedef void (*sink_state_cb) (struct audio_device *dev,
 				sink_state_t new_state,
 				void *user_data);
 
-unsigned int sink_add_state_cb(sink_state_cb cb, void *user_data);
+unsigned int sink_add_state_cb(struct audio_device *dev, sink_state_cb cb,
+							void *user_data);
 gboolean sink_remove_state_cb(unsigned int id);
 
 struct sink *sink_init(struct audio_device *dev);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 32ba50b..98106a2 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -751,9 +751,6 @@ static void sink_state_changed(struct audio_device *dev,
 {
 	struct media_transport *transport = user_data;
 
-	if (dev != transport->device)
-		return;
-
 	if (new_state == SINK_STATE_PLAYING)
 		transport_update_playing(transport, TRUE);
 	else
@@ -810,7 +807,7 @@ struct media_transport *media_transport_create(struct audio_device *device,
 
 		if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
 			a2dp->volume = -1;
-			transport->sink_watch = sink_add_state_cb(
+			transport->sink_watch = sink_add_state_cb(device,
 							sink_state_changed,
 							transport);
 		} else {
-- 
1.8.1.5

