Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 03/17] client: Add progress property to transfer
Date: Tue, 29 May 2012 11:23:08 +0200
Message-Id: <1338283402-11085-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338283402-11085-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338283402-11085-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The number of transferred bytes is exposed in D-Bus using a specific
property for this purpose.

Internally, the value of this property does not necessarily match the
internal progress counter. In order to avoid D-Bus overhead, the
property will be updated once per second.
---
 client/transfer.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 8292265..c1bd4be 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -75,6 +75,8 @@ struct obc_transfer {
 	guint xfer;
 	gint64 size;
 	gint64 transferred;
+	gint64 transferred_dbus;
+	guint progress_id;
 };
 
 static GQuark obc_transfer_error_quark(void)
@@ -105,6 +107,10 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 	obex_dbus_dict_append(&dict, "Filename", DBUS_TYPE_STRING,
 							&transfer->filename);
 
+	if (transfer->obex != NULL)
+		obex_dbus_dict_append(&dict, "Progress", DBUS_TYPE_UINT64,
+						&transfer->transferred_dbus);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
@@ -147,6 +153,11 @@ static gboolean obc_transfer_abort(struct obc_transfer *transfer)
 	if (transfer->xfer == 0)
 		return FALSE;
 
+	if (transfer->progress_id != 0) {
+		g_source_remove(transfer->progress_id);
+		transfer->progress_id = 0;
+	}
+
 	return g_obex_cancel_transfer(transfer->xfer, abort_complete,
 								transfer);
 }
@@ -182,6 +193,12 @@ static const GDBusMethodTable obc_transfer_methods[] = {
 	{ }
 };
 
+static const GDBusSignalTable obc_transfer_signals[] = {
+	{ GDBUS_SIGNAL("PropertyChanged",
+		GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
 static void obc_transfer_free(struct obc_transfer *transfer)
 {
 	DBG("%p", transfer);
@@ -189,6 +206,11 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->xfer)
 		g_obex_cancel_transfer(transfer->xfer, NULL, NULL);
 
+	if (transfer->progress_id != 0) {
+		g_source_remove(transfer->progress_id);
+		transfer->progress_id = 0;
+	}
+
 	if (transfer->op == G_OBEX_OP_GET &&
 					transfer->transferred != transfer->size)
 		remove(transfer->filename);
@@ -260,8 +282,8 @@ gboolean obc_transfer_register(struct obc_transfer *transfer,
 
 	if (g_dbus_register_interface(transfer->conn, transfer->path,
 				TRANSFER_INTERFACE,
-				obc_transfer_methods, NULL, NULL,
-				transfer, NULL) == FALSE) {
+				obc_transfer_methods, obc_transfer_signals,
+				NULL, transfer, NULL) == FALSE) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EFAULT,
 						"Unable to register to D-Bus");
 		return FALSE;
@@ -410,6 +432,11 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 
 	transfer->xfer = 0;
 
+	if (transfer->progress_id != 0) {
+		g_source_remove(transfer->progress_id);
+		transfer->progress_id = 0;
+	}
+
 	if (err)
 		goto done;
 
@@ -518,6 +545,29 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 	return TRUE;
 }
 
+static gboolean report_progress(gpointer data)
+{
+	struct obc_transfer *transfer = data;
+
+	if (transfer->transferred == transfer->transferred_dbus)
+		return TRUE;
+
+	transfer->transferred_dbus = transfer->transferred;
+
+	if (transfer->transferred == transfer->size) {
+		transfer->progress_id = 0;
+		return FALSE;
+	}
+
+	obex_dbus_signal_property_changed(transfer->conn,
+						transfer->path,
+						TRANSFER_INTERFACE, "Progress",
+						DBUS_TYPE_INT64,
+						&transfer->transferred_dbus);
+
+	return TRUE;
+}
+
 static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 {
 	GObexPacket *req;
@@ -549,6 +599,12 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 	if (transfer->xfer == 0)
 		return FALSE;
 
+	if (transfer->path == NULL)
+		return TRUE;
+
+	transfer->progress_id = g_timeout_add_seconds(1, report_progress,
+								transfer);
+
 	return TRUE;
 }
 
@@ -586,6 +642,12 @@ static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
 	if (transfer->xfer == 0)
 		return FALSE;
 
+	if (transfer->path == NULL)
+		return TRUE;
+
+	transfer->progress_id = g_timeout_add_seconds(1, report_progress,
+								transfer);
+
 	return TRUE;
 }
 
-- 
1.7.7.6

