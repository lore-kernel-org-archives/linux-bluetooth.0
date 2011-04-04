Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Refactore a2dp finalize_*_errno functions
Date: Mon,  4 Apr 2011 12:00:18 +0300
Message-Id: <1301907619-6684-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1301907619-6684-1-git-send-email-luiz.dentz@gmail.com>
References: <1301907619-6684-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

There were a lot of duplicate code in them so they are now replaced by
finalize_setup_errno which can deal with multiple callbacks reusing the
same error.
---
 audio/a2dp.c |   88 +++++++++++++++++++++++++++-------------------------------
 1 files changed, 41 insertions(+), 47 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 1208ad1..d51276d 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -202,8 +202,32 @@ static void setup_cb_free(struct a2dp_setup_cb *cb)
 	g_free(cb);
 }
 
-static gboolean finalize_config(struct a2dp_setup *s)
+static void finalize_setup_errno(struct a2dp_setup *s, int err,
+					GSourceFunc cb1, ...)
 {
+	GSourceFunc finalize;
+	va_list args;
+	struct avdtp_error avdtp_err;
+
+	if (err < 0) {
+		avdtp_error_init(&avdtp_err, AVDTP_ERRNO, -err);
+		s->err = &avdtp_err;
+	}
+
+	va_start(args, cb1);
+	finalize = cb1;
+	setup_ref(s);
+	while (finalize != NULL) {
+		finalize(s);
+		finalize = va_arg(args, GSourceFunc);
+	}
+	setup_unref(s);
+	va_end(args);
+}
+
+static gboolean finalize_config(gpointer data)
+{
+	struct a2dp_setup *s = data;
 	GSList *l;
 	struct avdtp_stream *stream = s->err ? NULL : s->stream;
 
@@ -223,18 +247,9 @@ static gboolean finalize_config(struct a2dp_setup *s)
 	return FALSE;
 }
 
-static gboolean finalize_config_errno(struct a2dp_setup *s, int err)
-{
-	struct avdtp_error avdtp_err;
-
-	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, -err);
-	s->err = err ? &avdtp_err : NULL;
-
-	return finalize_config(s);
-}
-
-static gboolean finalize_resume(struct a2dp_setup *s)
+static gboolean finalize_resume(gpointer data)
 {
+	struct a2dp_setup *s = data;
 	GSList *l;
 
 	for (l = s->cb; l != NULL; ) {
@@ -252,18 +267,9 @@ static gboolean finalize_resume(struct a2dp_setup *s)
 	return FALSE;
 }
 
-static gboolean finalize_resume_errno(struct a2dp_setup *s, int err)
-{
-	struct avdtp_error avdtp_err;
-
-	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, -err);
-	s->err = err ? &avdtp_err : NULL;
-
-	return finalize_resume(s);
-}
-
-static gboolean finalize_suspend(struct a2dp_setup *s)
+static gboolean finalize_suspend(gpointer data)
 {
+	struct a2dp_setup *s = data;
 	GSList *l;
 
 	for (l = s->cb; l != NULL; ) {
@@ -281,17 +287,7 @@ static gboolean finalize_suspend(struct a2dp_setup *s)
 	return FALSE;
 }
 
-static gboolean finalize_suspend_errno(struct a2dp_setup *s, int err)
-{
-	struct avdtp_error avdtp_err;
-
-	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, -err);
-	s->err = err ? &avdtp_err : NULL;
-
-	return finalize_suspend(s);
-}
-
-static gboolean finalize_select(struct a2dp_setup *s)
+static void finalize_select(struct a2dp_setup *s)
 {
 	GSList *l;
 
@@ -306,8 +302,6 @@ static gboolean finalize_select(struct a2dp_setup *s)
 		cb->select_cb(s->session, s->sep, s->caps, cb->user_data);
 		setup_cb_free(cb);
 	}
-
-	return FALSE;
 }
 
 static struct a2dp_setup *find_setup_by_session(struct avdtp *session)
@@ -777,7 +771,7 @@ static void endpoint_open_cb(struct media_endpoint *endpoint, void *ret,
 
 	if (ret == NULL) {
 		setup->stream = NULL;
-		finalize_config_errno(setup, -EPERM);
+		finalize_setup_errno(setup, -EPERM, finalize_config);
 		return;
 	}
 
@@ -787,7 +781,7 @@ static void endpoint_open_cb(struct media_endpoint *endpoint, void *ret,
 
 	error("Error on avdtp_open %s (%d)", strerror(-err), -err);
 	setup->stream = NULL;
-	finalize_config_errno(setup, err);
+	finalize_setup_errno(setup, err, finalize_config);
 }
 
 static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -844,7 +838,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			return;
 
 		setup->stream = NULL;
-		finalize_config_errno(setup, -EPERM);
+		finalize_setup_errno(setup, -EPERM, finalize_config);
 		return;
 	}
 
@@ -852,7 +846,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (ret < 0) {
 		error("Error on avdtp_open %s (%d)", strerror(-ret), -ret);
 		setup->stream = NULL;
-		finalize_config_errno(setup, ret);
+		finalize_setup_errno(setup, ret, finalize_config);
 	}
 }
 
@@ -1045,7 +1039,7 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	perr = avdtp_start(session, a2dp_sep->stream);
 	if (perr < 0) {
 		error("Error on avdtp_start %s (%d)", strerror(-perr), -perr);
-		finalize_resume_errno(setup, perr);
+		finalize_setup_errno(setup, -EIO, finalize_suspend);
 	}
 }
 
@@ -1065,8 +1059,8 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!setup)
 		return TRUE;
 
-	finalize_suspend_errno(setup, -ECONNRESET);
-	finalize_resume_errno(setup, -ECONNRESET);
+	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
+							finalize_resume);
 
 	return TRUE;
 }
@@ -1099,7 +1093,7 @@ static gboolean a2dp_reconfigure(gpointer data)
 	return FALSE;
 
 failed:
-	finalize_config_errno(setup, posix_err);
+	finalize_setup_errno(setup, posix_err, finalize_config);
 	return FALSE;
 }
 
@@ -2126,7 +2120,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	case AVDTP_STATE_STREAMING:
 		if (avdtp_stream_has_capabilities(setup->stream, caps)) {
 			DBG("Configuration match: resuming");
-			g_idle_add((GSourceFunc) finalize_config, setup);
+			g_idle_add(finalize_config, setup);
 		} else if (!setup->reconfigure) {
 			setup->reconfigure = TRUE;
 			if (avdtp_close(session, sep->stream, FALSE) < 0) {
@@ -2184,7 +2178,7 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 		if (sep->suspending)
 			setup->start = TRUE;
 		else
-			g_idle_add((GSourceFunc) finalize_resume, setup);
+			g_idle_add(finalize_resume, setup);
 		break;
 	default:
 		error("SEP in bad state for resume");
@@ -2221,7 +2215,7 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 		goto failed;
 		break;
 	case AVDTP_STATE_OPEN:
-		g_idle_add((GSourceFunc) finalize_suspend, setup);
+		g_idle_add(finalize_suspend, setup);
 		break;
 	case AVDTP_STATE_STREAMING:
 		if (avdtp_suspend(session, sep->stream) < 0) {
-- 
1.7.1

