Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 2/6] client: Split internal obc_transfer_register()
Date: Fri,  4 May 2012 14:39:34 +0200
Message-Id: <1336135178-21707-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The creation process has been internally split into two steps: creation
and D-Bus registration. This is easier to understand and it also allows
to expose these two-steps in the transfer API.
---
 client/transfer.c |   51 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 58baa85..a725e19 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -223,29 +223,35 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	g_free(transfer);
 }
 
-static struct obc_transfer *obc_transfer_register(DBusConnection *conn,
-						const char *agent,
-						guint8 op,
+static struct obc_transfer *obc_transfer_create(guint8 op,
 						const char *filename,
 						const char *name,
-						const char *type,
-						GError **err)
+						const char *type)
 {
 	struct obc_transfer *transfer;
 
 	transfer = g_new0(struct obc_transfer, 1);
 	transfer->op = op;
-	transfer->agent = g_strdup(agent);
 	transfer->filename = g_strdup(filename);
 	transfer->name = g_strdup(name);
 	transfer->type = g_strdup(type);
 
+	return transfer;
+}
+
+static gboolean obc_transfer_register(struct obc_transfer *transfer,
+						DBusConnection *conn,
+						const char *agent,
+						GError **err)
+{
 	/* for OBEX specific mime types we don't need to register a transfer */
-	if (type != NULL &&
-			(strncmp(type, "x-obex/", 7) == 0 ||
-			strncmp(type, "x-bt/", 5) == 0))
+	if (transfer->type != NULL &&
+			(strncmp(transfer->type, "x-obex/", 7) == 0 ||
+			strncmp(transfer->type, "x-bt/", 5) == 0))
 		goto done;
 
+	transfer->agent = g_strdup(agent);
+
 	transfer->path = g_strdup_printf("%s/transfer%ju",
 			TRANSFER_BASEPATH, counter++);
 
@@ -253,7 +259,7 @@ static struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 	if (transfer->conn == NULL) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EFAULT,
 						"Unable to connect to D-Bus");
-		goto fail;
+		return FALSE;
 	}
 
 	if (g_dbus_register_interface(transfer->conn, transfer->path,
@@ -262,18 +268,13 @@ static struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 				transfer, NULL) == FALSE) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EFAULT,
 						"Unable to register to D-Bus");
-		goto fail;
+		return FALSE;
 	}
 
 done:
 	DBG("%p registered %s", transfer, transfer->path);
 
-	return transfer;
-
-fail:
-	obc_transfer_free(transfer);
-
-	return NULL;
+	return TRUE;
 }
 
 static gboolean transfer_open(struct obc_transfer *transfer, int flags,
@@ -316,10 +317,12 @@ struct obc_transfer *obc_transfer_get(DBusConnection *conn,
 	struct obc_transfer *transfer;
 	int perr;
 
-	transfer = obc_transfer_register(conn, agent, G_OBEX_OP_GET, filename,
-							name, type, err);
-	if (transfer == NULL)
+	transfer = obc_transfer_create(G_OBEX_OP_GET, filename, name, type);
+
+	if (!obc_transfer_register(transfer, conn, agent, err)) {
+		obc_transfer_free(transfer);
 		return NULL;
+	}
 
 	perr = transfer_open(transfer, O_WRONLY | O_CREAT | O_TRUNC, 0600, err);
 	if (perr < 0) {
@@ -346,10 +349,12 @@ struct obc_transfer *obc_transfer_put(DBusConnection *conn,
 	struct stat st;
 	int perr;
 
-	transfer = obc_transfer_register(conn, agent, G_OBEX_OP_PUT, filename,
-							name, type, err);
-	if (transfer == NULL)
+	transfer = obc_transfer_create(G_OBEX_OP_PUT, filename, name, type);
+
+	if (!obc_transfer_register(transfer, conn, agent, err)) {
+		obc_transfer_free(transfer);
 		return NULL;
+	}
 
 	if (contents != NULL) {
 		ssize_t w;
-- 
1.7.7.6

