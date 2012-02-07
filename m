Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 03/13 v2] client: fix not queuing requests properly
Date: Tue,  7 Feb 2012 16:25:42 +0200
Message-Id: <1328624752-26061-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
References: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

OBEX does not support requests in parallel so they have to be queued
like in SendFiles.
---
 client/session.c |  266 +++++++++++++++++++++++++-----------------------------
 1 files changed, 124 insertions(+), 142 deletions(-)

diff --git a/client/session.c b/client/session.c
index 92ae8cf..482ee20 100644
--- a/client/session.c
+++ b/client/session.c
@@ -60,10 +60,12 @@ struct session_callback {
 	void *data;
 };
 
-struct pending_data {
-	session_callback_t cb;
+struct pending_request {
 	struct obc_session *session;
 	struct obc_transfer *transfer;
+	GFunc auth_complete;
+	session_callback_t func;
+	void *data;
 };
 
 struct obc_session {
@@ -78,16 +80,15 @@ struct obc_session {
 	DBusConnection *conn;
 	GObex *obex;
 	struct obc_agent *agent;
-	struct session_callback *callback;
+	struct pending_request *p;
 	gchar *owner;		/* Session owner */
 	guint watch;
-	GSList *pending;
+	GQueue *queue;
 };
 
 static GSList *sessions = NULL;
 
-static void session_prepare_put(struct obc_session *session, GError *err,
-								void *data);
+static void session_prepare_put(gpointer data, gpointer user_data);
 static void session_terminate_transfer(struct obc_session *session,
 					struct obc_transfer *transfer,
 					GError *gerr);
@@ -123,6 +124,17 @@ static void session_unregistered(struct obc_session *session)
 	g_free(path);
 }
 
+static void pending_request_free(struct pending_request *p)
+{
+	if (p->transfer)
+		obc_transfer_unregister(p->transfer);
+
+	if (p->session)
+		obc_session_unref(p->session);
+
+	g_free(p);
+}
+
 static void session_free(struct obc_session *session)
 {
 	DBG("%p", session);
@@ -132,6 +144,12 @@ static void session_free(struct obc_session *session)
 		obc_agent_free(session->agent);
 	}
 
+	if (session->queue) {
+		g_queue_foreach(session->queue, (GFunc) pending_request_free,
+									NULL);
+		g_queue_free(session->queue);
+	}
+
 	if (session->watch)
 		g_dbus_remove_watch(session->conn, session->watch);
 
@@ -147,9 +165,11 @@ static void session_free(struct obc_session *session)
 	if (session->conn)
 		dbus_connection_unref(session->conn);
 
+	if (session->p)
+		pending_request_free(session->p);
+
 	sessions = g_slist_remove(sessions, session);
 
-	g_free(session->callback);
 	g_free(session->path);
 	g_free(session->owner);
 	g_free(session->source);
@@ -398,6 +418,7 @@ struct obc_session *obc_session_create(const char *source,
 	session->source = g_strdup(source);
 	session->destination = g_strdup(destination);
 	session->channel = channel;
+	session->queue = g_queue_new();
 
 	if (owner)
 		obc_session_set_owner(session, owner, owner_disconnected);
@@ -414,37 +435,14 @@ proceed:
 	return session;
 }
 
-static void obc_session_add_transfer(struct obc_session *session,
-						struct obc_transfer *transfer)
-{
-	session->pending = g_slist_append(session->pending, transfer);
-	obc_session_ref(session);
-}
-
-static void obc_session_remove_transfer(struct obc_session *session,
-						struct obc_transfer *transfer)
-{
-	session->pending = g_slist_remove(session->pending, transfer);
-	obc_transfer_unregister(transfer);
-	obc_session_unref(session);
-}
-
 void obc_session_shutdown(struct obc_session *session)
 {
-	GSList *l = session->pending;
-
 	DBG("%p", session);
 
 	obc_session_ref(session);
 
 	/* Unregister any pending transfer */
-	while (l) {
-		struct obc_transfer *transfer = l->data;
-
-		l = l->next;
-
-		obc_session_remove_transfer(session, transfer);
-	}
+	g_queue_foreach(session->queue, (GFunc) pending_request_free, NULL);
 
 	/* Unregister interfaces */
 	if (session->path)
@@ -588,8 +586,9 @@ static GDBusMethodTable session_methods[] = {
 
 static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 {
-	struct pending_data *pending = user_data;
-	struct obc_session *session = pending->session;
+	struct obc_session *session = user_data;
+	struct pending_request *p = session->p;
+	struct obc_transfer *transfer = p->transfer;
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
 	const char *name;
 	DBusError derr;
@@ -605,7 +604,7 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 
 		g_set_error(&gerr, OBEX_IO_ERROR, -ECANCELED, "%s",
 								derr.message);
-		session_terminate_transfer(session, pending->transfer, gerr);
+		session_terminate_transfer(session, transfer, gerr);
 		g_clear_error(&gerr);
 
 		return;
@@ -618,9 +617,11 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 	DBG("Agent.Request() reply: %s", name);
 
 	if (strlen(name))
-		obc_transfer_set_name(pending->transfer, name);
+		obc_transfer_set_name(transfer, name);
+
+	if (p->auth_complete)
+		p->auth_complete(session, transfer);
 
-	pending->cb(session, NULL, pending->transfer);
 	dbus_message_unref(reply);
 
 	return;
@@ -628,74 +629,103 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 
 static gboolean session_request_proceed(gpointer data)
 {
-	struct pending_data *pending = data;
-	struct obc_transfer *transfer = pending->transfer;
+	struct obc_session *session = data;
+	struct pending_request *p = session->p;
+	struct obc_transfer *transfer = p->transfer;
 
-	pending->cb(pending->session, NULL, transfer);
-	g_free(pending);
+	if (p->auth_complete)
+		p->auth_complete(p->session, transfer);
 
 	return FALSE;
 }
 
-static int session_request(struct obc_session *session, session_callback_t cb,
-				struct obc_transfer *transfer)
+static int pending_request_auth(struct pending_request *p)
 {
+	struct obc_session *session = p->session;
 	struct obc_agent *agent = session->agent;
-	struct pending_data *pending;
 	const char *path;
-	int err;
-
-	pending = g_new0(struct pending_data, 1);
-	pending->cb = cb;
-	pending->session = session;
-	pending->transfer = transfer;
 
-	path = obc_transfer_get_path(transfer);
+	path = obc_transfer_get_path(p->transfer);
 
 	if (agent == NULL || path == NULL) {
-		g_idle_add(session_request_proceed, pending);
+		g_idle_add(session_request_proceed, session);
 		return 0;
 	}
 
-	err = obc_agent_request(agent, path, session_request_reply, pending,
-								g_free);
+	return obc_agent_request(agent, path, session_request_reply, session,
+									NULL);
+}
+
+static int session_request(struct obc_session *session,
+					struct obc_transfer *transfer,
+					GFunc auth_complete,
+					session_callback_t func,
+					void *data)
+{
+	struct pending_request *p;
+	int err;
+
+	p = g_new0(struct pending_request, 1);
+	p->session = obc_session_ref(session);
+	p->transfer = transfer;
+	p->auth_complete = auth_complete;
+	p->func = func;
+	p->data = data;
+
+	if (session->p) {
+		g_queue_push_tail(session->queue, p);
+		return 0;
+	}
+
+	err = pending_request_auth(p);
 	if (err < 0) {
-		g_free(pending);
+		pending_request_free(p);
 		return err;
 	}
 
+	session->p = p;
+
 	return 0;
 }
 
+static void session_process_queue(struct obc_session *session)
+{
+	struct pending_request *p;
+
+	if (session->queue == NULL || g_queue_is_empty(session->queue))
+		return;
+
+	while ((p = g_queue_pop_head(session->queue))) {
+		int err;
+
+		err = pending_request_auth(p);
+		if (err == 0) {
+			session->p = p;
+			return;
+		}
+
+		pending_request_free(p);
+	}
+}
+
 static void session_terminate_transfer(struct obc_session *session,
 					struct obc_transfer *transfer,
 					GError *gerr)
 {
-	struct session_callback *callback = session->callback;
+	struct pending_request *p = session->p;
 
-	if (callback) {
-		obc_session_ref(session);
-		callback->func(session, gerr, callback->data);
-		if (g_slist_find(session->pending, transfer))
-			obc_session_remove_transfer(session, transfer);
-		obc_session_unref(session);
+	if (p == NULL || p->transfer != transfer)
 		return;
-	}
 
 	obc_session_ref(session);
 
-	obc_session_remove_transfer(session, transfer);
-
-	while (session->pending != NULL) {
-		struct obc_transfer *transfer = session->pending->data;
-		int err;
+	if (p->func)
+		p->func(session, gerr, p->data);
 
-		err = session_request(session, session_prepare_put, transfer);
-		if (err == 0)
-			break;
+	pending_request_free(p);
+	session->p = NULL;
 
-		obc_session_remove_transfer(session, transfer);
-	}
+	session_process_queue(session);
 
 	obc_session_unref(session);
 }
@@ -777,10 +807,10 @@ fail:
 	session_notify_error(session, transfer, err);
 }
 
-static void session_prepare_get(struct obc_session *session,
-				GError *err, void *data)
+static void session_prepare_get(gpointer data, gpointer user_data)
 {
-	struct obc_transfer *transfer = data;
+	struct obc_session *session = data;
+	struct obc_transfer *transfer = user_data;
 	int ret;
 
 	ret = obc_transfer_get(transfer, transfer_progress, session);
@@ -804,7 +834,6 @@ int obc_session_get(struct obc_session *session, const char *type,
 	struct obc_transfer *transfer;
 	struct obc_transfer_params *params = NULL;
 	const char *agent;
-	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
@@ -833,23 +862,8 @@ int obc_session_get(struct obc_session *session, const char *type,
 		return -EIO;
 	}
 
-	if (func != NULL) {
-		struct session_callback *callback;
-		callback = g_new0(struct session_callback, 1);
-		callback->func = func;
-		callback->data = user_data;
-		session->callback = callback;
-	}
-
-	err = session_request(session, session_prepare_get, transfer);
-	if (err < 0) {
-		obc_transfer_unregister(transfer);
-		return err;
-	}
-
-	obc_session_add_transfer(session, transfer);
-
-	return 0;
+	return session_request(session, transfer, session_prepare_get,
+							func, user_data);
 }
 
 int obc_session_send(struct obc_session *session, const char *filename,
@@ -872,26 +886,13 @@ int obc_session_send(struct obc_session *session, const char *filename,
 		return -EINVAL;
 
 	err = obc_transfer_set_file(transfer);
-	if (err < 0)
-		goto fail;
-
-	/* Transfer should start if it is the first in the pending list */
-	if (session->pending != NULL)
-		goto done;
-
-	err = session_request(session, session_prepare_put, transfer);
-	if (err < 0)
-		goto fail;
-
-done:
-	obc_session_add_transfer(session, transfer);
-
-	return 0;
-
-fail:
-	obc_transfer_unregister(transfer);
+	if (err < 0) {
+		obc_transfer_unregister(transfer);
+		return err;
+	}
 
-	return err;
+	return session_request(session, transfer, session_prepare_put,
+								NULL, NULL);
 }
 
 int obc_session_pull(struct obc_session *session,
@@ -900,7 +901,6 @@ int obc_session_pull(struct obc_session *session,
 {
 	struct obc_transfer *transfer;
 	const char *agent;
-	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
@@ -918,22 +918,8 @@ int obc_session_pull(struct obc_session *session,
 		return -EIO;
 	}
 
-	if (function != NULL) {
-		struct session_callback *callback;
-		callback = g_new0(struct session_callback, 1);
-		callback->func = function;
-		callback->data = user_data;
-		session->callback = callback;
-	}
-
-	err = session_request(session, session_prepare_get, transfer);
-	if (err == 0) {
-		obc_session_add_transfer(session, transfer);
-		return 0;
-	}
-
-	obc_transfer_unregister(transfer);
-	return err;
+	return session_request(session, transfer, session_prepare_get,
+							function, user_data);
 }
 
 const char *obc_session_register(struct obc_session *session,
@@ -966,10 +952,10 @@ fail:
 	return NULL;
 }
 
-static void session_prepare_put(struct obc_session *session,
-				GError *err, void *data)
+static void session_prepare_put(gpointer data, gpointer user_data)
 {
-	struct obc_transfer *transfer = data;
+	struct obc_session *session = data;
+	struct obc_transfer *transfer = user_data;
 	int ret;
 
 	ret = obc_transfer_put(transfer, transfer_progress, session);
@@ -990,14 +976,10 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
 {
 	struct obc_transfer *transfer;
 	const char *agent;
-	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
-	if (session->pending != NULL)
-		return -EISCONN;
-
 	agent = obc_agent_get_name(session->agent);
 
 	transfer = obc_transfer_register(session->conn, session->obex,
@@ -1009,11 +991,8 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
 
 	obc_transfer_set_buffer(transfer, buf);
 
-	err = session_request(session, session_prepare_put, transfer);
-	if (err < 0)
-		return err;
-
-	return 0;
+	return session_request(session, transfer, session_prepare_put,
+								NULL, NULL);
 }
 
 static void agent_destroy(gpointer data, gpointer user_data)
@@ -1085,7 +1064,10 @@ GObex *obc_session_get_obex(struct obc_session *session)
 static struct obc_transfer *obc_session_get_transfer(
 						struct obc_session *session)
 {
-	return session->pending ? session->pending->data : NULL;
+	if (session->p == NULL)
+		return NULL;
+
+	return session->p->transfer;
 }
 
 const char *obc_session_get_buffer(struct obc_session *session, size_t *size)
-- 
1.7.7.6

