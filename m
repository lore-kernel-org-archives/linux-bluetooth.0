Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/2] A2DP: Mark start flag if resume happen while in configured state
Date: Tue, 19 Feb 2013 16:33:55 +0200
Message-Id: <1361284436-4584-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If SEP is in configured state that means OPEN is about to happen so just
mark start flag and send START once OPEN completes.
---
 profiles/audio/a2dp.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index f1646ee..d9680a7 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -336,6 +336,20 @@ static struct a2dp_setup *find_setup_by_dev(struct audio_device *dev)
 	return NULL;
 }
 
+static struct a2dp_setup *find_setup_by_stream(struct avdtp_stream *stream)
+{
+	GSList *l;
+
+	for (l = setups; l != NULL; l = l->next) {
+		struct a2dp_setup *setup = l->data;
+
+		if (setup->stream == stream)
+			return setup;
+	}
+
+	return NULL;
+}
+
 static void stream_state_changed(struct avdtp_stream *stream,
 					avdtp_state_t old_state,
 					avdtp_state_t new_state,
@@ -344,6 +358,29 @@ static void stream_state_changed(struct avdtp_stream *stream,
 {
 	struct a2dp_sep *sep = user_data;
 
+	if (new_state == AVDTP_STATE_OPEN) {
+		struct a2dp_setup *setup;
+		int err;
+
+		setup = find_setup_by_stream(stream);
+		if (!setup || !setup->start)
+			return;
+
+		setup->start = FALSE;
+
+		err = avdtp_start(setup->session, stream);
+		if (err < 0 && err != -EINPROGRESS) {
+			error("avdtp_start: %s (%d)", strerror(-err), -err);
+			finalize_setup_errno(setup, err, finalize_resume,
+									NULL);
+			return;
+		}
+
+		sep->starting = TRUE;
+
+		return;
+	}
+
 	if (new_state != AVDTP_STATE_IDLE)
 		return;
 
@@ -661,6 +698,12 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	finalize_config(setup);
 
+	if (!setup->start || !err)
+		return TRUE;
+
+	setup->start = FALSE;
+	finalize_resume(setup);
+
 	return TRUE;
 }
 
@@ -689,6 +732,14 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	}
 
 	finalize_config(setup);
+
+	if (!setup->start || !err)
+		return;
+
+	setup->start = FALSE;
+	finalize_resume(setup);
+
+	return;
 }
 
 static gboolean suspend_timeout(struct a2dp_sep *sep)
@@ -1718,6 +1769,9 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 	case AVDTP_STATE_IDLE:
 		goto failed;
 		break;
+	case AVDTP_STATE_CONFIGURED:
+		setup->start = TRUE;
+		break;
 	case AVDTP_STATE_OPEN:
 		if (avdtp_start(session, sep->stream) < 0) {
 			error("avdtp_start failed");
-- 
1.8.1.2

