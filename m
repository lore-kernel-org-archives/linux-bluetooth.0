Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/9 v3] audio: Fix handling of A2DP suspend indication
Date: Fri, 15 Jun 2012 17:41:34 +0300
Message-Id: <1339771301-24032-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
References: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When accepting the suspend indication all callbacks should be notified
that suspend completed.

In addition to this fix not using avdtp_start return in indication
callback as well as in the confirmation.
---
 audio/a2dp.c |   38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index cc8f139..fa97645 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -986,6 +986,9 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
+	gboolean start;
+	int start_err;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Suspend_Ind", sep);
@@ -999,6 +1002,30 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 		a2dp_sep->session = NULL;
 	}
 
+	if (!a2dp_sep->suspending)
+		return TRUE;
+
+	a2dp_sep->suspending = FALSE;
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return TRUE;
+
+	start = setup->start;
+	setup->start = FALSE;
+
+	finalize_suspend(setup);
+
+	if (!start)
+		return TRUE;
+
+	start_err = avdtp_start(session, a2dp_sep->stream);
+	if (start_err < 0) {
+		error("avdtp_start: %s (%d)", strerror(-start_err),
+								-start_err);
+		finalize_setup_errno(setup, start_err, finalize_resume);
+	}
+
 	return TRUE;
 }
 
@@ -1009,7 +1036,7 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_setup *setup;
 	gboolean start;
-	int perr;
+	int start_err;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Suspend_Cfm", sep);
@@ -1040,10 +1067,11 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		return;
 	}
 
-	perr = avdtp_start(session, a2dp_sep->stream);
-	if (perr < 0) {
-		error("Error on avdtp_start %s (%d)", strerror(-perr), -perr);
-		finalize_setup_errno(setup, -EIO, finalize_suspend, NULL);
+	start_err = avdtp_start(session, a2dp_sep->stream);
+	if (start_err < 0) {
+		error("avdtp_start: %s (%d)", strerror(-start_err),
+								-start_err);
+		finalize_setup_errno(setup, start_err, finalize_suspend, NULL);
 	}
 }
 
-- 
1.7.10.2

