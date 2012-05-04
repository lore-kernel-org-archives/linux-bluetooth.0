Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd v2 2/3] client: Wait for abort completion before
 Transfer.Cancel returns
Date: Fri, 04 May 2012 15:27:05 +0530
Message-id: <1336125426-30445-2-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1336125426-30445-1-git-send-email-jaganath.k@samsung.com>
References: <1336125426-30445-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A new callback is given to g_obex_cancel_transfer() which will be
called when abort completes and then only "Cancel" method reply will
be sent to user
---
 client/transfer.c |   65 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 411a7c0..d796239 100644
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
@@ -136,37 +137,51 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
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
 
-		err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
-							strerror(ECANCELED));
-		callback->func(transfer, transfer->transferred, err,
+	if (callback) {
+		if (err) {
+			callback->func(transfer, transfer->transferred, err,
 							callback->data);
-		g_error_free(err);
+		} else {
+			GError *abort_err;
+
+			abort_err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
+						"Transfer cancelled by user");
+			callback->func(transfer, transfer->transferred, abort_err,
+								callback->data);
+			g_error_free(abort_err);
+		}
 	}
 }
 
+static gboolean obc_transfer_abort(struct obc_transfer *transfer)
+{
+	if (transfer->xfer == 0)
+		return FALSE;
+
+	return g_obex_cancel_transfer(transfer->xfer, abort_complete,
+								transfer);
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
@@ -174,18 +189,19 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
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
 
@@ -194,7 +210,7 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	DBG("%p", transfer);
 
 	if (transfer->xfer)
-		g_obex_cancel_transfer(transfer->xfer);
+		g_obex_cancel_transfer(transfer->xfer, NULL, NULL);
 
 	if (transfer->op == G_OBEX_OP_GET &&
 					transfer->transferred != transfer->size)
@@ -211,6 +227,9 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->conn)
 		dbus_connection_unref(transfer->conn);
 
+	if (transfer->msg)
+		dbus_message_unref(transfer->msg);
+
 	if (transfer->obex)
 		g_obex_unref(transfer->obex);
 
-- 
1.7.1

