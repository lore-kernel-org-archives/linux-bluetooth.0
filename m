Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 3/6] client: Transfer API splits create and register
Date: Fri,  4 May 2012 14:39:35 +0200
Message-Id: <1336135178-21707-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The transfer-creating functions (obc_transfer_get and obc_transfer_put)
no longer register the transfer automatically.

This separation makes it possible that the modules would create the
transfers and then pass the object to the session, which would be
responsible for the registration.
---
 client/session.c  |   33 +++++++++++++++------------------
 client/transfer.c |   20 +++-----------------
 client/transfer.h |   13 +++++++------
 3 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/client/session.c b/client/session.c
index 3a8807b..e9993c8 100644
--- a/client/session.c
+++ b/client/session.c
@@ -751,8 +751,19 @@ static guint session_request(struct obc_session *session,
 					void *data, GError **err)
 {
 	struct pending_request *p;
+	const char *agent;
 	int perr;
 
+	if (session->agent)
+		agent = obc_agent_get_name(session->agent);
+	else
+		agent = NULL;
+
+	if (!obc_transfer_register(transfer, session->conn, agent, err)) {
+		obc_transfer_unregister(transfer);
+		return 0;
+	}
+
 	obc_transfer_set_callback(transfer, transfer_progress, session);
 
 	p = pending_request_new(session, transfer, session_start_transfer,
@@ -953,7 +964,6 @@ guint obc_session_get(struct obc_session *session, const char *type,
 {
 	struct obc_transfer *transfer;
 	struct obc_transfer_params *params = NULL;
-	const char *agent;
 
 	if (session->obex == NULL) {
 		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
@@ -968,13 +978,7 @@ guint obc_session_get(struct obc_session *session, const char *type,
 		params->size = apparam_size;
 	}
 
-	if (session->agent)
-		agent = obc_agent_get_name(session->agent);
-	else
-		agent = NULL;
-
-	transfer = obc_transfer_get(session->conn, agent, targetfile, name,
-							type, params, err);
+	transfer = obc_transfer_get(targetfile, name, type, params, err);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
@@ -990,7 +994,6 @@ guint obc_session_send(struct obc_session *session, const char *filename,
 				const char *name, GError **err)
 {
 	struct obc_transfer *transfer;
-	const char *agent;
 
 	if (session->obex == NULL) {
 		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
@@ -998,10 +1001,7 @@ guint obc_session_send(struct obc_session *session, const char *filename,
 		return 0;
 	}
 
-	agent = obc_agent_get_name(session->agent);
-
-	transfer = obc_transfer_put(session->conn, agent, filename, name,
-					NULL, NULL, 0, NULL, err);
+	transfer = obc_transfer_put(filename, name, NULL, NULL, 0, NULL, err);
 	if (transfer == NULL)
 		return 0;
 
@@ -1051,7 +1051,6 @@ guint obc_session_put(struct obc_session *session, const char *contents,
 				size_t size, const char *name, GError **err)
 {
 	struct obc_transfer *transfer;
-	const char *agent;
 
 	if (session->obex == NULL) {
 		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
@@ -1059,10 +1058,8 @@ guint obc_session_put(struct obc_session *session, const char *contents,
 		return 0;
 	}
 
-	agent = obc_agent_get_name(session->agent);
-
-	transfer = obc_transfer_put(session->conn, agent, NULL, name, NULL,
-						contents, size, NULL, err);
+	transfer = obc_transfer_put(NULL, name, NULL, contents, size, NULL,
+									err);
 	if (transfer == NULL)
 		return 0;
 
diff --git a/client/transfer.c b/client/transfer.c
index a725e19..7a55fe6 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -239,7 +239,7 @@ static struct obc_transfer *obc_transfer_create(guint8 op,
 	return transfer;
 }
 
-static gboolean obc_transfer_register(struct obc_transfer *transfer,
+gboolean obc_transfer_register(struct obc_transfer *transfer,
 						DBusConnection *conn,
 						const char *agent,
 						GError **err)
@@ -306,9 +306,7 @@ done:
 	return TRUE;
 }
 
-struct obc_transfer *obc_transfer_get(DBusConnection *conn,
-					const char *agent,
-					const char *filename,
+struct obc_transfer *obc_transfer_get(const char *filename,
 					const char *name,
 					const char *type,
 					struct obc_transfer_params *params,
@@ -319,11 +317,6 @@ struct obc_transfer *obc_transfer_get(DBusConnection *conn,
 
 	transfer = obc_transfer_create(G_OBEX_OP_GET, filename, name, type);
 
-	if (!obc_transfer_register(transfer, conn, agent, err)) {
-		obc_transfer_free(transfer);
-		return NULL;
-	}
-
 	perr = transfer_open(transfer, O_WRONLY | O_CREAT | O_TRUNC, 0600, err);
 	if (perr < 0) {
 		obc_transfer_free(transfer);
@@ -335,9 +328,7 @@ struct obc_transfer *obc_transfer_get(DBusConnection *conn,
 	return transfer;
 }
 
-struct obc_transfer *obc_transfer_put(DBusConnection *conn,
-					const char *agent,
-					const char *filename,
+struct obc_transfer *obc_transfer_put(const char *filename,
 					const char *name,
 					const char *type,
 					const char *contents,
@@ -351,11 +342,6 @@ struct obc_transfer *obc_transfer_put(DBusConnection *conn,
 
 	transfer = obc_transfer_create(G_OBEX_OP_PUT, filename, name, type);
 
-	if (!obc_transfer_register(transfer, conn, agent, err)) {
-		obc_transfer_free(transfer);
-		return NULL;
-	}
-
 	if (contents != NULL) {
 		ssize_t w;
 
diff --git a/client/transfer.h b/client/transfer.h
index 1b83d18..073b279 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -32,16 +32,12 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 					gint64 transferred, GError *err,
 					void *user_data);
 
-struct obc_transfer *obc_transfer_get(DBusConnection *conn,
-					const char *agent,
-					const char *filename,
+struct obc_transfer *obc_transfer_get(const char *filename,
 					const char *name,
 					const char *type,
 					struct obc_transfer_params *params,
 					GError **err);
-struct obc_transfer *obc_transfer_put(DBusConnection *conn,
-					const char *agent,
-					const char *filename,
+struct obc_transfer *obc_transfer_put(const char *filename,
 					const char *name,
 					const char *type,
 					const char *contents,
@@ -49,6 +45,11 @@ struct obc_transfer *obc_transfer_put(DBusConnection *conn,
 					struct obc_transfer_params *params,
 					GError **err);
 
+gboolean obc_transfer_register(struct obc_transfer *transfer,
+					DBusConnection *conn,
+					const char *agent,
+					GError **err);
+
 void obc_transfer_unregister(struct obc_transfer *transfer);
 
 gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
-- 
1.7.7.6

