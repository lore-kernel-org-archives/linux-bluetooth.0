Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/avdtp: Cleanup watch id when removing session watch
Date: Fri, 29 Aug 2014 10:33:58 +0200
Message-Id: <1409301238-29049-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When session_cb returns FALSE respective watch id is removed so it
must be cleanup. This fix following Glib warning when unrefing
avdtp after transport was disconnected by remote:
(process:28510): GLib-CRITICAL **: Source ID 2 was not found when
    attempting to remove it
---
 android/avdtp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index c9bd8bc..970476a 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -1974,8 +1974,11 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	DBG("");
 
-	if (cond & G_IO_NVAL)
+	if (cond & G_IO_NVAL) {
+		session->io_id = 0;
+
 		return FALSE;
+	}
 
 	header = (void *) session->buf;
 
@@ -2078,6 +2081,8 @@ next:
 failed:
 	connection_lost(session, EIO);
 
+	session->io_id = 0;
+
 	return FALSE;
 }
 
-- 
1.9.1

