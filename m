Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 3/4] client: refactor naming convention in session api
Date: Wed,  7 Mar 2012 15:50:28 +0100
Message-Id: <1331131829-28509-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The terms "name", "filename" and "targetname" are used in session.h that
can be confusing. This patch proposes to follow the terminology in the
D-Bus api:
	- Name: the remote name of the object being transferred
	- Filename: the local filesystem name of a file being sent
	- Targetfile: the local filesystem name of a file being
		received
---
 client/session.c |   29 ++++++++++++++---------------
 client/session.h |   12 ++++++------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/client/session.c b/client/session.c
index 28fae03..e130427 100644
--- a/client/session.c
+++ b/client/session.c
@@ -935,7 +935,7 @@ static void session_prepare_get(gpointer data, gpointer user_data)
 }
 
 int obc_session_get(struct obc_session *session, const char *type,
-		const char *filename, const char *targetname,
+		const char *name, const char *targetfile,
 		const guint8 *apparam, gint apparam_size,
 		session_callback_t func, void *user_data)
 {
@@ -959,9 +959,8 @@ int obc_session_get(struct obc_session *session, const char *type,
 		agent = NULL;
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, targetname,
-							filename, type,
-							params);
+							agent, targetfile,
+							name, type, params);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
@@ -975,7 +974,7 @@ int obc_session_get(struct obc_session *session, const char *type,
 }
 
 int obc_session_send(struct obc_session *session, const char *filename,
-				const char *targetname)
+				const char *name)
 {
 	struct obc_transfer *transfer;
 	const char *agent;
@@ -988,8 +987,7 @@ int obc_session_send(struct obc_session *session, const char *filename,
 
 	transfer = obc_transfer_register(session->conn, session->obex,
 							agent, filename,
-							targetname, NULL,
-							NULL);
+							name, NULL, NULL);
 	if (transfer == NULL)
 		return -EINVAL;
 
@@ -1004,7 +1002,7 @@ int obc_session_send(struct obc_session *session, const char *filename,
 }
 
 int obc_session_pull(struct obc_session *session,
-				const char *type, const char *filename,
+				const char *type, const char *targetfile,
 				session_callback_t function, void *user_data)
 {
 	struct obc_transfer *transfer;
@@ -1019,7 +1017,8 @@ int obc_session_pull(struct obc_session *session,
 		agent = NULL;
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-								agent, filename,
+								agent,
+								targetfile,
 								NULL, type,
 								NULL);
 	if (transfer == NULL) {
@@ -1080,7 +1079,7 @@ static void session_prepare_put(gpointer data, gpointer user_data)
 	DBG("Transfer(%p) started", transfer);
 }
 
-int obc_session_put(struct obc_session *session, char *buf, const char *targetname)
+int obc_session_put(struct obc_session *session, char *buf, const char *name)
 {
 	struct obc_transfer *transfer;
 	const char *agent;
@@ -1094,7 +1093,7 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
 
 	transfer = obc_transfer_register(session->conn, session->obex,
 							agent, NULL,
-							targetname, NULL,
+							name, NULL,
 							NULL);
 	if (transfer == NULL) {
 		g_free(buf);
@@ -1387,7 +1386,7 @@ guint obc_session_mkdir(struct obc_session *session, const char *folder,
 	return p->id;
 }
 
-guint obc_session_copy(struct obc_session *session, const char *filename,
+guint obc_session_copy(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err)
 {
@@ -1406,7 +1405,7 @@ guint obc_session_copy(struct obc_session *session, const char *filename,
 
 	p = pending_request_new(session, NULL, NULL, func, user_data);
 
-	p->req_id = g_obex_copy(session->obex, filename, destname, async_cb, p,
+	p->req_id = g_obex_copy(session->obex, srcname, destname, async_cb, p,
 									err);
 	if (*err != NULL) {
 		pending_request_free(p);
@@ -1417,7 +1416,7 @@ guint obc_session_copy(struct obc_session *session, const char *filename,
 	return p->id;
 }
 
-guint obc_session_move(struct obc_session *session, const char *filename,
+guint obc_session_move(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err)
 {
@@ -1436,7 +1435,7 @@ guint obc_session_move(struct obc_session *session, const char *filename,
 
 	p = pending_request_new(session, NULL, NULL, func, user_data);
 
-	p->req_id = g_obex_move(session->obex, filename, destname, async_cb, p,
+	p->req_id = g_obex_move(session->obex, srcname, destname, async_cb, p,
 									err);
 	if (*err != NULL) {
 		pending_request_free(p);
diff --git a/client/session.h b/client/session.h
index a19b31f..4bfb41d 100644
--- a/client/session.h
+++ b/client/session.h
@@ -56,18 +56,18 @@ const char *obc_session_get_buffer(struct obc_session *session, size_t *size);
 void *obc_session_get_params(struct obc_session *session, size_t *size);
 
 int obc_session_send(struct obc_session *session, const char *filename,
-				const char *remotename);
+				const char *name);
 int obc_session_get(struct obc_session *session, const char *type,
-		const char *filename, const char *targetname,
+		const char *name, const char *targetfile,
 		const guint8  *apparam, gint apparam_size,
 		session_callback_t func, void *user_data);
 int obc_session_pull(struct obc_session *session,
-				const char *type, const char *filename,
+				const char *type, const char *targetfile,
 				session_callback_t function, void *user_data);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
 int obc_session_put(struct obc_session *session, char *buf,
-				const char *targetname);
+				const char *name);
 
 guint obc_session_setpath(struct obc_session *session, const char *path,
 				session_callback_t func, void *user_data,
@@ -75,10 +75,10 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
 guint obc_session_mkdir(struct obc_session *session, const char *folder,
 				session_callback_t func, void *user_data,
 				GError **err);
-guint obc_session_copy(struct obc_session *session, const char *filename,
+guint obc_session_copy(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err);
-guint obc_session_move(struct obc_session *session, const char *filename,
+guint obc_session_move(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err);
 guint obc_session_delete(struct obc_session *session, const char *file,
-- 
1.7.6.5

