Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 03/16] client: Add progress property to transfer
Date: Wed, 23 May 2012 17:00:05 +0200
Message-Id: <1337785218-8661-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The number of transferred bytes is exposed in D-Bus using a specific
property for this purpose.

Internally, the value of this property does not necessarily match the
internal progress counter. In order to avoid D-Bus overhead, the
property will be updated at least every N bytes, where N is fixed and
hardcoded (TRANSFER_PROGRESS_PERIOD).
---
 client/transfer.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 8292265..2c6e1ed 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -44,6 +44,7 @@
 
 #define TRANSFER_INTERFACE  "org.openobex.Transfer"
 #define TRANSFER_BASEPATH   "/org/openobex"
+#define TRANSFER_PROGRESS_PERIOD (16 * 1024)
 
 #define OBC_TRANSFER_ERROR obc_transfer_error_quark()
 
@@ -75,6 +76,7 @@ struct obc_transfer {
 	guint xfer;
 	gint64 size;
 	gint64 transferred;
+	gint64 transferred_dbus;
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
@@ -182,6 +188,12 @@ static const GDBusMethodTable obc_transfer_methods[] = {
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
@@ -260,8 +272,8 @@ gboolean obc_transfer_register(struct obc_transfer *transfer,
 
 	if (g_dbus_register_interface(transfer->conn, transfer->path,
 				TRANSFER_INTERFACE,
-				obc_transfer_methods, NULL, NULL,
-				transfer, NULL) == FALSE) {
+				obc_transfer_methods, obc_transfer_signals,
+				NULL, transfer, NULL) == FALSE) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EFAULT,
 						"Unable to register to D-Bus");
 		return FALSE;
@@ -380,6 +392,33 @@ void obc_transfer_unregister(struct obc_transfer *transfer)
 	obc_transfer_free(transfer);
 }
 
+static void transfer_notify_progress(struct obc_transfer *transfer)
+{
+	gint64 notify;
+
+	DBG("Transfer %p progress: %lu bytes", transfer, transfer->transferred);
+
+	if (transfer->path == NULL)
+		return;
+
+	if (transfer->transferred == transfer->transferred_dbus)
+		return;
+
+	notify = transfer->transferred_dbus + TRANSFER_PROGRESS_PERIOD;
+
+	if ((transfer->transferred != transfer->size) &&
+					(transfer->transferred < notify))
+		return;
+
+	transfer->transferred_dbus = transfer->transferred;
+
+	obex_dbus_signal_property_changed(transfer->conn,
+						transfer->path,
+						TRANSFER_INTERFACE, "Progress",
+						DBUS_TYPE_INT64,
+						&transfer->transferred_dbus);
+}
+
 static gboolean get_xfer_progress(const void *buf, gsize len,
 							gpointer user_data)
 {
@@ -400,6 +439,8 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 		callback->func(transfer, transfer->transferred, NULL,
 							callback->data);
 
+	transfer_notify_progress(transfer);
+
 	return TRUE;
 }
 
@@ -497,6 +538,8 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
 
 	transfer->transferred += size;
 
+	transfer_notify_progress(transfer);
+
 	return size;
 }
 
-- 
1.7.7.6

