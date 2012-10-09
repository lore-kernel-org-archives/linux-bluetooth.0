Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] audio: Fix memory leak of AVDTP buffer
Date: Tue,  9 Oct 2012 18:03:52 +0200
Message-Id: <1349798633-28071-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Upon disconnection all references to AVDTP session should be release
otherwise the data associate with it cannot be freed and new connection
may overwrite the buf pointer causing it to leak.
---
 audio/sink.c   | 8 ++++++++
 audio/source.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/audio/sink.c b/audio/sink.c
index 4eb2c61..0628fd2 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -125,6 +125,14 @@ static void sink_set_state(struct audio_device *dev, sink_state_t new_state)
 		struct sink_state_callback *cb = l->data;
 		cb->cb(dev, old_state, new_state, cb->user_data);
 	}
+
+	if (new_state != SINK_STATE_DISCONNECTED)
+		return;
+
+	if (sink->session) {
+		avdtp_unref(sink->session);
+		sink->session = NULL;
+	}
 }
 
 static void avdtp_state_callback(struct audio_device *dev,
diff --git a/audio/source.c b/audio/source.c
index 41aedd2..e111954 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -116,6 +116,14 @@ static void source_set_state(struct audio_device *dev, source_state_t new_state)
 		struct source_state_callback *cb = l->data;
 		cb->cb(dev, old_state, new_state, cb->user_data);
 	}
+
+	if (new_state != SOURCE_STATE_DISCONNECTED)
+		return;
+
+	if (source->session) {
+		avdtp_unref(source->session);
+		source->session = NULL;
+	}
 }
 
 static void avdtp_state_callback(struct audio_device *dev,
-- 
1.7.11.4

