Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 3/8] source: Add missing code in source_disconnect()
Date: Thu, 15 Nov 2012 08:27:35 +0100
Message-Id: <1352964460-8531-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use the implementation in sink_disconnect() as a template to implement
the missing code in source_disconnect(). Both functions should be
equivalent.
---
 profiles/audio/source.c | 37 +++++++++++++++++++++++++++++++------
 profiles/audio/source.h |  2 +-
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 38cb822..9981d79 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -593,15 +593,40 @@ gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 	return TRUE;
 }
 
-gboolean source_disconnect(struct source *source)
+int source_disconnect(struct audio_device *dev, gboolean shutdown)
 {
-	if (!source->stream)
-		return FALSE;
+	struct source *source = dev->source;
 
-	if (avdtp_close(source->session, source->stream, FALSE) < 0)
-		return FALSE;
+	if (!source->session)
+		return -ENOTCONN;
 
-	return TRUE;
+	if (shutdown)
+		avdtp_set_device_disconnect(source->session, TRUE);
+
+	/* cancel pending connect */
+	if (source->connect) {
+		struct pending_request *pending = source->connect;
+
+		if (pending->msg)
+			error_failed(pending->msg, "Stream setup failed");
+
+		pending_request_free(source->dev, pending);
+		source->connect = NULL;
+
+		avdtp_unref(source->session);
+		source->session = NULL;
+
+		return 0;
+	}
+
+	/* disconnect already ongoing */
+	if (source->disconnect)
+		return -EBUSY;
+
+	if (!source->stream)
+		return -ENOTCONN;
+
+	return avdtp_close(source->session, source->stream, FALSE);
 }
 
 unsigned int source_add_state_cb(source_state_cb cb, void *user_data)
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 49a8d64..3406754 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -47,4 +47,4 @@ source_state_t source_get_state(struct audio_device *dev);
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean source_setup_stream(struct source *source, struct avdtp *session);
-gboolean source_disconnect(struct source *source);
+int source_disconnect(struct audio_device *dev, gboolean shutdown);
-- 
1.7.11.7

