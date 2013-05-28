Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 8/9] obexd: Queue move command
Date: Tue, 28 May 2013 14:37:12 +0200
Message-Id: <1369744633-8980-9-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 374b95a..5033f70 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -1140,10 +1140,29 @@ guint obc_session_copy(struct obc_session *session, const char *srcname,
 	return p->id;
 }
 
+static int session_process_move(struct pending_request *p, GError **err)
+{
+	struct file_data *req = p->data;
+
+	p->req_id = g_obex_move(p->session->obex, req->srcname, req->destname,
+							async_cb, p, err);
+	if (*err != NULL)
+		goto fail;
+
+	p->session->p = p;
+
+	return 0;
+
+fail:
+	pending_request_free(p);
+	return (*err)->code;
+}
+
 guint obc_session_move(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err)
 {
+	struct file_data *data;
 	struct pending_request *p;
 
 	if (session->obex == NULL) {
@@ -1152,21 +1171,15 @@ guint obc_session_move(struct obc_session *session, const char *srcname,
 		return 0;
 	}
 
-	if (session->p != NULL) {
-		g_set_error(err, OBEX_IO_ERROR, OBEX_IO_BUSY, "Session busy");
-		return 0;
-	}
-
-	p = pending_request_new(session, NULL, NULL, NULL, func, user_data);
-
-	p->req_id = g_obex_move(session->obex, srcname, destname, async_cb, p,
-									err);
-	if (*err != NULL) {
-		pending_request_free(p);
-		return 0;
-	}
+	data = g_new0(struct file_data, 1);
+	data->srcname = g_strdup(srcname);
+	data->destname = g_strdup(destname);
+	data->func = func;
+	data->user_data = user_data;
 
-	session->p = p;
+	p = pending_request_new(session, session_process_move, file_data_free,
+					NULL, file_op_complete, data);
+	session_queue_add(p);
 	return p->id;
 }
 
-- 
1.8.2.3

