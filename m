Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Fix handling of suspend response
Date: Mon,  4 Apr 2011 12:00:17 +0300
Message-Id: <1301907619-6684-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

finalize_suspend is being called twice when a resume request is queue
after it or if start fails.
---
 audio/a2dp.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 9d9c61d..1208ad1 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1011,6 +1011,7 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_setup *setup;
 	gboolean start;
+	int perr;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Suspend_Cfm", sep);
@@ -1029,23 +1030,22 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (err) {
 		setup->stream = NULL;
 		setup->err = err;
-		finalize_suspend(setup);
 	}
-	else
-		finalize_suspend_errno(setup, 0);
+
+	finalize_suspend(setup);
 
 	if (!start)
 		return;
 
 	if (err) {
-		setup->err = err;
-		finalize_suspend(setup);
-	} else if (avdtp_start(session, a2dp_sep->stream) < 0) {
-		struct avdtp_error start_err;
-		error("avdtp_start failed");
-		avdtp_error_init(&start_err, AVDTP_ERRNO, EIO);
-		setup->err = err;
-		finalize_suspend(setup);
+		finalize_resume(setup);
+		return;
+	}
+
+	perr = avdtp_start(session, a2dp_sep->stream);
+	if (perr < 0) {
+		error("Error on avdtp_start %s (%d)", strerror(-perr), -perr);
+		finalize_resume_errno(setup, perr);
 	}
 }
 
-- 
1.7.1

