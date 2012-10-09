Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/5] audio: Remove redundant procedure when a2dp connect
Date: Tue, 09 Oct 2012 20:35:48 +0900
Message-id: <1349782548-27923-5-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1349782548-27923-1-git-send-email-chanyeol.park@samsung.com>
References: <1349782548-27923-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch fixes the bug that when remote host is down a2dp connection failure
is handled like XCASE
---
 audio/avdtp.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index d905db3..ae1ab7b 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2411,9 +2411,10 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct avdtp *session = user_data;
 	char address[18];
-	GError *gerr = NULL;
+	int err_no = EIO;
 
 	if (err) {
+		err_no = err->code;
 		error("%s", err->message);
 		goto failed;
 	}
@@ -2421,13 +2422,13 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	if (!session->io)
 		session->io = g_io_channel_ref(chan);
 
-	bt_io_get(chan, &gerr,
+	bt_io_get(chan, &err,
 			BT_IO_OPT_OMTU, &session->omtu,
 			BT_IO_OPT_IMTU, &session->imtu,
 			BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("%s", gerr->message);
-		g_error_free(gerr);
+	if (err) {
+		err_no = err->code;
+		error("%s", err->message);
 		goto failed;
 	}
 
@@ -2481,7 +2482,7 @@ failed:
 			avdtp_sep_set_state(session, stream->lsep,
 						AVDTP_STATE_IDLE);
 	} else
-		connection_lost(session, EIO);
+		connection_lost(session, err_no);
 }
 
 static void auth_cb(DBusError *derr, void *user_data)
-- 
1.7.9.5

