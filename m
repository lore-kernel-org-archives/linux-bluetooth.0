Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd v3] client: Remove buffer based transfer
Date: Wed, 18 Apr 2012 16:47:14 +0300
Message-Id: <1334756834-19770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Simplify the code by using temporary files and eliminates reallocations.
---
v3: - Uses g_file_open_tmp which properly checks for tmp location
    - Reuse code for both PUT and GET
    - Add parameters contents and size to obc_transfer_set_file
    - Remove unrelated/inconsistent changes
    - Replace g_malloc0 with g_malloc

 client/ftp.c      |    8 +-
 client/manager.c  |   18 +++-
 client/map.c      |   18 +++-
 client/pbap.c     |   39 +++++--
 client/session.c  |   44 +++++----
 client/session.h  |    7 +-
 client/sync.c     |   36 +++++--
 client/transfer.c |  304 ++++++++++++++++++++++-------------------------------
 client/transfer.h |    8 +-
 9 files changed, 241 insertions(+), 241 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 9be5d69..f415f2f 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -196,13 +196,12 @@ static void list_folder_callback(struct obc_session *session,
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
-	const char *buf;
+	char *contents;
 	size_t size;
 
 	reply = dbus_message_new_method_return(msg);
 
-	buf = obc_session_get_buffer(session, &size);
-	if (size == 0)
+	if (obc_session_get_contents(session, &contents, &size) < 0)
 		goto done;
 
 	dbus_message_iter_init_append(reply, &iter);
@@ -212,9 +211,10 @@ static void list_folder_callback(struct obc_session *session,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
 	ctxt = g_markup_parse_context_new(&parser, 0, &array, NULL);
-	g_markup_parse_context_parse(ctxt, buf, strlen(buf) - 1, NULL);
+	g_markup_parse_context_parse(ctxt, contents, size, NULL);
 	g_markup_parse_context_free(ctxt);
 	dbus_message_iter_close_container(&iter, &array);
+	g_free(contents);
 
 done:
 	g_dbus_send_message(conn, reply);
diff --git a/client/manager.c b/client/manager.c
index 2e01e54..4f0b750 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -442,8 +442,9 @@ static void capabilities_complete_callback(struct obc_session *session,
 						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
-	const char *capabilities;
+	char *contents;
 	size_t size;
+	int perr;
 
 	if (err != NULL) {
 		DBusMessage *error = g_dbus_create_error(data->message,
@@ -453,13 +454,20 @@ static void capabilities_complete_callback(struct obc_session *session,
 		goto done;
 	}
 
-	capabilities = obc_session_get_buffer(session, &size);
-	if (size == 0)
-		capabilities = "";
+	perr = obc_session_get_contents(session, &contents, &size);
+	if (perr < 0) {
+		DBusMessage *error = g_dbus_create_error(data->message,
+						"org.openobex.Error.Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		g_dbus_send_message(data->connection, error);
+		goto done;
+	}
 
 	g_dbus_send_reply(data->connection, data->message,
-			DBUS_TYPE_STRING, &capabilities,
+			DBUS_TYPE_STRING, &contents,
 			DBUS_TYPE_INVALID);
+	g_free(contents);
 
 done:
 
diff --git a/client/map.c b/client/map.c
index 68b1fbc..3841299 100644
--- a/client/map.c
+++ b/client/map.c
@@ -25,6 +25,7 @@
 #endif
 
 #include <errno.h>
+#include <string.h>
 #include <glib.h>
 #include <gdbus.h>
 
@@ -98,8 +99,9 @@ static void buffer_cb(struct obc_session *session, GError *err,
 {
 	struct map_data *map = user_data;
 	DBusMessage *reply;
-	const char *buf;
+	char *contents;
 	size_t size;
+	int perr;
 
 	if (err != NULL) {
 		reply = g_dbus_create_error(map->msg,
@@ -108,13 +110,19 @@ static void buffer_cb(struct obc_session *session, GError *err,
 		goto done;
 	}
 
-	buf = obc_session_get_buffer(session, &size);
-	if (size == 0)
-		buf = "";
+	perr = obc_session_get_contents(session, &contents, &size);
+	if (perr < 0) {
+		reply = g_dbus_create_error(map->msg,
+						"org.openobex.Error.Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		goto done;
+	}
 
-	reply = g_dbus_create_reply(map->msg, DBUS_TYPE_STRING, &buf,
+	reply = g_dbus_create_reply(map->msg, DBUS_TYPE_STRING, &contents,
 							DBUS_TYPE_INVALID);
 
+	g_free(contents);
 done:
 	g_dbus_send_message(conn, reply);
 	dbus_message_unref(map->msg);
diff --git a/client/pbap.c b/client/pbap.c
index 53a608e..85f970b 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -343,8 +343,9 @@ static void pull_phonebook_callback(struct obc_session *session,
 {
 	struct pending_request *request = user_data;
 	DBusMessage *reply;
-	const char *buf;
+	char *contents;
 	size_t size;
+	int perr;
 
 	if (err) {
 		reply = g_dbus_create_error(request->msg,
@@ -353,16 +354,23 @@ static void pull_phonebook_callback(struct obc_session *session,
 		goto send;
 	}
 
-	reply = dbus_message_new_method_return(request->msg);
+	perr = obc_session_get_contents(session, &contents, &size);
+	if (perr < 0) {
+		reply = g_dbus_create_error(request->msg,
+						"org.openobex.Error.Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		goto send;
+	}
 
-	buf = obc_session_get_buffer(session, &size);
-	if (size == 0)
-		buf = "";
+	reply = dbus_message_new_method_return(request->msg);
 
 	dbus_message_append_args(reply,
-			DBUS_TYPE_STRING, &buf,
+			DBUS_TYPE_STRING, &contents,
 			DBUS_TYPE_INVALID);
 
+	g_free(contents);
+
 send:
 	g_dbus_send_message(conn, reply);
 	pending_request_free(request);
@@ -403,8 +411,9 @@ static void pull_vcard_listing_callback(struct obc_session *session,
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
-	const char *buf;
+	char *contents;
 	size_t size;
+	int perr;
 
 	if (err) {
 		reply = g_dbus_create_error(request->msg,
@@ -413,11 +422,16 @@ static void pull_vcard_listing_callback(struct obc_session *session,
 		goto send;
 	}
 
-	reply = dbus_message_new_method_return(request->msg);
+	perr = obc_session_get_contents(session, &contents, &size);
+	if (perr < 0) {
+		reply = g_dbus_create_error(request->msg,
+						"org.openobex.Error.Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		goto send;
+	}
 
-	buf = obc_session_get_buffer(session, &size);
-	if (size == 0)
-		buf = "";
+	reply = dbus_message_new_method_return(request->msg);
 
 	dbus_message_iter_init_append(reply, &iter);
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
@@ -425,9 +439,10 @@ static void pull_vcard_listing_callback(struct obc_session *session,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_STRING_AS_STRING
 			DBUS_STRUCT_END_CHAR_AS_STRING, &array);
 	ctxt = g_markup_parse_context_new(&listing_parser, 0, &array, NULL);
-	g_markup_parse_context_parse(ctxt, buf, strlen(buf) - 1, NULL);
+	g_markup_parse_context_parse(ctxt, contents, size, NULL);
 	g_markup_parse_context_free(ctxt);
 	dbus_message_iter_close_container(&iter, &array);
+	g_free(contents);
 
 send:
 	g_dbus_send_message(conn, reply);
diff --git a/client/session.c b/client/session.c
index 868eb9f..1b6dc95 100644
--- a/client/session.c
+++ b/client/session.c
@@ -25,6 +25,8 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
+#include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
@@ -991,7 +993,7 @@ int obc_session_send(struct obc_session *session, const char *filename,
 	if (transfer == NULL)
 		return -EINVAL;
 
-	err = obc_transfer_set_file(transfer);
+	err = obc_transfer_set_file(transfer, NULL, 0);
 	if (err < 0) {
 		obc_transfer_unregister(transfer);
 		return err;
@@ -1059,15 +1061,15 @@ static void session_prepare_put(gpointer data, gpointer user_data)
 	DBG("Transfer(%p) started", transfer);
 }
 
-int obc_session_put(struct obc_session *session, char *buf, const char *name)
+int obc_session_put(struct obc_session *session, const char *contents,
+					size_t size, const char *name)
 {
 	struct obc_transfer *transfer;
 	const char *agent;
+	int err;
 
-	if (session->obex == NULL) {
-		g_free(buf);
+	if (session->obex == NULL)
 		return -ENOTCONN;
-	}
 
 	agent = obc_agent_get_name(session->agent);
 
@@ -1075,15 +1077,23 @@ int obc_session_put(struct obc_session *session, char *buf, const char *name)
 							agent, NULL,
 							name, NULL,
 							NULL);
-	if (transfer == NULL) {
-		g_free(buf);
+	if (transfer == NULL)
 		return -EIO;
-	}
 
-	obc_transfer_set_buffer(transfer, buf);
+	err = obc_transfer_set_file(transfer, contents, size);
+	if (err < 0)
+		goto fail;
 
-	return session_request(session, transfer, session_prepare_put,
-								NULL, NULL);
+	err = session_request(session, transfer, session_prepare_put, NULL,
+									NULL);
+	if (err < 0)
+		goto fail;
+
+	return 0;
+
+fail:
+	obc_transfer_unregister(transfer);
+	return err;
 }
 
 static void agent_destroy(gpointer data, gpointer user_data)
@@ -1156,24 +1166,20 @@ static struct obc_transfer *obc_session_get_transfer(
 	return session->p->transfer;
 }
 
-const char *obc_session_get_buffer(struct obc_session *session, size_t *size)
+int obc_session_get_contents(struct obc_session *session, char **contents,
+								size_t *size)
 {
 	struct obc_transfer *transfer;
-	const char *buf;
 
 	transfer = obc_session_get_transfer(session);
 	if (transfer == NULL) {
 		if (size != NULL)
 			*size = 0;
 
-		return NULL;
+		return -EINVAL;
 	}
 
-	buf = obc_transfer_get_buffer(transfer, size);
-
-	obc_transfer_clear_buffer(transfer);
-
-	return buf;
+	return obc_transfer_get_contents(transfer, contents, size);
 }
 
 void *obc_session_get_params(struct obc_session *session, size_t *size)
diff --git a/client/session.h b/client/session.h
index 4bfb41d..7e6f42b 100644
--- a/client/session.h
+++ b/client/session.h
@@ -52,7 +52,8 @@ const char *obc_session_get_agent(struct obc_session *session);
 
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
-const char *obc_session_get_buffer(struct obc_session *session, size_t *size);
+int obc_session_get_contents(struct obc_session *session, char **contents,
+								size_t *size);
 void *obc_session_get_params(struct obc_session *session, size_t *size);
 
 int obc_session_send(struct obc_session *session, const char *filename,
@@ -66,8 +67,8 @@ int obc_session_pull(struct obc_session *session,
 				session_callback_t function, void *user_data);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
-int obc_session_put(struct obc_session *session, char *buf,
-				const char *name);
+int obc_session_put(struct obc_session *session, const char *contents,
+					size_t size, const char *name);
 
 guint obc_session_setpath(struct obc_session *session, const char *path,
 				session_callback_t func, void *user_data,
diff --git a/client/sync.c b/client/sync.c
index 7d713a8..0dffab7 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -27,6 +27,7 @@
 #endif
 
 #include <errno.h>
+#include <string.h>
 
 #include <glib.h>
 #include <gdbus.h>
@@ -87,19 +88,34 @@ static void sync_getphonebook_callback(struct obc_session *session,
 {
 	struct sync_data *sync = user_data;
 	DBusMessage *reply;
-	const char *buf;
+	char *contents;
 	size_t size;
+	int perr;
+
+	if (err) {
+		reply = g_dbus_create_error(sync->msg,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		goto send;
+	}
+
+	perr = obc_session_get_contents(session, &contents, &size);
+	if (perr < 0) {
+		reply = g_dbus_create_error(sync->msg,
+						"org.openobex.Error.Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		goto send;
+	}
 
 	reply = dbus_message_new_method_return(sync->msg);
 
-	buf = obc_session_get_buffer(session, &size);
-	if (buf == NULL)
-		buf = "";
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &contents,
+							DBUS_TYPE_INVALID);
 
-	dbus_message_append_args(reply,
-		DBUS_TYPE_STRING, &buf,
-		DBUS_TYPE_INVALID);
+	g_free(contents);
 
+send:
 	g_dbus_send_message(conn, reply);
 	dbus_message_unref(sync->msg);
 	sync->msg = NULL;
@@ -133,7 +149,6 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 {
 	struct sync_data *sync = user_data;
 	const char *buf;
-	char *buffer;
 
 	if (dbus_message_get_args(message, NULL,
 			DBUS_TYPE_STRING, &buf,
@@ -145,9 +160,8 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	buffer = g_strdup(buf);
-
-	if (obc_session_put(sync->session, buffer, sync->phonebook_path) < 0)
+	if (obc_session_put(sync->session, buf, strlen(buf),
+						sync->phonebook_path) < 0)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Failed", "Failed");
 
diff --git a/client/transfer.c b/client/transfer.c
index f476680..1ef0768 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -25,6 +25,8 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
+#include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
@@ -42,8 +44,6 @@
 #define TRANSFER_INTERFACE  "org.openobex.Transfer"
 #define TRANSFER_BASEPATH   "/org/openobex"
 
-#define DEFAULT_BUFFER_SIZE 4096
-
 #define OBC_TRANSFER_ERROR obc_transfer_error_quark()
 
 static guint64 counter = 0;
@@ -61,13 +61,11 @@ struct obc_transfer {
 	char *agent;		/* Transfer agent */
 	char *path;		/* Transfer path */
 	gchar *filename;	/* Transfer file location */
+	char *tmpname;		/* Transfer temporary location */
 	char *name;		/* Transfer object name */
 	char *type;		/* Transfer object type */
 	int fd;
 	guint xfer;
-	char *buffer;
-	size_t buffer_len;
-	int filled;
 	gint64 size;
 	gint64 transferred;
 	int err;
@@ -207,6 +205,11 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 		g_free(transfer->params);
 	}
 
+	if (transfer->tmpname) {
+		remove(transfer->tmpname);
+		g_free(transfer->tmpname);
+	}
+
 	if (transfer->conn)
 		dbus_connection_unref(transfer->conn);
 
@@ -219,7 +222,6 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	g_free(transfer->name);
 	g_free(transfer->type);
 	g_free(transfer->path);
-	g_free(transfer->buffer);
 	g_free(transfer);
 }
 
@@ -282,31 +284,35 @@ void obc_transfer_unregister(struct obc_transfer *transfer)
 	obc_transfer_free(transfer);
 }
 
-static void obc_transfer_read(struct obc_transfer *transfer,
-						const void *buf, gsize len)
+static gboolean get_xfer_progress(const void *buf, gsize len,
+							gpointer user_data)
 {
-	gsize bsize;
+	struct obc_transfer *transfer = user_data;
+	struct transfer_callback *callback = transfer->callback;
 
-	/* copy all buffered data */
-	bsize = transfer->buffer_len - transfer->filled;
+	if (transfer->fd > 0) {
+		gint w;
 
-	if (bsize < len) {
-		transfer->buffer_len += len - bsize;
-		transfer->buffer = g_realloc(transfer->buffer,
-							transfer->buffer_len);
+		w = write(transfer->fd, buf, len);
+		if (w < 0) {
+			transfer->err = -errno;
+			return FALSE;
+		}
+
+		transfer->transferred += w;
 	}
 
-	memcpy(transfer->buffer + transfer->filled, buf, len);
+	if (callback && transfer->transferred != transfer->size)
+		callback->func(transfer, transfer->transferred, NULL,
+							callback->data);
 
-	transfer->filled += len;
-	transfer->transferred += len;
+	return TRUE;
 }
 
-static void get_buf_xfer_complete(GObex *obex, GError *err, gpointer user_data)
+static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
-	gsize bsize;
 
 	transfer->xfer = 0;
 
@@ -315,30 +321,17 @@ static void get_buf_xfer_complete(GObex *obex, GError *err, gpointer user_data)
 		goto done;
 	}
 
-	if (transfer->filled > 0 &&
-			transfer->buffer[transfer->filled - 1] == '\0')
-		goto done;
-
-	bsize = transfer->buffer_len - transfer->filled;
-	if (bsize < 1) {
-		transfer->buffer_len += 1;
-		transfer->buffer = g_realloc(transfer->buffer,
-						transfer->buffer_len);
-	}
-
-	transfer->buffer[transfer->filled] = '\0';
-	transfer->size = strlen(transfer->buffer);
+	transfer->size = transfer->transferred;
 
 done:
 	if (callback)
 		callback->func(transfer, transfer->size, err, callback->data);
 }
 
-static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
+static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
 	GObexPacket *req;
 	GObexHeader *hdr;
 	const guint8 *buf;
@@ -347,7 +340,7 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 	gboolean final;
 
 	if (err != NULL) {
-		get_buf_xfer_complete(obex, err, transfer);
+		xfer_complete(obex, err, transfer);
 		return;
 	}
 
@@ -355,7 +348,7 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 	if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
 		err = g_error_new(OBC_TRANSFER_ERROR, rspcode,
 					"Transfer failed (0x%02x)", rspcode);
-		get_buf_xfer_complete(obex, err, transfer);
+		xfer_complete(obex, err, transfer);
 		g_error_free(err);
 		return;
 	}
@@ -379,96 +372,21 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 	if (hdr) {
 		g_obex_header_get_bytes(hdr, &buf, &len);
 		if (len != 0)
-			obc_transfer_read(transfer, buf, len);
+			get_xfer_progress(buf, len, transfer);
 	}
 
 	if (rspcode == G_OBEX_RSP_SUCCESS) {
-		get_buf_xfer_complete(obex, err, transfer);
+		xfer_complete(obex, err, transfer);
 		return;
 	}
 
 	if (!g_obex_srm_active(obex)) {
 		req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
 
-		transfer->xfer = g_obex_send_req(obex, req, -1,
-							get_buf_xfer_progress,
-							transfer, &err);
-	}
-
-	if (callback && transfer->transferred != transfer->size)
-		callback->func(transfer, transfer->transferred, err,
-							callback->data);
-}
-
-static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
-{
-	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
-
-	transfer->xfer = 0;
-
-	if (err) {
-		transfer->err = err->code;
-		goto done;
-	}
-
-	transfer->size = transfer->transferred;
-
-done:
-	if (callback)
-		callback->func(transfer, transfer->size, err, callback->data);
-}
-
-static gboolean get_xfer_progress(const void *buf, gsize len,
-							gpointer user_data)
-{
-	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
-
-	obc_transfer_read(transfer, buf, len);
-
-	if (transfer->fd > 0) {
-		gint w;
-
-		w = write(transfer->fd, transfer->buffer, transfer->filled);
-		if (w < 0) {
-			transfer->err = -errno;
-			return FALSE;
-		}
-
-		transfer->filled -= w;
+		transfer->xfer = g_obex_get_req_pkt(obex, req, get_xfer_progress,
+						xfer_complete, transfer,
+						&err);
 	}
-
-	if (callback && transfer->transferred != transfer->size)
-		callback->func(transfer, transfer->transferred, NULL,
-							callback->data);
-
-	return TRUE;
-}
-
-static gssize put_buf_xfer_progress(void *buf, gsize len, gpointer user_data)
-{
-	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
-	gsize size;
-
-	if (transfer->transferred == transfer->size)
-		return 0;
-
-	size = transfer->size - transfer->transferred;
-	size = len > size ? len : size;
-	if (size == 0)
-		return 0;
-
-	memcpy(buf, transfer->buffer + transfer->transferred, size);
-
-	transfer->transferred += size;
-
-	if (callback)
-		callback->func(transfer, transfer->transferred, NULL,
-							callback->data);
-
-	return size;
 }
 
 static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
@@ -510,33 +428,44 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 	return TRUE;
 }
 
-int obc_transfer_get(struct obc_transfer *transfer)
+static int transfer_open(struct obc_transfer *transfer, int flags, mode_t mode)
 {
 	GError *err = NULL;
-	GObexPacket *req;
-	GObexDataConsumer data_cb;
-	GObexFunc complete_cb;
-	GObexResponseFunc rsp_cb = NULL;
-
-	if (transfer->xfer != 0)
-		return -EALREADY;
+	int fd;
 
-	if (transfer->type != NULL &&
-			(strncmp(transfer->type, "x-obex/", 7) == 0 ||
-			strncmp(transfer->type, "x-bt/", 5) == 0)) {
-		rsp_cb = get_buf_xfer_progress;
-	} else {
-		int fd = open(transfer->filename ? : transfer->name,
-				O_WRONLY | O_CREAT, 0600);
+	if (transfer->filename != NULL) {
+		fd = open(transfer->filename, flags, mode);
 		if (fd < 0) {
 			error("open(): %s(%d)", strerror(errno), errno);
 			return -errno;
 		}
-		transfer->fd = fd;
-		data_cb = get_xfer_progress;
-		complete_cb = xfer_complete;
+		goto done;
+	}
+
+	fd = g_file_open_tmp("obex-clientXXXXXX", &transfer->tmpname, &err);
+	if (fd < 0) {
+		error("g_file_open_tmp(): %s", err->message);
+		return -EFAULT;
 	}
 
+done:
+	transfer->fd = fd;
+	return fd;
+}
+
+int obc_transfer_get(struct obc_transfer *transfer)
+{
+	GError *err = NULL;
+	GObexPacket *req;
+	int perr;
+
+	if (transfer->xfer != 0)
+		return -EALREADY;
+
+	perr = transfer_open(transfer, O_WRONLY | O_CREAT, 0600);
+	if (perr < 0)
+		return perr;
+
 	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
 
 	if (transfer->name != NULL)
@@ -552,14 +481,9 @@ int obc_transfer_get(struct obc_transfer *transfer)
 						transfer->params->data,
 						transfer->params->size);
 
-	if (rsp_cb)
-		transfer->xfer = g_obex_send_req(transfer->obex, req, -1,
-						rsp_cb, transfer, &err);
-	else
-		transfer->xfer = g_obex_get_req_pkt(transfer->obex, req,
-						data_cb, complete_cb, transfer,
-						&err);
-
+	transfer->xfer = g_obex_send_req(transfer->obex, req, -1,
+						get_xfer_progress_first,
+						transfer, &err);
 	if (transfer->xfer == 0)
 		return -ENOTCONN;
 
@@ -570,19 +494,10 @@ int obc_transfer_put(struct obc_transfer *transfer)
 {
 	GError *err = NULL;
 	GObexPacket *req;
-	GObexDataProducer data_cb;
 
 	if (transfer->xfer != 0)
 		return -EALREADY;
 
-	if (transfer->buffer) {
-		data_cb = put_buf_xfer_progress;
-		goto done;
-	}
-
-	data_cb = put_xfer_progress;
-
-done:
 	req = g_obex_packet_new(G_OBEX_OP_PUT, FALSE, G_OBEX_HDR_INVALID);
 
 	if (transfer->name != NULL)
@@ -601,9 +516,9 @@ done:
 						transfer->params->data,
 						transfer->params->size);
 
-	transfer->xfer = g_obex_put_req_pkt(transfer->obex, req, data_cb,
-						xfer_complete, transfer,
-						&err);
+	transfer->xfer = g_obex_put_req_pkt(transfer->obex, req,
+					put_xfer_progress, xfer_complete,
+					transfer, &err);
 	if (transfer->xfer == 0)
 		return -ENOTCONN;
 
@@ -619,23 +534,40 @@ int obc_transfer_get_params(struct obc_transfer *transfer,
 	return 0;
 }
 
-void obc_transfer_clear_buffer(struct obc_transfer *transfer)
+int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
+								size_t *size)
 {
-	transfer->filled = 0;
-}
+	struct stat st;
+	ssize_t ret;
 
-const char *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size)
-{
-	if (size)
-		*size = transfer->filled;
+	if (contents == NULL)
+		return -EINVAL;
 
-	return transfer->buffer;
-}
+	if (fstat(transfer->fd, &st) < 0) {
+		error("fstat(): %s(%d)", strerror(errno), errno);
+		return -errno;
+	}
 
-void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer)
-{
-	transfer->size = strlen(buffer);
-	transfer->buffer = buffer;
+	if (lseek(transfer->fd, 0, SEEK_SET) < 0) {
+		error("lseek(): %s(%d)", strerror(errno), errno);
+		return -errno;
+	}
+
+	*contents = g_malloc(st.st_size + 1);
+
+	ret = read(transfer->fd, *contents, st.st_size);
+	if (ret < 0) {
+		error("read(): %s(%d)", strerror(errno), errno);
+		g_free(*contents);
+		return -errno;
+	}
+
+	(*contents)[ret] = '\0';
+
+	if (size)
+		*size = ret;
+
+	return 0;
 }
 
 void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
@@ -661,25 +593,41 @@ gint64 obc_transfer_get_size(struct obc_transfer *transfer)
 	return transfer->size;
 }
 
-int obc_transfer_set_file(struct obc_transfer *transfer)
+int obc_transfer_set_file(struct obc_transfer *transfer, const char *contents,
+								size_t size)
 {
-	int fd;
+	int err;
 	struct stat st;
 
-	fd = open(transfer->filename, O_RDONLY);
-	if (fd < 0) {
-		error("open(): %s(%d)", strerror(errno), errno);
-		return -errno;
+	err = transfer_open(transfer, O_RDONLY, 0);
+	if (err < 0)
+		return err;
+
+	if (contents != NULL) {
+		ssize_t w = write(transfer->fd, contents, size);
+		if (w < 0) {
+			error("write(): %s(%d)", strerror(errno), errno);
+			err = -errno;
+			goto fail;
+		} else if ((size_t) w != size) {
+			error("Unable to write all contents to file");
+			err = -EFAULT;
+			goto fail;
+		}
 	}
 
-	if (fstat(fd, &st) < 0) {
+	err = fstat(transfer->fd, &st);
+	if (err < 0) {
 		error("fstat(): %s(%d)", strerror(errno), errno);
-		close(fd);
-		return -errno;
+		err = -errno;
+		goto fail;
 	}
 
-	transfer->fd = fd;
 	transfer->size = st.st_size;
 
 	return 0;
+fail:
+	close(transfer->fd);
+	transfer->fd = -1;
+	return err;
 }
diff --git a/client/transfer.h b/client/transfer.h
index da7d151..a65981c 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -51,13 +51,13 @@ int obc_transfer_put(struct obc_transfer *transfer);
 
 int obc_transfer_get_params(struct obc_transfer *transfer,
 					struct obc_transfer_params *params);
-const char *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size);
-void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer);
-void obc_transfer_clear_buffer(struct obc_transfer *transfer);
+int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
+								size_t *size);
 
 void obc_transfer_set_name(struct obc_transfer *transfer, const char *name);
 void obc_transfer_set_filename(struct obc_transfer *transfer,
 					const char *filename);
 const char *obc_transfer_get_path(struct obc_transfer *transfer);
 gint64 obc_transfer_get_size(struct obc_transfer *transfer);
-int obc_transfer_set_file(struct obc_transfer *transfer);
+int obc_transfer_set_file(struct obc_transfer *transfer, const char *contents,
+								size_t size);
-- 
1.7.7.6

