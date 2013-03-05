Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/6] avdtp: Register state callback for specified audio device
Date: Tue, 5 Mar 2013 15:59:50 +0100
Message-ID: <1362495595-17492-2-git-send-email-szymon.janc@tieto.com>
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

16 bytes in 1 blocks are still reachable in loss record 43 of 227
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E93FC2: g_slist_append (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4278BD: avdtp_add_state_cb (avdtp.c:3931)
   by 0x41DDA3: audio_device_register (device.c:315)
   by 0x416ECA: manager_get_audio_device (manager.c:491)
   by 0x4171A8: a2dp_sink_probe (manager.c:131)
   by 0x46A7B1: dev_probe (device.c:2347)
   by 0x468C4E: btd_profile_foreach (profile.c:599)
   by 0x46BB45: device_probe_profiles (device.c:2423)
   by 0x4613E8: load_devices (adapter.c:2549)

16 bytes in 1 blocks are still reachable in loss record 45 of 227
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E93FC2: g_slist_append (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4278BD: avdtp_add_state_cb (avdtp.c:3931)
   by 0x41F112: sink_init (sink.c:380)
   by 0x4171B8: a2dp_sink_probe (manager.c:137)
   by 0x46A7B1: dev_probe (device.c:2347)
   by 0x468C4E: btd_profile_foreach (profile.c:599)
   by 0x46BB45: device_probe_profiles (device.c:2423)
   by 0x4613E8: load_devices (adapter.c:2549)
   by 0x465016: read_info_complete (adapter.c:5514)

24 bytes in 1 blocks are still reachable in loss record 61 of 227
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x427892: avdtp_add_state_cb (avdtp.c:3926)
   by 0x41DDA3: audio_device_register (device.c:315)
   by 0x416ECA: manager_get_audio_device (manager.c:491)
   by 0x4171A8: a2dp_sink_probe (manager.c:131)
   by 0x46A7B1: dev_probe (device.c:2347)
   by 0x468C4E: btd_profile_foreach (profile.c:599)
   by 0x46BB45: device_probe_profiles (device.c:2423)
   by 0x4613E8: load_devices (adapter.c:2549)
   by 0x465016: read_info_complete (adapter.c:5514)
   by 0x471331: request_complete (mgmt.c:221)

24 bytes in 1 blocks are still reachable in loss record 63 of 227
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x427892: avdtp_add_state_cb (avdtp.c:3926)
   by 0x41F112: sink_init (sink.c:380)
   by 0x4171B8: a2dp_sink_probe (manager.c:137)
   by 0x46A7B1: dev_probe (device.c:2347)
   by 0x468C4E: btd_profile_foreach (profile.c:599)
   by 0x46BB45: device_probe_profiles (device.c:2423)
   by 0x4613E8: load_devices (adapter.c:2549)
   by 0x465016: read_info_complete (adapter.c:5514)
   by 0x471331: request_complete (mgmt.c:221)
   by 0x4716EB: received_data (mgmt.c:319)
---
 profiles/audio/avdtp.c  |  9 ++++++++-
 profiles/audio/avdtp.h  |  3 ++-
 profiles/audio/device.c | 11 ++++++++---
 profiles/audio/sink.c   | 15 ++++++---------
 profiles/audio/source.c | 16 +++++++---------
 5 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 403a22b..e4921b5 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -356,6 +356,7 @@ struct stream_callback {
 
 struct avdtp_state_callback {
 	avdtp_session_state_cb cb;
+	struct audio_device *dev;
 	void *user_data;
 	unsigned int id;
 };
@@ -727,6 +728,10 @@ static void avdtp_set_state(struct avdtp *session,
 
 	for (l = avdtp_callbacks; l != NULL; l = l->next) {
 		struct avdtp_state_callback *cb = l->data;
+
+		if (dev != cb->dev)
+			continue;
+
 		cb->cb(dev, session, old_state, new_state, cb->user_data);
 	}
 }
@@ -3918,13 +3923,15 @@ void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc)
 	session->device_disconnect = dev_dc;
 }
 
-unsigned int avdtp_add_state_cb(avdtp_session_state_cb cb, void *user_data)
+unsigned int avdtp_add_state_cb(struct audio_device *dev,
+				avdtp_session_state_cb cb, void *user_data)
 {
 	struct avdtp_state_callback *state_cb;
 	static unsigned int id = 0;
 
 	state_cb = g_new(struct avdtp_state_callback, 1);
 	state_cb->cb = cb;
+	state_cb->dev = dev;
 	state_cb->user_data = user_data;
 	state_cb->id = ++id;
 
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 8f0d7e6..437ee03 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -260,7 +260,8 @@ gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 						struct avdtp_stream *stream);
 
-unsigned int avdtp_add_state_cb(avdtp_session_state_cb cb, void *user_data);
+unsigned int avdtp_add_state_cb(struct audio_device *dev,
+				avdtp_session_state_cb cb, void *user_data);
 
 gboolean avdtp_remove_state_cb(unsigned int id);
 
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 2aa22bb..67ff697 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -79,11 +79,12 @@ struct dev_priv {
 	guint dc_id;
 
 	gboolean disconnecting;
+
+	unsigned int avdtp_callback_id;
 };
 
 static unsigned int sink_callback_id = 0;
 static unsigned int avctp_callback_id = 0;
-static unsigned int avdtp_callback_id = 0;
 
 static void device_free(struct audio_device *dev)
 {
@@ -97,6 +98,9 @@ static void device_free(struct audio_device *dev)
 		if (priv->dc_id)
 			device_remove_disconnect_watch(dev->btd_dev,
 							priv->dc_id);
+
+		avdtp_remove_state_cb(priv->avdtp_callback_id);
+
 		g_free(priv);
 	}
 
@@ -311,8 +315,9 @@ struct audio_device *audio_device_register(struct btd_device *device)
 	if (sink_callback_id == 0)
 		sink_callback_id = sink_add_state_cb(device_sink_cb, NULL);
 
-	if (avdtp_callback_id == 0)
-		avdtp_callback_id = avdtp_add_state_cb(device_avdtp_cb, NULL);
+	dev->priv->avdtp_callback_id = avdtp_add_state_cb(dev, device_avdtp_cb,
+									NULL);
+
 	if (avctp_callback_id == 0)
 		avctp_callback_id = avctp_add_state_cb(device_avctp_cb, NULL);
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 8c49961..de15eff 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -64,6 +64,7 @@ struct sink {
 	sink_state_t state;
 	unsigned int connect_id;
 	unsigned int disconnect_id;
+	unsigned int avdtp_callback_id;
 };
 
 struct sink_state_callback {
@@ -74,8 +75,6 @@ struct sink_state_callback {
 
 static GSList *sink_callbacks = NULL;
 
-static unsigned int avdtp_callback_id = 0;
-
 static char *str_state[] = {
 	"SINK_STATE_DISCONNECTED",
 	"SINK_STATE_CONNECTING",
@@ -116,9 +115,6 @@ static void avdtp_state_callback(struct audio_device *dev,
 {
 	struct sink *sink = dev->sink;
 
-	if (sink == NULL)
-		return;
-
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
 		sink_set_state(dev, SINK_STATE_DISCONNECTED);
@@ -360,6 +356,8 @@ static void sink_free(struct audio_device *dev)
 	if (sink->retry_id)
 		g_source_remove(sink->retry_id);
 
+	avdtp_remove_state_cb(sink->avdtp_callback_id);
+
 	g_free(sink);
 	dev->sink = NULL;
 }
@@ -376,14 +374,13 @@ struct sink *sink_init(struct audio_device *dev)
 
 	DBG("%s", device_get_path(dev->btd_dev));
 
-	if (avdtp_callback_id == 0)
-		avdtp_callback_id = avdtp_add_state_cb(avdtp_state_callback,
-									NULL);
-
 	sink = g_new0(struct sink, 1);
 
 	sink->dev = dev;
 
+	sink->avdtp_callback_id = avdtp_add_state_cb(dev, avdtp_state_callback,
+									NULL);
+
 	return sink;
 }
 
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 3c9143c..64fbe15 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -65,6 +65,7 @@ struct source {
 	source_state_t state;
 	unsigned int connect_id;
 	unsigned int disconnect_id;
+	unsigned int avdtp_callback_id;
 };
 
 struct source_state_callback {
@@ -75,8 +76,6 @@ struct source_state_callback {
 
 static GSList *source_callbacks = NULL;
 
-static unsigned int avdtp_callback_id = 0;
-
 static char *str_state[] = {
 	"SOURCE_STATE_DISCONNECTED",
 	"SOURCE_STATE_CONNECTING",
@@ -117,9 +116,6 @@ static void avdtp_state_callback(struct audio_device *dev,
 {
 	struct source *source = dev->source;
 
-	if (source == NULL)
-		return;
-
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
 		source_set_state(dev, SOURCE_STATE_DISCONNECTED);
@@ -364,6 +360,8 @@ static void source_free(struct audio_device *dev)
 	if (source->retry_id)
 		g_source_remove(source->retry_id);
 
+	avdtp_remove_state_cb(source->avdtp_callback_id);
+
 	g_free(source);
 	dev->source = NULL;
 }
@@ -381,14 +379,14 @@ struct source *source_init(struct audio_device *dev)
 
 	DBG("%s", device_get_path(dev->btd_dev));
 
-	if (avdtp_callback_id == 0)
-		avdtp_callback_id = avdtp_add_state_cb(avdtp_state_callback,
-									NULL);
-
 	source = g_new0(struct source, 1);
 
 	source->dev = dev;
 
+	source->avdtp_callback_id = avdtp_add_state_cb(dev,
+							avdtp_state_callback,
+							NULL);
+
 	return source;
 }
 
-- 
1.8.1.5

