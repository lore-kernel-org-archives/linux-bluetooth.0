Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/4] client: port to gobex
Date: Thu,  1 Sep 2011 12:21:27 +0300
Message-Id: <1314868888-31435-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314868888-31435-1-git-send-email-luiz.dentz@gmail.com>
References: <1314868888-31435-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This remove gwobex dependency of the client using gobex instead.
---
 Makefile.am       |    2 +-
 client/driver.h   |    2 +-
 client/ftp.c      |  139 +++++++++++++------
 client/pbap.c     |  144 ++++++++++++++------
 client/session.c  |   74 ++++++++---
 client/session.h  |    5 +-
 client/sync.c     |    3 +
 client/transfer.c |  390 ++++++++++++++++++++++++++++++----------------------
 client/transfer.h |    5 +-
 9 files changed, 490 insertions(+), 274 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 374fa1d..5f0b2eb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -123,7 +123,7 @@ service_in_files += client/obex-client.service.in
 libexec_PROGRAMS += client/obex-client
 
 client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
-				$(gwobex_sources) $(btio_sources) \
+				$(btio_sources) \
 				client/main.c src/log.h src/log.c \
 				client/manager.h client/manager.c \
 				client/session.h client/session.c \
diff --git a/client/driver.h b/client/driver.h
index 4c54fb8..f1c0646 100644
--- a/client/driver.h
+++ b/client/driver.h
@@ -25,7 +25,7 @@ struct obc_driver {
 	const char *service;
 	const char *uuid;
 	void *target;
-	int target_len;
+	gsize target_len;
 	int (*probe) (struct obc_session *session);
 	void (*remove) (struct obc_session *session);
 };
diff --git a/client/ftp.c b/client/ftp.c
index 159bf47..2d1a87c 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -28,7 +28,6 @@
 #include <errno.h>
 #include <string.h>
 
-#include <gw-obex.h>
 #include <gdbus.h>
 
 #include "log.h"
@@ -38,6 +37,10 @@
 #include "driver.h"
 #include "ftp.h"
 
+#define OBEX_FTP_UUID \
+	"\xF9\xEC\x7B\xC4\x95\x3C\x11\xD2\x98\x4E\x52\x54\x00\xDC\x9E\x09"
+#define OBEX_FTP_UUID_LEN 16
+
 #define FTP_INTERFACE "org.openobex.FileTransfer"
 #define FTP_UUID "00001106-0000-1000-8000-00805f9b34fb"
 #define PCSUITE_UUID "00005005-0000-1000-8000-0002ee000001"
@@ -49,14 +52,29 @@ struct ftp_data {
 	DBusMessage *msg;
 };
 
+static void async_cb(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	DBusMessage *reply, *msg = user_data;
+
+	if (err != NULL)
+		reply = g_dbus_create_error(msg, "org.openobex.Error.Failed",
+						"%s", err->message);
+	else
+		reply = dbus_message_new_method_return(msg);
+
+	g_dbus_send_message(conn, reply);
+	dbus_message_unref(msg);
+}
+
 static DBusMessage *change_folder(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GwObex *obex = obc_session_get_obex(session);
+	GObex *obex = obc_session_get_obex(session);
 	const char *folder;
-	int err;
+	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &folder,
@@ -64,13 +82,19 @@ static DBusMessage *change_folder(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	if (gw_obex_chdir(obex, folder, &err) == FALSE) {
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"%s", OBEX_ResponseToString(err));
+	g_obex_setpath(obex, folder, async_cb, message, &err);
+	if (err != NULL) {
+		DBusMessage *reply;
+		reply =  g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
+		return reply;
 	}
 
-	return dbus_message_new_method_return(message);
+	dbus_message_ref(message);
+
+	return NULL;
 }
 
 static void append_variant(DBusMessageIter *iter, int type, void *val)
@@ -214,9 +238,9 @@ static DBusMessage *create_folder(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GwObex *obex = obc_session_get_obex(session);
+	GObex *obex = obc_session_get_obex(session);
 	const char *folder;
-	int err;
+	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &folder,
@@ -224,12 +248,19 @@ static DBusMessage *create_folder(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	if (gw_obex_mkdir(obex, folder, &err) == FALSE)
-		return g_dbus_create_error(message,
+	g_obex_mkdir(obex, folder, async_cb, message, &err);
+	if (err != NULL) {
+		DBusMessage *reply;
+		reply = g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
-				"%s", OBEX_ResponseToString(err));
+				"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 
-	return dbus_message_new_method_return(message);
+	dbus_message_ref(message);
+
+	return NULL;
 }
 
 static DBusMessage *list_folder(DBusConnection *connection,
@@ -312,9 +343,9 @@ static DBusMessage *copy_file(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GwObex *obex = obc_session_get_obex(session);
+	GObex *obex = obc_session_get_obex(session);
 	const char *filename, *destname;
-	int err;
+	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &filename,
@@ -323,12 +354,19 @@ static DBusMessage *copy_file(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	if (gw_obex_copy(obex, filename, destname, &err) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"%s", OBEX_ResponseToString(err));
+	g_obex_copy(obex, filename, destname, async_cb, message, &err);
+	if (err != NULL) {
+		DBusMessage *reply;
+		reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 
-	return dbus_message_new_method_return(message);
+	dbus_message_ref(message);
+
+	return NULL;
 }
 
 static DBusMessage *move_file(DBusConnection *connection,
@@ -336,9 +374,9 @@ static DBusMessage *move_file(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GwObex *obex = obc_session_get_obex(session);
+	GObex *obex = obc_session_get_obex(session);
 	const char *filename, *destname;
-	int err;
+	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &filename,
@@ -347,12 +385,19 @@ static DBusMessage *move_file(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	if (gw_obex_move(obex, filename, destname, &err) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"%s", OBEX_ResponseToString(err));
+	g_obex_move(obex, filename, destname, async_cb, message, &err);
+	if (err != NULL) {
+		DBusMessage *reply;
+		reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 
-	return dbus_message_new_method_return(message);
+	dbus_message_ref(message);
+
+	return NULL;
 }
 
 static DBusMessage *delete(DBusConnection *connection,
@@ -360,9 +405,9 @@ static DBusMessage *delete(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GwObex *obex = obc_session_get_obex(session);
+	GObex *obex = obc_session_get_obex(session);
 	const char *file;
-	int err;
+	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &file,
@@ -370,26 +415,38 @@ static DBusMessage *delete(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	if (gw_obex_delete(obex, file, &err) == FALSE) {
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"%s", OBEX_ResponseToString(err));
+	g_obex_delete(obex, file, async_cb, message, &err);
+	if (err != NULL) {
+		DBusMessage *reply;
+		reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
+		return reply;
 	}
 
-	return dbus_message_new_method_return(message);
+	dbus_message_ref(message);
+
+	return NULL;
 }
 
 static GDBusMethodTable ftp_methods[] = {
-	{ "ChangeFolder",	"s", "",	change_folder	},
-	{ "CreateFolder",	"s", "",	create_folder	},
+	{ "ChangeFolder",	"s", "",	change_folder,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "CreateFolder",	"s", "",	create_folder,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "ListFolder",		"", "aa{sv}",	list_folder,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetFile",		"ss", "",	get_file,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PutFile",		"ss", "",	put_file	},
-	{ "CopyFile",		"ss", "",	copy_file	},
-	{ "MoveFile",		"ss", "",	move_file	},
-	{ "Delete",		"s", "",	delete		},
+	{ "PutFile",		"ss", "",	put_file,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "CopyFile",		"ss", "",	copy_file,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "MoveFile",		"ss", "",	move_file,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Delete",		"s", "",	delete,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 
diff --git a/client/pbap.c b/client/pbap.c
index 1fa4cb3..9e9eb05 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -41,6 +41,10 @@
 #include "driver.h"
 #include "pbap.h"
 
+#define OBEX_PBAP_UUID \
+	"\x79\x61\x35\xF0\xF0\xC5\x11\xD8\x09\x66\x08\x00\x20\x0C\x9A\x66"
+#define OBEX_PBAP_UUID_LEN 16
+
 #define ERROR_INF PBAP_INTERFACE ".Error"
 
 #define FORMAT_VCARD21	0x0
@@ -237,65 +241,122 @@ static gchar *build_phonebook_path(const char *location, const char *item)
 	return path;
 }
 
+typedef void (*setpath_cb_t) (GError *err, gpointer user_data);
+
+struct setpath_data {
+	char **remaining;
+	int index;
+	setpath_cb_t func;
+	gpointer user_data;
+};
+
+static void setpath_complete(GError *err, struct setpath_data *data)
+{
+	if (data->func)
+		data->func(err, data->user_data);
+	g_strfreev(data->remaining);
+	g_free(data);
+}
+
+static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	struct setpath_data *data = user_data;
+	char *next;
+
+	if (err != NULL) {
+		setpath_complete(err, data);
+		return;
+	}
+
+	next = data->remaining[data->index];
+	if (next == NULL) {
+		setpath_complete(NULL, data);
+		return;
+	}
+
+	data->index++;
+
+	g_obex_setpath(obex, next, setpath_cb, data, &err);
+	if (err != NULL) {
+		setpath_complete(err, data);
+		g_error_free(err);
+	}
+}
+
+static gboolean setpath(GObex *obex, const char *path, size_t max_elem,
+					setpath_cb_t func, gpointer user_data)
+{
+	GError *err = NULL;
+	struct setpath_data *data;
+
+	data = g_new0(struct setpath_data, 1);
+
+	g_obex_setpath(obex, "", setpath_cb, data, &err);
+	if (err != NULL) {
+		error("set_path: %s", err->message);
+		g_error_free(err);
+		g_free(data);
+		return FALSE;
+	}
+
+	data->func = func;
+	data->user_data = user_data;
+	data->remaining = g_strsplit(path, "/", max_elem);
+
+	return TRUE;
+}
+
 /* should only be called inside pbap_set_path */
 static void pbap_reset_path(struct pbap_data *pbap)
 {
-	int err = 0;
-	char **paths = NULL, **item;
-	GwObex *obex = obc_session_get_obex(pbap->session);
+	GObex *obex = obc_session_get_obex(pbap->session);
 
 	if (!pbap->path)
 		return;
 
-	gw_obex_chdir(obex, "", &err);
+	setpath(obex, pbap->path, 3, NULL, NULL);
+}
 
-	paths = g_strsplit(pbap->path, "/", 3);
+static void pbap_setpath_cb(GError *err, gpointer user_data)
+{
+	struct pbap_data *pbap = user_data;
+
+	if (err != NULL)
+		pbap_reset_path(user_data);
+
+	if (pbap->msg == NULL)
+		return;
 
-	for (item = paths; *item; item++)
-		gw_obex_chdir(obex, *item, &err);
+	if (err) {
+		DBusMessage *reply= g_dbus_create_error(pbap->msg,
+							ERROR_INF ".Failed",
+							"%s", err->message);
+		g_dbus_send_message(conn, reply);
+	} else
+		g_dbus_send_reply(conn, pbap->msg, DBUS_TYPE_INVALID);
 
-	g_strfreev(paths);
+	dbus_message_unref(pbap->msg);
+	pbap->msg = NULL;
 }
 
-static gint pbap_set_path(struct pbap_data *pbap, const char *path)
+static int pbap_set_path(struct pbap_data *pbap, const char *path)
 {
-	int err = 0;
-	char **paths = NULL, **item;
-	GwObex *obex = obc_session_get_obex(pbap->session);
+	GObex *obex = obc_session_get_obex(pbap->session);
 
 	if (!path)
-		return OBEX_RSP_BAD_REQUEST;
+		return G_OBEX_RSP_BAD_REQUEST;
 
 	if (pbap->path != NULL && g_str_equal(pbap->path, path))
 		return 0;
 
-	if (gw_obex_chdir(obex, "", &err) == FALSE) {
-		if (err == OBEX_RSP_NOT_IMPLEMENTED)
-			goto done;
-		goto fail;
-	}
+	if (!setpath(obex, path, 3, pbap_setpath_cb, pbap))
+		return G_OBEX_RSP_INTERNAL_SERVER_ERROR;
 
-	paths = g_strsplit(path, "/", 3);
-	for (item = paths; *item; item++) {
-		if (gw_obex_chdir(obex, *item, &err) == FALSE) {
-			/* we need to reset the path to the saved one on fail*/
-			pbap_reset_path(pbap);
-			goto fail;
-		}
-	}
-
-	g_strfreev(paths);
-
-done:
 	g_free(pbap->path);
 	pbap->path = g_strdup(path);
-	return 0;
-
-fail:
-	if (paths)
-		g_strfreev(paths);
 
-	return err;
+	return G_OBEX_RSP_SUCCESS;
 }
 
 static void read_return_apparam(struct obc_session *session,
@@ -725,12 +786,14 @@ static DBusMessage *pbap_select(DBusConnection *connection,
 
 	err = pbap_set_path(pbap, path);
 	g_free(path);
-	if (err)
+	if (err != G_OBEX_RSP_SUCCESS)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Failed",
-				"%s", OBEX_ResponseToString(err));
+				"0x%02x", err);
 
-	return dbus_message_new_method_return(message);
+	pbap->msg = dbus_message_ref(message);
+
+	return NULL;
 }
 
 static DBusMessage *pbap_pull_all(DBusConnection *connection,
@@ -968,7 +1031,8 @@ static DBusMessage *pbap_list_filter_fields(DBusConnection *connection,
 }
 
 static GDBusMethodTable pbap_methods[] = {
-	{ "Select",	"ss",	"",	pbap_select },
+	{ "Select",	"ss",	"",	pbap_select,
+					G_DBUS_METHOD_FLAG_ASYNC },
 	{ "PullAll",	"",	"s",	pbap_pull_all,
 					G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Pull",	"s",	"s",	pbap_pull_vcard,
diff --git a/client/session.c b/client/session.c
index 8ad20d1..4fe682d 100644
--- a/client/session.c
+++ b/client/session.c
@@ -33,7 +33,7 @@
 
 #include <glib.h>
 #include <gdbus.h>
-#include <gw-obex.h>
+#include <gobex.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/rfcomm.h>
@@ -92,7 +92,7 @@ struct obc_session {
 	DBusConnection *conn;
 	DBusConnection *conn_system; /* system bus connection */
 	DBusMessage *msg;
-	GwObex *obex;
+	GObex *obex;
 	GIOChannel *io;
 	struct obc_agent *agent;
 	struct session_callback *callback;
@@ -191,7 +191,7 @@ static void session_free(struct obc_session *session)
 		g_dbus_remove_watch(session->conn, session->watch);
 
 	if (session->obex != NULL)
-		gw_obex_close(session->obex);
+		g_obex_unref(session->obex);
 
 	if (session->io != NULL) {
 		g_io_channel_shutdown(session->io, TRUE, NULL);
@@ -284,13 +284,38 @@ void obc_session_unref(struct obc_session *session)
 	session_free(session);
 }
 
+static void connect_cb(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	struct callback_data *callback = user_data;
+	GError *gerr = NULL;
+	uint8_t rsp_code;
+
+	if (err != NULL) {
+		error("connect_cb: %s", err->message);
+		gerr = g_error_copy(err);
+		goto done;
+	}
+
+	rsp_code = g_obex_packet_get_operation(rsp, NULL);
+	if (rsp_code != G_OBEX_RSP_SUCCESS)
+		gerr = g_error_new(OBEX_IO_ERROR, -EIO,
+				"OBEX Connect failed with 0x%02x", rsp_code);
+
+done:
+	callback->func(callback->session, gerr, callback->data);
+	if (gerr != NULL)
+		g_error_free(gerr);
+	obc_session_unref(callback->session);
+	g_free(callback);
+}
+
 static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct callback_data *callback = user_data;
 	struct obc_session *session = callback->session;
 	struct obc_driver *driver = session->driver;
-	GwObex *obex;
-	int fd;
+	GObex *obex;
 
 	DBG("");
 
@@ -299,25 +324,37 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 		goto done;
 	}
 
-	/* do not close when gw_obex is using the fd */
 	g_io_channel_set_close_on_unref(session->io, FALSE);
+
+	obex = g_obex_new(session->io, G_OBEX_TRANSPORT_STREAM, -1, -1);
+	if (obex == NULL)
+		goto done;
+
+	g_io_channel_set_close_on_unref(session->io, TRUE);
 	g_io_channel_unref(session->io);
 	session->io = NULL;
 
-	fd = g_io_channel_unix_get_fd(io);
+	if (driver->target != NULL)
+		g_obex_connect(obex, connect_cb, callback, &err,
+			G_OBEX_HDR_TARGET, driver->target, driver->target_len,
+			G_OBEX_HDR_INVALID);
+	else
+		g_obex_connect(obex, connect_cb, callback, &err,
+							G_OBEX_HDR_INVALID);
 
-	obex = gw_obex_setup_fd(fd, driver->target, driver->target_len,
-								NULL, NULL);
+	if (err != NULL) {
+		error("%s", err->message);
+		g_obex_unref(obex);
+		goto done;
+	}
 
 	session->obex = obex;
-
 	sessions = g_slist_prepend(sessions, session);
 
+	return;
 done:
 	callback->func(callback->session, err, callback->data);
-
 	obc_session_unref(callback->session);
-
 	g_free(callback);
 }
 
@@ -1146,11 +1183,11 @@ done:
 		session_notify_complete(session, transfer);
 }
 
-static void transfer_progress(struct obc_transfer *transfer, gint64 transferred,
-				int err, void *user_data)
+static void transfer_progress(struct obc_transfer *transfer,
+					gint64 transferred, GError *err,
+					void *user_data)
 {
 	struct obc_session *session = user_data;
-	GError *gerr = NULL;
 
 	if (err != 0)
 		goto fail;
@@ -1160,10 +1197,7 @@ static void transfer_progress(struct obc_transfer *transfer, gint64 transferred,
 	return;
 
 fail:
-	g_set_error(&gerr, OBEX_IO_ERROR, err, "%s",
-			err > 0 ? OBEX_ResponseToString(err) : strerror(-err));
-	session_notify_error(session, transfer, gerr);
-	g_clear_error(&gerr);
+	session_notify_error(session, transfer, err);
 }
 
 static void session_prepare_get(struct obc_session *session,
@@ -1427,7 +1461,7 @@ const char *obc_session_get_target(struct obc_session *session)
 	return session->driver->target;
 }
 
-GwObex *obc_session_get_obex(struct obc_session *session)
+GObex *obc_session_get_obex(struct obc_session *session)
 {
 	return session->obex;
 }
diff --git a/client/session.h b/client/session.h
index 8a9480b..e0c837c 100644
--- a/client/session.h
+++ b/client/session.h
@@ -21,9 +21,10 @@
  *
  */
 
+#include <stdint.h>
 #include <glib.h>
 #include <gdbus.h>
-#include <gw-obex.h>
+#include <gobex.h>
 
 struct obc_session;
 
@@ -52,7 +53,7 @@ const char *obc_session_get_agent(struct obc_session *session);
 
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
-GwObex *obc_session_get_obex(struct obc_session *session);
+GObex *obc_session_get_obex(struct obc_session *session);
 
 struct obc_transfer *obc_session_get_transfer(struct obc_session *session);
 void obc_session_add_transfer(struct obc_session *session,
diff --git a/client/sync.c b/client/sync.c
index 349f950..7675b23 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -38,6 +38,9 @@
 #include "driver.h"
 #include "sync.h"
 
+#define OBEX_SYNC_UUID "IRMC-SYNC"
+#define OBEX_SYNC_UUID_LEN 9
+
 #define SYNC_INTERFACE	"org.openobex.Synchronization"
 #define ERROR_INF SYNC_INTERFACE ".Error"
 #define SYNC_UUID "00001104-0000-1000-8000-00805f9b34fb"
diff --git a/client/transfer.c b/client/transfer.c
index af48f69..ea56429 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -33,7 +33,6 @@
 
 #include <glib.h>
 #include <gdbus.h>
-#include <gw-obex.h>
 
 #include "log.h"
 #include "transfer.h"
@@ -61,7 +60,7 @@ struct obc_transfer {
 	char *name;		/* Transfer object name */
 	char *type;		/* Transfer object type */
 	int fd;
-	GwObexXfer *xfer;
+	guint xfer;
 	char *buffer;
 	size_t buffer_len;
 	int filled;
@@ -131,6 +130,27 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 	return reply;
 }
 
+static void obc_transfer_abort(struct obc_transfer *transfer)
+{
+	struct transfer_callback *callback = transfer->callback;
+
+	if (transfer->xfer == 0)
+		return;
+
+	g_obex_cancel_transfer(transfer->xfer);
+	transfer->xfer = 0;
+
+	if (callback) {
+		GError *err;
+
+		err = g_error_new(G_OBEX_ERROR, -ECANCELED,
+							strerror(ECANCELED));
+		callback->func(transfer, transfer->transferred, err,
+							callback->data);
+		g_error_free(err);
+	}
+}
+
 static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -167,10 +187,8 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 
 	DBG("%p", transfer);
 
-	if (transfer->xfer) {
-		gw_obex_xfer_close(transfer->xfer, NULL);
-		gw_obex_xfer_free(transfer->xfer);
-	}
+	if (transfer->xfer)
+		g_obex_cancel_transfer(transfer->xfer);
 
 	if (transfer->fd > 0)
 		close(transfer->fd);
@@ -256,90 +274,141 @@ void obc_transfer_unregister(struct obc_transfer *transfer)
 	obc_transfer_free(transfer);
 }
 
-static gboolean obc_transfer_read(struct obc_transfer *transfer, GwObexXfer *xfer)
+static void obc_transfer_read(struct obc_transfer *transfer,
+						const void *buf, gsize len)
 {
-	gint bsize, bread;
-
-	/* check if object size is available */
-	if (transfer->size == 0)
-		transfer->size = gw_obex_xfer_object_size(xfer);
+	gsize bsize;
 
-	/* read all buffered data */
-	do {
-		bsize = transfer->buffer_len - transfer->filled;
+	/* copy all buffered data */
+	bsize = transfer->buffer_len - transfer->filled;
 
-		if (bsize < DEFAULT_BUFFER_SIZE) {
-			transfer->buffer_len += DEFAULT_BUFFER_SIZE;
-			transfer->buffer = g_realloc(transfer->buffer,
+	if (bsize < len) {
+		transfer->buffer_len += len - bsize;
+		transfer->buffer = g_realloc(transfer->buffer,
 							transfer->buffer_len);
-			bsize += DEFAULT_BUFFER_SIZE;
-		}
-
-		if (gw_obex_xfer_read(xfer, transfer->buffer +
-				transfer->filled, bsize, &bread,
-				&transfer->err) == FALSE) {
-			if (transfer->err == GW_OBEX_ERROR_NO_DATA) {
-				transfer->err = 0;
-				return TRUE;
-			} else
-				return FALSE;
-		}
-
-		transfer->filled += bread;
-		transfer->transferred += bread;
-	} while (bread != 0);
+	}
 
-	/* set size to transferred if object is done and size is unknown */
-	if (gw_obex_xfer_object_done(xfer) == TRUE &&
-			transfer->size == GW_OBEX_UNKNOWN_LENGTH)
-		transfer->size = transfer->transferred;
+	memcpy(transfer->buffer + transfer->filled, buf, len);
 
-	return TRUE;
+	transfer->filled += len;
+	transfer->transferred += len;
 }
 
-static void get_buf_xfer_progress(GwObexXfer *xfer,
-					gpointer user_data)
+static void get_buf_xfer_complete(GObex *obex, GError *err, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
+	gsize bsize;
+
+	transfer->xfer = 0;
 
-	if (obc_transfer_read(transfer, xfer) == FALSE)
-		goto fail;
+	if (err) {
+		transfer->err = err->code;
+		goto done;
+	}
 
-	if (gw_obex_xfer_object_done(xfer)) {
-		int bsize;
-		if (transfer->filled > 0 &&
-				transfer->buffer[transfer->filled - 1] == '\0')
-			goto done;
+	if (transfer->filled > 0 &&
+			transfer->buffer[transfer->filled - 1] == '\0')
+		goto done;
 
-		bsize = transfer->buffer_len - transfer->filled;
-		if (bsize < 1) {
-			transfer->buffer_len += DEFAULT_BUFFER_SIZE;
-			transfer->buffer = g_realloc(transfer->buffer,
+	bsize = transfer->buffer_len - transfer->filled;
+	if (bsize < 1) {
+		transfer->buffer_len += 1;
+		transfer->buffer = g_realloc(transfer->buffer,
 						transfer->buffer_len);
+	}
+
+	transfer->buffer[transfer->filled] = '\0';
+	transfer->size = strlen(transfer->buffer);
+
+done:
+	if (callback)
+		callback->func(transfer, transfer->size, err, callback->data);
+}
+
+static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	struct obc_transfer *transfer = user_data;
+	struct transfer_callback *callback = transfer->callback;
+	GObexPacket *req;
+	GObexHeader *hdr;
+	const guint8 *buf;
+	gsize len;
+	guint8 rspcode;
+	gboolean final;
+
+	if (err != NULL) {
+		get_buf_xfer_complete(obex, err, transfer);
+		return;
+	}
+
+	rspcode = g_obex_packet_get_operation(rsp, &final);
+	if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
+		err = g_error_new(G_OBEX_ERROR, rspcode,
+					"Transfer failed (0x%02x)", rspcode);
+		get_buf_xfer_complete(obex, err, transfer);
+		g_error_free(err);
+		return;
+	}
+
+	hdr = g_obex_packet_find_header(rsp, G_OBEX_HDR_APPARAM);
+	if (hdr) {
+		g_obex_header_get_bytes(hdr, &buf, &len);
+		if (len != 0) {
+			transfer->params->data = g_memdup(buf, len);
+			transfer->params->size = len;
 		}
+	}
+
+	hdr = g_obex_packet_get_body(rsp);
+	if (hdr) {
+		g_obex_header_get_bytes(hdr, &buf, &len);
+		if (len != 0)
+			obc_transfer_read(transfer, buf, len);
+	}
+
+	if (rspcode == G_OBEX_RSP_SUCCESS) {
+		get_buf_xfer_complete(obex, err, transfer);
+		return;
+	}
+
+	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
+
+	transfer->xfer = g_obex_send_req(obex, req, -1, get_buf_xfer_progress,
+							transfer, &err);
+
+	if (callback)
+		callback->func(transfer, transfer->transferred, err,
+							callback->data);
+}
 
-		transfer->buffer[transfer->filled] = '\0';
+static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
+{
+	struct obc_transfer *transfer = user_data;
+	struct transfer_callback *callback = transfer->callback;
+
+	transfer->xfer = 0;
+
+	if (err) {
+		transfer->err = err->code;
 		goto done;
 	}
 
-	return;
+	transfer->size = transfer->transferred;
 
 done:
-	transfer->size = strlen(transfer->buffer);
-fail:
 	if (callback)
-		callback->func(transfer, transfer->size, transfer->err,
-				callback->data);
+		callback->func(transfer, transfer->size, err, callback->data);
 }
 
-static void get_xfer_progress(GwObexXfer *xfer, gpointer user_data)
+static gboolean get_xfer_progress(const void *buf, gsize len,
+							gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
 
-	if (obc_transfer_read(transfer, xfer) == FALSE)
-		goto done;
+	obc_transfer_read(transfer, buf, len);
 
 	if (transfer->fd > 0) {
 		gint w;
@@ -347,86 +416,63 @@ static void get_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 		w = write(transfer->fd, transfer->buffer, transfer->filled);
 		if (w < 0) {
 			transfer->err = -errno;
-			goto done;
+			return FALSE;
 		}
 
 		transfer->filled -= w;
 	}
 
-done:
 	if (callback)
-		callback->func(transfer, transfer->transferred, transfer->err,
-				callback->data);
+		callback->func(transfer, transfer->transferred, NULL,
+							callback->data);
+
+	return TRUE;
 }
 
-static void put_buf_xfer_progress(GwObexXfer *xfer, gpointer user_data)
+static gssize put_buf_xfer_progress(void *buf, gsize len, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
-	gint written;
+	gsize size;
 
 	if (transfer->transferred == transfer->size)
-		goto done;
+		return 0;
 
-	if (gw_obex_xfer_write(xfer, transfer->buffer + transfer->transferred,
-				transfer->size - transfer->transferred,
-				&written, &transfer->err) == FALSE)
-		goto done;
+	size = transfer->size - transfer->transferred;
+	size = len > size ? len : size;
+	if (size == 0)
+		return 0;
 
-	if (gw_obex_xfer_flush(xfer, &transfer->err) == FALSE)
-		goto done;
+	memcpy(buf, transfer->buffer + transfer->transferred, size);
 
-	transfer->transferred += written;
+	transfer->transferred += size;
 
-done:
 	if (callback)
-		callback->func(transfer, transfer->transferred, transfer->err,
-				callback->data);
+		callback->func(transfer, transfer->transferred, NULL,
+							callback->data);
+
+	return size;
 }
 
-static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
+static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
-	gint written;
+	gssize size;
 
-	if (transfer->buffer_len == 0) {
-		transfer->buffer_len = DEFAULT_BUFFER_SIZE;
-		transfer->buffer = g_new0(char, DEFAULT_BUFFER_SIZE);
+	size = read(transfer->fd, buf, len);
+	if (size <= 0) {
+		transfer->err = -errno;
+		return size;
 	}
 
-	do {
-		ssize_t len;
-
-		len = read(transfer->fd, transfer->buffer + transfer->filled,
-				transfer->buffer_len - transfer->filled);
-		if (len < 0) {
-			transfer->err = -errno;
-			goto done;
-		}
-
-		transfer->filled += len;
-
-		if (transfer->filled == 0) {
-			gw_obex_xfer_close(xfer, &transfer->err);
-			goto done;
-		}
-
-		if (gw_obex_xfer_write(xfer, transfer->buffer,
-					transfer->filled,
-					&written, &transfer->err) == FALSE)
-			goto done;
-
-		transfer->filled -= written;
-		transfer->transferred += written;
-	} while (transfer->filled == 0);
-
-	memmove(transfer->buffer, transfer->buffer + written, transfer->filled);
+	transfer->transferred += size;
 
-done:
 	if (callback)
-		callback->func(transfer, transfer->transferred, transfer->err,
-				callback->data);
+		callback->func(transfer, transfer->transferred, NULL,
+							callback->data);
+
+	return size;
 }
 
 static void obc_transfer_set_callback(struct obc_transfer *transfer,
@@ -448,17 +494,21 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data)
 {
 	struct obc_session *session = transfer->session;
-	GwObex *obex;
-	gw_obex_xfer_cb_t cb;
-
-	if (transfer->xfer != NULL)
+	GError *err = NULL;
+	GObex *obex;
+	GObexPacket *req;
+	GObexDataConsumer data_cb;
+	GObexFunc complete_cb;
+	GObexResponseFunc rsp_cb = NULL;
+
+	if (transfer->xfer != 0)
 		return -EALREADY;
 
 	if (transfer->type != NULL &&
 			(strncmp(transfer->type, "x-obex/", 7) == 0 ||
-			strncmp(transfer->type, "x-bt/", 5) == 0))
-		cb = get_buf_xfer_progress;
-	else {
+			strncmp(transfer->type, "x-bt/", 5) == 0)) {
+		rsp_cb = get_buf_xfer_progress;
+	} else {
 		int fd = open(transfer->name ? : transfer->filename,
 				O_WRONLY | O_CREAT, 0600);
 
@@ -467,31 +517,41 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 			return -errno;
 		}
 		transfer->fd = fd;
-		cb = get_xfer_progress;
+		data_cb = get_xfer_progress;
+		complete_cb = xfer_complete;
 	}
 
 	obex = obc_session_get_obex(session);
 
+	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
+
+	if (transfer->filename != NULL)
+		g_obex_packet_add_unicode(req, G_OBEX_HDR_NAME,
+							transfer->filename);
+
+	if (transfer->type != NULL)
+		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
+						strlen(transfer->type) + 1);
+
 	if (transfer->params != NULL)
-		transfer->xfer = gw_obex_get_async_with_apparam(obex,
-							transfer->filename,
-							transfer->type,
-							transfer->params->data,
-							transfer->params->size,
-							NULL);
+		g_obex_packet_add_bytes(req, G_OBEX_HDR_APPARAM,
+						transfer->params->data,
+						transfer->params->size);
+
+	if (rsp_cb)
+		transfer->xfer = g_obex_send_req(obex, req, -1, rsp_cb,
+							transfer, &err);
 	else
-		transfer->xfer = gw_obex_get_async(obex,
-							transfer->filename,
-							transfer->type,
-							NULL);
-	if (transfer->xfer == NULL)
+		transfer->xfer = g_obex_get_req_pkt(obex, req, data_cb,
+							complete_cb, transfer,
+							&err);
+
+	if (transfer->xfer == 0)
 		return -ENOTCONN;
 
 	if (func)
 		obc_transfer_set_callback(transfer, func, user_data);
 
-	gw_obex_xfer_set_callback(transfer->xfer, cb, transfer);
-
 	return 0;
 }
 
@@ -499,16 +559,18 @@ int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data)
 {
 	struct obc_session *session = transfer->session;
-	GwObex *obex;
-	gw_obex_xfer_cb_t cb;
+	GError *err = NULL;
+	GObex *obex;
+	GObexPacket *req;
+	GObexDataProducer data_cb;
 	struct stat st;
-	int fd, size;
+	int fd;
 
-	if (transfer->xfer != NULL)
+	if (transfer->xfer != 0)
 		return -EALREADY;
 
 	if (transfer->buffer) {
-		cb = put_buf_xfer_progress;
+		data_cb = put_buf_xfer_progress;
 		goto done;
 	}
 
@@ -526,49 +588,47 @@ int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
 
 	transfer->fd = fd;
 	transfer->size = st.st_size;
-	cb = put_xfer_progress;
+	data_cb = put_xfer_progress;
 
 done:
 	obex = obc_session_get_obex(session);
-	size = transfer->size < UINT32_MAX ? transfer->size : 0;
-	transfer->xfer = gw_obex_put_async(obex, transfer->name,
-						transfer->type, size,
-						-1, NULL);
-	if (transfer->xfer == NULL)
-		return -ENOTCONN;
+	req = g_obex_packet_new(G_OBEX_OP_PUT, FALSE, G_OBEX_HDR_INVALID);
 
-	if (func)
-		obc_transfer_set_callback(transfer, func, user_data);
+	if (transfer->name != NULL)
+		g_obex_packet_add_unicode(req, G_OBEX_HDR_NAME,
+							transfer->name);
 
-	gw_obex_xfer_set_callback(transfer->xfer, cb, transfer);
+	if (transfer->type != NULL)
+		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
+						strlen(transfer->type) + 1);
 
-	return 0;
-}
+	if (transfer->size < UINT32_MAX)
+		g_obex_packet_add_uint32(req, G_OBEX_HDR_LENGTH, transfer->size);
 
-void obc_transfer_abort(struct obc_transfer *transfer)
-{
-	struct transfer_callback *callback = transfer->callback;
+	if (transfer->params != NULL)
+		g_obex_packet_add_bytes(req, G_OBEX_HDR_APPARAM,
+						transfer->params->data,
+						transfer->params->size);
 
-	if (transfer->xfer == NULL)
-		return;
+	transfer->xfer = g_obex_put_req_pkt(obex, req, data_cb, xfer_complete,
+							transfer, &err);
+	if (transfer->xfer == 0)
+		return -ENOTCONN;
 
-	gw_obex_xfer_abort(transfer->xfer, NULL);
-	gw_obex_xfer_free(transfer->xfer);
-	transfer->xfer = NULL;
+	if (func)
+		obc_transfer_set_callback(transfer, func, user_data);
 
-	if (callback)
-		callback->func(transfer, transfer->transferred, -ECANCELED,
-				callback->data);
+	return 0;
 }
 
 int obc_transfer_get_params(struct obc_transfer *transfer,
 					struct obc_transfer_params *params)
 {
-	if (!transfer->xfer)
+	if (transfer->xfer == 0)
 		return -ENOTCONN;
 
-	params->data = gw_obex_xfer_object_apparam(transfer->xfer,
-								&params->size);
+	params->data = transfer->params->data;
+	params->size = transfer->params->size;
 
 	return 0;
 }
diff --git a/client/transfer.h b/client/transfer.h
index ec0cf8e..ba53fd1 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -21,8 +21,6 @@
  *
  */
 
-#include <gw-obex.h>
-
 struct obc_transfer_params {
 	guint8 *data;
 	size_t size;
@@ -31,7 +29,7 @@ struct obc_transfer_params {
 struct obc_transfer;
 
 typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
-					gint64 transferred, gint err,
+					gint64 transferred, GError *err,
 					void *user_data);
 
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
@@ -47,7 +45,6 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data);
 int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data);
-void obc_transfer_abort(struct obc_transfer *transfer);
 
 int obc_transfer_get_params(struct obc_transfer *transfer,
 					struct obc_transfer_params *params);
-- 
1.7.6

