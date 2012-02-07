Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 04/13 v2] client: introduce obc_session_setpath
Date: Tue,  7 Feb 2012 16:25:43 +0200
Message-Id: <1328624752-26061-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
References: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/session.c |  148 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 client/session.h |    4 ++
 2 files changed, 146 insertions(+), 6 deletions(-)

diff --git a/client/session.c b/client/session.c
index 482ee20..a4d9f4f 100644
--- a/client/session.c
+++ b/client/session.c
@@ -61,6 +61,8 @@ struct session_callback {
 };
 
 struct pending_request {
+	guint id;
+	guint req_id;
 	struct obc_session *session;
 	struct obc_transfer *transfer;
 	GFunc auth_complete;
@@ -68,6 +70,13 @@ struct pending_request {
 	void *data;
 };
 
+struct setpath_data {
+	char **remaining;
+	int index;
+	session_callback_t func;
+	void *user_data;
+};
+
 struct obc_session {
 	guint id;
 	gint refcount;
@@ -124,6 +133,26 @@ static void session_unregistered(struct obc_session *session)
 	g_free(path);
 }
 
+static struct pending_request *pending_request_new(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GFunc auth_complete,
+						session_callback_t func,
+						void *data)
+{
+	struct pending_request *p;
+	static guint id = 0;
+
+	p = g_new0(struct pending_request, 1);
+	p->id = ++id;
+	p->session = obc_session_ref(session);
+	p->transfer = transfer;
+	p->auth_complete = auth_complete;
+	p->func = func;
+	p->data = data;
+
+	return p;
+}
+
 static void pending_request_free(struct pending_request *p)
 {
 	if (p->transfer)
@@ -665,12 +694,7 @@ static int session_request(struct obc_session *session,
 	struct pending_request *p;
 	int err;
 
-	p = g_new0(struct pending_request, 1);
-	p->session = obc_session_ref(session);
-	p->transfer = transfer;
-	p->auth_complete = auth_complete;
-	p->func = func;
-	p->data = data;
+	p = pending_request_new(session, transfer, auth_complete, func, data);
 
 	if (session->p) {
 		g_queue_push_tail(session->queue, p);
@@ -1103,3 +1127,115 @@ void *obc_session_get_params(struct obc_session *session, size_t *size)
 
 	return params.data;
 }
+
+static void setpath_complete(struct obc_session *session, GError *err,
+							void *user_data)
+{
+	struct pending_request *p = user_data;
+	struct setpath_data *data = p->data;
+
+	if (data->func)
+		data->func(session, err, data->user_data);
+
+	g_strfreev(data->remaining);
+	g_free(data);
+
+	if (session->p == p)
+		session->p = NULL;
+
+	pending_request_free(p);
+
+	session_process_queue(session);
+}
+
+static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	struct pending_request *p = user_data;
+	struct setpath_data *data = p->data;
+	char *next;
+	guint8 code;
+
+	p->req_id = 0;
+
+	if (err != NULL) {
+		setpath_complete(p->session, err, user_data);
+		return;
+	}
+
+	code = g_obex_packet_get_operation(rsp, NULL);
+	if (code != G_OBEX_RSP_SUCCESS) {
+		GError *gerr = NULL;
+		g_set_error(&gerr, OBEX_IO_ERROR, code, "%s",
+							g_obex_strerror(code));
+		setpath_complete(p->session, err, user_data);
+		g_clear_error(&gerr);
+		return;
+	}
+
+	next = data->remaining[data->index];
+	if (next == NULL) {
+		setpath_complete(p->session, NULL, user_data);
+		return;
+	}
+
+	data->index++;
+
+	p->req_id = g_obex_setpath(obex, next, setpath_cb, p, &err);
+	if (err != NULL) {
+		setpath_complete(p->session, err, data);
+		g_error_free(err);
+	}
+}
+
+guint obc_session_setpath(struct obc_session *session, const char *path,
+				session_callback_t func, void *user_data,
+				GError **err)
+{
+	struct setpath_data *data;
+	struct pending_request *p;
+	const char *first = "";
+
+	if (session->obex == NULL) {
+		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
+							strerror(-ENOTCONN));
+		return 0;
+	}
+
+	if (session->p != NULL) {
+		g_set_error(err, OBEX_IO_ERROR, -EBUSY, strerror(-EBUSY));
+		return 0;
+	}
+
+	data = g_new0(struct setpath_data, 1);
+	data->func = func;
+	data->user_data = user_data;
+	data->remaining = g_strsplit(path, "/", 3);
+
+	p = pending_request_new(session, NULL, NULL, setpath_complete, data);
+
+	/* Relative path */
+	if (path[0] != '/') {
+		first = data->remaining[data->index];
+		data->index++;
+	}
+
+	if (first == NULL) {
+		g_set_error(err, OBEX_IO_ERROR, -EINVAL, strerror(-EINVAL));
+		goto fail;
+	}
+
+	p->req_id = g_obex_setpath(session->obex, first, setpath_cb, p, err);
+	if (*err != NULL)
+		goto fail;
+
+	session->p = p;
+
+	return p->id;
+
+fail:
+	g_strfreev(data->remaining);
+	g_free(data);
+	pending_request_free(p);
+	return 0;
+}
diff --git a/client/session.h b/client/session.h
index 511f084..65cf4bd 100644
--- a/client/session.h
+++ b/client/session.h
@@ -73,3 +73,7 @@ const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
 int obc_session_put(struct obc_session *session, char *buf,
 				const char *targetname);
+
+guint obc_session_setpath(struct obc_session *session, const char *path,
+				session_callback_t func, void *user_data,
+				GError **err);
-- 
1.7.7.6

