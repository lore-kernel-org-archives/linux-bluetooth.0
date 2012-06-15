Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/9 v3] AVDTP: Fix responding to ABORT with reject
Date: Fri, 15 Jun 2012 17:41:40 +0300
Message-Id: <1339771301-24032-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
References: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ABORT command cannot be rejected
---
 audio/a2dp.c  |    6 +++---
 audio/avdtp.c |   12 +++---------
 audio/avdtp.h |    2 +-
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index d9dcead..fafff87 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1177,7 +1177,7 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
 }
 
-static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+static void abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream, uint8_t *err,
 				void *user_data)
 {
@@ -1193,13 +1193,13 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	setup = find_setup_by_session(session);
 	if (!setup)
-		return TRUE;
+		return;
 
 	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
 							finalize_resume,
 							finalize_config);
 
-	return TRUE;
+	return;
 }
 
 static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
diff --git a/audio/avdtp.c b/audio/avdtp.c
index e9dea6c..3ba2366 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1951,11 +1951,9 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 	if (!sep || !sep->stream)
 		return TRUE;
 
-	if (sep->ind && sep->ind->abort) {
-		if (!sep->ind->abort(session, sep, sep->stream, &err,
-					sep->user_data))
-			goto failed;
-	}
+	if (sep->ind && sep->ind->abort)
+		sep->ind->abort(session, sep, sep->stream, &err,
+							sep->user_data);
 
 	avdtp_check_collision(session, AVDTP_ABORT, sep->stream);
 
@@ -1965,10 +1963,6 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
 
 	return ret;
-
-failed:
-	return avdtp_send(session, transaction, AVDTP_MSG_TYPE_REJECT,
-					AVDTP_ABORT, &err, sizeof(err));
 }
 
 static gboolean avdtp_secctl_cmd(struct avdtp *session, uint8_t transaction,
diff --git a/audio/avdtp.h b/audio/avdtp.h
index 5f37dc3..dac093b 100644
--- a/audio/avdtp.h
+++ b/audio/avdtp.h
@@ -198,7 +198,7 @@ struct avdtp_sep_ind {
 	gboolean (*close) (struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream, uint8_t *err,
 				void *user_data);
-	gboolean (*abort) (struct avdtp *session, struct avdtp_local_sep *sep,
+	void (*abort) (struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream, uint8_t *err,
 				void *user_data);
 	gboolean (*reconfigure) (struct avdtp *session,
-- 
1.7.10.2

