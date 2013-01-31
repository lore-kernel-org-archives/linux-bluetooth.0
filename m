Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] A2DP: Fix not setting setup error to NULL
Date: Thu, 31 Jan 2013 11:12:42 -0600
Message-Id: <1359652363-25602-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359652363-25602-1-git-send-email-luiz.dentz@gmail.com>
References: <1359652363-25602-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Once the error is informed to the callback it should be properly freed and
set to NULL otherwise a subsequent operation may end up reusing the same
error which might lead to crashes.
---
 profiles/audio/a2dp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index efb4178..4b28465 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -366,16 +366,13 @@ static void stream_state_changed(struct avdtp_stream *stream,
 static gboolean auto_config(gpointer data)
 {
 	struct a2dp_setup *setup = data;
-	struct avdtp_error *err = NULL;
 
 	/* Check if configuration was aborted */
 	if (setup->sep->stream == NULL)
 		return FALSE;
 
-	if (setup->err != NULL) {
-		err = setup->err;
+	if (setup->err != NULL)
 		goto done;
-	}
 
 	avdtp_stream_add_cb(setup->session, setup->stream,
 				stream_state_changed, setup->sep);
@@ -391,8 +388,10 @@ done:
 
 	finalize_config(setup);
 
-	if (err)
-		g_free(err);
+	if (setup->err) {
+		g_free(setup->err);
+		setup->err = NULL;
+	}
 
 	setup_unref(setup);
 
@@ -565,6 +564,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		if (setup) {
 			setup->err = err;
 			finalize_config(setup);
+			setup->err = NULL;
 		}
 		return;
 	}
-- 
1.8.1

