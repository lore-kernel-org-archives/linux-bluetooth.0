Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/9] obexd: Queue setpath command
Date: Tue, 28 May 2013 14:37:08 +0200
Message-Id: <1369744633-8980-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 6c2ecb7..36ed541 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -182,6 +182,14 @@ static void pending_request_free(struct pending_request *p)
 	g_free(p);
 }
 
+static void setpath_data_free(void *process_data)
+{
+	struct setpath_data *data = process_data;
+
+	g_strfreev(data->remaining);
+	g_free(data);
+}
+
 static void session_free(struct obc_session *session)
 {
 	DBG("%p", session);
@@ -888,9 +896,6 @@ static void setpath_complete(struct obc_session *session,
 	if (data->func)
 		data->func(session, NULL, err, data->user_data);
 
-	g_strfreev(data->remaining);
-	g_free(data);
-
 	if (session->p == p)
 		session->p = NULL;
 
@@ -942,13 +947,35 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 	}
 }
 
+static int session_process_setpath(struct pending_request *p, GError **err)
+{
+	struct setpath_data *req = p->data;
+	const char *first = "";
+
+	/* Relative path */
+	if (req->remaining[0][0] != '/')
+		first = req->remaining[req->index];
+	req->index++;
+
+	p->req_id = g_obex_setpath(p->session->obex, first, setpath_cb, p, err);
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
 guint obc_session_setpath(struct obc_session *session, const char *path,
 				session_callback_t func, void *user_data,
 				GError **err)
 {
 	struct setpath_data *data;
 	struct pending_request *p;
-	const char *first = "";
 
 	if (session->obex == NULL) {
 		g_set_error(err, OBEX_IO_ERROR, OBEX_IO_DISCONNECTED,
@@ -956,39 +983,15 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
 		return 0;
 	}
 
-	if (session->p != NULL) {
-		g_set_error(err, OBEX_IO_ERROR, OBEX_IO_BUSY,
-							"Session busy");
-		return 0;
-	}
-
 	data = g_new0(struct setpath_data, 1);
 	data->func = func;
 	data->user_data = user_data;
 	data->remaining = g_strsplit(strlen(path) ? path : "/", "/", 0);
 
-	p = pending_request_new(session, NULL, NULL, NULL, setpath_complete,
-									data);
-
-	/* Relative path */
-	if (path[0] != '/')
-		first = data->remaining[data->index];
-
-	data->index++;
-
-	p->req_id = g_obex_setpath(session->obex, first, setpath_cb, p, err);
-	if (*err != NULL)
-		goto fail;
-
-	session->p = p;
-
+	p = pending_request_new(session, session_process_setpath,
+			setpath_data_free, NULL, setpath_complete, data);
+	session_queue_add(p);
 	return p->id;
-
-fail:
-	g_strfreev(data->remaining);
-	g_free(data);
-	pending_request_free(p);
-	return 0;
 }
 
 static void async_cb(GObex *obex, GError *err, GObexPacket *rsp,
-- 
1.8.2.3

