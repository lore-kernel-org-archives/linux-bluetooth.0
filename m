Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2 v2] client: Return request id when generating a request in session API
Date: Thu, 26 Apr 2012 18:11:05 +0300
Message-Id: <1335453065-12641-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1335453065-12641-1-git-send-email-luiz.dentz@gmail.com>
References: <1335453065-12641-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is more consistent with other functions and allow the caller to
cancel the request using obc_session_cancel.
---
 client/session.c |   28 ++++++++++++++--------------
 client/session.h |    8 ++++----
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/client/session.c b/client/session.c
index b9c37a1..e277fa0 100644
--- a/client/session.c
+++ b/client/session.c
@@ -743,7 +743,7 @@ static int pending_request_auth(struct pending_request *p)
 									NULL);
 }
 
-static gboolean session_request(struct obc_session *session,
+static guint session_request(struct obc_session *session,
 					struct obc_transfer *transfer,
 					session_callback_t func,
 					void *data, GError **err)
@@ -757,19 +757,19 @@ static gboolean session_request(struct obc_session *session,
 								func, data);
 	if (session->p) {
 		g_queue_push_tail(session->queue, p);
-		return TRUE;
+		return p->id;
 	}
 
 	perr = pending_request_auth(p);
 	if (perr < 0) {
 		g_set_error(err, OBEX_IO_ERROR, perr, "Authorization failed");
 		pending_request_free(p);
-		return FALSE;
+		return 0;
 	}
 
 	session->p = p;
 
-	return TRUE;
+	return p->id;
 }
 
 static void session_process_queue(struct obc_session *session)
@@ -946,7 +946,7 @@ static void session_start_transfer(gpointer data, gpointer user_data)
 	DBG("Transfer(%p) started", transfer);
 }
 
-gboolean obc_session_get(struct obc_session *session, const char *type,
+guint obc_session_get(struct obc_session *session, const char *type,
 				const char *name, const char *targetfile,
 				const guint8 *apparam, gint apparam_size,
 				session_callback_t func, void *user_data,
@@ -959,7 +959,7 @@ gboolean obc_session_get(struct obc_session *session, const char *type,
 	if (session->obex == NULL) {
 		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
 						"Session not connected");
-		return FALSE;
+		return 0;
 	}
 
 	if (apparam != NULL) {
@@ -981,13 +981,13 @@ gboolean obc_session_get(struct obc_session *session, const char *type,
 			g_free(params->data);
 			g_free(params);
 		}
-		return FALSE;
+		return 0;
 	}
 
 	return session_request(session, transfer, func, user_data, err);
 }
 
-gboolean obc_session_send(struct obc_session *session, const char *filename,
+guint obc_session_send(struct obc_session *session, const char *filename,
 				const char *name, GError **err)
 {
 	struct obc_transfer *transfer;
@@ -996,7 +996,7 @@ gboolean obc_session_send(struct obc_session *session, const char *filename,
 	if (session->obex == NULL) {
 		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
 						"Session not connected");
-		return FALSE;
+		return 0;
 	}
 
 	agent = obc_agent_get_name(session->agent);
@@ -1004,12 +1004,12 @@ gboolean obc_session_send(struct obc_session *session, const char *filename,
 	transfer = obc_transfer_put(session->conn, agent, filename, name,
 					NULL, NULL, 0, NULL, err);
 	if (transfer == NULL)
-		return FALSE;
+		return 0;
 
 	return session_request(session, transfer, NULL, NULL, err);
 }
 
-gboolean obc_session_pull(struct obc_session *session,
+guint obc_session_pull(struct obc_session *session,
 				const char *type, const char *targetfile,
 				session_callback_t function, void *user_data,
 				GError **err)
@@ -1048,7 +1048,7 @@ fail:
 	return NULL;
 }
 
-gboolean obc_session_put(struct obc_session *session, const char *contents,
+guint obc_session_put(struct obc_session *session, const char *contents,
 				size_t size, const char *name, GError **err)
 {
 	struct obc_transfer *transfer;
@@ -1057,7 +1057,7 @@ gboolean obc_session_put(struct obc_session *session, const char *contents,
 	if (session->obex == NULL) {
 		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
 						"Session not connected");
-		return FALSE;
+		return 0;
 	}
 
 	agent = obc_agent_get_name(session->agent);
@@ -1065,7 +1065,7 @@ gboolean obc_session_put(struct obc_session *session, const char *contents,
 	transfer = obc_transfer_put(session->conn, agent, NULL, name, NULL,
 						contents, size, NULL, err);
 	if (transfer == NULL)
-		return FALSE;
+		return 0;
 
 	return session_request(session, transfer, NULL, NULL, err);
 }
diff --git a/client/session.h b/client/session.h
index a0ee321..c443392 100644
--- a/client/session.h
+++ b/client/session.h
@@ -56,20 +56,20 @@ int obc_session_get_contents(struct obc_session *session, char **contents,
 								size_t *size);
 void *obc_session_get_params(struct obc_session *session, size_t *size);
 
-gboolean obc_session_send(struct obc_session *session, const char *filename,
+guint obc_session_send(struct obc_session *session, const char *filename,
 				const char *name, GError **err);
-gboolean obc_session_get(struct obc_session *session, const char *type,
+guint obc_session_get(struct obc_session *session, const char *type,
 				const char *name, const char *targetfile,
 				const guint8  *apparam, gint apparam_size,
 				session_callback_t func, void *user_data,
 				GError **err);
-gboolean obc_session_pull(struct obc_session *session,
+guint obc_session_pull(struct obc_session *session,
 				const char *type, const char *targetfile,
 				session_callback_t function, void *user_data,
 				GError **err);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
-gboolean obc_session_put(struct obc_session *session, const char *contents,
+guint obc_session_put(struct obc_session *session, const char *contents,
 				size_t size, const char *name, GError **err);
 
 guint obc_session_setpath(struct obc_session *session, const char *path,
-- 
1.7.7.6

