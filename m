Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 9/9 v3] audio: Fix aborting A2DP setup while AVDTP_START is in progress
Date: Fri, 15 Jun 2012 17:41:41 +0300
Message-Id: <1339771301-24032-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
References: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Change return of avdtp_start to -EINPROGRESS so the caller can check if
the operation is in progress and don't abort because of that.
---
 audio/a2dp.c  |    4 ++--
 audio/avdtp.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index fafff87..404be53 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1038,7 +1038,7 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 		return TRUE;
 
 	start_err = avdtp_start(session, a2dp_sep->stream);
-	if (start_err < 0) {
+	if (start_err < 0 && start_err != -EINPROGRESS) {
 		error("avdtp_start: %s (%d)", strerror(-start_err),
 								-start_err);
 		finalize_setup_errno(setup, start_err, finalize_resume);
@@ -1086,7 +1086,7 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	}
 
 	start_err = avdtp_start(session, a2dp_sep->stream);
-	if (start_err < 0) {
+	if (start_err < 0 && start_err != -EINPROGRESS) {
 		error("avdtp_start: %s (%d)", strerror(-start_err),
 								-start_err);
 		finalize_setup_errno(setup, start_err, finalize_suspend, NULL);
diff --git a/audio/avdtp.c b/audio/avdtp.c
index 3ba2366..eb56c7c 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -3675,7 +3675,7 @@ int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 
 	if (stream->starting == TRUE) {
 		DBG("stream already started");
-		return -EINVAL;
+		return -EINPROGRESS;
 	}
 
 	memset(&req, 0, sizeof(req));
-- 
1.7.10.2

