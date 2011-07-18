Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/6] client: make session structure private
Date: Mon, 18 Jul 2011 13:35:12 +0300
Message-Id: <1310985316-2197-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
References: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Session data should not be acessible directly otherwise it cause too
much dependency by profile specific code which is quite inefficient in
the long term.
---
 client/main.c     |   25 +++--
 client/pbap.c     |  284 ++++++++++++++++++++++++++++++-----------------------
 client/pbap.h     |   14 +---
 client/session.c  |  118 ++++++++++++++++------
 client/session.h  |   45 +++------
 client/sync.c     |   86 +++++++++-------
 client/sync.h     |    5 +-
 client/transfer.c |   30 ++++--
 client/transfer.h |    1 +
 9 files changed, 351 insertions(+), 257 deletions(-)

diff --git a/client/main.c b/client/main.c
index 478181c..18f4d2f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -61,11 +61,15 @@ static void shutdown_session(struct session_data *session)
 	session_unref(session);
 }
 
-static void owner_exit(DBusConnection *connection, void *user_data)
+static void unregister_session(void *data)
 {
-	struct session_data *session = user_data;
+	struct session_data *session = data;
 
-	shutdown_session(session);
+	if (g_slist_find(sessions, session) == NULL)
+		return;
+
+	sessions = g_slist_remove(sessions, session);
+	session_unref(session);
 }
 
 static void create_callback(struct session_data *session, GError *err,
@@ -83,12 +87,13 @@ static void create_callback(struct session_data *session, GError *err,
 		goto done;
 	}
 
-	if (session->target != NULL) {
-		session_register(session);
-		session_set_owner(session, data->sender, owner_exit);
+	if (session_get_target(session) != NULL) {
+		const char *path;
+
+		path = session_register(session, unregister_session);
 
 		g_dbus_send_reply(data->connection, data->message,
-				DBUS_TYPE_OBJECT_PATH, &session->path,
+				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
 		goto done;
 	}
@@ -351,7 +356,7 @@ static struct session_data *find_session(const char *path)
 	for (l = sessions; l; l = l->next) {
 		struct session_data *session = l->data;
 
-		if (g_str_equal(session->path, path) == TRUE)
+		if (g_str_equal(session_get_path(session), path) == TRUE)
 			return session;
 	}
 
@@ -417,7 +422,7 @@ static DBusMessage *remove_session(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	sender = dbus_message_get_sender(message);
-	if (g_str_equal(sender, session->owner) == FALSE)
+	if (g_str_equal(sender, session_get_owner(session)) == FALSE)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.NotAuthorized",
 				"Not Authorized");
@@ -430,7 +435,7 @@ static DBusMessage *remove_session(DBusConnection *connection,
 static void capabilities_complete_callback(struct session_data *session,
 						GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session->pending->data;
+	struct transfer_data *transfer = session_get_transfer(session);
 	struct send_data *data = user_data;
 	char *capabilities;
 
diff --git a/client/pbap.c b/client/pbap.c
index 589b1ca..a7017bd 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -112,6 +112,18 @@ static const char *filter_list[] = {
 #define FILTER_BIT_MAX	63
 #define FILTER_ALL	0xFFFFFFFFFFFFFFFFULL
 
+#define PBAP_INTERFACE  "org.openobex.PhonebookAccess"
+
+struct pbap_data {
+	struct session_data *session;
+	char *path;
+	DBusConnection *conn;
+	DBusMessage *msg;
+	guint8 format;
+	guint8 order;
+	uint64_t filter;
+};
+
 struct pullphonebook_apparam {
 	uint8_t     filter_tag;
 	uint8_t     filter_len;
@@ -218,38 +230,38 @@ static gchar *build_phonebook_path(const char *location, const char *item)
 }
 
 /* should only be called inside pbap_set_path */
-static void pbap_reset_path(struct session_data *session)
+static void pbap_reset_path(struct pbap_data *pbap)
 {
 	int err = 0;
 	char **paths = NULL, **item;
-	struct pbap_data *pbapdata = session_get_data(session);
+	GwObex *obex = session_get_obex(pbap->session);
 
-	if (!pbapdata->path)
+	if (!pbap->path)
 		return;
 
-	gw_obex_chdir(session->obex, "", &err);
+	gw_obex_chdir(obex, "", &err);
 
-	paths = g_strsplit(pbapdata->path, "/", 3);
+	paths = g_strsplit(pbap->path, "/", 3);
 
 	for (item = paths; *item; item++)
-		gw_obex_chdir(session->obex, *item, &err);
+		gw_obex_chdir(obex, *item, &err);
 
 	g_strfreev(paths);
 }
 
-static gint pbap_set_path(struct session_data *session, const char *path)
+static gint pbap_set_path(struct pbap_data *pbap, const char *path)
 {
 	int err = 0;
 	char **paths = NULL, **item;
-	struct pbap_data *pbapdata = session_get_data(session);
+	GwObex *obex = session_get_obex(pbap->session);
 
 	if (!path)
 		return OBEX_RSP_BAD_REQUEST;
 
-	if (pbapdata->path != NULL && g_str_equal(pbapdata->path, path))
+	if (pbap->path != NULL && g_str_equal(pbap->path, path))
 		return 0;
 
-	if (gw_obex_chdir(session->obex, "", &err) == FALSE) {
+	if (gw_obex_chdir(obex, "", &err) == FALSE) {
 		if (err == OBEX_RSP_NOT_IMPLEMENTED)
 			goto done;
 		goto fail;
@@ -257,9 +269,9 @@ static gint pbap_set_path(struct session_data *session, const char *path)
 
 	paths = g_strsplit(path, "/", 3);
 	for (item = paths; *item; item++) {
-		if (gw_obex_chdir(session->obex, *item, &err) == FALSE) {
+		if (gw_obex_chdir(obex, *item, &err) == FALSE) {
 			/* we need to reset the path to the saved one on fail*/
-			pbap_reset_path(session);
+			pbap_reset_path(pbap);
 			goto fail;
 		}
 	}
@@ -267,8 +279,8 @@ static gint pbap_set_path(struct session_data *session, const char *path)
 	g_strfreev(paths);
 
 done:
-	g_free(pbapdata->path);
-	pbapdata->path = g_strdup(path);
+	g_free(pbap->path);
+	pbap->path = g_strdup(path);
 	return 0;
 
 fail:
@@ -281,7 +293,7 @@ fail:
 static void read_return_apparam(struct session_data *session,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
-	struct transfer_data *transfer = session->pending->data;
+	struct transfer_data *transfer = session_get_transfer(session);
 	GwObexXfer *xfer = transfer->xfer;
 	unsigned char *buf;
 	size_t size = 0;
@@ -333,14 +345,22 @@ static void read_return_apparam(struct session_data *session,
 static void pull_phonebook_callback(struct session_data *session,
 					GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session->pending->data;
+	struct transfer_data *transfer = session_get_transfer(session);
+	struct pbap_data *pbap = user_data;
 	DBusMessage *reply;
 	char *buf = "";
 
-	if (session->msg == NULL)
+	if (pbap->msg == NULL)
 		goto done;
 
-	reply = dbus_message_new_method_return(session->msg);
+	if (err) {
+		reply = g_dbus_create_error(pbap->msg,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		goto send;
+	}
+
+	reply = dbus_message_new_method_return(pbap->msg);
 
 	if (transfer->filled > 0)
 		buf = transfer->buffer;
@@ -350,9 +370,11 @@ static void pull_phonebook_callback(struct session_data *session,
 			DBUS_TYPE_INVALID);
 
 	transfer->filled = 0;
-	g_dbus_send_message(session->conn, reply);
-	dbus_message_unref(session->msg);
-	session->msg = NULL;
+
+send:
+	g_dbus_send_message(pbap->conn, reply);
+	dbus_message_unref(pbap->msg);
+	pbap->msg = NULL;
 
 done:
 	transfer_unregister(transfer);
@@ -361,15 +383,23 @@ done:
 static void phonebook_size_callback(struct session_data *session,
 					GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session->pending->data;
+	struct transfer_data *transfer = session_get_transfer(session);
+	struct pbap_data *pbap = user_data;
 	DBusMessage *reply;
 	guint16 phone_book_size;
 	guint8 new_missed_calls;
 
-	if (session->msg == NULL)
+	if (pbap->msg == NULL)
 		goto done;
 
-	reply = dbus_message_new_method_return(session->msg);
+	if (err) {
+		reply = g_dbus_create_error(pbap->msg,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		goto send;
+	}
+
+	reply = dbus_message_new_method_return(pbap->msg);
 
 	read_return_apparam(session, &phone_book_size, &new_missed_calls);
 
@@ -378,9 +408,11 @@ static void phonebook_size_callback(struct session_data *session,
 			DBUS_TYPE_INVALID);
 
 	transfer->filled = 0;
-	g_dbus_send_message(session->conn, reply);
-	dbus_message_unref(session->msg);
-	session->msg = NULL;
+
+send:
+	g_dbus_send_message(pbap->conn, reply);
+	dbus_message_unref(pbap->msg);
+	pbap->msg = NULL;
 
 done:
 	transfer_unregister(transfer);
@@ -389,19 +421,27 @@ done:
 static void pull_vcard_listing_callback(struct session_data *session,
 					GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session->pending->data;
+	struct transfer_data *transfer = session_get_transfer(session);
+	struct pbap_data *pbap = user_data;
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
 	int i;
 
-	if (session->msg == NULL)
+	if (pbap->msg == NULL)
 		goto complete;
 
-	reply = dbus_message_new_method_return(session->msg);
+	if (err) {
+		reply = g_dbus_create_error(pbap->msg,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		goto send;
+	}
+
+	reply = dbus_message_new_method_return(pbap->msg);
 
 	if (transfer->filled == 0)
-		goto done;
+		goto send;
 
 	for (i = transfer->filled - 1; i > 0; i--) {
 		if (transfer->buffer[i] != '\0')
@@ -423,15 +463,15 @@ static void pull_vcard_listing_callback(struct session_data *session,
 
 	transfer->filled = 0;
 
-done:
-	g_dbus_send_message(session->conn, reply);
-	dbus_message_unref(session->msg);
-	session->msg = NULL;
+send:
+	g_dbus_send_message(pbap->conn, reply);
+	dbus_message_unref(pbap->msg);
+	pbap->msg = NULL;
 complete:
 	transfer_unregister(transfer);
 }
 
-static DBusMessage *pull_phonebook(struct session_data *session,
+static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 					DBusMessage *message, guint8 type,
 					const char *name, uint64_t filter,
 					guint8 format, guint16 maxlistcount,
@@ -440,7 +480,7 @@ static DBusMessage *pull_phonebook(struct session_data *session,
 	struct pullphonebook_apparam apparam;
 	session_callback_t func;
 
-	if (session->msg)
+	if (pbap->msg)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InProgress",
 				"Transfer in progress");
@@ -470,14 +510,14 @@ static DBusMessage *pull_phonebook(struct session_data *session,
 		return NULL;
 	}
 
-	if (session_get(session, "x-bt/phonebook", name, NULL,
+	if (session_get(pbap->session, "x-bt/phonebook", name, NULL,
 				(guint8 *) &apparam, sizeof(apparam),
-				func) < 0)
+				func, pbap) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"Failed");
 
-	session->msg = dbus_message_ref(message);
+	pbap->msg = dbus_message_ref(message);
 
 	return NULL;
 }
@@ -494,7 +534,7 @@ static guint8 *fill_apparam(guint8 *dest, void *buf, guint8 tag, guint8 len)
 	return dest;
 }
 
-static DBusMessage *pull_vcard_listing(struct session_data *session,
+static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 					DBusMessage *message, const char *name,
 					guint8 order, char *searchval, guint8 attrib,
 					guint16 count, guint16 offset)
@@ -503,7 +543,7 @@ static DBusMessage *pull_vcard_listing(struct session_data *session,
 	gint apparam_size;
 	int err;
 
-	if (session->msg)
+	if (pbap->msg)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InProgress",
 				"Transfer in progress");
@@ -534,53 +574,50 @@ static DBusMessage *pull_vcard_listing(struct session_data *session,
 	offset = GUINT16_TO_BE(offset);
 	p = fill_apparam(p, &offset, LISTSTARTOFFSET_TAG, LISTSTARTOFFSET_LEN);
 
-	err = session_get(session, "x-bt/vcard-listing", name, NULL,
-				apparam, apparam_size, pull_vcard_listing_callback);
+	err = session_get(pbap->session, "x-bt/vcard-listing", name, NULL,
+				apparam, apparam_size,
+				pull_vcard_listing_callback, pbap);
 	g_free(apparam);
 	if (err < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"Failed");
 
-	session->msg = dbus_message_ref(message);
+	pbap->msg = dbus_message_ref(message);
 
 	return NULL;
 }
 
-static int set_format(struct session_data *session, const char *formatstr)
+static int set_format(struct pbap_data *pbap, const char *formatstr)
 {
-	struct pbap_data *pbapdata = session_get_data(session);
-
 	if (!formatstr || g_str_equal(formatstr, "")) {
-		pbapdata->format = FORMAT_VCARD21;
+		pbap->format = FORMAT_VCARD21;
 		return 0;
 	}
 
 	if (!g_ascii_strcasecmp(formatstr, "vcard21"))
-		pbapdata->format = FORMAT_VCARD21;
+		pbap->format = FORMAT_VCARD21;
 	else if (!g_ascii_strcasecmp(formatstr, "vcard30"))
-		pbapdata->format = FORMAT_VCARD30;
+		pbap->format = FORMAT_VCARD30;
 	else
 		return -EINVAL;
 
 	return 0;
 }
 
-static int set_order(struct session_data *session, const char *orderstr)
+static int set_order(struct pbap_data *pbap, const char *orderstr)
 {
-	struct pbap_data *pbapdata = session_get_data(session);
-
 	if (!orderstr || g_str_equal(orderstr, "")) {
-		pbapdata->order = ORDER_INDEXED;
+		pbap->order = ORDER_INDEXED;
 		return 0;
 	}
 
 	if (!g_ascii_strcasecmp(orderstr, "indexed"))
-		pbapdata->order = ORDER_INDEXED;
+		pbap->order = ORDER_INDEXED;
 	else if (!g_ascii_strcasecmp(orderstr, "alphanumeric"))
-		pbapdata->order = ORDER_ALPHANUMERIC;
+		pbap->order = ORDER_ALPHANUMERIC;
 	else if (!g_ascii_strcasecmp(orderstr, "phonetic"))
-		pbapdata->order = ORDER_PHONETIC;
+		pbap->order = ORDER_PHONETIC;
 	else
 		return -EINVAL;
 
@@ -612,9 +649,8 @@ static uint64_t get_filter_mask(const char *filterstr)
 		return 0;
 }
 
-static int add_filter(struct session_data *session, const char *filterstr)
+static int add_filter(struct pbap_data *pbap, const char *filterstr)
 {
-	struct pbap_data *pbapdata = session_get_data(session);
 	uint64_t mask;
 
 	mask = get_filter_mask(filterstr);
@@ -622,13 +658,12 @@ static int add_filter(struct session_data *session, const char *filterstr)
 	if (mask == 0)
 		return -EINVAL;
 
-	pbapdata->filter |= mask;
+	pbap->filter |= mask;
 	return 0;
 }
 
-static int remove_filter(struct session_data *session, const char *filterstr)
+static int remove_filter(struct pbap_data *pbap, const char *filterstr)
 {
-	struct pbap_data *pbapdata = session_get_data(session);
 	uint64_t mask;
 
 	mask = get_filter_mask(filterstr);
@@ -636,7 +671,7 @@ static int remove_filter(struct session_data *session, const char *filterstr)
 	if (mask == 0)
 		return -EINVAL;
 
-	pbapdata->filter &= ~mask;
+	pbap->filter &= ~mask;
 	return 0;
 }
 
@@ -669,7 +704,7 @@ static gchar **get_filter_strs(uint64_t filter, gint *size)
 static DBusMessage *pbap_select(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
+	struct pbap_data *pbap = user_data;
 	const char *item, *location;
 	char *path = NULL;
 	int err = 0;
@@ -686,7 +721,7 @@ static DBusMessage *pbap_select(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", "InvalidPhonebook");
 
-	err = pbap_set_path(session, path);
+	err = pbap_set_path(pbap, path);
 	g_free(path);
 	if (err)
 		return g_dbus_create_error(message,
@@ -699,19 +734,18 @@ static DBusMessage *pbap_select(DBusConnection *connection,
 static DBusMessage *pbap_pull_all(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct pbap_data *pbapdata = session_get_data(session);
+	struct pbap_data *pbap = user_data;
 	DBusMessage * err;
 	char *name;
 
-	if (!pbapdata->path)
+	if (!pbap->path)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Forbidden", "Call Select first of all");
 
-	name = g_strconcat(pbapdata->path, ".vcf", NULL);
+	name = g_strconcat(pbap->path, ".vcf", NULL);
 
-	err = pull_phonebook(session, message, PULLPHONEBOOK, name,
-				pbapdata->filter, pbapdata->format,
+	err = pull_phonebook(pbap, message, PULLPHONEBOOK, name,
+				pbap->filter, pbap->format,
 				DEFAULT_COUNT, DEFAULT_OFFSET);
 	g_free(name);
 	return err;
@@ -720,12 +754,11 @@ static DBusMessage *pbap_pull_all(DBusConnection *connection,
 static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct pbap_data *pbapdata = session_get_data(session);
+	struct pbap_data *pbap = user_data;
 	struct pullvcardentry_apparam apparam;
 	const char *name;
 
-	if (!pbapdata->path)
+	if (!pbap->path)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Forbidden",
 				"Call Select first of all");
@@ -736,26 +769,26 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	if (session->msg)
+	if (pbap->msg)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InProgress",
 				"Transfer in progress");
 
 	apparam.filter_tag = FILTER_TAG;
 	apparam.filter_len = FILTER_LEN;
-	apparam.filter = GUINT64_TO_BE(pbapdata->filter);
+	apparam.filter = GUINT64_TO_BE(pbap->filter);
 	apparam.format_tag = FORMAT_TAG;
 	apparam.format_len = FORMAT_LEN;
-	apparam.format = pbapdata->format;
+	apparam.format = pbap->format;
 
-	if (session_get(session, "x-bt/vcard", name, NULL,
+	if (session_get(pbap->session, "x-bt/vcard", name, NULL,
 			(guint8 *)&apparam, sizeof(apparam),
-			pull_phonebook_callback) < 0)
+			pull_phonebook_callback, pbap) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"Failed");
 
-	session->msg = dbus_message_ref(message);
+	pbap->msg = dbus_message_ref(message);
 
 	return NULL;
 }
@@ -763,22 +796,20 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 static DBusMessage *pbap_list(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct pbap_data *pbapdata = session_get_data(session);
+	struct pbap_data *pbap = user_data;
 
-	if (!pbapdata->path)
+	if (!pbap->path)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Forbidden", "Call Select first of all");
 
-	return pull_vcard_listing(session, message, "", pbapdata->order, "",
+	return pull_vcard_listing(pbap, message, "", pbap->order, "",
 				ATTRIB_NAME, DEFAULT_COUNT, DEFAULT_OFFSET);
 }
 
 static DBusMessage *pbap_search(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct pbap_data *pbapdata = session_get_data(session);
+	struct pbap_data *pbap = user_data;
 	char *field, *value;
 	guint8 attrib;
 
@@ -789,7 +820,7 @@ static DBusMessage *pbap_search(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	if (!pbapdata->path)
+	if (!pbap->path)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Forbidden", "Call Select first of all");
 
@@ -805,27 +836,26 @@ static DBusMessage *pbap_search(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	return pull_vcard_listing(session, message, "", pbapdata->order, value,
-				attrib, DEFAULT_COUNT, DEFAULT_OFFSET);
+	return pull_vcard_listing(pbap, message, "", pbap->order, value,
+					attrib, DEFAULT_COUNT, DEFAULT_OFFSET);
 }
 
 static DBusMessage *pbap_get_size(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct pbap_data *pbapdata = session_get_data(session);
+	struct pbap_data *pbap = user_data;
 	DBusMessage * err;
 	char *name;
 
-	if (!pbapdata->path)
+	if (!pbap->path)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Forbidden", "Call Select first of all");
 
-	name = g_strconcat(pbapdata->path, ".vcf", NULL);
+	name = g_strconcat(pbap->path, ".vcf", NULL);
 
-	err = pull_phonebook(session, message, GETPHONEBOOKSIZE, name,
-				pbapdata->filter, pbapdata->format,
-				0, DEFAULT_OFFSET);
+	err = pull_phonebook(pbap, message, GETPHONEBOOKSIZE, name,
+				pbap->filter, pbap->format, 0,
+				DEFAULT_OFFSET);
 	g_free(name);
 	return err;
 }
@@ -833,7 +863,7 @@ static DBusMessage *pbap_get_size(DBusConnection *connection,
 static DBusMessage *pbap_set_format(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
+	struct pbap_data *pbap = user_data;
 	const char *format;
 
 	if (dbus_message_get_args(message, NULL,
@@ -842,7 +872,7 @@ static DBusMessage *pbap_set_format(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	if (set_format(session, format) < 0)
+	if (set_format(pbap, format) < 0)
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", "InvalidFormat");
 
@@ -852,7 +882,7 @@ static DBusMessage *pbap_set_format(DBusConnection *connection,
 static DBusMessage *pbap_set_order(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
+	struct pbap_data *pbap = user_data;
 	const char *order;
 
 	if (dbus_message_get_args(message, NULL,
@@ -861,7 +891,7 @@ static DBusMessage *pbap_set_order(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	if (set_order(session, order) < 0)
+	if (set_order(pbap, order) < 0)
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", "InvalidFilter");
 
@@ -871,11 +901,10 @@ static DBusMessage *pbap_set_order(DBusConnection *connection,
 static DBusMessage *pbap_set_filter(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct pbap_data *pbapdata = session_get_data(session);
+	struct pbap_data *pbap = user_data;
 	char **filters, **item;
 	gint size;
-	uint64_t oldfilter = pbapdata->filter;
+	uint64_t oldfilter = pbap->filter;
 
 	if (dbus_message_get_args(message, NULL, DBUS_TYPE_ARRAY,
 			DBUS_TYPE_STRING, &filters, &size,
@@ -883,13 +912,13 @@ static DBusMessage *pbap_set_filter(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	remove_filter(session, "ALL");
+	remove_filter(pbap, "ALL");
 	if (size == 0)
 		goto done;
 
 	for (item = filters; *item; item++) {
-		if (add_filter(session, *item) < 0) {
-			pbapdata->filter = oldfilter;
+		if (add_filter(pbap, *item) < 0) {
+			pbap->filter = oldfilter;
 			g_strfreev(filters);
 			return g_dbus_create_error(message,
 					ERROR_INF ".InvalidArguments", "InvalidFilters");
@@ -904,13 +933,12 @@ done:
 static DBusMessage *pbap_get_filter(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct pbap_data *pbapdata = session_get_data(session);
+	struct pbap_data *pbap = user_data;
 	gchar **filters = NULL;
 	gint size;
 	DBusMessage *reply;
 
-	filters = get_filter_strs(pbapdata->filter, &size);
+	filters = get_filter_strs(pbap->filter, &size);
 	reply = dbus_message_new_method_return(message);
 	dbus_message_append_args(reply, DBUS_TYPE_ARRAY,
 				DBUS_TYPE_STRING, &filters, size,
@@ -957,28 +985,38 @@ static GDBusMethodTable pbap_methods[] = {
 	{ }
 };
 
+static void pbap_free(void *data)
+{
+	struct pbap_data *pbap = data;
+
+	session_unref(pbap->session);
+	dbus_connection_unref(pbap->conn);
+	g_free(pbap);
+}
+
 gboolean pbap_register_interface(DBusConnection *connection, const char *path,
-				void *user_data, GDBusDestroyFunction destroy)
+							void *user_data)
 {
 	struct session_data *session = user_data;
-	void *priv;
+	struct pbap_data *pbap;
 
-	priv = g_try_malloc0(sizeof(struct pbap_data));
-	if (!priv)
+	pbap = g_try_new0(struct pbap_data, 1);
+	if (!pbap)
 		return FALSE;
 
-	session_set_data(session, priv);
+	pbap->session = session_ref(session);
+	pbap->conn = dbus_connection_ref(connection);
+
+	if (g_dbus_register_interface(connection, path, PBAP_INTERFACE,
+			pbap_methods, NULL, NULL, pbap, pbap_free) == FALSE) {
+		pbap_free(pbap);
+		return FALSE;
+	}
 
-	return g_dbus_register_interface(connection, path, PBAP_INTERFACE,
-				pbap_methods, NULL, NULL, user_data, destroy);
+	return TRUE;
 }
 
-void pbap_unregister_interface(DBusConnection *connection, const char *path,
-				void *user_data)
+void pbap_unregister_interface(DBusConnection *connection, const char *path)
 {
-	struct session_data *session = user_data;
-	void *priv = session_get_data(session);
-
 	g_dbus_unregister_interface(connection, path, PBAP_INTERFACE);
-	g_free(priv);
 }
diff --git a/client/pbap.h b/client/pbap.h
index 8fae116..3ae1159 100644
--- a/client/pbap.h
+++ b/client/pbap.h
@@ -24,16 +24,6 @@
 
 #include <gdbus.h>
 
-#define PBAP_INTERFACE  "org.openobex.PhonebookAccess"
-
-struct pbap_data {
-	char *path;
-	guint8 format;
-	guint8 order;
-	uint64_t filter;
-};
-
 gboolean pbap_register_interface(DBusConnection *connection, const char *path,
-				void *user_data, GDBusDestroyFunction destroy);
-void pbap_unregister_interface(DBusConnection *connection, const char *path,
-				void *user_data);
\ No newline at end of file
+							void *user_data);
+void pbap_unregister_interface(DBusConnection *connection, const char *path);
diff --git a/client/session.c b/client/session.c
index 36475d6..64bcb78 100644
--- a/client/session.c
+++ b/client/session.c
@@ -97,6 +97,31 @@ struct pending_req {
 	void *user_data;
 };
 
+struct session_data {
+	gint refcount;
+	bdaddr_t src;
+	bdaddr_t dst;
+	uint8_t channel;
+	char *service;		/* Service friendly name */
+	const char *target;	/* OBEX Target UUID */
+	int target_len;
+	uuid_t uuid;		/* Bluetooth Service Class */
+	gchar *path;		/* Session path */
+	DBusConnection *conn;
+	DBusConnection *conn_system; /* system bus connection */
+	DBusMessage *msg;
+	GwObex *obex;
+	GIOChannel *io;
+	struct agent_data *agent;
+	struct session_callback *callback;
+	gchar *owner;		/* Session owner */
+	guint watch;
+	GSList *pending;
+	GSList *pending_calls;
+	void *priv;
+	char *adapter;
+};
+
 static GSList *sessions = NULL;
 
 static void session_prepare_put(struct session_data *session, GError *err,
@@ -163,27 +188,28 @@ static void agent_release(struct session_data *session)
 
 static void session_unregistered(struct session_data *session)
 {
+	char *path;
+
 	switch (session->uuid.value.uuid16) {
 	case OBEX_FILETRANS_SVCLASS_ID:
 		g_dbus_unregister_interface(session->conn, session->path,
 						FTP_INTERFACE);
 		break;
 	case PBAP_PSE_SVCLASS_ID:
-		pbap_unregister_interface(session->conn, session->path,
-						session);
+		pbap_unregister_interface(session->conn, session->path);
 		break;
 	case IRMC_SYNC_SVCLASS_ID:
-		sync_unregister_interface(session->conn, session->path,
-						session);
+		sync_unregister_interface(session->conn, session->path);
 	}
 
-	g_dbus_unregister_interface(session->conn, session->path,
-					SESSION_INTERFACE);
+	path = session->path;
+	session->path = NULL;
 
-	DBG("Session(%p) unregistered %s", session, session->path);
+	g_dbus_unregister_interface(session->conn, path, SESSION_INTERFACE);
 
-	g_free(session->path);
-	session->path = NULL;
+	DBG("Session(%p) unregistered %s", session, path);
+
+	g_free(path);
 }
 
 static struct pending_req *find_session_request(
@@ -1408,7 +1434,7 @@ static void session_prepare_get(struct session_data *session,
 int session_get(struct session_data *session, const char *type,
 		const char *filename, const char *targetname,
 		const guint8 *apparam, gint apparam_size,
-		session_callback_t func)
+		session_callback_t func, void *user_data)
 {
 	struct transfer_data *transfer;
 	struct transfer_params *params = NULL;
@@ -1438,6 +1464,7 @@ int session_get(struct session_data *session, const char *type,
 		struct session_callback *callback;
 		callback = g_new0(struct session_callback, 1);
 		callback->func = func;
+		callback->data = user_data;
 		session->callback = callback;
 	}
 
@@ -1502,7 +1529,7 @@ static DBusMessage *list_folder(DBusConnection *connection,
 				"Transfer in progress");
 
 	if (session_get(session, "x-obex/folder-listing",
-				NULL, NULL, NULL, 0, list_folder_callback) < 0)
+			NULL, NULL, NULL, 0, list_folder_callback, NULL) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"Failed");
@@ -1531,7 +1558,7 @@ static DBusMessage *get_file(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	if (session_get(session, NULL, source_file,
-				target_file, NULL, 0, get_file_callback) < 0)
+			target_file, NULL, 0, get_file_callback, NULL) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"Failed");
@@ -1672,17 +1699,21 @@ int session_pull(struct session_data *session,
 	return err;
 }
 
-int session_register(struct session_data *session)
+const char *session_register(struct session_data *session,
+						GDBusDestroyFunction destroy)
 {
 	gboolean result = FALSE;
 
+	if (session->path)
+		return session->path;
+
 	session->path = g_strdup_printf("%s/session%ju",
 						SESSION_BASEPATH, counter++);
 
 	if (g_dbus_register_interface(session->conn, session->path,
 					SESSION_INTERFACE, session_methods,
-					NULL, NULL, session, NULL) == FALSE)
-		return -EIO;
+					NULL, NULL, session, destroy) == FALSE)
+		goto fail;
 
 	switch (session->uuid.value.uuid16) {
 	case OBEX_FILETRANS_SVCLASS_ID:
@@ -1691,33 +1722,28 @@ int session_register(struct session_data *session)
 					ftp_methods, NULL, NULL, session, NULL);
 		break;
 	case PBAP_PSE_SVCLASS_ID:
-		result = pbap_register_interface(session->conn,
-						session->path, session, NULL);
+		result = pbap_register_interface(session->conn, session->path,
+								session);
 		break;
 	case IRMC_SYNC_SVCLASS_ID:
-		result = sync_register_interface(session->conn,
-						session->path, session, NULL);
+		result = sync_register_interface(session->conn, session->path,
+								session);
 	}
 
 	if (result == FALSE) {
 		g_dbus_unregister_interface(session->conn,
 					session->path, SESSION_INTERFACE);
-		return -EIO;
+		goto fail;
 	}
 
 	DBG("Session(%p) registered %s", session, session->path);
 
-	return 0;
-}
+	return session->path;
 
-void *session_get_data(struct session_data *session)
-{
-	return session->priv;
-}
-
-void session_set_data(struct session_data *session, void *priv)
-{
-	session->priv = priv;
+fail:
+	g_free(session->path);
+	session->path = NULL;
+	return NULL;
 }
 
 static void session_prepare_put(struct session_data *session,
@@ -1813,3 +1839,35 @@ const char *session_get_owner(struct session_data *session)
 
 	return session->owner;
 }
+
+const char *session_get_path(struct session_data *session)
+{
+	return session->path;
+}
+
+const char *session_get_target(struct session_data *session)
+{
+	return session->target;
+}
+
+GwObex *session_get_obex(struct session_data *session)
+{
+	return session->obex;
+}
+
+struct transfer_data *session_get_transfer(struct session_data *session)
+{
+	return session->pending ? session->pending->data : NULL;
+}
+
+void session_add_transfer(struct session_data *session,
+					struct transfer_data *transfer)
+{
+	session->pending = g_slist_append(session->pending, transfer);
+}
+
+void session_remove_transfer(struct session_data *session,
+					struct transfer_data *transfer)
+{
+	session->pending = g_slist_remove(session->pending, transfer);
+}
diff --git a/client/session.h b/client/session.h
index 39f5742..081a2c3 100644
--- a/client/session.h
+++ b/client/session.h
@@ -28,33 +28,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 
-struct agent_data;
-struct session_callback;
-
-struct session_data {
-	gint refcount;
-	bdaddr_t src;
-	bdaddr_t dst;
-	uint8_t channel;
-	char *service;		/* Service friendly name */
-	const char *target;	/* OBEX Target UUID */
-	int target_len;
-	uuid_t uuid;		/* Bluetooth Service Class */
-	gchar *path;		/* Session path */
-	DBusConnection *conn;
-	DBusConnection *conn_system; /* system bus connection */
-	DBusMessage *msg;
-	GwObex *obex;
-	GIOChannel *io;
-	struct agent_data *agent;
-	struct session_callback *callback;
-	gchar *owner;		/* Session owner */
-	guint watch;
-	GSList *pending;
-	GSList *pending_calls;
-	void *priv;
-	char *adapter;
-};
+struct session_data;
 
 typedef void (*session_callback_t) (struct session_data *session,
 					GError *err, void *user_data);
@@ -79,17 +53,26 @@ int session_set_agent(struct session_data *session, const char *name,
 							const char *path);
 const char *session_get_agent(struct session_data *session);
 
+const char *session_get_path(struct session_data *session);
+const char *session_get_target(struct session_data *session);
+GwObex *session_get_obex(struct session_data *session);
+
+struct transfer_data *session_get_transfer(struct session_data *session);
+void session_add_transfer(struct session_data *session,
+					struct transfer_data *transfer);
+void session_remove_transfer(struct session_data *session,
+					struct transfer_data *transfer);
+
 int session_send(struct session_data *session, const char *filename,
 				const char *remotename);
 int session_get(struct session_data *session, const char *type,
 		const char *filename, const char *targetname,
 		const guint8  *apparam, gint apparam_size,
-		session_callback_t func);
+		session_callback_t func, void *user_data);
 int session_pull(struct session_data *session,
 				const char *type, const char *filename,
 				session_callback_t function, void *user_data);
-int session_register(struct session_data *session);
-void *session_get_data(struct session_data *session);
-void session_set_data(struct session_data *session, void *priv);
+const char *session_register(struct session_data *session,
+						GDBusDestroyFunction destroy);
 int session_put(struct session_data *session, char *buf,
 				const char *targetname);
diff --git a/client/sync.c b/client/sync.c
index 3622a3d..9271bf3 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -37,14 +37,16 @@
 #define ERROR_INF SYNC_INTERFACE ".Error"
 
 struct sync_data {
+	struct session_data *session;
 	char *phonebook_path;
+	DBusConnection *conn;
+	DBusMessage *msg;
 };
 
 static DBusMessage *sync_setlocation(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct sync_data *syncdata = session_get_data(session);
+	struct sync_data *sync = user_data;
 	const char *location;
 	char *path = NULL, *tmp;
 
@@ -65,8 +67,8 @@ static DBusMessage *sync_setlocation(DBusConnection *connection,
 		return g_dbus_create_error(message,
 			ERROR_INF ".InvalidArguments", "InvalidPhonebook");
 
-	g_free(syncdata->phonebook_path);
-	syncdata->phonebook_path = path;
+	g_free(sync->phonebook_path);
+	sync->phonebook_path = path;
 
 	return dbus_message_new_method_return(message);
 }
@@ -74,11 +76,12 @@ static DBusMessage *sync_setlocation(DBusConnection *connection,
 static void sync_getphonebook_callback(struct session_data *session,
 					GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session->pending->data;
+	struct transfer_data *transfer = session_get_transfer(session);
+	struct sync_data *sync = user_data;
 	DBusMessage *reply;
 	char *buf = NULL;
 
-	reply = dbus_message_new_method_return(session->msg);
+	reply = dbus_message_new_method_return(sync->msg);
 
 	if (transfer->filled > 0)
 		buf = transfer->buffer;
@@ -88,31 +91,30 @@ static void sync_getphonebook_callback(struct session_data *session,
 		DBUS_TYPE_INVALID);
 
 	transfer->filled = 0;
-	g_dbus_send_message(session->conn, reply);
-	dbus_message_unref(session->msg);
-	session->msg = NULL;
+	g_dbus_send_message(sync->conn, reply);
+	dbus_message_unref(sync->msg);
+	sync->msg = NULL;
 }
 
 static DBusMessage *sync_getphonebook(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct sync_data *syncdata = session_get_data(session);
+	struct sync_data *sync = user_data;
 
-	if (session->msg)
+	if (sync->msg)
 		return g_dbus_create_error(message,
 			ERROR_INF ".InProgress", "Transfer in progress");
 
 	/* set default phonebook_path to memory internal phonebook */
-	if (!syncdata->phonebook_path)
-		syncdata->phonebook_path = g_strdup("telecom/pb.vcf");
+	if (!sync->phonebook_path)
+		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	if (session_get(session, "phonebook", syncdata->phonebook_path, NULL,
-				NULL, 0, sync_getphonebook_callback) < 0)
+	if (session_get(sync->session, "phonebook", sync->phonebook_path, NULL,
+				NULL, 0, sync_getphonebook_callback, sync) < 0)
 		return g_dbus_create_error(message,
 			ERROR_INF ".Failed", "Failed");
 
-	session->msg = dbus_message_ref(message);
+	sync->msg = dbus_message_ref(message);
 
 	return NULL;
 }
@@ -120,8 +122,7 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 static DBusMessage *sync_putphonebook(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct sync_data *syncdata = session_get_data(session);
+	struct sync_data *sync = user_data;
 	const char *buf;
 	char *buffer;
 
@@ -132,12 +133,12 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 			ERROR_INF ".InvalidArguments", NULL);
 
 	/* set default phonebook_path to memory internal phonebook */
-	if (!syncdata->phonebook_path)
-		syncdata->phonebook_path = g_strdup("telecom/pb.vcf");
+	if (!sync->phonebook_path)
+		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
 	buffer = g_strdup(buf);
 
-	if (session_put(session, buffer, syncdata->phonebook_path) < 0)
+	if (session_put(sync->session, buffer, sync->phonebook_path) < 0)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Failed", "Failed");
 
@@ -153,32 +154,39 @@ static GDBusMethodTable sync_methods[] = {
 	{}
 };
 
+static void sync_free(void *data)
+{
+	struct sync_data *sync = data;
+
+	session_unref(sync->session);
+	dbus_connection_unref(sync->conn);
+	g_free(sync->phonebook_path);
+	g_free(sync);
+}
+
 gboolean sync_register_interface(DBusConnection *connection, const char *path,
-				void *user_data, GDBusDestroyFunction destroy)
+							void *user_data)
 {
 	struct session_data *session = user_data;
-	void *priv;
+	struct sync_data *sync;
 
-	priv = g_try_malloc0(sizeof(struct sync_data));
-	if (!priv)
+	sync = g_try_new0(struct sync_data, 1);
+	if (!sync)
 		return FALSE;
 
-	session_set_data(session, priv);
+	sync->session = session_ref(session);
+	sync->conn = dbus_connection_ref(connection);
 
-	return g_dbus_register_interface(connection, path, SYNC_INTERFACE,
-				sync_methods, NULL, NULL, user_data, destroy);
+	if (g_dbus_register_interface(connection, path, SYNC_INTERFACE,
+				sync_methods, NULL, NULL, sync, sync_free)) {
+		sync_free(sync);
+		return FALSE;
+	}
+
+	return TRUE;
 }
 
-void sync_unregister_interface(DBusConnection *connection, const char *path,
-							void *user_data)
+void sync_unregister_interface(DBusConnection *connection, const char *path)
 {
-	struct session_data *session = user_data;
-	struct sync_data *syncdata = session_get_data(session);
-
 	g_dbus_unregister_interface(connection, path, SYNC_INTERFACE);
-
-	if (syncdata) {
-		g_free(syncdata->phonebook_path);
-		g_free(syncdata);
-	}
 }
diff --git a/client/sync.h b/client/sync.h
index 5f9c483..01806e6 100644
--- a/client/sync.h
+++ b/client/sync.h
@@ -25,6 +25,5 @@
 #include <gdbus.h>
 
 gboolean sync_register_interface(DBusConnection *connection, const char *path,
-				void *user_data, GDBusDestroyFunction destroy);
-void sync_unregister_interface(DBusConnection *connection, const char *path,
-				void *user_data);
+							void *user_data);
+void sync_unregister_interface(DBusConnection *connection, const char *path);
diff --git a/client/transfer.c b/client/transfer.c
index fdcaa46..9e6f0ad 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -156,7 +156,7 @@ static void transfer_free(struct transfer_data *transfer)
 	if (transfer->fd > 0)
 		close(transfer->fd);
 
-	session->pending = g_slist_remove(session->pending, transfer);
+	session_remove_transfer(session, transfer);
 
 	session_unref(session);
 
@@ -165,6 +165,9 @@ static void transfer_free(struct transfer_data *transfer)
 		g_free(transfer->params);
 	}
 
+	if (transfer->conn)
+		dbus_connection_unref(transfer->conn);
+
 	g_free(transfer->callback);
 	g_free(transfer->filename);
 	g_free(transfer->name);
@@ -198,7 +201,13 @@ struct transfer_data *transfer_register(struct session_data *session,
 	transfer->path = g_strdup_printf("%s/transfer%ju",
 			TRANSFER_BASEPATH, counter++);
 
-	if (g_dbus_register_interface(session->conn, transfer->path,
+	transfer->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (transfer->conn == NULL) {
+		transfer_free(transfer);
+		return NULL;
+	}
+
+	if (g_dbus_register_interface(transfer->conn, transfer->path,
 				TRANSFER_INTERFACE,
 				transfer_methods, NULL, NULL,
 				transfer, NULL) == FALSE) {
@@ -209,17 +218,15 @@ struct transfer_data *transfer_register(struct session_data *session,
 done:
 	DBG("%p registered %s", transfer, transfer->path);
 
-	session->pending = g_slist_append(session->pending, transfer);
+	session_add_transfer(session, transfer);
 
 	return transfer;
 }
 
 void transfer_unregister(struct transfer_data *transfer)
 {
-	struct session_data *session = transfer->session;
-
 	if (transfer->path) {
-		g_dbus_unregister_interface(session->conn,
+		g_dbus_unregister_interface(transfer->conn,
 			transfer->path, TRANSFER_INTERFACE);
 	}
 
@@ -420,6 +427,7 @@ int transfer_get(struct transfer_data *transfer, transfer_callback_t func,
 			void *user_data)
 {
 	struct session_data *session = transfer->session;
+	GwObex *obex;
 	gw_obex_xfer_cb_t cb;
 
 	if (transfer->xfer != NULL)
@@ -441,15 +449,17 @@ int transfer_get(struct transfer_data *transfer, transfer_callback_t func,
 		cb = get_xfer_progress;
 	}
 
+	obex = session_get_obex(session);
+
 	if (transfer->params != NULL)
-		transfer->xfer = gw_obex_get_async_with_apparam(session->obex,
+		transfer->xfer = gw_obex_get_async_with_apparam(obex,
 							transfer->filename,
 							transfer->type,
 							transfer->params->data,
 							transfer->params->size,
 							NULL);
 	else
-		transfer->xfer = gw_obex_get_async(session->obex,
+		transfer->xfer = gw_obex_get_async(obex,
 							transfer->filename,
 							transfer->type,
 							NULL);
@@ -468,6 +478,7 @@ int transfer_put(struct transfer_data *transfer, transfer_callback_t func,
 			void *user_data)
 {
 	struct session_data *session = transfer->session;
+	GwObex *obex;
 	gw_obex_xfer_cb_t cb;
 	struct stat st;
 	int fd, size;
@@ -497,8 +508,9 @@ int transfer_put(struct transfer_data *transfer, transfer_callback_t func,
 	cb = put_xfer_progress;
 
 done:
+	obex = session_get_obex(session);
 	size = transfer->size < UINT32_MAX ? transfer->size : 0;
-	transfer->xfer = gw_obex_put_async(session->obex, transfer->name,
+	transfer->xfer = gw_obex_put_async(obex, transfer->name,
 						transfer->type, size,
 						-1, NULL);
 	if (transfer->xfer == NULL)
diff --git a/client/transfer.h b/client/transfer.h
index 500232b..7392267 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -34,6 +34,7 @@ struct transfer_data {
 	struct session_data *session;
 	struct transfer_params *params;
 	struct transfer_callback *callback;
+	DBusConnection *conn;
 	char *path;		/* Transfer path */
 	gchar *filename;	/* Transfer file location */
 	char *name;		/* Transfer object name */
-- 
1.7.6

