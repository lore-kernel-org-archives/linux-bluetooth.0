Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 11/16] client: Remove obsolete authentication code
Date: Fri, 25 May 2012 12:11:28 +0200
Message-Id: <1337940693-3417-12-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

After the removal of the agent, the implementation of the session can be
simplified by removing all authentication-related code.
---
 client/session.c |   86 ++++++++++++++++-------------------------------------
 1 files changed, 26 insertions(+), 60 deletions(-)

diff --git a/client/session.c b/client/session.c
index 8e21da4..9670968 100644
--- a/client/session.c
+++ b/client/session.c
@@ -68,7 +68,6 @@ struct pending_request {
 	guint req_id;
 	struct obc_session *session;
 	struct obc_transfer *transfer;
-	GFunc auth_complete;
 	session_callback_t func;
 	void *data;
 };
@@ -95,11 +94,12 @@ struct obc_session {
 	gchar *owner;		/* Session owner */
 	guint watch;
 	GQueue *queue;
+	guint queue_complete_id;
 };
 
 static GSList *sessions = NULL;
 
-static void session_start_transfer(gpointer data, gpointer user_data);
+static void session_process_queue(struct obc_session *session);
 static void session_terminate_transfer(struct obc_session *session,
 					struct obc_transfer *transfer,
 					GError *gerr);
@@ -139,7 +139,6 @@ static void session_unregistered(struct obc_session *session)
 
 static struct pending_request *pending_request_new(struct obc_session *session,
 						struct obc_transfer *transfer,
-						GFunc auth_complete,
 						session_callback_t func,
 						void *data)
 {
@@ -150,7 +149,6 @@ static struct pending_request *pending_request_new(struct obc_session *session,
 	p->id = ++id;
 	p->session = obc_session_ref(session);
 	p->transfer = transfer;
-	p->auth_complete = auth_complete;
 	p->func = func;
 	p->data = data;
 
@@ -172,6 +170,9 @@ static void session_free(struct obc_session *session)
 {
 	DBG("%p", session);
 
+	if (session->queue_complete_id != 0)
+		g_source_remove(session->queue_complete_id);
+
 	if (session->queue) {
 		g_queue_foreach(session->queue, (GFunc) pending_request_free,
 									NULL);
@@ -629,22 +630,15 @@ static const GDBusMethodTable session_methods[] = {
 	{ }
 };
 
-static gboolean session_request_proceed(gpointer data)
+static gboolean session_queue_complete(gpointer data)
 {
 	struct obc_session *session = data;
-	struct pending_request *p = session->p;
-	struct obc_transfer *transfer = p->transfer;
 
-	if (p->auth_complete)
-		p->auth_complete(p->session, transfer);
+	session_process_queue(session);
 
-	return FALSE;
-}
+	session->queue_complete_id = 0;
 
-static int pending_request_auth(struct pending_request *p)
-{
-	g_idle_add(session_request_proceed, p->session);
-	return 0;
+	return FALSE;
 }
 
 guint obc_session_queue(struct obc_session *session,
@@ -653,7 +647,6 @@ guint obc_session_queue(struct obc_session *session,
 				GError **err)
 {
 	struct pending_request *p;
-	int perr;
 
 	if (session->obex == NULL) {
 		obc_transfer_unregister(transfer);
@@ -670,21 +663,12 @@ guint obc_session_queue(struct obc_session *session,
 
 	obc_transfer_set_callback(transfer, transfer_complete, session);
 
-	p = pending_request_new(session, transfer, session_start_transfer,
-							func, user_data);
-	if (session->p) {
-		g_queue_push_tail(session->queue, p);
-		return p->id;
-	}
-
-	perr = pending_request_auth(p);
-	if (perr < 0) {
-		g_set_error(err, OBEX_IO_ERROR, perr, "Authorization failed");
-		pending_request_free(p);
-		return 0;
-	}
+	p = pending_request_new(session, transfer, func, user_data);
+	g_queue_push_tail(session->queue, p);
 
-	session->p = p;
+	if (session->queue_complete_id == 0)
+		session->queue_complete_id = g_idle_add(
+					session_queue_complete, session);
 
 	return p->id;
 }
@@ -702,22 +686,19 @@ static void session_process_queue(struct obc_session *session)
 	obc_session_ref(session);
 
 	while ((p = g_queue_pop_head(session->queue))) {
-		int err;
+		GError *gerr = NULL;
+
+		DBG("Transfer(%p) started", p->transfer);
 
-		err = pending_request_auth(p);
-		if (err == 0) {
+		if (obc_transfer_start(p->transfer, session->obex, &gerr)) {
 			session->p = p;
 			break;
 		}
 
-		if (p->func) {
-			GError *gerr = NULL;
-
-			g_set_error(&gerr, OBEX_IO_ERROR, err,
-							"Authorization failed");
+		if (p->func)
 			p->func(session, p->transfer, gerr, p->data);
-			g_error_free(gerr);
-		}
+
+		g_clear_error(&gerr);
 
 		pending_request_free(p);
 	}
@@ -801,21 +782,6 @@ fail:
 	session_notify_error(session, transfer, err);
 }
 
-static void session_start_transfer(gpointer data, gpointer user_data)
-{
-	struct obc_session *session = data;
-	struct obc_transfer *transfer = user_data;
-	GError *err = NULL;
-
-	if (!obc_transfer_start(transfer, session->obex, &err)) {
-		session_notify_error(session, transfer, err);
-		g_clear_error(&err);
-		return;
-	}
-
-	DBG("Transfer(%p) started", transfer);
-}
-
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy)
 {
@@ -950,7 +916,7 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
 	data->user_data = user_data;
 	data->remaining = g_strsplit(path, "/", 3);
 
-	p = pending_request_new(session, NULL, NULL, setpath_complete, data);
+	p = pending_request_new(session, NULL, setpath_complete, data);
 
 	/* Relative path */
 	if (path[0] != '/') {
@@ -1025,7 +991,7 @@ guint obc_session_mkdir(struct obc_session *session, const char *folder,
 	}
 
 
-	p = pending_request_new(session, NULL, NULL, func, user_data);
+	p = pending_request_new(session, NULL, func, user_data);
 
 	p->req_id = g_obex_mkdir(session->obex, folder, async_cb, p, err);
 	if (*err != NULL) {
@@ -1054,7 +1020,7 @@ guint obc_session_copy(struct obc_session *session, const char *srcname,
 		return 0;
 	}
 
-	p = pending_request_new(session, NULL, NULL, func, user_data);
+	p = pending_request_new(session, NULL, func, user_data);
 
 	p->req_id = g_obex_copy(session->obex, srcname, destname, async_cb, p,
 									err);
@@ -1084,7 +1050,7 @@ guint obc_session_move(struct obc_session *session, const char *srcname,
 		return 0;
 	}
 
-	p = pending_request_new(session, NULL, NULL, func, user_data);
+	p = pending_request_new(session, NULL, func, user_data);
 
 	p->req_id = g_obex_move(session->obex, srcname, destname, async_cb, p,
 									err);
@@ -1114,7 +1080,7 @@ guint obc_session_delete(struct obc_session *session, const char *file,
 		return 0;
 	}
 
-	p = pending_request_new(session, NULL, NULL, func, user_data);
+	p = pending_request_new(session, NULL, func, user_data);
 
 	p->req_id = g_obex_delete(session->obex, file, async_cb, p, err);
 	if (*err != NULL) {
-- 
1.7.7.6

