Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Remove a2dp setup callbacks after they return
Date: Thu, 11 Nov 2010 11:40:24 +0200
Message-Id: <1289468425-11997-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Since the callback won't be ever called again it make no sense to keep
them, also this cause a2dp_cancel to assume there are still some pending
callbacks to be processed and do not abort when it should.
---
 audio/a2dp.c |   55 +++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 3aaf022..a55020d 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -160,15 +160,18 @@ static gboolean finalize_config(struct a2dp_setup *s)
 	struct avdtp_stream *stream = s->err ? NULL : s->stream;
 
 	setup_ref(s);
-	for (l = s->cb; l != NULL; l = l->next) {
+	for (l = s->cb; l != NULL; ){
 		struct a2dp_setup_cb *cb = l->data;
 
+		l = l->next;
+
 		if (!cb->config_cb)
 			continue;
 
 		cb->config_cb(s->session, s->sep, stream, s->err,
 							cb->user_data);
-		cb->config_cb = NULL;
+		s->cb = g_slist_remove(s->cb, cb);
+		g_free(cb);
 		setup_unref(s);
 	}
 
@@ -193,14 +196,18 @@ static gboolean finalize_resume(struct a2dp_setup *s)
 
 	setup_ref(s);
 
-	for (l = s->cb; l != NULL; l = l->next) {
+	for (l = s->cb; l != NULL; ) {
 		struct a2dp_setup_cb *cb = l->data;
 
-		if (cb && cb->resume_cb) {
-			cb->resume_cb(s->session, s->err, cb->user_data);
-			cb->resume_cb = NULL;
-			setup_unref(s);
-		}
+		l = l->next;
+
+		if (!cb->resume_cb)
+			continue;
+
+		cb->resume_cb(s->session, s->err, cb->user_data);
+		s->cb = g_slist_remove(s->cb, cb);
+		g_free(cb);
+		setup_unref(s);
 	}
 
 	setup_unref(s);
@@ -213,14 +220,18 @@ static gboolean finalize_suspend(struct a2dp_setup *s)
 	GSList *l;
 
 	setup_ref(s);
-	for (l = s->cb; l != NULL; l = l->next) {
+	for (l = s->cb; l != NULL; ) {
 		struct a2dp_setup_cb *cb = l->data;
 
-		if (cb->suspend_cb) {
-			cb->suspend_cb(s->session, s->err, cb->user_data);
-			cb->suspend_cb = NULL;
-			setup_unref(s);
-		}
+		l = l->next;
+
+		if (!cb->suspend_cb)
+			continue;
+
+		cb->suspend_cb(s->session, s->err, cb->user_data);
+		s->cb = g_slist_remove(s->cb, cb);
+		g_free(cb);
+		setup_unref(s);
 	}
 
 	setup_unref(s);
@@ -242,14 +253,18 @@ static gboolean finalize_select(struct a2dp_setup *s, GSList *caps)
 	GSList *l;
 
 	setup_ref(s);
-	for (l = s->cb; l != NULL; l = l->next) {
+	for (l = s->cb; l != NULL; ) {
 		struct a2dp_setup_cb *cb = l->data;
 
-		if (cb->select_cb) {
-			cb->select_cb(s->session, s->sep, caps, cb->user_data);
-			cb->select_cb = NULL;
-			setup_unref(s);
-		}
+		l = l->next;
+
+		if (!cb->select_cb)
+			continue;
+
+		cb->select_cb(s->session, s->sep, caps, cb->user_data);
+		s->cb = g_slist_remove(s->cb, cb);
+		g_free(cb);
+		setup_unref(s);
 	}
 
 	setup_unref(s);
-- 
1.7.1

