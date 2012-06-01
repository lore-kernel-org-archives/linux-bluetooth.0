Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 03/14] client: Expose D-Bus data in internal transfer API
Date: Fri,  1 Jun 2012 12:51:12 +0200
Message-Id: <1338547883-18907-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Expose in transfer API the D-Bus path and properties as should be
returned by transfer-initiating D-Bus methods.
---
 client/transfer.c |   62 ++++++++++++++++++++++++++++++++++++++++++----------
 client/transfer.h |    3 ++
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 04533b8..c4eda84 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -85,6 +85,19 @@ static GQuark obc_transfer_error_quark(void)
 	return g_quark_from_static_string("obc-transfer-error-quark");
 }
 
+static void obc_transfer_append_dbus_properties(struct obc_transfer *transfer,
+							DBusMessageIter *dict)
+{
+	obex_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &transfer->name);
+	obex_dbus_dict_append(dict, "Size", DBUS_TYPE_UINT64, &transfer->size);
+	obex_dbus_dict_append(dict, "Filename", DBUS_TYPE_STRING,
+							&transfer->filename);
+
+	if (transfer->obex != NULL)
+		obex_dbus_dict_append(dict, "Progress", DBUS_TYPE_UINT64,
+						&transfer->progress);
+}
+
 static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -97,26 +110,51 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 		return NULL;
 
 	dbus_message_iter_init_append(reply, &iter);
-
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+						OBC_PROPERTIES_ARRAY_SIGNATURE,
+						&dict);
 
-	obex_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING, &transfer->name);
-	obex_dbus_dict_append(&dict, "Size", DBUS_TYPE_UINT64, &transfer->size);
-	obex_dbus_dict_append(&dict, "Filename", DBUS_TYPE_STRING,
-							&transfer->filename);
-
-	if (transfer->obex != NULL)
-		obex_dbus_dict_append(&dict, "Progress", DBUS_TYPE_UINT64,
-						&transfer->progress);
+	obc_transfer_append_dbus_properties(transfer, &dict);
 
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
 }
 
+static void obc_transfer_append_dbus_data(struct obc_transfer *transfer,
+							DBusMessageIter *iter)
+{
+	const char *path = transfer->path;
+	DBusMessageIter entry, dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_STRUCT, NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH, &path);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_ARRAY,
+						OBC_PROPERTIES_ARRAY_SIGNATURE,
+						&dict);
+
+	obc_transfer_append_dbus_properties(transfer, &dict);
+
+	dbus_message_iter_close_container(&entry, &dict);
+	dbus_message_iter_close_container(iter, &entry);
+}
+
+DBusMessage *obc_transfer_create_dbus_reply(struct obc_transfer *transfer,
+							DBusMessage *message)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+
+	reply = dbus_message_new_method_return(message);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+	obc_transfer_append_dbus_data(transfer, &iter);
+
+	return reply;
+}
+
 static void abort_complete(GObex *obex, GError *err, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
diff --git a/client/transfer.h b/client/transfer.h
index 15c157a..eb5275c 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -57,3 +57,6 @@ int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
 
 const char *obc_transfer_get_path(struct obc_transfer *transfer);
 gint64 obc_transfer_get_size(struct obc_transfer *transfer);
+
+DBusMessage *obc_transfer_create_dbus_reply(struct obc_transfer *transfer,
+							DBusMessage *message);
-- 
1.7.7.6

