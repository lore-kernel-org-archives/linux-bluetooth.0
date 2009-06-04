Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH 6/6] Create a2dp_sink_suspend().
Date: Thu,  4 Jun 2009 16:09:56 -0300
Message-Id: <1244142596-8076-6-git-send-email-jprvita@gmail.com>
In-Reply-To: <1244142596-8076-5-git-send-email-jprvita@gmail.com>
References: <1244142596-8076-1-git-send-email-jprvita@gmail.com>
 <1244142596-8076-2-git-send-email-jprvita@gmail.com>
 <1244142596-8076-3-git-send-email-jprvita@gmail.com>
 <1244142596-8076-4-git-send-email-jprvita@gmail.com>
 <1244142596-8076-5-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/a2dp.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/a2dp.h |    2 ++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 1c05f21..721ad16 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1811,6 +1811,57 @@ failed:
 	return 0;
 }
 
+unsigned int a2dp_sink_suspend(struct avdtp *session, struct a2dp_sep *sep,
+				a2dp_stream_cb_t cb, void *user_data)
+{
+	struct a2dp_setup_cb *cb_data;
+	struct a2dp_setup *setup;
+
+	cb_data = g_new0(struct a2dp_setup_cb, 1);
+	cb_data->suspend_cb = cb;
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
+		error("a2dp_sink_suspend: no stream to suspend");
+		goto failed;
+		break;
+	case AVDTP_STATE_OPEN:
+		g_idle_add((GSourceFunc) finalize_suspend, setup);
+		break;
+	case AVDTP_STATE_STREAMING:
+		if (avdtp_suspend(session, sep->stream) < 0) {
+			error("avdtp_suspend failed");
+			goto failed;
+		}
+		break;
+	default:
+		error("SEP in bad state for suspend");
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
index db378da..cb1bcbd 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -150,6 +150,8 @@ unsigned int a2dp_sink_config(struct avdtp *session, struct a2dp_sep *sep,
 				void *user_data);
 unsigned int a2dp_sink_resume(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data);
+unsigned int a2dp_sink_suspend(struct avdtp *session, struct a2dp_sep *sep,
+				a2dp_stream_cb_t cb, void *user_data);
 gboolean a2dp_sink_cancel(struct audio_device *dev, unsigned int id);
 
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
-- 
1.6.0.4

