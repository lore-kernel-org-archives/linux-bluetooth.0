Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 2/3] client: Wait for abort completion before
 Transfer.Cancel returns
Date: Mon, 30 Apr 2012 16:33:17 +0530
Message-id: <1335783797-7430-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A new callback is given to g_obex_cancel_transfer() which will be
called when abort completes and then only "Cancel" method reply will
be sent to user
---
 client/transfer.c |   52 +++++++++++++++++++++++++++++++++-------------------
 1 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 8b5d126..739a789 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -59,6 +59,7 @@ struct obc_transfer {
 	struct obc_transfer_params *params;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
+	DBusMessage *msg;
 	char *agent;		/* Transfer agent */
 	char *path;		/* Transfer path */
 	gchar *filename;	/* Transfer file location */
@@ -136,23 +137,22 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 	return reply;
 }
 
-static void obc_transfer_abort(struct obc_transfer *transfer)
+static void abort_complete(GObex *obex, GError *err, gpointer user_data)
 {
+	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
+	DBusMessage *reply;
 
-	if (transfer->xfer > 0) {
-		g_obex_cancel_transfer(transfer->xfer);
-		transfer->xfer = 0;
-	}
+	transfer->xfer = 0;
 
-	if (transfer->obex != NULL) {
-		g_obex_unref(transfer->obex);
-		transfer->obex = NULL;
-	}
+	reply = dbus_message_new_method_return(transfer->msg);
+	if (reply)
+		g_dbus_send_message(transfer->conn, reply);
 
-	if (callback) {
-		GError *err;
+	dbus_message_unref(transfer->msg);
+	transfer->msg = NULL;
 
+	if (callback) {
 		err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
 							strerror(ECANCELED));
 		callback->func(transfer, transfer->transferred, err,
@@ -161,12 +161,22 @@ static void obc_transfer_abort(struct obc_transfer *transfer)
 	}
 }
 
+static gboolean obc_transfer_abort(struct obc_transfer *transfer)
+{
+	if (transfer->xfer == 0)
+		return FALSE;
+
+	if (!g_obex_cancel_transfer(transfer->xfer, abort_complete, transfer))
+		return FALSE;
+
+	return TRUE;
+}
+
 static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct obc_transfer *transfer = user_data;
 	const gchar *sender;
-	DBusMessage *reply;
 
 	sender = dbus_message_get_sender(message);
 	if (g_strcmp0(transfer->agent, sender) != 0)
@@ -174,18 +184,19 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 				"org.openobex.Error.NotAuthorized",
 				"Not Authorized");
 
-	reply = dbus_message_new_method_return(message);
-	if (!reply)
-		return NULL;
+	if (!obc_transfer_abort(transfer))
+		return g_dbus_create_error(message,
+				"org.openobex.Error.Failed",
+				"Failed");
 
-	obc_transfer_abort(transfer);
+	transfer->msg = dbus_message_ref(message);
 
-	return reply;
+	return NULL;
 }
 
 static GDBusMethodTable obc_transfer_methods[] = {
 	{ "GetProperties", "", "a{sv}", obc_transfer_get_properties },
-	{ "Cancel", "", "", obc_transfer_cancel },
+	{ "Cancel", "", "", obc_transfer_cancel, G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 
@@ -194,7 +205,7 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	DBG("%p", transfer);
 
 	if (transfer->xfer)
-		g_obex_cancel_transfer(transfer->xfer);
+		g_obex_cancel_transfer(transfer->xfer, NULL, NULL);
 
 	if (transfer->op == G_OBEX_OP_GET &&
 					transfer->transferred != transfer->size)
@@ -211,6 +222,9 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->conn)
 		dbus_connection_unref(transfer->conn);
 
+	if (transfer->msg)
+		dbus_message_unref(transfer->msg);
+
 	if (transfer->obex)
 		g_obex_unref(transfer->obex);
 
-- 
1.7.1

