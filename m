Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/6] client: fix circular dependency of session and transfer
Date: Fri, 20 Jan 2012 11:49:56 +0200
Message-Id: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently the code has to to pass session to transfer via user data
(void *) only to be casted to session.
---
 client/ftp.c      |    7 +--
 client/manager.c  |    6 +--
 client/map.c      |    9 +---
 client/pbap.c     |   42 ++++-------------
 client/session.c  |  129 ++++++++++++++++++++++++++++++++++++++++++++---------
 client/session.h  |    8 +---
 client/sync.c     |    8 +--
 client/transfer.c |   68 ++++++++++++++--------------
 client/transfer.h |   13 +++---
 9 files changed, 168 insertions(+), 122 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 336fc26..fdadf43 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -201,16 +201,15 @@ static void list_folder_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
 	struct ftp_data *ftp = user_data;
-	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
 	const char *buf;
-	int size;
+	size_t size;
 
 	reply = dbus_message_new_method_return(ftp->msg);
 
-	buf = obc_transfer_get_buffer(transfer, &size);
+	buf = obc_session_get_buffer(session, &size);
 	if (size == 0)
 		goto done;
 
@@ -225,8 +224,6 @@ static void list_folder_callback(struct obc_session *session,
 	g_markup_parse_context_free(ctxt);
 	dbus_message_iter_close_container(&iter, &array);
 
-	obc_transfer_clear_buffer(transfer);
-
 done:
 	g_dbus_send_message(conn, reply);
 	dbus_message_unref(ftp->msg);
diff --git a/client/manager.c b/client/manager.c
index f6628d7..7841753 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -35,7 +35,6 @@
 #include <gdbus.h>
 
 #include "log.h"
-#include "transfer.h"
 #include "session.h"
 #include "manager.h"
 #include "opp.h"
@@ -441,10 +440,9 @@ static DBusMessage *remove_session(DBusConnection *connection,
 static void capabilities_complete_callback(struct obc_session *session,
 						GError *err, void *user_data)
 {
-	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct send_data *data = user_data;
 	const char *capabilities;
-	int size;
+	size_t size;
 
 	if (err != NULL) {
 		DBusMessage *error = g_dbus_create_error(data->message,
@@ -454,7 +452,7 @@ static void capabilities_complete_callback(struct obc_session *session,
 		goto done;
 	}
 
-	capabilities = obc_transfer_get_buffer(transfer, &size);
+	capabilities = obc_session_get_buffer(session, &size);
 	if (size == 0)
 		capabilities = "";
 
diff --git a/client/map.c b/client/map.c
index cdd2725..9a76919 100644
--- a/client/map.c
+++ b/client/map.c
@@ -31,7 +31,6 @@
 #include "log.h"
 
 #include "map.h"
-#include "transfer.h"
 #include "session.h"
 #include "driver.h"
 
@@ -107,11 +106,10 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 static void buffer_cb(struct obc_session *session, GError *err,
 							void *user_data)
 {
-	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct map_data *map = user_data;
 	DBusMessage *reply;
 	const char *buf;
-	int size;
+	size_t size;
 
 	if (err != NULL) {
 		reply = g_dbus_create_error(map->msg,
@@ -120,19 +118,16 @@ static void buffer_cb(struct obc_session *session, GError *err,
 		goto done;
 	}
 
-	buf = obc_transfer_get_buffer(transfer, &size);
+	buf = obc_session_get_buffer(session, &size);
 	if (size == 0)
 		buf = "";
 
 	reply = g_dbus_create_reply(map->msg, DBUS_TYPE_STRING, &buf,
 							DBUS_TYPE_INVALID);
 
-	obc_transfer_clear_buffer(transfer);
-
 done:
 	g_dbus_send_message(conn, reply);
 	dbus_message_unref(map->msg);
-	obc_transfer_unregister(transfer);
 }
 
 static DBusMessage *map_get_folder_listing(DBusConnection *connection,
diff --git a/client/pbap.c b/client/pbap.c
index 8efa568..4a93fd5 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -36,7 +36,6 @@
 
 #include "log.h"
 
-#include "transfer.h"
 #include "session.h"
 #include "driver.h"
 #include "pbap.h"
@@ -362,23 +361,19 @@ static int pbap_set_path(struct pbap_data *pbap, const char *path)
 static void read_return_apparam(struct obc_session *session,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
-	struct obc_transfer *transfer = obc_session_get_transfer(session);
-	struct obc_transfer_params params;
 	struct apparam_hdr *hdr;
 	size_t size;
 
 	*phone_book_size = 0;
 	*new_missed_calls = 0;
 
-	if (obc_transfer_get_params(transfer, &params) < 0)
+	hdr = obc_session_get_params(session, &size);
+	if (hdr == NULL)
 		return;
 
-	if (params.size < APPARAM_HDR_SIZE)
+	if (size < APPARAM_HDR_SIZE)
 		return;
 
-	hdr = (struct apparam_hdr *) params.data;
-	size = params.size;
-
 	while (size > APPARAM_HDR_SIZE) {
 		if (hdr->len > size - APPARAM_HDR_SIZE) {
 			error("Unexpected PBAP pullphonebook app"
@@ -413,14 +408,13 @@ static void read_return_apparam(struct obc_session *session,
 static void pull_phonebook_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
-	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct pbap_data *pbap = user_data;
 	DBusMessage *reply;
 	const char *buf;
-	int size;
+	size_t size;
 
 	if (pbap->msg == NULL)
-		goto done;
+		return;
 
 	if (err) {
 		reply = g_dbus_create_error(pbap->msg,
@@ -431,7 +425,7 @@ static void pull_phonebook_callback(struct obc_session *session,
 
 	reply = dbus_message_new_method_return(pbap->msg);
 
-	buf = obc_transfer_get_buffer(transfer, &size);
+	buf = obc_session_get_buffer(session, &size);
 	if (size == 0)
 		buf = "";
 
@@ -439,28 +433,22 @@ static void pull_phonebook_callback(struct obc_session *session,
 			DBUS_TYPE_STRING, &buf,
 			DBUS_TYPE_INVALID);
 
-	obc_transfer_clear_buffer(transfer);
-
 send:
 	g_dbus_send_message(conn, reply);
 	dbus_message_unref(pbap->msg);
 	pbap->msg = NULL;
-
-done:
-	obc_transfer_unregister(transfer);
 }
 
 static void phonebook_size_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
-	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct pbap_data *pbap = user_data;
 	DBusMessage *reply;
 	guint16 phone_book_size;
 	guint8 new_missed_calls;
 
 	if (pbap->msg == NULL)
-		goto done;
+		return;
 
 	if (err) {
 		reply = g_dbus_create_error(pbap->msg,
@@ -477,30 +465,24 @@ static void phonebook_size_callback(struct obc_session *session,
 			DBUS_TYPE_UINT16, &phone_book_size,
 			DBUS_TYPE_INVALID);
 
-	obc_transfer_clear_buffer(transfer);
-
 send:
 	g_dbus_send_message(conn, reply);
 	dbus_message_unref(pbap->msg);
 	pbap->msg = NULL;
-
-done:
-	obc_transfer_unregister(transfer);
 }
 
 static void pull_vcard_listing_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
-	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct pbap_data *pbap = user_data;
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
 	const char *buf;
-	int size;
+	size_t size;
 
 	if (pbap->msg == NULL)
-		goto complete;
+		return;
 
 	if (err) {
 		reply = g_dbus_create_error(pbap->msg,
@@ -511,7 +493,7 @@ static void pull_vcard_listing_callback(struct obc_session *session,
 
 	reply = dbus_message_new_method_return(pbap->msg);
 
-	buf = obc_transfer_get_buffer(transfer, &size);
+	buf = obc_session_get_buffer(session, &size);
 	if (size == 0)
 		buf = "";
 
@@ -525,14 +507,10 @@ static void pull_vcard_listing_callback(struct obc_session *session,
 	g_markup_parse_context_free(ctxt);
 	dbus_message_iter_close_container(&iter, &array);
 
-	obc_transfer_clear_buffer(transfer);
-
 send:
 	g_dbus_send_message(conn, reply);
 	dbus_message_unref(pbap->msg);
 	pbap->msg = NULL;
-complete:
-	obc_transfer_unregister(transfer);
 }
 
 static DBusMessage *pull_phonebook(struct pbap_data *pbap,
diff --git a/client/session.c b/client/session.c
index 9f02512..5dfbd47 100644
--- a/client/session.c
+++ b/client/session.c
@@ -869,15 +869,38 @@ proceed:
 	return session;
 }
 
+static void obc_session_add_transfer(struct obc_session *session,
+						struct obc_transfer *transfer)
+{
+	session->pending = g_slist_append(session->pending, transfer);
+	obc_session_ref(session);
+}
+
+static void obc_session_remove_transfer(struct obc_session *session,
+						struct obc_transfer *transfer)
+{
+	session->pending = g_slist_remove(session->pending, transfer);
+	obc_transfer_unregister(transfer);
+	obc_session_unref(session);
+}
+
 void obc_session_shutdown(struct obc_session *session)
 {
+	GSList *l = session->pending;
+
 	DBG("%p", session);
 
 	obc_session_ref(session);
 
 	/* Unregister any pending transfer */
-	g_slist_foreach(session->pending, (GFunc) obc_transfer_unregister,
-									NULL);
+	while (l) {
+		struct obc_transfer *transfer = l->data;
+
+		l = l->next;
+
+		obc_session_remove_transfer(session, transfer);
+	}
+
 
 	/* Unregister interfaces */
 	if (session->path)
@@ -1108,13 +1131,17 @@ static void session_terminate_transfer(struct obc_session *session,
 	struct session_callback *callback = session->callback;
 
 	if (callback) {
+		obc_session_ref(session);
 		callback->func(session, gerr, callback->data);
+		if (g_slist_find(session->pending, transfer))
+			obc_session_remove_transfer(session, transfer);
+		obc_session_unref(session);
 		return;
 	}
 
 	obc_session_ref(session);
 
-	obc_transfer_unregister(transfer);
+	obc_session_remove_transfer(session, transfer);
 
 	if (session->pending)
 		session_request(session, session_prepare_put,
@@ -1226,6 +1253,7 @@ int obc_session_get(struct obc_session *session, const char *type,
 {
 	struct obc_transfer *transfer;
 	struct obc_transfer_params *params = NULL;
+	const char *agent;
 	int err;
 
 	if (session->obex == NULL)
@@ -1238,8 +1266,15 @@ int obc_session_get(struct obc_session *session, const char *type,
 		params->size = apparam_size;
 	}
 
-	transfer = obc_transfer_register(session->conn, filename, targetname,
-							type, params, session);
+	if (session->agent)
+		agent = obc_agent_get_name(session->agent);
+	else
+		agent = NULL;
+
+	transfer = obc_transfer_register(session->conn, session->obex,
+							agent, filename,
+							targetname, type,
+							params);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
@@ -1257,8 +1292,12 @@ int obc_session_get(struct obc_session *session, const char *type,
 	}
 
 	err = session_request(session, session_prepare_get, transfer);
-	if (err < 0)
+	if (err < 0) {
+		obc_transfer_unregister(transfer);
 		return err;
+	}
+
+	obc_session_add_transfer(session, transfer);
 
 	return 0;
 }
@@ -1267,13 +1306,18 @@ int obc_session_send(struct obc_session *session, const char *filename,
 				const char *targetname)
 {
 	struct obc_transfer *transfer;
+	const char *agent;
 	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
-	transfer = obc_transfer_register(session->conn, filename, targetname,
-							NULL, NULL, session);
+	agent = obc_agent_get_name(session->agent);
+
+	transfer = obc_transfer_register(session->conn, session->obex,
+							agent, filename,
+							targetname, NULL,
+							NULL);
 	if (transfer == NULL)
 		return -EINVAL;
 
@@ -1282,13 +1326,16 @@ int obc_session_send(struct obc_session *session, const char *filename,
 		goto fail;
 
 	/* Transfer should start if it is the first in the pending list */
-	if (transfer != session->pending->data)
-		return 0;
+	if (session->pending != NULL)
+		goto done;
 
 	err = session_request(session, session_prepare_put, transfer);
 	if (err < 0)
 		goto fail;
 
+done:
+	obc_session_add_transfer(session, transfer);
+
 	return 0;
 
 fail:
@@ -1302,13 +1349,21 @@ int obc_session_pull(struct obc_session *session,
 				session_callback_t function, void *user_data)
 {
 	struct obc_transfer *transfer;
+	const char *agent;
 	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
-	transfer = obc_transfer_register(session->conn, NULL, filename, type,
-								NULL, session);
+	if (session->agent != NULL)
+		agent = obc_agent_get_name(session->agent);
+	else
+		agent = NULL;
+
+	transfer = obc_transfer_register(session->conn, session->obex,
+								agent, NULL,
+								filename, type,
+								NULL);
 	if (transfer == NULL) {
 		return -EIO;
 	}
@@ -1322,8 +1377,10 @@ int obc_session_pull(struct obc_session *session,
 	}
 
 	err = session_request(session, session_prepare_get, transfer);
-	if (err == 0)
+	if (err == 0) {
+		obc_session_add_transfer(session, transfer);
 		return 0;
+	}
 
 	obc_transfer_unregister(transfer);
 	return err;
@@ -1382,6 +1439,7 @@ static void session_prepare_put(struct obc_session *session,
 int obc_session_put(struct obc_session *session, char *buf, const char *targetname)
 {
 	struct obc_transfer *transfer;
+	const char *agent;
 	int err;
 
 	if (session->obex == NULL)
@@ -1390,8 +1448,12 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
 	if (session->pending != NULL)
 		return -EISCONN;
 
-	transfer = obc_transfer_register(session->conn, NULL, targetname, NULL,
-								NULL, session);
+	agent = obc_agent_get_name(session->agent);
+
+	transfer = obc_transfer_register(session->conn, session->obex,
+							agent, NULL,
+							targetname, NULL,
+							NULL);
 	if (transfer == NULL)
 		return -EIO;
 
@@ -1470,19 +1532,42 @@ GObex *obc_session_get_obex(struct obc_session *session)
 	return session->obex;
 }
 
-struct obc_transfer *obc_session_get_transfer(struct obc_session *session)
+static struct obc_transfer *obc_session_get_transfer(
+						struct obc_session *session)
 {
 	return session->pending ? session->pending->data : NULL;
 }
 
-void obc_session_add_transfer(struct obc_session *session,
-					struct obc_transfer *transfer)
+const char *obc_session_get_buffer(struct obc_session *session, size_t *size)
 {
-	session->pending = g_slist_append(session->pending, transfer);
+	struct obc_transfer *transfer;
+	const char *buf;
+
+	transfer = obc_session_get_transfer(session);
+	if (transfer == NULL)
+		return NULL;
+
+	buf = obc_transfer_get_buffer(transfer, size);
+
+	obc_transfer_clear_buffer(transfer);
+
+	return buf;
 }
 
-void obc_session_remove_transfer(struct obc_session *session,
-					struct obc_transfer *transfer)
+void *obc_session_get_params(struct obc_session *session, size_t *size)
 {
-	session->pending = g_slist_remove(session->pending, transfer);
+	struct obc_transfer *transfer;
+	struct obc_transfer_params params;
+
+	transfer= obc_session_get_transfer(session);
+	if (transfer == NULL)
+		return NULL;
+
+	if (obc_transfer_get_params(transfer, &params) < 0)
+		return NULL;
+
+	if (size)
+		*size = params.size;
+
+	return params.data;
 }
diff --git a/client/session.h b/client/session.h
index b2a83d9..511f084 100644
--- a/client/session.h
+++ b/client/session.h
@@ -57,12 +57,8 @@ const char *obc_session_get_agent(struct obc_session *session);
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
 GObex *obc_session_get_obex(struct obc_session *session);
-
-struct obc_transfer *obc_session_get_transfer(struct obc_session *session);
-void obc_session_add_transfer(struct obc_session *session,
-					struct obc_transfer *transfer);
-void obc_session_remove_transfer(struct obc_session *session,
-					struct obc_transfer *transfer);
+const char *obc_session_get_buffer(struct obc_session *session, size_t *size);
+void *obc_session_get_params(struct obc_session *session, size_t *size);
 
 int obc_session_send(struct obc_session *session, const char *filename,
 				const char *remotename);
diff --git a/client/sync.c b/client/sync.c
index 7675b23..7d713a8 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -33,7 +33,6 @@
 
 #include "log.h"
 
-#include "transfer.h"
 #include "session.h"
 #include "driver.h"
 #include "sync.h"
@@ -86,16 +85,15 @@ static DBusMessage *sync_setlocation(DBusConnection *connection,
 static void sync_getphonebook_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
-	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct sync_data *sync = user_data;
 	DBusMessage *reply;
 	const char *buf;
-	int size;
+	size_t size;
 
 	reply = dbus_message_new_method_return(sync->msg);
 
-	buf = obc_transfer_get_buffer(transfer, &size);
-	if (size == 0)
+	buf = obc_session_get_buffer(session, &size);
+	if (buf == NULL)
 		buf = "";
 
 	dbus_message_append_args(reply,
diff --git a/client/transfer.c b/client/transfer.c
index 2532294..8677b07 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -30,19 +30,22 @@
 #include <unistd.h>
 #include <string.h>
 #include <sys/stat.h>
+#include <inttypes.h>
 
 #include <glib.h>
 #include <gdbus.h>
+#include <gobex.h>
 
 #include "log.h"
 #include "transfer.h"
-#include "session.h"
 
 #define TRANSFER_INTERFACE  "org.openobex.Transfer"
 #define TRANSFER_BASEPATH   "/org/openobex"
 
 #define DEFAULT_BUFFER_SIZE 4096
 
+#define OBC_TRANSFER_ERROR obc_transfer_error_quark()
+
 static guint64 counter = 0;
 
 struct transfer_callback {
@@ -51,10 +54,11 @@ struct transfer_callback {
 };
 
 struct obc_transfer {
-	struct obc_session *session;
+	GObex *obex;
 	struct obc_transfer_params *params;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
+	char *agent;		/* Transfer agent */
 	char *path;		/* Transfer path */
 	gchar *filename;	/* Transfer file location */
 	char *name;		/* Transfer object name */
@@ -69,6 +73,11 @@ struct obc_transfer {
 	int err;
 };
 
+static GQuark obc_transfer_error_quark(void)
+{
+	return g_quark_from_static_string("obc-transfer-error-quark");
+}
+
 static void append_entry(DBusMessageIter *dict,
 				const char *key, int type, void *val)
 {
@@ -143,7 +152,7 @@ static void obc_transfer_abort(struct obc_transfer *transfer)
 	if (callback) {
 		GError *err;
 
-		err = g_error_new(OBEX_IO_ERROR, -ECANCELED, "%s",
+		err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
 							strerror(ECANCELED));
 		callback->func(transfer, transfer->transferred, err,
 							callback->data);
@@ -155,13 +164,11 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct obc_session *session = transfer->session;
-	const gchar *sender, *agent;
+	const gchar *sender;
 	DBusMessage *reply;
 
 	sender = dbus_message_get_sender(message);
-	agent = obc_session_get_agent(session);
-	if (g_str_equal(sender, agent) == FALSE)
+	if (g_str_equal(transfer->agent, sender) == FALSE)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.NotAuthorized",
 				"Not Authorized");
@@ -183,8 +190,6 @@ static GDBusMethodTable obc_transfer_methods[] = {
 
 static void obc_transfer_free(struct obc_transfer *transfer)
 {
-	struct obc_session *session = transfer->session;
-
 	DBG("%p", transfer);
 
 	if (transfer->xfer)
@@ -193,10 +198,6 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->fd > 0)
 		close(transfer->fd);
 
-	obc_session_remove_transfer(session, transfer);
-
-	obc_session_unref(session);
-
 	if (transfer->params != NULL) {
 		g_free(transfer->params->data);
 		g_free(transfer->params);
@@ -205,7 +206,11 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->conn)
 		dbus_connection_unref(transfer->conn);
 
+	if (transfer->obex)
+		g_obex_unref(transfer->obex);
+
 	g_free(transfer->callback);
+	g_free(transfer->agent);
 	g_free(transfer->filename);
 	g_free(transfer->name);
 	g_free(transfer->type);
@@ -215,17 +220,18 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 }
 
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
+						GObex *obex,
+						const char *agent,
 						const char *filename,
 						const char *name,
 						const char *type,
-						struct obc_transfer_params *params,
-						void *user_data)
+						struct obc_transfer_params *params)
 {
-	struct obc_session *session = user_data;
 	struct obc_transfer *transfer;
 
 	transfer = g_new0(struct obc_transfer, 1);
-	transfer->session = obc_session_ref(session);
+	transfer->obex = g_obex_ref(obex);
+	transfer->agent = g_strdup(agent);
 	transfer->filename = g_strdup(filename);
 	transfer->name = g_strdup(name);
 	transfer->type = g_strdup(type);
@@ -257,8 +263,6 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 done:
 	DBG("%p registered %s", transfer, transfer->path);
 
-	obc_session_add_transfer(session, transfer);
-
 	return transfer;
 }
 
@@ -345,7 +349,7 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 
 	rspcode = g_obex_packet_get_operation(rsp, &final);
 	if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
-		err = g_error_new(OBEX_IO_ERROR, rspcode,
+		err = g_error_new(OBC_TRANSFER_ERROR, rspcode,
 					"Transfer failed (0x%02x)", rspcode);
 		get_buf_xfer_complete(obex, err, transfer);
 		g_error_free(err);
@@ -499,9 +503,7 @@ static void obc_transfer_set_callback(struct obc_transfer *transfer,
 int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data)
 {
-	struct obc_session *session = transfer->session;
 	GError *err = NULL;
-	GObex *obex;
 	GObexPacket *req;
 	GObexDataConsumer data_cb;
 	GObexFunc complete_cb;
@@ -527,8 +529,6 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 		complete_cb = xfer_complete;
 	}
 
-	obex = obc_session_get_obex(session);
-
 	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
 
 	if (transfer->filename != NULL)
@@ -545,12 +545,12 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 						transfer->params->size);
 
 	if (rsp_cb)
-		transfer->xfer = g_obex_send_req(obex, req, -1, rsp_cb,
-							transfer, &err);
+		transfer->xfer = g_obex_send_req(transfer->obex, req, -1,
+						rsp_cb, transfer, &err);
 	else
-		transfer->xfer = g_obex_get_req_pkt(obex, req, data_cb,
-							complete_cb, transfer,
-							&err);
+		transfer->xfer = g_obex_get_req_pkt(transfer->obex, req,
+						data_cb, complete_cb, transfer,
+						&err);
 
 	if (transfer->xfer == 0)
 		return -ENOTCONN;
@@ -564,9 +564,7 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data)
 {
-	struct obc_session *session = transfer->session;
 	GError *err = NULL;
-	GObex *obex;
 	GObexPacket *req;
 	GObexDataProducer data_cb;
 
@@ -581,7 +579,6 @@ int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
 	data_cb = put_xfer_progress;
 
 done:
-	obex = obc_session_get_obex(session);
 	req = g_obex_packet_new(G_OBEX_OP_PUT, FALSE, G_OBEX_HDR_INVALID);
 
 	if (transfer->name != NULL)
@@ -600,8 +597,9 @@ done:
 						transfer->params->data,
 						transfer->params->size);
 
-	transfer->xfer = g_obex_put_req_pkt(obex, req, data_cb, xfer_complete,
-							transfer, &err);
+	transfer->xfer = g_obex_put_req_pkt(transfer->obex, req, data_cb,
+						xfer_complete, transfer,
+						&err);
 	if (transfer->xfer == 0)
 		return -ENOTCONN;
 
@@ -625,7 +623,7 @@ void obc_transfer_clear_buffer(struct obc_transfer *transfer)
 	transfer->filled = 0;
 }
 
-const char *obc_transfer_get_buffer(struct obc_transfer *transfer, int *size)
+const char *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size)
 {
 	if (size)
 		*size = transfer->filled;
diff --git a/client/transfer.h b/client/transfer.h
index c051cbd..e5387fc 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -33,11 +33,12 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 					void *user_data);
 
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
-						const char *filename,
-						const char *name,
-						const char *type,
-						struct obc_transfer_params *params,
-						void *user_data);
+					GObex *obex,
+					const char *agent,
+					const char *filename,
+					const char *name,
+					const char *type,
+					struct obc_transfer_params *params);
 
 void obc_transfer_unregister(struct obc_transfer *transfer);
 
@@ -48,7 +49,7 @@ int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
 
 int obc_transfer_get_params(struct obc_transfer *transfer,
 					struct obc_transfer_params *params);
-const char *obc_transfer_get_buffer(struct obc_transfer *transfer, int *size);
+const char *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size);
 void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer);
 void obc_transfer_clear_buffer(struct obc_transfer *transfer);
 
-- 
1.7.7.5

