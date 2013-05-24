Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] obexd: Queue session commands
Date: Fri, 24 May 2013 14:39:15 +0200
Message-Id: <1369399155-16028-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

So far only transfers are queued in OBEX sessions. Commands like SetPath
are not queued and the commands will simply fail when a different
operation or transfer is ongoing. This patch removes this limitation and
queues commands as well.

Currently, the MAP client is directly affected by this limitation.
An immediate call to SetPath after the MAP connection has been established
reliably fails, because MNS is being connected in the background in parallel.
---
 obexd/client/session.c | 271 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 190 insertions(+), 81 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index f1bdf18..bffc015 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -65,10 +65,18 @@ struct callback_data {
 	void *data;
 };
 
+struct pending_request;
+typedef int (*session_process_cb) (struct pending_request *pr, GError **err);
+
+typedef void (*process_free_cb)(void *process_data);
+
 struct pending_request {
 	guint id;
 	guint req_id;
 	struct obc_session *session;
+	session_process_cb process;
+	void *process_data;
+	process_free_cb process_free;
 	struct obc_transfer *transfer;
 	session_callback_t func;
 	void *data;
@@ -81,6 +89,11 @@ struct setpath_data {
 	void *user_data;
 };
 
+struct file_data {
+	char *srcname;
+	char *destname;
+};
+
 struct obc_session {
 	guint id;
 	int refcount;
@@ -140,6 +153,9 @@ static void session_unregistered(struct obc_session *session)
 }
 
 static struct pending_request *pending_request_new(struct obc_session *session,
+						session_process_cb process,
+						void *process_data,
+						process_free_cb process_free,
 						struct obc_transfer *transfer,
 						session_callback_t func,
 						void *data)
@@ -150,6 +166,9 @@ static struct pending_request *pending_request_new(struct obc_session *session,
 	p = g_new0(struct pending_request, 1);
 	p->id = ++id;
 	p->session = obc_session_ref(session);
+	p->process = process;
+	p->process_data = process_data;
+	p->process_free = process_free;
 	p->transfer = transfer;
 	p->func = func;
 	p->data = data;
@@ -159,6 +178,9 @@ static struct pending_request *pending_request_new(struct obc_session *session,
 
 static void pending_request_free(struct pending_request *p)
 {
+	if (p->process_free && p->process_data)
+		p->process_free(p->process_data);
+
 	if (p->transfer)
 		obc_transfer_unregister(p->transfer);
 
@@ -168,6 +190,23 @@ static void pending_request_free(struct pending_request *p)
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
+static void file_data_free(void *process_data)
+{
+	struct file_data *data = process_data;
+
+	g_free(data->srcname);
+	g_free(data->destname);
+	g_free(data);
+}
+
 static void session_free(struct obc_session *session)
 {
 	DBG("%p", session);
@@ -656,6 +695,15 @@ static gboolean session_queue_complete(gpointer data)
 	return FALSE;
 }
 
+static int session_process_transfer(struct pending_request *p, GError **err)
+{
+	if (obc_transfer_start(p->transfer, p->session->obex, err)) {
+		p->session->p = p;
+		return 0;
+	}
+	return -1;
+}
+
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
@@ -678,7 +726,8 @@ guint obc_session_queue(struct obc_session *session,
 
 	obc_transfer_set_callback(transfer, transfer_complete, session);
 
-	p = pending_request_new(session, transfer, func, user_data);
+	p = pending_request_new(session, session_process_transfer, NULL, NULL,
+						transfer, func, user_data);
 	g_queue_push_tail(session->queue, p);
 
 	if (session->queue_complete_id == 0)
@@ -703,12 +752,8 @@ static void session_process_queue(struct obc_session *session)
 	while ((p = g_queue_pop_head(session->queue))) {
 		GError *gerr = NULL;
 
-		DBG("Transfer(%p) started", p->transfer);
-
-		if (obc_transfer_start(p->transfer, session->obex, &gerr)) {
-			session->p = p;
+		if (p->process(p, &gerr) == 0)
 			break;
-		}
 
 		if (p->func)
 			p->func(session, p->transfer, gerr, p->data);
@@ -864,9 +909,6 @@ static void setpath_complete(struct obc_session *session,
 	if (data->func)
 		data->func(session, NULL, err, data->user_data);
 
-	g_strfreev(data->remaining);
-	g_free(data);
-
 	if (session->p == p)
 		session->p = NULL;
 
@@ -918,13 +960,35 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 	}
 }
 
+static int session_process_setpath(struct pending_request *p, GError **err)
+{
+	struct setpath_data *req = p->process_data;
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
@@ -932,38 +996,20 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
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
 
-	p = pending_request_new(session, NULL, setpath_complete, data);
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
+	p = pending_request_new(session, session_process_setpath, data,
+			setpath_data_free, NULL, setpath_complete, data);
+	g_queue_push_tail(session->queue, p);
 
-	session->p = p;
+	if (session->queue_complete_id == 0)
+		session->queue_complete_id = g_idle_add(
+					session_queue_complete, session);
 
 	return p->id;
-
-fail:
-	g_strfreev(data->remaining);
-	g_free(data);
-	pending_request_free(p);
-	return 0;
 }
 
 static void async_cb(GObex *obex, GError *err, GObexPacket *rsp,
@@ -1000,10 +1046,29 @@ done:
 	session_process_queue(session);
 }
 
+static int session_process_mkdir(struct pending_request *p, GError **err)
+{
+	struct file_data *req = p->process_data;
+
+	p->req_id = g_obex_mkdir(p->session->obex, req->srcname, async_cb, p,
+									err);
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
 guint obc_session_mkdir(struct obc_session *session, const char *folder,
 				session_callback_t func, void *user_data,
 				GError **err)
 {
+	struct file_data *data;
 	struct pending_request *p;
 
 	if (session->obex == NULL) {
@@ -1012,28 +1077,43 @@ guint obc_session_mkdir(struct obc_session *session, const char *folder,
 		return 0;
 	}
 
-	if (session->p != NULL) {
-		g_set_error(err, OBEX_IO_ERROR, OBEX_IO_BUSY, "Session busy");
-		return 0;
-	}
-
+	data = g_new0(struct file_data, 1);
+	data->srcname = g_strdup(folder);
 
-	p = pending_request_new(session, NULL, func, user_data);
+	p = pending_request_new(session, session_process_mkdir, data,
+					file_data_free, NULL, func, user_data);
+	g_queue_push_tail(session->queue, p);
 
-	p->req_id = g_obex_mkdir(session->obex, folder, async_cb, p, err);
-	if (*err != NULL) {
-		pending_request_free(p);
-		return 0;
-	}
+	if (session->queue_complete_id == 0)
+		session->queue_complete_id = g_idle_add(
+					session_queue_complete, session);
 
-	session->p = p;
 	return p->id;
 }
 
+static int session_process_copy(struct pending_request *p, GError **err)
+{
+	struct file_data *req = p->process_data;
+
+	p->req_id = g_obex_copy(p->session->obex, req->srcname, req->destname,
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
 guint obc_session_copy(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err)
 {
+	struct file_data *data;
 	struct pending_request *p;
 
 	if (session->obex == NULL) {
@@ -1042,28 +1122,44 @@ guint obc_session_copy(struct obc_session *session, const char *srcname,
 		return 0;
 	}
 
-	if (session->p != NULL) {
-		g_set_error(err, OBEX_IO_ERROR, OBEX_IO_BUSY, "Session busy");
-		return 0;
-	}
+	data = g_new0(struct file_data, 1);
+	data->srcname = g_strdup(srcname);
+	data->destname = g_strdup(destname);
 
-	p = pending_request_new(session, NULL, func, user_data);
+	p = pending_request_new(session, session_process_copy, data,
+					file_data_free, NULL, func, user_data);
+	g_queue_push_tail(session->queue, p);
 
-	p->req_id = g_obex_copy(session->obex, srcname, destname, async_cb, p,
-									err);
-	if (*err != NULL) {
-		pending_request_free(p);
-		return 0;
-	}
+	if (session->queue_complete_id == 0)
+		session->queue_complete_id = g_idle_add(
+					session_queue_complete, session);
 
-	session->p = p;
 	return p->id;
 }
 
+static int session_process_move(struct pending_request *p, GError **err)
+{
+	struct file_data *req = p->process_data;
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
@@ -1072,28 +1168,44 @@ guint obc_session_move(struct obc_session *session, const char *srcname,
 		return 0;
 	}
 
-	if (session->p != NULL) {
-		g_set_error(err, OBEX_IO_ERROR, OBEX_IO_BUSY, "Session busy");
-		return 0;
-	}
+	data = g_new0(struct file_data, 1);
+	data->srcname = g_strdup(srcname);
+	data->destname = g_strdup(destname);
 
-	p = pending_request_new(session, NULL, func, user_data);
+	p = pending_request_new(session, session_process_move, data,
+					file_data_free, NULL, func, user_data);
+	g_queue_push_tail(session->queue, p);
 
-	p->req_id = g_obex_move(session->obex, srcname, destname, async_cb, p,
-									err);
-	if (*err != NULL) {
-		pending_request_free(p);
-		return 0;
-	}
+	if (session->queue_complete_id == 0)
+		session->queue_complete_id = g_idle_add(
+					session_queue_complete, session);
 
-	session->p = p;
 	return p->id;
 }
 
+static int session_process_delete(struct pending_request *p, GError **err)
+{
+	struct file_data *req = p->process_data;
+
+	p->req_id = g_obex_delete(p->session->obex, req->srcname, async_cb, p,
+									err);
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
 guint obc_session_delete(struct obc_session *session, const char *file,
 				session_callback_t func, void *user_data,
 				GError **err)
 {
+	struct file_data *data;
 	struct pending_request *p;
 
 	if (session->obex == NULL) {
@@ -1102,20 +1214,17 @@ guint obc_session_delete(struct obc_session *session, const char *file,
 		return 0;
 	}
 
-	if (session->p != NULL) {
-		g_set_error(err, OBEX_IO_ERROR, OBEX_IO_BUSY, "Session busy");
-		return 0;
-	}
+	data = g_new0(struct file_data, 1);
+	data->srcname = g_strdup(file);
 
-	p = pending_request_new(session, NULL, func, user_data);
+	p = pending_request_new(session, session_process_delete, data,
+					file_data_free, NULL, func, user_data);
+	g_queue_push_tail(session->queue, p);
 
-	p->req_id = g_obex_delete(session->obex, file, async_cb, p, err);
-	if (*err != NULL) {
-		pending_request_free(p);
-		return 0;
-	}
+	if (session->queue_complete_id == 0)
+		session->queue_complete_id = g_idle_add(
+					session_queue_complete, session);
 
-	session->p = p;
 	return p->id;
 }
 
-- 
1.8.2.3

