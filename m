Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/6] client: make transfer structure private
Date: Mon, 18 Jul 2011 13:35:13 +0300
Message-Id: <1310985316-2197-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
References: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This make it easier to modularize obex-client
---
 client/main.c     |    9 +++--
 client/pbap.c     |   42 +++++++++++---------------
 client/session.c  |   86 ++++++++++++++++++++++++++++++-----------------------
 client/sync.c     |    9 +++--
 client/transfer.c |   72 +++++++++++++++++++++++++++++++++++++++++++-
 client/transfer.h |   37 +++++++++-------------
 6 files changed, 162 insertions(+), 93 deletions(-)

diff --git a/client/main.c b/client/main.c
index 18f4d2f..19ca436 100644
--- a/client/main.c
+++ b/client/main.c
@@ -437,7 +437,8 @@ static void capabilities_complete_callback(struct session_data *session,
 {
 	struct transfer_data *transfer = session_get_transfer(session);
 	struct send_data *data = user_data;
-	char *capabilities;
+	const char *capabilities;
+	int size;
 
 	if (err != NULL) {
 		DBusMessage *error = g_dbus_create_error(data->message,
@@ -447,14 +448,14 @@ static void capabilities_complete_callback(struct session_data *session,
 		goto done;
 	}
 
-	capabilities = g_strndup(transfer->buffer, transfer->filled);
+	capabilities = transfer_get_buffer(transfer, &size);
+	if (size == 0)
+		capabilities = "";
 
 	g_dbus_send_reply(data->connection, data->message,
 			DBUS_TYPE_STRING, &capabilities,
 			DBUS_TYPE_INVALID);
 
-	g_free(capabilities);
-
 done:
 
 	shutdown_session(session);
diff --git a/client/pbap.c b/client/pbap.c
index a7017bd..38d5a47 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -294,23 +294,21 @@ static void read_return_apparam(struct session_data *session,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
 	struct transfer_data *transfer = session_get_transfer(session);
-	GwObexXfer *xfer = transfer->xfer;
+	struct transfer_params params;
 	unsigned char *buf;
 	size_t size = 0;
 
 	*phone_book_size = 0;
 	*new_missed_calls = 0;
 
-	if (xfer == NULL)
+	if (transfer_get_params(transfer, &params) < 0)
 		return;
 
-	buf = gw_obex_xfer_object_apparam(xfer, &size);
-
-	if (size < APPARAM_HDR_SIZE)
+	if (params.size < APPARAM_HDR_SIZE)
 		return;
 
 	while (size > APPARAM_HDR_SIZE) {
-		struct apparam_hdr *hdr = (struct apparam_hdr *) buf;
+		struct apparam_hdr *hdr = (struct apparam_hdr *) params.data;
 
 		if (hdr->len > size - APPARAM_HDR_SIZE) {
 			error("Unexpected PBAP pullphonebook app"
@@ -348,7 +346,8 @@ static void pull_phonebook_callback(struct session_data *session,
 	struct transfer_data *transfer = session_get_transfer(session);
 	struct pbap_data *pbap = user_data;
 	DBusMessage *reply;
-	char *buf = "";
+	const char *buf;
+	int size;
 
 	if (pbap->msg == NULL)
 		goto done;
@@ -362,14 +361,15 @@ static void pull_phonebook_callback(struct session_data *session,
 
 	reply = dbus_message_new_method_return(pbap->msg);
 
-	if (transfer->filled > 0)
-		buf = transfer->buffer;
+	buf = transfer_get_buffer(transfer, &size);
+	if (size == 0)
+		buf = "";
 
 	dbus_message_append_args(reply,
 			DBUS_TYPE_STRING, &buf,
 			DBUS_TYPE_INVALID);
 
-	transfer->filled = 0;
+	transfer_clear_buffer(transfer);
 
 send:
 	g_dbus_send_message(pbap->conn, reply);
@@ -407,7 +407,7 @@ static void phonebook_size_callback(struct session_data *session,
 			DBUS_TYPE_UINT16, &phone_book_size,
 			DBUS_TYPE_INVALID);
 
-	transfer->filled = 0;
+	transfer_clear_buffer(transfer);
 
 send:
 	g_dbus_send_message(pbap->conn, reply);
@@ -426,7 +426,8 @@ static void pull_vcard_listing_callback(struct session_data *session,
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
-	int i;
+	const char *buf;
+	int size;
 
 	if (pbap->msg == NULL)
 		goto complete;
@@ -440,15 +441,9 @@ static void pull_vcard_listing_callback(struct session_data *session,
 
 	reply = dbus_message_new_method_return(pbap->msg);
 
-	if (transfer->filled == 0)
-		goto send;
-
-	for (i = transfer->filled - 1; i > 0; i--) {
-		if (transfer->buffer[i] != '\0')
-			break;
-
-		transfer->filled--;
-	}
+	buf = transfer_get_buffer(transfer, &size);
+	if (size == 0)
+		buf = "";
 
 	dbus_message_iter_init_append(reply, &iter);
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
@@ -456,12 +451,11 @@ static void pull_vcard_listing_callback(struct session_data *session,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_STRING_AS_STRING
 			DBUS_STRUCT_END_CHAR_AS_STRING, &array);
 	ctxt = g_markup_parse_context_new(&listing_parser, 0, &array, NULL);
-	g_markup_parse_context_parse(ctxt, transfer->buffer,
-					transfer->filled, NULL);
+	g_markup_parse_context_parse(ctxt, buf, strlen(buf) - 1, NULL);
 	g_markup_parse_context_free(ctxt);
 	dbus_message_iter_close_container(&iter, &array);
 
-	transfer->filled = 0;
+	transfer_clear_buffer(transfer);
 
 send:
 	g_dbus_send_message(pbap->conn, reply);
diff --git a/client/session.c b/client/session.c
index 64bcb78..8ad9a49 100644
--- a/client/session.c
+++ b/client/session.c
@@ -82,6 +82,7 @@ struct session_callback {
 struct pending_data {
 	DBusPendingCall *call;
 	session_callback_t cb;
+	struct session_data *session;
 	struct transfer_data *transfer;
 };
 
@@ -1118,19 +1119,20 @@ static void list_folder_callback(struct session_data *session,
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
-	int i;
-
-	reply = dbus_message_new_method_return(session->msg);
+	const char *buf;
+	int size;
 
-	if (transfer->filled == 0)
+	if (err != NULL) {
+		reply = g_dbus_create_error(session->msg,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
 		goto done;
+	} else
+		reply = dbus_message_new_method_return(session->msg);
 
-	for (i = transfer->filled - 1; i > 0; i--) {
-		if (transfer->buffer[i] != '\0')
-			break;
-
-		transfer->filled--;
-	}
+	buf = transfer_get_buffer(transfer, &size);
+	if (size == 0)
+		buf = "";
 
 	dbus_message_iter_init_append(reply, &iter);
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
@@ -1139,12 +1141,11 @@ static void list_folder_callback(struct session_data *session,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
 	ctxt = g_markup_parse_context_new(&parser, 0, &array, NULL);
-	g_markup_parse_context_parse(ctxt, transfer->buffer,
-					transfer->filled, NULL);
+	g_markup_parse_context_parse(ctxt, buf, strlen(buf) - 1, NULL);
 	g_markup_parse_context_free(ctxt);
 	dbus_message_iter_close_container(&iter, &array);
 
-	transfer->filled = 0;
+	transfer_clear_buffer(transfer);
 
 done:
 	g_dbus_send_message(session->conn, reply);
@@ -1190,10 +1191,8 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 
 	DBG("Agent.Request() reply: %s", name);
 
-	if (strlen(name)) {
-		g_free(pending->transfer->name);
-		pending->transfer->name = g_strdup(name);
-	}
+	if (strlen(name))
+		transfer_set_name(pending->transfer, name);
 
 	agent->pending = NULL;
 
@@ -1209,7 +1208,7 @@ static gboolean session_request_proceed(gpointer data)
 	struct pending_data *pending = data;
 	struct transfer_data *transfer = pending->transfer;
 
-	pending->cb(transfer->session, NULL, transfer);
+	pending->cb(pending->session, NULL, transfer);
 	free_pending(pending);
 
 	return FALSE;
@@ -1221,12 +1220,16 @@ static int session_request(struct session_data *session, session_callback_t cb,
 	struct agent_data *agent = session->agent;
 	DBusMessage *message;
 	struct pending_data *pending;
+	const char *path;
 
 	pending = g_new0(struct pending_data, 1);
 	pending->cb = cb;
+	pending->session = session;
 	pending->transfer = transfer;
 
-	if (agent == NULL || transfer->path == NULL) {
+	path = transfer_get_path(transfer);
+
+	if (agent == NULL || path == NULL) {
 		g_idle_add(session_request_proceed, pending);
 		return 0;
 	}
@@ -1235,7 +1238,7 @@ static int session_request(struct session_data *session, session_callback_t cb,
 			agent->path, AGENT_INTERFACE, "Request");
 
 	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &transfer->path,
+			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
 
 	if (!dbus_connection_send_with_reply(session->conn, message,
@@ -1251,7 +1254,7 @@ static int session_request(struct session_data *session, session_callback_t cb,
 	dbus_pending_call_set_notify(pending->call, session_request_reply,
 					session, NULL);
 
-	DBG("Agent.Request(\"%s\")", transfer->path);
+	DBG("Agent.Request(\"%s\")", path);
 
 	return 0;
 }
@@ -1283,8 +1286,11 @@ static void session_notify_complete(struct session_data *session,
 {
 	struct agent_data *agent = session->agent;
 	DBusMessage *message;
+	const char *path;
+
+	path = transfer_get_path(transfer);
 
-	if (agent == NULL || transfer->path == NULL)
+	if (agent == NULL || path == NULL)
 		goto done;
 
 	message = dbus_message_new_method_call(agent->name,
@@ -1295,7 +1301,7 @@ static void session_notify_complete(struct session_data *session,
 	dbus_message_set_no_reply(message, TRUE);
 
 	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &transfer->path,
+			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
 
 	g_dbus_send_message(session->conn, message);
@@ -1313,6 +1319,7 @@ static void session_notify_error(struct session_data *session,
 {
 	struct agent_data *agent = session->agent;
 	DBusMessage *message;
+	const char *path;
 
 	if (session->msg) {
 		DBusMessage *reply;
@@ -1326,7 +1333,8 @@ static void session_notify_error(struct session_data *session,
 		session->msg = NULL;
 	}
 
-	if (agent == NULL || transfer->path == NULL)
+	path = transfer_get_path(transfer);
+	if (agent == NULL || path == NULL)
 		goto done;
 
 	message = dbus_message_new_method_call(agent->name,
@@ -1337,7 +1345,7 @@ static void session_notify_error(struct session_data *session,
 	dbus_message_set_no_reply(message, TRUE);
 
 	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &transfer->path,
+			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_STRING, &err->message,
 			DBUS_TYPE_INVALID);
 
@@ -1355,9 +1363,11 @@ static void session_notify_progress(struct session_data *session,
 {
 	struct agent_data *agent = session->agent;
 	DBusMessage *message;
+	const char *path;
 
 	/* For GetFile reply on the first received stream */
-	if (transfer->fd > 0 && session->msg) {
+	if (session->msg &&
+			dbus_message_has_member(session->msg, "GetFile")) {
 		DBusMessage *reply;
 
 		reply = dbus_message_new_method_return(session->msg);
@@ -1367,7 +1377,8 @@ static void session_notify_progress(struct session_data *session,
 		session->msg = NULL;
 	}
 
-	if (agent == NULL || transfer->path == NULL)
+	path = transfer_get_path(transfer);
+	if (agent == NULL || path == NULL)
 		goto done;
 
 	message = dbus_message_new_method_call(agent->name,
@@ -1378,7 +1389,7 @@ static void session_notify_progress(struct session_data *session,
 	dbus_message_set_no_reply(message, TRUE);
 
 	dbus_message_append_args(message,
-			DBUS_TYPE_OBJECT_PATH, &transfer->path,
+			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_UINT64, &transferred,
 			DBUS_TYPE_INVALID);
 
@@ -1388,7 +1399,7 @@ done:
 	DBG("Transfer(%p) progress: %ld bytes", transfer,
 			(long int ) transferred);
 
-	if (transferred == transfer->size)
+	if (transferred == transfer_get_size(transfer))
 		session_notify_complete(session, transfer);
 }
 
@@ -1450,8 +1461,8 @@ int session_get(struct session_data *session, const char *type,
 		params->size = apparam_size;
 	}
 
-	transfer = transfer_register(session, filename, targetname, type,
-					params);
+	transfer = transfer_register(session->conn, filename, targetname, type,
+					params, session);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
@@ -1647,8 +1658,8 @@ int session_send(struct session_data *session, const char *filename,
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
-	transfer = transfer_register(session, filename, targetname, NULL,
-					NULL);
+	transfer = transfer_register(session->conn, filename, targetname, NULL,
+					NULL, session);
 	if (transfer == NULL)
 		return -EINVAL;
 
@@ -1678,7 +1689,8 @@ int session_pull(struct session_data *session,
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
-	transfer = transfer_register(session, NULL, filename, type, NULL);
+	transfer = transfer_register(session->conn, NULL, filename, type, NULL,
+								session);
 	if (transfer == NULL) {
 		return -EIO;
 	}
@@ -1777,12 +1789,12 @@ int session_put(struct session_data *session, char *buf, const char *targetname)
 	if (session->pending != NULL)
 		return -EISCONN;
 
-	transfer = transfer_register(session, NULL, targetname, NULL, NULL);
+	transfer = transfer_register(session->conn, NULL, targetname, NULL,
+								NULL, session);
 	if (transfer == NULL)
 		return -EIO;
 
-	transfer->size = strlen(buf);
-	transfer->buffer = buf;
+	transfer_set_buffer(transfer, buf);
 
 	err = session_request(session, session_prepare_put, transfer);
 	if (err < 0)
diff --git a/client/sync.c b/client/sync.c
index 9271bf3..d9b6af7 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -79,18 +79,19 @@ static void sync_getphonebook_callback(struct session_data *session,
 	struct transfer_data *transfer = session_get_transfer(session);
 	struct sync_data *sync = user_data;
 	DBusMessage *reply;
-	char *buf = NULL;
+	const char *buf;
+	int size;
 
 	reply = dbus_message_new_method_return(sync->msg);
 
-	if (transfer->filled > 0)
-		buf = transfer->buffer;
+	buf = transfer_get_buffer(transfer, &size);
+	if (size == 0)
+		buf = "";
 
 	dbus_message_append_args(reply,
 		DBUS_TYPE_STRING, &buf,
 		DBUS_TYPE_INVALID);
 
-	transfer->filled = 0;
 	g_dbus_send_message(sync->conn, reply);
 	dbus_message_unref(sync->msg);
 	sync->msg = NULL;
diff --git a/client/transfer.c b/client/transfer.c
index 9e6f0ad..39b0c91 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -51,6 +51,25 @@ struct transfer_callback {
 	void *data;
 };
 
+struct transfer_data {
+	struct session_data *session;
+	struct transfer_params *params;
+	struct transfer_callback *callback;
+	DBusConnection *conn;
+	char *path;		/* Transfer path */
+	gchar *filename;	/* Transfer file location */
+	char *name;		/* Transfer object name */
+	char *type;		/* Transfer object type */
+	int fd;
+	GwObexXfer *xfer;
+	char *buffer;
+	size_t buffer_len;
+	int filled;
+	gint64 size;
+	gint64 transferred;
+	int err;
+};
+
 static void append_entry(DBusMessageIter *dict,
 				const char *key, int type, void *val)
 {
@@ -177,12 +196,14 @@ static void transfer_free(struct transfer_data *transfer)
 	g_free(transfer);
 }
 
-struct transfer_data *transfer_register(struct session_data *session,
+struct transfer_data *transfer_register(DBusConnection *conn,
 						const char *filename,
 						const char *name,
 						const char *type,
-						struct transfer_params *params)
+						struct transfer_params *params,
+						void *user_data)
 {
+	struct session_data *session = user_data;
 	struct transfer_data *transfer;
 
 	transfer = g_new0(struct transfer_data, 1);
@@ -539,3 +560,50 @@ void transfer_abort(struct transfer_data *transfer)
 		callback->func(transfer, transfer->transferred, -ECANCELED,
 				callback->data);
 }
+
+int transfer_get_params(struct transfer_data *transfer,
+					struct transfer_params *params)
+{
+	if (!transfer->xfer)
+		return -ENOTCONN;
+
+	params->data = gw_obex_xfer_object_apparam(transfer->xfer,
+								&params->size);
+
+	return 0;
+}
+
+void transfer_clear_buffer(struct transfer_data *transfer)
+{
+	transfer->filled = 0;
+}
+
+const char *transfer_get_buffer(struct transfer_data *transfer, int *size)
+{
+	if (size)
+		*size = transfer->filled;
+
+	return transfer->buffer;
+}
+
+void transfer_set_buffer(struct transfer_data *transfer, char *buffer)
+{
+	transfer->size = strlen(buffer);
+	transfer->buffer = buffer;
+}
+
+void transfer_set_name(struct transfer_data *transfer, const char *name)
+{
+	g_free(transfer->name);
+	transfer->name = g_strdup(name);
+}
+
+const char *transfer_get_path(struct transfer_data *transfer)
+{
+	return transfer->path;
+}
+
+gint64 transfer_get_size(struct transfer_data *transfer)
+{
+	return transfer->size;
+}
diff --git a/client/transfer.h b/client/transfer.h
index 7392267..ac14623 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -25,39 +25,22 @@
 
 struct transfer_params {
 	guint8 *data;
-	gint size;
+	size_t size;
 };
 
 struct transfer_callback;
-
-struct transfer_data {
-	struct session_data *session;
-	struct transfer_params *params;
-	struct transfer_callback *callback;
-	DBusConnection *conn;
-	char *path;		/* Transfer path */
-	gchar *filename;	/* Transfer file location */
-	char *name;		/* Transfer object name */
-	char *type;		/* Transfer object type */
-	int fd;
-	GwObexXfer *xfer;
-	char *buffer;
-	size_t buffer_len;
-	int filled;
-	gint64 size;
-	gint64 transferred;
-	int err;
-};
+struct transfer_data;
 
 typedef void (*transfer_callback_t) (struct transfer_data *transfer,
 					gint64 transferred, gint err,
 					void *user_data);
 
-struct transfer_data *transfer_register(struct session_data *session,
+struct transfer_data *transfer_register(DBusConnection *conn,
 						const char *filename,
 						const char *name,
 						const char *type,
-						struct transfer_params *params);
+						struct transfer_params *params,
+						void *user_data);
 
 void transfer_unregister(struct transfer_data *transfer);
 
@@ -66,3 +49,13 @@ int transfer_get(struct transfer_data *transfer, transfer_callback_t func,
 int transfer_put(struct transfer_data *transfer, transfer_callback_t func,
 			void *user_data);
 void transfer_abort(struct transfer_data *transfer);
+
+int transfer_get_params(struct transfer_data *transfer,
+					struct transfer_params *params);
+const char *transfer_get_buffer(struct transfer_data *transfer, int *size);
+void transfer_set_buffer(struct transfer_data *transfer, char *buffer);
+void transfer_clear_buffer(struct transfer_data *transfer);
+
+void transfer_set_name(struct transfer_data *transfer, const char *name);
+const char *transfer_get_path(struct transfer_data *transfer);
+gint64 transfer_get_size(struct transfer_data *transfer);
-- 
1.7.6

