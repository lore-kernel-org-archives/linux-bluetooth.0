Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH 3/6] Create a2dp_sink_get().
Date: Thu,  4 Jun 2009 16:09:53 -0300
Message-Id: <1244142596-8076-3-git-send-email-jprvita@gmail.com>
In-Reply-To: <1244142596-8076-2-git-send-email-jprvita@gmail.com>
References: <1244142596-8076-1-git-send-email-jprvita@gmail.com>
 <1244142596-8076-2-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/a2dp.c |   33 +++++++++++++++++++++++++++++++++
 audio/a2dp.h |    2 ++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 67e2576..605dfed 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1601,6 +1601,39 @@ gboolean a2dp_sink_cancel(struct audio_device *dev, unsigned int id)
 	return TRUE;
 }
 
+struct a2dp_sep *a2dp_sink_get(struct avdtp *session,
+				struct avdtp_remote_sep *rsep)
+{
+	GSList *l;
+	struct a2dp_server *server;
+	struct avdtp_service_capability *cap;
+	struct avdtp_media_codec_capability *codec_cap = NULL;
+	bdaddr_t src;
+
+	avdtp_get_peers(session, &src, NULL);
+	server = find_server(servers, &src);
+	if (!server)
+		return NULL;
+
+	cap = avdtp_get_codec(rsep);
+	codec_cap = (void *) cap->data;
+
+	for (l = server->sinks; l != NULL; l = l->next) {
+		struct a2dp_sep *sep = l->data;
+
+		if (sep->locked)
+			continue;
+
+		if (sep->codec != codec_cap->media_codec_type)
+			continue;
+
+		if (!sep->stream || avdtp_has_stream(session, sep->stream))
+			return sep;
+	}
+
+	return NULL;
+}
+
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 {
 	if (sep->locked)
diff --git a/audio/a2dp.h b/audio/a2dp.h
index f72480c..f0a61e3 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -143,6 +143,8 @@ unsigned int a2dp_source_suspend(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data);
 gboolean a2dp_source_cancel(struct audio_device *dev, unsigned int id);
 
+struct a2dp_sep *a2dp_sink_get(struct avdtp *session,
+				struct avdtp_remote_sep *sep);
 gboolean a2dp_sink_cancel(struct audio_device *dev, unsigned int id);
 
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
-- 
1.6.0.4

