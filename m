Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/6 v4] client: transfers take gobex when starting
Date: Tue, 24 Apr 2012 15:03:13 +0300
Message-Id: <1335268995-20572-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1335268995-20572-1-git-send-email-luiz.dentz@gmail.com>
References: <1335268995-20572-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

gobex api should not be used by a transfer until it is started. This
seems more explicit if the pointer is not passed during creation.
---
 client/session.c  |   20 +++++++-------------
 client/transfer.c |    7 ++++---
 client/transfer.h |    4 ++--
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/client/session.c b/client/session.c
index ab20b88..306e2ba 100644
--- a/client/session.c
+++ b/client/session.c
@@ -923,7 +923,7 @@ static void session_start_transfer(gpointer data, gpointer user_data)
 	struct obc_transfer *transfer = user_data;
 	GError *err = NULL;
 
-	if (!obc_transfer_start(transfer, &err)) {
+	if (!obc_transfer_start(transfer, session->obex, &err)) {
 		session_notify_error(session, transfer, err);
 		g_clear_error(&err);
 		return;
@@ -956,10 +956,8 @@ int obc_session_get(struct obc_session *session, const char *type,
 	else
 		agent = NULL;
 
-	transfer = obc_transfer_register(session->conn, session->obex,
-						agent, G_OBEX_OP_GET,
-						targetfile, name,
-						type, params);
+	transfer = obc_transfer_register(session->conn, agent, G_OBEX_OP_GET,
+					targetfile, name, type, params);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
@@ -983,10 +981,8 @@ int obc_session_send(struct obc_session *session, const char *filename,
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, session->obex,
-						agent, G_OBEX_OP_PUT,
-						filename, name,
-						NULL, NULL);
+	transfer = obc_transfer_register(session->conn, agent, G_OBEX_OP_PUT,
+						filename, name, NULL, NULL);
 	if (transfer == NULL)
 		return -EINVAL;
 
@@ -1049,10 +1045,8 @@ int obc_session_put(struct obc_session *session, const char *contents,
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, G_OBEX_OP_PUT,
-							NULL, name,
-							NULL, NULL);
+	transfer = obc_transfer_register(session->conn, agent, G_OBEX_OP_PUT,
+						NULL, name, NULL, NULL);
 	if (transfer == NULL)
 		return -EIO;
 
diff --git a/client/transfer.c b/client/transfer.c
index 34dc277..999b08b 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -220,7 +220,6 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 }
 
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
-						GObex *obex,
 						const char *agent,
 						guint8 op,
 						const char *filename,
@@ -231,7 +230,6 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 	struct obc_transfer *transfer;
 
 	transfer = g_new0(struct obc_transfer, 1);
-	transfer->obex = g_obex_ref(obex);
 	transfer->op = op;
 	transfer->agent = g_strdup(agent);
 	transfer->filename = g_strdup(filename);
@@ -522,8 +520,11 @@ static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
 	return TRUE;
 }
 
-gboolean obc_transfer_start(struct obc_transfer *transfer, GError **err)
+gboolean obc_transfer_start(struct obc_transfer *transfer, GObex *obex,
+								GError **err)
 {
+	transfer->obex = g_obex_ref(obex);
+
 	switch (transfer->op) {
 	case G_OBEX_OP_GET:
 		return transfer_start_get(transfer, err);
diff --git a/client/transfer.h b/client/transfer.h
index 7858423..b044ce1 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -33,7 +33,6 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 					void *user_data);
 
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
-					GObex *obex,
 					const char *agent,
 					guint8 op,
 					const char *filename,
@@ -47,7 +46,8 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 					transfer_callback_t func,
 					void *user_data);
 
-gboolean obc_transfer_start(struct obc_transfer *transfer, GError **err);
+gboolean obc_transfer_start(struct obc_transfer *transfer, GObex *obex,
+								GError **err);
 guint8 obc_transfer_get_operation(struct obc_transfer *transfer);
 
 int obc_transfer_get_params(struct obc_transfer *transfer,
-- 
1.7.7.6

