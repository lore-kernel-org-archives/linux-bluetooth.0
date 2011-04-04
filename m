Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Fix not removing source when removing setup callback
Date: Mon,  4 Apr 2011 12:00:19 +0300
Message-Id: <1301907619-6684-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1301907619-6684-1-git-send-email-luiz.dentz@gmail.com>
References: <1301907619-6684-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

In rare situation this may lead to access invalid memory since setup can
be freed before idle callback is called.
---
 audio/a2dp.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index d51276d..1f3bc99 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -82,6 +82,7 @@ struct a2dp_setup_cb {
 	a2dp_config_cb_t config_cb;
 	a2dp_stream_cb_t resume_cb;
 	a2dp_stream_cb_t suspend_cb;
+	guint source_id;
 	void *user_data;
 	unsigned int id;
 };
@@ -197,6 +198,9 @@ static void setup_cb_free(struct a2dp_setup_cb *cb)
 {
 	struct a2dp_setup *setup = cb->setup;
 
+	if (cb->source_id)
+		g_source_remove(cb->source_id);
+
 	setup->cb = g_slist_remove(setup->cb, cb);
 	setup_unref(cb->setup);
 	g_free(cb);
@@ -2120,7 +2124,8 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	case AVDTP_STATE_STREAMING:
 		if (avdtp_stream_has_capabilities(setup->stream, caps)) {
 			DBG("Configuration match: resuming");
-			g_idle_add(finalize_config, setup);
+			cb_data->source_id = g_idle_add(finalize_config,
+								setup);
 		} else if (!setup->reconfigure) {
 			setup->reconfigure = TRUE;
 			if (avdtp_close(session, sep->stream, FALSE) < 0) {
@@ -2178,7 +2183,8 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 		if (sep->suspending)
 			setup->start = TRUE;
 		else
-			g_idle_add(finalize_resume, setup);
+			cb_data->source_id = g_idle_add(finalize_resume,
+								setup);
 		break;
 	default:
 		error("SEP in bad state for resume");
@@ -2215,7 +2221,7 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 		goto failed;
 		break;
 	case AVDTP_STATE_OPEN:
-		g_idle_add(finalize_suspend, setup);
+		cb_data->source_id = g_idle_add(finalize_suspend, setup);
 		break;
 	case AVDTP_STATE_STREAMING:
 		if (avdtp_suspend(session, sep->stream) < 0) {
-- 
1.7.1

