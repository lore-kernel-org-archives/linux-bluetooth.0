Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH 5/6] Create a2dp_sink_resume().
Date: Thu,  4 Jun 2009 16:09:55 -0300
Message-Id: <1244142596-8076-5-git-send-email-jprvita@gmail.com>
In-Reply-To: <1244142596-8076-4-git-send-email-jprvita@gmail.com>
References: <1244142596-8076-1-git-send-email-jprvita@gmail.com>
 <1244142596-8076-2-git-send-email-jprvita@gmail.com>
 <1244142596-8076-3-git-send-email-jprvita@gmail.com>
 <1244142596-8076-4-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/a2dp.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/a2dp.h |    2 +
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index dc4f699..1c05f21 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1752,6 +1752,65 @@ failed:
 	return 0;
 }
 
+unsigned int a2dp_sink_resume(struct avdtp *session, struct a2dp_sep *sep,
+				a2dp_stream_cb_t cb, void *user_data)
+{
+	struct a2dp_setup_cb *cb_data;
+	struct a2dp_setup *setup;
+
+	cb_data = g_new0(struct a2dp_setup_cb, 1);
+	cb_data->resume_cb = cb;
+	cb_data->user_data = user_data;
+	cb_data->id = ++cb_id;
+
+	setup = find_setup_by_session(session);
+	if (!setup) {
+		setup = g_new0(struct a2dp_setup, 1);
+		setup->session = avdtp_ref(session);
+		setup->dev = a2dp_get_dev(session);
+		setups = g_slist_append(setups, setup);
+	}
+
+	setup_ref(setup);
+	setup->cb = g_slist_append(setup->cb, cb_data);
+	setup->sep = sep;
+	setup->stream = sep->stream;
+
+	switch (avdtp_sep_get_state(sep->sep)) {
+	case AVDTP_STATE_IDLE:
+		goto failed;
+		break;
+	case AVDTP_STATE_OPEN:
+		if (avdtp_start(session, sep->stream) < 0) {
+			error("avdtp_start failed");
+			goto failed;
+		}
+		break;
+	case AVDTP_STATE_STREAMING:
+		if (!sep->suspending && sep->suspend_timer) {
+			g_source_remove(sep->suspend_timer);
+			sep->suspend_timer = 0;
+			avdtp_unref(sep->session);
+			sep->session = NULL;
+		}
+		if (sep->suspending)
+			setup->start = TRUE;
+		else
+			g_idle_add((GSourceFunc) finalize_resume, setup);
+		break;
+	default:
+		error("SEP in bad state for resume");
+		goto failed;
+	}
+
+	return cb_data->id;
+
+failed:
+	setup_unref(setup);
+	cb_id--;
+	return 0;
+}
+
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 {
 	if (sep->locked)
diff --git a/audio/a2dp.h b/audio/a2dp.h
index 3be38a7..db378da 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -148,6 +148,8 @@ struct a2dp_sep *a2dp_sink_get(struct avdtp *session,
 unsigned int a2dp_sink_config(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_config_cb_t cb, GSList *caps,
 				void *user_data);
+unsigned int a2dp_sink_resume(struct avdtp *session, struct a2dp_sep *sep,
+				a2dp_stream_cb_t cb, void *user_data);
 gboolean a2dp_sink_cancel(struct audio_device *dev, unsigned int id);
 
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
-- 
1.6.0.4

