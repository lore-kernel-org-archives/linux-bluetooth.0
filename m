Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 07/14] client: Use transfer owner instead of agent
Date: Wed, 30 May 2012 17:50:16 +0200
Message-Id: <1338393023-29941-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The security checks in the transfers' D-Bus API will consider check for
the transfer owner's path (session owner) instead of the agent path.
---
 client/session.c  |    9 ++-------
 client/transfer.c |   10 +++++-----
 client/transfer.h |    2 +-
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/client/session.c b/client/session.c
index 94256b4..9c4c9f0 100644
--- a/client/session.c
+++ b/client/session.c
@@ -793,7 +793,6 @@ guint obc_session_queue(struct obc_session *session,
 				GError **err)
 {
 	struct pending_request *p;
-	const char *agent;
 	int perr;
 
 	if (session->obex == NULL) {
@@ -803,12 +802,8 @@ guint obc_session_queue(struct obc_session *session,
 		return 0;
 	}
 
-	if (session->agent)
-		agent = obc_agent_get_name(session->agent);
-	else
-		agent = NULL;
-
-	if (!obc_transfer_register(transfer, session->conn, agent, err)) {
+	if (!obc_transfer_register(transfer, session->conn, session->owner,
+									err)) {
 		obc_transfer_unregister(transfer);
 		return 0;
 	}
diff --git a/client/transfer.c b/client/transfer.c
index 6bf6591..0385321 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -66,7 +66,7 @@ struct obc_transfer {
 	struct transfer_callback *callback;
 	DBusConnection *conn;
 	DBusMessage *msg;
-	char *agent;		/* Transfer agent */
+	char *owner;		/* Transfer initiator */
 	char *path;		/* Transfer path */
 	gchar *filename;	/* Transfer file location */
 	char *name;		/* Transfer object name */
@@ -169,7 +169,7 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 	const gchar *sender;
 
 	sender = dbus_message_get_sender(message);
-	if (g_strcmp0(transfer->agent, sender) != 0)
+	if (g_strcmp0(transfer->owner, sender) != 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.NotAuthorized",
 				"Not Authorized");
@@ -236,7 +236,7 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 		g_obex_unref(transfer->obex);
 
 	g_free(transfer->callback);
-	g_free(transfer->agent);
+	g_free(transfer->owner);
 	g_free(transfer->filename);
 	g_free(transfer->name);
 	g_free(transfer->type);
@@ -262,7 +262,7 @@ static struct obc_transfer *obc_transfer_create(guint8 op,
 
 gboolean obc_transfer_register(struct obc_transfer *transfer,
 						DBusConnection *conn,
-						const char *agent,
+						const char *owner,
 						GError **err)
 {
 	/* for OBEX specific mime types we don't need to register a transfer */
@@ -271,7 +271,7 @@ gboolean obc_transfer_register(struct obc_transfer *transfer,
 			strncmp(transfer->type, "x-bt/", 5) == 0))
 		goto done;
 
-	transfer->agent = g_strdup(agent);
+	transfer->owner = g_strdup(owner);
 
 	transfer->path = g_strdup_printf("%s/transfer%ju",
 			TRANSFER_BASEPATH, counter++);
diff --git a/client/transfer.h b/client/transfer.h
index bf40a4c..a65a2ed 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -36,7 +36,7 @@ struct obc_transfer *obc_transfer_put(const char *type, const char *name,
 
 gboolean obc_transfer_register(struct obc_transfer *transfer,
 					DBusConnection *conn,
-					const char *agent,
+					const char *owner,
 					GError **err);
 
 void obc_transfer_unregister(struct obc_transfer *transfer);
-- 
1.7.7.6

