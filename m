Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix crash when calling finalize_setup_errno
Date: Fri, 29 Apr 2011 13:56:03 +0300
Message-Id: <1304074563-16865-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

finalize_setup_errno last parameter must be NULL otherwise it may access
invalid memory.
---
 audio/a2dp.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 741b134..9cd7207 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -775,7 +775,7 @@ static void endpoint_open_cb(struct media_endpoint *endpoint, void *ret,
 
 	if (ret == NULL) {
 		setup->stream = NULL;
-		finalize_setup_errno(setup, -EPERM, finalize_config);
+		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
 		return;
 	}
 
@@ -785,7 +785,7 @@ static void endpoint_open_cb(struct media_endpoint *endpoint, void *ret,
 
 	error("Error on avdtp_open %s (%d)", strerror(-err), -err);
 	setup->stream = NULL;
-	finalize_setup_errno(setup, err, finalize_config);
+	finalize_setup_errno(setup, err, finalize_config, NULL);
 }
 
 static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -842,7 +842,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			return;
 
 		setup->stream = NULL;
-		finalize_setup_errno(setup, -EPERM, finalize_config);
+		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
 		return;
 	}
 
@@ -850,7 +850,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (ret < 0) {
 		error("Error on avdtp_open %s (%d)", strerror(-ret), -ret);
 		setup->stream = NULL;
-		finalize_setup_errno(setup, ret, finalize_config);
+		finalize_setup_errno(setup, ret, finalize_config, NULL);
 	}
 }
 
@@ -1043,7 +1043,7 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	perr = avdtp_start(session, a2dp_sep->stream);
 	if (perr < 0) {
 		error("Error on avdtp_start %s (%d)", strerror(-perr), -perr);
-		finalize_setup_errno(setup, -EIO, finalize_suspend);
+		finalize_setup_errno(setup, -EIO, finalize_suspend, NULL);
 	}
 }
 
@@ -1064,7 +1064,7 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 		return TRUE;
 
 	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
-							finalize_resume);
+							finalize_resume, NULL);
 
 	return TRUE;
 }
@@ -1097,7 +1097,7 @@ static gboolean a2dp_reconfigure(gpointer data)
 	return FALSE;
 
 failed:
-	finalize_setup_errno(setup, posix_err, finalize_config);
+	finalize_setup_errno(setup, posix_err, finalize_config, NULL);
 	return FALSE;
 }
 
-- 
1.7.1

