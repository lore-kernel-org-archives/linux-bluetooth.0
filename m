Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix crash when receiving avdtp close command
Date: Mon, 28 Mar 2011 18:31:09 +0300
Message-Id: <1301326269-5078-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

If there are pending start or suspend requests they should all fail since
once close indication return the state will be changed to closing and
remote stack can then disconnect cleanly.

This also follow what specs says about connection release:

"When the Upper Layer has completed releasing all resources allocated to
the stream, an AVDTP_CLOSE_RSP is sent back to the INT."
---
 audio/a2dp.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 88c280a..9d9c61d 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -252,6 +252,16 @@ static gboolean finalize_resume(struct a2dp_setup *s)
 	return FALSE;
 }
 
+static gboolean finalize_resume_errno(struct a2dp_setup *s, int err)
+{
+	struct avdtp_error avdtp_err;
+
+	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, -err);
+	s->err = err ? &avdtp_err : NULL;
+
+	return finalize_resume(s);
+}
+
 static gboolean finalize_suspend(struct a2dp_setup *s)
 {
 	GSList *l;
@@ -1044,12 +1054,20 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
+	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: Close_Ind", sep);
 	else
 		DBG("Source %p: Close_Ind", sep);
 
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return TRUE;
+
+	finalize_suspend_errno(setup, -ECONNRESET);
+	finalize_resume_errno(setup, -ECONNRESET);
+
 	return TRUE;
 }
 
-- 
1.7.1

