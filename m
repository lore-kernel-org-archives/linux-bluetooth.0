Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH 2/6] Create a2dp_sink_cancel().
Date: Thu,  4 Jun 2009 16:09:52 -0300
Message-Id: <1244142596-8076-2-git-send-email-jprvita@gmail.com>
In-Reply-To: <1244142596-8076-1-git-send-email-jprvita@gmail.com>
References: <1244142596-8076-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/a2dp.c |   35 +++++++++++++++++++++++++++++++++++
 audio/a2dp.h |    2 ++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 1ef23c4..67e2576 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1566,6 +1566,41 @@ failed:
 	return 0;
 }
 
+gboolean a2dp_sink_cancel(struct audio_device *dev, unsigned int id)
+{
+	struct a2dp_setup_cb *cb_data;
+	struct a2dp_setup *setup;
+	GSList *l;
+
+	debug("a2dp_sink_cancel()");
+
+	setup = find_setup_by_dev(dev);
+	if (!setup)
+		return FALSE;
+
+	for (cb_data = NULL, l = setup->cb; l != NULL; l = g_slist_next(l)) {
+		struct a2dp_setup_cb *cb = l->data;
+
+		if (cb->id == id) {
+			cb_data = cb;
+			break;
+		}
+	}
+
+	if (!cb_data)
+		error("a2dp_sink_cancel: no matching callback with id %u", id);
+
+	setup->cb = g_slist_remove(setup->cb, cb_data);
+	g_free(cb_data);
+
+	if (!setup->cb) {
+		setup->canceled = TRUE;
+		setup->sep = NULL;
+	}
+
+	return TRUE;
+}
+
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 {
 	if (sep->locked)
diff --git a/audio/a2dp.h b/audio/a2dp.h
index 0e5f796..f72480c 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -143,6 +143,8 @@ unsigned int a2dp_source_suspend(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data);
 gboolean a2dp_source_cancel(struct audio_device *dev, unsigned int id);
 
+gboolean a2dp_sink_cancel(struct audio_device *dev, unsigned int id);
+
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_get_lock(struct a2dp_sep *sep);
-- 
1.6.0.4

