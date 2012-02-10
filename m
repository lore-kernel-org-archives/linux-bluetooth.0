Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 14/22] audio: Fix clang compiler warnings regarding implicit enum conversion
Date: Fri, 10 Feb 2012 18:39:59 -0300
Message-Id: <1328910007-25604-15-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It was expected that source_get_state() returned a source_state_t, and
that sink_get_state() returned a sink_state_t.
---
 audio/sink.c   |    4 ++--
 audio/sink.h   |    2 +-
 audio/source.c |    4 ++--
 audio/source.h |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/audio/sink.c b/audio/sink.c
index 2d5db18..52f70a9 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -649,11 +649,11 @@ gboolean sink_is_active(struct audio_device *dev)
 	return FALSE;
 }
 
-avdtp_state_t sink_get_state(struct audio_device *dev)
+sink_state_t sink_get_state(struct audio_device *dev)
 {
 	struct sink *sink = dev->sink;
 
-	return sink->stream_state;
+	return sink->state;
 }
 
 gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
diff --git a/audio/sink.h b/audio/sink.h
index 7b1902b..4fea5ba 100644
--- a/audio/sink.h
+++ b/audio/sink.h
@@ -42,7 +42,7 @@ gboolean sink_remove_state_cb(unsigned int id);
 struct sink *sink_init(struct audio_device *dev);
 void sink_unregister(struct audio_device *dev);
 gboolean sink_is_active(struct audio_device *dev);
-avdtp_state_t sink_get_state(struct audio_device *dev);
+sink_state_t sink_get_state(struct audio_device *dev);
 gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean sink_setup_stream(struct sink *sink, struct avdtp *session);
diff --git a/audio/source.c b/audio/source.c
index 6d266f2..4c6e2d0 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -564,11 +564,11 @@ gboolean source_is_active(struct audio_device *dev)
 	return FALSE;
 }
 
-avdtp_state_t source_get_state(struct audio_device *dev)
+source_state_t source_get_state(struct audio_device *dev)
 {
 	struct source *source = dev->source;
 
-	return source->stream_state;
+	return source->state;
 }
 
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
diff --git a/audio/source.h b/audio/source.h
index 7837284..695bded 100644
--- a/audio/source.h
+++ b/audio/source.h
@@ -43,7 +43,7 @@ gboolean source_remove_state_cb(unsigned int id);
 struct source *source_init(struct audio_device *dev);
 void source_unregister(struct audio_device *dev);
 gboolean source_is_active(struct audio_device *dev);
-avdtp_state_t source_get_state(struct audio_device *dev);
+source_state_t source_get_state(struct audio_device *dev);
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean source_setup_stream(struct source *source, struct avdtp *session);
-- 
1.7.8.1

