Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] obex-client: Port transfer code to use D-Bus properties interface
Date: Fri, 14 Dec 2012 23:31:59 +0200
Message-Id: <1355520720-11731-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355520720-11731-1-git-send-email-luiz.dentz@gmail.com>
References: <1355520720-11731-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/obex-client-api.txt | 12 --------
 obexd/client/transfer.c | 80 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/doc/obex-client-api.txt b/doc/obex-client-api.txt
index f516760..817ca71 100644
--- a/doc/obex-client-api.txt
+++ b/doc/obex-client-api.txt
@@ -535,18 +535,6 @@ Methods		object, dict Get(string targetfile, boolean attachment)
 			The properties of this transfer are also returned along
 			with the object path, to avoid a call to GetProperties.
 
-		dict GetProperties()
-
-			Returns all properties for the message. See the
-			properties section for available properties.
-
-		void SetProperty (string name, variant value)
-
-			Sets value to the mentioned property.
-
-			Possible properties: Read and Deleted.
-
-
 Properties	string Subject [readonly]
 
 			Message subject
diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 38c99cd..29d61f3 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -231,24 +231,91 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 	return NULL;
 }
 
+static gboolean get_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obc_transfer *transfer = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&transfer->name);
+
+	return TRUE;
+}
+
+static gboolean get_size(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obc_transfer *transfer = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64,
+							&transfer->size);
+
+	return TRUE;
+}
+
+static gboolean filename_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct obc_transfer *transfer = data;
+
+	return transfer->filename != NULL;
+}
+
+static gboolean get_filename(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obc_transfer *transfer = data;
+
+	if (transfer->filename == NULL)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&transfer->filename);
+
+	return TRUE;
+}
+
+static gboolean progress_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct obc_transfer *transfer = data;
+
+	return transfer->obex != NULL;
+}
+
+static gboolean get_progress(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obc_transfer *transfer = data;
+
+	if (transfer->obex == NULL)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64,
+							&transfer->progress);
+
+	return TRUE;
+}
+
 static const GDBusMethodTable obc_transfer_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				obc_transfer_get_properties) },
 	{ GDBUS_ASYNC_METHOD("Cancel", NULL, NULL,
 				obc_transfer_cancel) },
 	{ }
 };
 
 static const GDBusSignalTable obc_transfer_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-		GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ GDBUS_SIGNAL("Complete", NULL) },
 	{ GDBUS_SIGNAL("Error",
 		GDBUS_ARGS({ "code", "s" }, { "message", "s" })) },
 	{ }
 };
 
+static const GDBusPropertyTable obc_transfer_properties[] = {
+	{ "Name", "s", get_name },
+	{ "Size", "t", get_size },
+	{ "Filename", "s", get_filename, NULL, filename_exists },
+	{ "Progress", "t", get_progress, NULL, progress_exists },
+	{ }
+};
+
 static void obc_transfer_free(struct obc_transfer *transfer)
 {
 	DBG("%p", transfer);
@@ -325,7 +392,8 @@ gboolean obc_transfer_register(struct obc_transfer *transfer,
 	if (g_dbus_register_interface(transfer->conn, transfer->path,
 				TRANSFER_INTERFACE,
 				obc_transfer_methods, obc_transfer_signals,
-				NULL, transfer, NULL) == FALSE) {
+				obc_transfer_properties, transfer,
+				NULL) == FALSE) {
 		g_set_error(err, OBC_TRANSFER_ERROR, -EFAULT,
 						"Unable to register to D-Bus");
 		return FALSE;
-- 
1.7.11.7

