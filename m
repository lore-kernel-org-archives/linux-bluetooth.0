Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] source: Register state callback for specified audio device
Date: Tue, 5 Mar 2013 12:06:59 +0100
Message-ID: <1362481619-25815-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1362481619-25815-1-git-send-email-szymon.janc@tieto.com>
References: <1362481619-25815-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

State callback will now be registered and called for specified device
only. This will allow for more cleaner callback register/unregister
in roles code.
---
 profiles/audio/source.c    | 9 ++++++++-
 profiles/audio/source.h    | 3 ++-
 profiles/audio/transport.c | 5 +----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 4ebe598..5c5568a 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -70,6 +70,7 @@ struct source {
 
 struct source_state_callback {
 	source_state_cb cb;
+	struct audio_device *dev;
 	void *user_data;
 	unsigned int id;
 };
@@ -96,6 +97,10 @@ static void source_set_state(struct audio_device *dev, source_state_t new_state)
 
 	for (l = source_callbacks; l != NULL; l = l->next) {
 		struct source_state_callback *cb = l->data;
+
+		if (cb->dev != dev)
+			return;
+
 		cb->cb(dev, old_state, new_state, cb->user_data);
 	}
 
@@ -439,13 +444,15 @@ int source_disconnect(struct audio_device *dev, gboolean shutdown)
 	return avdtp_close(source->session, source->stream, FALSE);
 }
 
-unsigned int source_add_state_cb(source_state_cb cb, void *user_data)
+unsigned int source_add_state_cb(source_state_cb cb, struct audio_device *dev,
+								void *user_data)
 {
 	struct source_state_callback *state_cb;
 	static unsigned int id = 0;
 
 	state_cb = g_new(struct source_state_callback, 1);
 	state_cb->cb = cb;
+	state_cb->dev = dev;
 	state_cb->user_data = user_data;
 	state_cb->id = ++id;
 
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 4c01d27..d39abac 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -37,7 +37,8 @@ typedef void (*source_state_cb) (struct audio_device *dev,
 				source_state_t new_state,
 				void *user_data);
 
-unsigned int source_add_state_cb(source_state_cb cb, void *user_data);
+unsigned int source_add_state_cb(source_state_cb cb, struct audio_device *dev,
+							void *user_data);
 gboolean source_remove_state_cb(unsigned int id);
 
 struct source *source_init(struct audio_device *dev);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 1e54323..0b39ed0 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -764,9 +764,6 @@ static void source_state_changed(struct audio_device *dev,
 {
 	struct media_transport *transport = user_data;
 
-	if (dev != transport->device)
-		return;
-
 	if (new_state == SOURCE_STATE_PLAYING)
 		transport_update_playing(transport, TRUE);
 	else
@@ -815,7 +812,7 @@ struct media_transport *media_transport_create(struct audio_device *device,
 			avrcp_set_volume(device, a2dp->volume);
 			transport->source_watch = source_add_state_cb(
 							source_state_changed,
-							transport);
+							device, transport);
 		}
 	} else
 		goto fail;
-- 
1.8.1.5

