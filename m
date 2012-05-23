Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 15/16] client: Add signal to report new transfers
Date: Wed, 23 May 2012 17:00:17 +0200
Message-Id: <1337785218-8661-16-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 client/session.c  |   45 +++++++++++++++++++++++++++++++++++++++++++--
 client/transfer.c |    2 +-
 client/transfer.h |    2 ++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/client/session.c b/client/session.c
index bb20a61..fcaa97e 100644
--- a/client/session.c
+++ b/client/session.c
@@ -630,6 +630,12 @@ static const GDBusMethodTable session_methods[] = {
 	{ }
 };
 
+static const GDBusSignalTable session_signals[] = {
+	{ GDBUS_SIGNAL("TransferAdded",
+		GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })) },
+	{ }
+};
+
 static gboolean session_queue_complete(gpointer data)
 {
 	struct obc_session *session = data;
@@ -641,6 +647,34 @@ static gboolean session_queue_complete(gpointer data)
 	return FALSE;
 }
 
+static gboolean emit_transfer_added(struct obc_session *session,
+						struct obc_transfer *transfer)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *path;
+
+	signal = dbus_message_new_signal(session->path, SESSION_INTERFACE,
+							"TransferAdded");
+	if (signal == NULL)
+		return FALSE;
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	path = obc_transfer_get_path(transfer);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+						OBC_PROPERTIES_ARRAY_SIGNATURE,
+						&dict);
+	obc_transfer_append_dbus_properties(transfer, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(session->conn, signal);
+
+	return TRUE;
+}
+
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
@@ -655,13 +689,19 @@ guint obc_session_queue(struct obc_session *session,
 		return 0;
 	}
 
-	if (dbus_register)
+	if (dbus_register) {
 		if (!obc_transfer_register(transfer, session->conn,
 							session->owner, err)) {
 			obc_transfer_unregister(transfer);
 			return 0;
 		}
 
+		if (!emit_transfer_added(session, transfer)) {
+			obc_transfer_unregister(transfer);
+			return 0;
+		}
+	}
+
 	obc_transfer_set_callback(transfer, transfer_complete, session);
 
 	p = pending_request_new(session, transfer, func, user_data);
@@ -794,7 +834,8 @@ const char *obc_session_register(struct obc_session *session,
 
 	if (g_dbus_register_interface(session->conn, session->path,
 					SESSION_INTERFACE, session_methods,
-					NULL, NULL, session, destroy) == FALSE)
+					session_signals, NULL, session,
+					destroy) == FALSE)
 		goto fail;
 
 	if (session->driver->probe && session->driver->probe(session) < 0) {
diff --git a/client/transfer.c b/client/transfer.c
index 9f1aea0..e61cb3c 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -84,7 +84,7 @@ static GQuark obc_transfer_error_quark(void)
 	return g_quark_from_static_string("obc-transfer-error-quark");
 }
 
-static void obc_transfer_append_dbus_properties(struct obc_transfer *transfer,
+void obc_transfer_append_dbus_properties(struct obc_transfer *transfer,
 							DBusMessageIter *dict)
 {
 	obex_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &transfer->name);
diff --git a/client/transfer.h b/client/transfer.h
index eb5275c..df01a2b 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -58,5 +58,7 @@ int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
 const char *obc_transfer_get_path(struct obc_transfer *transfer);
 gint64 obc_transfer_get_size(struct obc_transfer *transfer);
 
+void obc_transfer_append_dbus_properties(struct obc_transfer *transfer,
+							DBusMessageIter *dict);
 DBusMessage *obc_transfer_create_dbus_reply(struct obc_transfer *transfer,
 							DBusMessage *message);
-- 
1.7.7.6

