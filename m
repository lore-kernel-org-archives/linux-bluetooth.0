Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/6] client: separate ftp code from session
Date: Mon, 18 Jul 2011 13:35:14 +0300
Message-Id: <1310985316-2197-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
References: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This should improve modularization of code
---
 Makefile.am      |    2 +
 client/ftp.c     |  382 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/ftp.h     |   29 ++++
 client/session.c |  323 +---------------------------------------------
 4 files changed, 417 insertions(+), 319 deletions(-)
 create mode 100644 client/ftp.c
 create mode 100644 client/ftp.h

diff --git a/Makefile.am b/Makefile.am
index 049fc10..ab73539 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -128,8 +128,10 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/session.h client/session.c \
 				client/pbap.h client/pbap.c \
 				client/sync.h client/sync.c \
+				client/ftp.h client/ftp.c \
 				client/transfer.h client/transfer.c
 
+
 client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @OPENOBEX_LIBS@ @BLUEZ_LIBS@
 endif
 
diff --git a/client/ftp.c b/client/ftp.c
new file mode 100644
index 0000000..d8557f2
--- /dev/null
+++ b/client/ftp.c
@@ -0,0 +1,382 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "session.h"
+#include "transfer.h"
+#include "ftp.h"
+
+#define FTP_INTERFACE  "org.openobex.FileTransfer"
+
+struct ftp_data {
+	struct session_data *session;
+	DBusConnection *conn;
+	DBusMessage *msg;
+};
+
+static DBusMessage *change_folder(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	struct ftp_data *ftp = user_data;
+	struct session_data *session = ftp->session;
+	GwObex *obex = session_get_obex(session);
+	const char *folder;
+	int err;
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &folder,
+				DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	if (gw_obex_chdir(obex, folder, &err) == FALSE) {
+		return g_dbus_create_error(message,
+				"org.openobex.Error.Failed",
+				"%s", OBEX_ResponseToString(err));
+	}
+
+	return dbus_message_new_method_return(message);
+}
+
+static void append_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter value;
+	char sig[2] = { type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
+
+	dbus_message_iter_append_basic(&value, type, val);
+
+	dbus_message_iter_close_container(iter, &value);
+}
+
+static void dict_append_entry(DBusMessageIter *dict,
+			const char *key, int type, void *val)
+{
+	DBusMessageIter entry;
+
+	if (type == DBUS_TYPE_STRING) {
+		const char *str = *((const char **) val);
+		if (str == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void xml_element(GMarkupParseContext *ctxt,
+			const gchar *element,
+			const gchar **names,
+			const gchar **values,
+			gpointer user_data,
+			GError **gerr)
+{
+	DBusMessageIter dict, *iter = user_data;
+	gchar *key;
+	gint i;
+
+	if (strcasecmp("folder", element) != 0 && strcasecmp("file", element) != 0)
+		return;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &element);
+
+	/* FIXME: User, Group, Other permission must be reviewed */
+
+	i = 0;
+	for (key = (gchar *) names[i]; key; key = (gchar *) names[++i]) {
+		key[0] = g_ascii_toupper(key[0]);
+		if (g_str_equal("Size", key) == TRUE) {
+			guint64 size;
+			size = g_ascii_strtoll(values[i], NULL, 10);
+			dict_append_entry(&dict, key, DBUS_TYPE_UINT64, &size);
+		} else
+			dict_append_entry(&dict, key, DBUS_TYPE_STRING, &values[i]);
+	}
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static const GMarkupParser parser = {
+	xml_element,
+	NULL,
+	NULL,
+	NULL,
+	NULL
+};
+
+static void get_file_callback(struct session_data *session, GError *err,
+							void *user_data)
+{
+	struct ftp_data *ftp = user_data;
+	DBusMessage *reply;
+
+	if (!ftp->msg)
+		return;
+
+	if (err)
+		reply = g_dbus_create_error(ftp->msg,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
+	else
+		reply = dbus_message_new_method_return(ftp->msg);
+
+	g_dbus_send_message(ftp->conn, reply);
+
+	dbus_message_unref(ftp->msg);
+	ftp->msg = NULL;
+}
+
+static void list_folder_callback(struct session_data *session,
+					GError *err, void *user_data)
+{
+	struct ftp_data *ftp = user_data;
+	struct transfer_data *transfer = session_get_transfer(session);
+	GMarkupParseContext *ctxt;
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+	const char *buf;
+	int size;
+
+	reply = dbus_message_new_method_return(ftp->msg);
+
+	buf = transfer_get_buffer(transfer, &size);
+	if (size == 0)
+		goto done;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
+	ctxt = g_markup_parse_context_new(&parser, 0, &array, NULL);
+	g_markup_parse_context_parse(ctxt, buf, strlen(buf) - 1, NULL);
+	g_markup_parse_context_free(ctxt);
+	dbus_message_iter_close_container(&iter, &array);
+
+	transfer_clear_buffer(transfer);
+
+done:
+	g_dbus_send_message(ftp->conn, reply);
+	dbus_message_unref(ftp->msg);
+	ftp->msg = NULL;
+}
+
+static DBusMessage *create_folder(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	struct ftp_data *ftp = user_data;
+	struct session_data *session = ftp->session;
+	GwObex *obex = session_get_obex(session);
+	const char *folder;
+	int err;
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &folder,
+				DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	if (gw_obex_mkdir(obex, folder, &err) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.Failed",
+				"%s", OBEX_ResponseToString(err));
+
+	return dbus_message_new_method_return(message);
+}
+
+static DBusMessage *list_folder(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	struct ftp_data *ftp = user_data;
+	struct session_data *session = ftp->session;
+
+	if (ftp->msg)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InProgress",
+				"Transfer in progress");
+
+	if (session_get(session, "x-obex/folder-listing",
+			NULL, NULL, NULL, 0, list_folder_callback, ftp) < 0)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.Failed",
+				"Failed");
+
+	ftp->msg = dbus_message_ref(message);
+
+	return NULL;
+}
+
+static DBusMessage *get_file(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	struct ftp_data *ftp = user_data;
+	struct session_data *session = ftp->session;
+	const char *target_file, *source_file;
+
+	if (ftp->msg)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InProgress",
+				"Transfer in progress");
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &target_file,
+				DBUS_TYPE_STRING, &source_file,
+				DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	if (session_get(session, NULL, source_file,
+			target_file, NULL, 0, get_file_callback, NULL) < 0)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.Failed",
+				"Failed");
+
+	ftp->msg = dbus_message_ref(message);
+
+	return NULL;
+}
+
+static DBusMessage *put_file(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	struct ftp_data *ftp = user_data;
+	struct session_data *session = ftp->session;
+	gchar *sourcefile, *targetfile;
+
+	if (dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &sourcefile,
+					DBUS_TYPE_STRING, &targetfile,
+					DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments",
+				"Invalid arguments in method call");
+
+	if (session_send(session, sourcefile, targetfile) < 0)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.Failed",
+				"Failed");
+
+	return dbus_message_new_method_return(message);
+}
+
+static DBusMessage *copy_file(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	return dbus_message_new_method_return(message);
+}
+
+static DBusMessage *move_file(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	return dbus_message_new_method_return(message);
+}
+
+static DBusMessage *delete(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	struct ftp_data *ftp = user_data;
+	struct session_data *session = ftp->session;
+	GwObex *obex = session_get_obex(session);
+	const char *file;
+	int err;
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &file,
+				DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	if (gw_obex_delete(obex, file, &err) == FALSE) {
+		return g_dbus_create_error(message,
+				"org.openobex.Error.Failed",
+				"%s", OBEX_ResponseToString(err));
+	}
+
+	return dbus_message_new_method_return(message);
+}
+
+static GDBusMethodTable ftp_methods[] = {
+	{ "ChangeFolder",	"s", "",	change_folder	},
+	{ "CreateFolder",	"s", "",	create_folder	},
+	{ "ListFolder",		"", "aa{sv}",	list_folder,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetFile",		"ss", "",	get_file,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "PutFile",		"ss", "",	put_file	},
+	{ "CopyFile",		"ss", "",	copy_file	},
+	{ "MoveFile",		"ss", "",	move_file	},
+	{ "Delete",		"s", "",	delete		},
+	{ }
+};
+
+static void ftp_free(void *data)
+{
+	struct ftp_data *ftp = data;
+
+	session_unref(ftp->session);
+	dbus_connection_unref(ftp->conn);
+	g_free(ftp);
+}
+
+gboolean ftp_register_interface(DBusConnection *connection, const char *path,
+							void *user_data)
+{
+	struct session_data *session = user_data;
+	struct ftp_data *ftp;
+
+	ftp = g_try_new0(struct ftp_data, 1);
+	if (!ftp)
+		return FALSE;
+
+	ftp->session = session_ref(session);
+	ftp->conn = dbus_connection_ref(connection);
+
+	if (!g_dbus_register_interface(connection, path, FTP_INTERFACE,
+				ftp_methods, NULL, NULL, ftp, ftp_free)) {
+		ftp_free(ftp);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+void ftp_unregister_interface(DBusConnection *connection, const char *path)
+{
+	g_dbus_unregister_interface(connection, path, FTP_INTERFACE);
+}
diff --git a/client/ftp.h b/client/ftp.h
new file mode 100644
index 0000000..1af2a3d
--- /dev/null
+++ b/client/ftp.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2007-2010  Intel Corporation
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <gdbus.h>
+
+gboolean ftp_register_interface(DBusConnection *connection, const char *path,
+							void *user_data);
+void ftp_unregister_interface(DBusConnection *connection, const char *path);
diff --git a/client/session.c b/client/session.c
index 8ad9a49..f2168b4 100644
--- a/client/session.c
+++ b/client/session.c
@@ -43,6 +43,7 @@
 #include "log.h"
 #include "pbap.h"
 #include "sync.h"
+#include "ftp.h"
 #include "transfer.h"
 #include "session.h"
 #include "btio.h"
@@ -52,8 +53,6 @@
 #define SESSION_INTERFACE  "org.openobex.Session"
 #define SESSION_BASEPATH   "/org/openobex"
 
-#define FTP_INTERFACE  "org.openobex.FileTransfer"
-
 #define OBEX_IO_ERROR obex_io_error_quark()
 
 #define BT_BUS_NAME		"org.bluez"
@@ -193,8 +192,7 @@ static void session_unregistered(struct session_data *session)
 
 	switch (session->uuid.value.uuid16) {
 	case OBEX_FILETRANS_SVCLASS_ID:
-		g_dbus_unregister_interface(session->conn, session->path,
-						FTP_INTERFACE);
+		ftp_unregister_interface(session->conn, session->path);
 		break;
 	case PBAP_PSE_SVCLASS_ID:
 		pbap_unregister_interface(session->conn, session->path);
@@ -1034,131 +1032,6 @@ static GDBusMethodTable session_methods[] = {
 	{ }
 };
 
-static void append_variant(DBusMessageIter *iter, int type, void *val)
-{
-	DBusMessageIter value;
-	char sig[2] = { type, '\0' };
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
-
-	dbus_message_iter_append_basic(&value, type, val);
-
-	dbus_message_iter_close_container(iter, &value);
-}
-
-static void dict_append_entry(DBusMessageIter *dict,
-			const char *key, int type, void *val)
-{
-	DBusMessageIter entry;
-
-	if (type == DBUS_TYPE_STRING) {
-		const char *str = *((const char **) val);
-		if (str == NULL)
-			return;
-	}
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-							NULL, &entry);
-
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
-
-	append_variant(&entry, type, val);
-
-	dbus_message_iter_close_container(dict, &entry);
-}
-
-static void xml_element(GMarkupParseContext *ctxt,
-			const gchar *element,
-			const gchar **names,
-			const gchar **values,
-			gpointer user_data,
-			GError **gerr)
-{
-	DBusMessageIter dict, *iter = user_data;
-	gchar *key;
-	gint i;
-
-	if (strcasecmp("folder", element) != 0 && strcasecmp("file", element) != 0)
-		return;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &element);
-
-	/* FIXME: User, Group, Other permission must be reviewed */
-
-	i = 0;
-	for (key = (gchar *) names[i]; key; key = (gchar *) names[++i]) {
-		key[0] = g_ascii_toupper(key[0]);
-		if (g_str_equal("Size", key) == TRUE) {
-			guint64 size;
-			size = g_ascii_strtoll(values[i], NULL, 10);
-			dict_append_entry(&dict, key, DBUS_TYPE_UINT64, &size);
-		} else
-			dict_append_entry(&dict, key, DBUS_TYPE_STRING, &values[i]);
-	}
-
-	dbus_message_iter_close_container(iter, &dict);
-}
-
-static const GMarkupParser parser = {
-	xml_element,
-	NULL,
-	NULL,
-	NULL,
-	NULL
-};
-
-static void list_folder_callback(struct session_data *session,
-					GError *err, void *user_data)
-{
-	struct transfer_data *transfer = session->pending->data;
-	GMarkupParseContext *ctxt;
-	DBusMessage *reply;
-	DBusMessageIter iter, array;
-	const char *buf;
-	int size;
-
-	if (err != NULL) {
-		reply = g_dbus_create_error(session->msg,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		goto done;
-	} else
-		reply = dbus_message_new_method_return(session->msg);
-
-	buf = transfer_get_buffer(transfer, &size);
-	if (size == 0)
-		buf = "";
-
-	dbus_message_iter_init_append(reply, &iter);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_TYPE_ARRAY_AS_STRING
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
-	ctxt = g_markup_parse_context_new(&parser, 0, &array, NULL);
-	g_markup_parse_context_parse(ctxt, buf, strlen(buf) - 1, NULL);
-	g_markup_parse_context_free(ctxt);
-	dbus_message_iter_close_container(&iter, &array);
-
-	transfer_clear_buffer(transfer);
-
-done:
-	g_dbus_send_message(session->conn, reply);
-	dbus_message_unref(session->msg);
-	session->msg = NULL;
-}
-
-static void get_file_callback(struct session_data *session, GError *err,
-							void *user_data)
-{
-
-}
-
 static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 {
 	struct session_data *session = user_data;
@@ -1321,18 +1194,6 @@ static void session_notify_error(struct session_data *session,
 	DBusMessage *message;
 	const char *path;
 
-	if (session->msg) {
-		DBusMessage *reply;
-
-		reply = g_dbus_create_error(session->msg,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
-		g_dbus_send_message(session->conn, reply);
-
-		dbus_message_unref(session->msg);
-		session->msg = NULL;
-	}
-
 	path = transfer_get_path(transfer);
 	if (agent == NULL || path == NULL)
 		goto done;
@@ -1365,18 +1226,6 @@ static void session_notify_progress(struct session_data *session,
 	DBusMessage *message;
 	const char *path;
 
-	/* For GetFile reply on the first received stream */
-	if (session->msg &&
-			dbus_message_has_member(session->msg, "GetFile")) {
-		DBusMessage *reply;
-
-		reply = dbus_message_new_method_return(session->msg);
-		g_dbus_send_message(session->conn, reply);
-
-		dbus_message_unref(session->msg);
-		session->msg = NULL;
-	}
-
 	path = transfer_get_path(transfer);
 	if (agent == NULL || path == NULL)
 		goto done;
@@ -1486,169 +1335,6 @@ int session_get(struct session_data *session, const char *type,
 	return 0;
 }
 
-static DBusMessage *change_folder(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct session_data *session = user_data;
-	const char *folder;
-	int err;
-
-	if (dbus_message_get_args(message, NULL,
-				DBUS_TYPE_STRING, &folder,
-				DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	if (gw_obex_chdir(session->obex, folder, &err) == FALSE) {
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"%s", OBEX_ResponseToString(err));
-	}
-
-	return dbus_message_new_method_return(message);
-}
-
-static DBusMessage *create_folder(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct session_data *session = user_data;
-	const char *folder;
-	int err;
-
-	if (dbus_message_get_args(message, NULL,
-				DBUS_TYPE_STRING, &folder,
-				DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	if (gw_obex_mkdir(session->obex, folder, &err) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"%s", OBEX_ResponseToString(err));
-
-	return dbus_message_new_method_return(message);
-}
-
-static DBusMessage *list_folder(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct session_data *session = user_data;
-
-	if (session->msg)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InProgress",
-				"Transfer in progress");
-
-	if (session_get(session, "x-obex/folder-listing",
-			NULL, NULL, NULL, 0, list_folder_callback, NULL) < 0)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"Failed");
-
-	session->msg = dbus_message_ref(message);
-
-	return NULL;
-}
-
-static DBusMessage *get_file(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct session_data *session = user_data;
-	const char *target_file, *source_file;
-
-	if (session->msg)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InProgress",
-				"Transfer in progress");
-
-	if (dbus_message_get_args(message, NULL,
-				DBUS_TYPE_STRING, &target_file,
-				DBUS_TYPE_STRING, &source_file,
-				DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	if (session_get(session, NULL, source_file,
-			target_file, NULL, 0, get_file_callback, NULL) < 0)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"Failed");
-
-	session->msg = dbus_message_ref(message);
-
-	return NULL;
-}
-
-static DBusMessage *put_file(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct session_data *session = user_data;
-	gchar *sourcefile, *targetfile;
-
-	if (dbus_message_get_args(message, NULL,
-					DBUS_TYPE_STRING, &sourcefile,
-					DBUS_TYPE_STRING, &targetfile,
-					DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments",
-				"Invalid arguments in method call");
-
-	if (session_send(session, sourcefile, targetfile) < 0)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"Failed");
-
-	return dbus_message_new_method_return(message);
-}
-
-static DBusMessage *copy_file(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	return dbus_message_new_method_return(message);
-}
-
-static DBusMessage *move_file(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	return dbus_message_new_method_return(message);
-}
-
-static DBusMessage *delete(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct session_data *session = user_data;
-	const char *file;
-	int err;
-
-	if (dbus_message_get_args(message, NULL,
-				DBUS_TYPE_STRING, &file,
-				DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	if (gw_obex_delete(session->obex, file, &err) == FALSE) {
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"%s", OBEX_ResponseToString(err));
-	}
-
-	return dbus_message_new_method_return(message);
-}
-
-static GDBusMethodTable ftp_methods[] = {
-	{ "ChangeFolder",	"s", "",	change_folder	},
-	{ "CreateFolder",	"s", "",	create_folder	},
-	{ "ListFolder",		"", "aa{sv}",	list_folder,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetFile",		"ss", "",	get_file,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PutFile",		"ss", "",	put_file	},
-	{ "CopyFile",		"ss", "",	copy_file	},
-	{ "MoveFile",		"ss", "",	move_file	},
-	{ "Delete",		"s", "",	delete		},
-	{ }
-};
-
 int session_send(struct session_data *session, const char *filename,
 				const char *targetname)
 {
@@ -1729,9 +1415,8 @@ const char *session_register(struct session_data *session,
 
 	switch (session->uuid.value.uuid16) {
 	case OBEX_FILETRANS_SVCLASS_ID:
-		result = g_dbus_register_interface(session->conn,
-					session->path, FTP_INTERFACE,
-					ftp_methods, NULL, NULL, session, NULL);
+		result = ftp_register_interface(session->conn, session->path,
+								session);
 		break;
 	case PBAP_PSE_SVCLASS_ID:
 		result = pbap_register_interface(session->conn, session->path,
-- 
1.7.6

