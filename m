Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] client: fix not canceling connection request if client exit bus
Date: Fri,  6 May 2011 13:43:58 +0300
Message-Id: <1304678639-31853-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

There is no point on proceeding with sdp/rfcomm connections if client
exit the bus.
---
 client/main.c    |   23 +++++----
 client/session.c |  144 ++++++++++++++++++++++++++++++++++++------------------
 client/session.h |   10 +++-
 3 files changed, 115 insertions(+), 62 deletions(-)

diff --git a/client/main.c b/client/main.c
index 20d56d2..478181c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -86,6 +86,7 @@ static void create_callback(struct session_data *session, GError *err,
 	if (session->target != NULL) {
 		session_register(session);
 		session_set_owner(session, data->sender, owner_exit);
+
 		g_dbus_send_reply(data->connection, data->message,
 				DBUS_TYPE_OBJECT_PATH, &session->path,
 				DBUS_TYPE_INVALID);
@@ -165,6 +166,7 @@ static DBusMessage *send_files(DBusConnection *connection,
 	GPtrArray *files;
 	struct send_data *data;
 	const char *agent, *source = NULL, *dest = NULL, *target = NULL;
+	const char *sender;
 	uint8_t channel = 0;
 
 	dbus_message_iter_init(message, &iter);
@@ -201,6 +203,8 @@ static DBusMessage *send_files(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 	}
 
+	sender = dbus_message_get_sender(message);
+
 	data = g_try_malloc0(sizeof(*data));
 	if (data == NULL) {
 		g_ptr_array_free(files, TRUE);
@@ -210,12 +214,12 @@ static DBusMessage *send_files(DBusConnection *connection,
 
 	data->connection = dbus_connection_ref(connection);
 	data->message = dbus_message_ref(message);
-	data->sender = g_strdup(dbus_message_get_sender(message));
+	data->sender = g_strdup(sender);
 	data->agent = g_strdup(agent);
 	data->files = files;
 
-	session = session_create(source, dest, "OPP", channel, create_callback,
-				data);
+	session = session_create(source, dest, "OPP", channel, sender,
+							create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
 		return NULL;
@@ -269,8 +273,6 @@ static void pull_session_callback(struct session_data *session,
 		goto done;
 	}
 
-	session_set_owner(session, data->sender, owner_exit);
-
 	session_pull(session, "text/x-vcard", data->filename,
 						pull_complete_callback, data);
 
@@ -320,7 +322,7 @@ static DBusMessage *pull_business_card(DBusConnection *connection,
 	data->sender = g_strdup(dbus_message_get_sender(message));
 	data->filename = g_strdup(name);
 
-	session = session_create(source, dest, "OPP", channel,
+	session = session_create(source, dest, "OPP", channel, data->sender,
 					pull_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -382,8 +384,8 @@ static DBusMessage *create_session(DBusConnection *connection,
 	data->message = dbus_message_ref(message);
 	data->sender = g_strdup(dbus_message_get_sender(message));
 
-	session = session_create(source, dest, target, channel,
-					create_callback, data);
+	session = session_create(source, dest, target, channel, data->sender,
+							create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
 		return NULL;
@@ -471,7 +473,6 @@ static void capability_session_callback(struct session_data *session,
 		goto done;
 	}
 
-	session_set_owner(session, data->sender, owner_exit);
 	session_pull(session, "x-obex/capability", NULL,
 				capabilities_complete_callback, data);
 
@@ -513,8 +514,8 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	if (!target)
 		target = "OPP";
 
-	session = session_create(source, dest, target, channel,
-				capability_session_callback, data);
+	session = session_create(source, dest, target, channel, data->sender,
+					capability_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
 		return NULL;
diff --git a/client/session.c b/client/session.c
index 88eae8d..8c41858 100644
--- a/client/session.c
+++ b/client/session.c
@@ -169,6 +169,9 @@ static void session_unregistered(struct session_data *session)
 					SESSION_INTERFACE);
 
 	DBG("Session(%p) unregistered %s", session, session->path);
+
+	g_free(session->path);
+	session->path = NULL;
 }
 
 static void session_free(struct session_data *session)
@@ -199,6 +202,7 @@ static void session_free(struct session_data *session)
 	g_free(session->callback);
 	g_free(session->path);
 	g_free(session->owner);
+	g_free(session->service);
 	g_free(session);
 }
 
@@ -223,6 +227,8 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 	GwObex *obex;
 	int fd;
 
+	DBG("");
+
 	if (err != NULL) {
 		error("%s", err->message);
 		goto done;
@@ -255,6 +261,8 @@ static GIOChannel *rfcomm_connect(const bdaddr_t *src, const bdaddr_t *dst,
 	GIOChannel *io;
 	GError *err = NULL;
 
+	DBG("");
+
 	io = bt_io_connect(BT_IO_RFCOMM, function, user_data, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_DEST_BDADDR, dst,
@@ -273,6 +281,7 @@ static void search_callback(uint8_t type, uint16_t status,
 			uint8_t *rsp, size_t size, void *user_data)
 {
 	struct callback_data *callback = user_data;
+	struct session_data *session = callback->session;
 	unsigned int scanned, bytesleft = size;
 	int seqlen = 0;
 	uint8_t dataType, channel = 0;
@@ -325,23 +334,26 @@ static void search_callback(uint8_t type, uint16_t status,
 	if (channel == 0)
 		goto failed;
 
-	callback->session->channel = channel;
+	session->channel = channel;
 
-	callback->session->io = rfcomm_connect(&callback->session->src,
-						&callback->session->dst,
-						channel, rfcomm_callback,
-						callback);
-	if (callback->session->io != NULL) {
+	g_io_channel_set_close_on_unref(session->io, FALSE);
+	g_io_channel_unref(session->io);
+
+	session->io = rfcomm_connect(&session->src, &session->dst, channel,
+					rfcomm_callback, callback);
+	if (session->io != NULL) {
 		sdp_close(callback->sdp);
 		return;
 	}
 
 failed:
-	sdp_close(callback->sdp);
+	g_io_channel_shutdown(session->io, TRUE, NULL);
+	g_io_channel_unref(session->io);
+	session->io = NULL;
 
 	g_set_error(&gerr, OBEX_IO_ERROR, -EIO,
 					"Unable to find service record");
-	callback->func(callback->session, gerr, callback->data);
+	callback->func(session, gerr, callback->data);
 	g_clear_error(&gerr);
 
 	session_unref(callback->session);
@@ -366,6 +378,7 @@ static gboolean service_callback(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct callback_data *callback = user_data;
+	struct session_data *session = callback->session;
 	sdp_list_t *search, *attrid;
 	uint32_t range = 0x0000ffff;
 	GError *gerr = NULL;
@@ -395,7 +408,9 @@ static gboolean service_callback(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 
 failed:
-	sdp_close(callback->sdp);
+	g_io_channel_shutdown(session->io, TRUE, NULL);
+	g_io_channel_unref(session->io);
+	session->io = NULL;
 
 	g_set_error(&gerr, OBEX_IO_ERROR, -EIO,
 					"Unable to find service record");
@@ -410,6 +425,7 @@ failed:
 static sdp_session_t *service_connect(const bdaddr_t *src, const bdaddr_t *dst,
 					GIOFunc function, gpointer user_data)
 {
+	struct callback_data *cb = user_data;
 	sdp_session_t *sdp;
 	GIOChannel *io;
 
@@ -426,15 +442,59 @@ static sdp_session_t *service_connect(const bdaddr_t *src, const bdaddr_t *dst,
 	g_io_add_watch(io, G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 							function, user_data);
 
-	g_io_channel_unref(io);
+	cb->session->io = io;
 
 	return sdp;
 }
 
+static gboolean connection_complete(gpointer data)
+{
+	struct callback_data *cb = data;
+
+	cb->func(cb->session, 0, cb->data);
+
+	session_unref(cb->session);
+
+	g_free(cb);
+
+	return FALSE;
+}
+
+static void owner_disconnected(DBusConnection *connection, void *user_data)
+{
+	struct session_data *session = user_data;
+
+	DBG("");
+
+	session_shutdown(session);
+}
+
+int session_set_owner(struct session_data *session, const char *name,
+			GDBusWatchFunction func)
+{
+	if (session == NULL)
+		return -EINVAL;
+
+	if (session->watch)
+		g_dbus_remove_watch(session->conn, session->watch);
+
+	session->watch = g_dbus_add_disconnect_watch(session->conn, name, func,
+							session, NULL);
+	if (session->watch == 0)
+		return -EINVAL;
+
+	session->owner = g_strdup(name);
+
+	return 0;
+}
+
 struct session_data *session_create(const char *source,
-			const char *destination, const char *target,
-			uint8_t channel, session_callback_t function,
-			void *user_data)
+						const char *destination,
+						const char *service,
+						uint8_t channel,
+						const char *owner,
+						session_callback_t function,
+						void *user_data)
 {
 	struct session_data *session;
 	struct callback_data *callback;
@@ -462,22 +522,23 @@ struct session_data *session_create(const char *source,
 		str2ba(source, &session->src);
 
 	str2ba(destination, &session->dst);
+	session->service = g_strdup(service);
 
-	if (!g_ascii_strncasecmp(target, "OPP", 3)) {
+	if (!g_ascii_strncasecmp(service, "OPP", 3)) {
 		sdp_uuid16_create(&session->uuid, OBEX_OBJPUSH_SVCLASS_ID);
-	} else if (!g_ascii_strncasecmp(target, "FTP", 3)) {
+	} else if (!g_ascii_strncasecmp(service, "FTP", 3)) {
 		sdp_uuid16_create(&session->uuid, OBEX_FILETRANS_SVCLASS_ID);
 		session->target = OBEX_FTP_UUID;
 		session->target_len = OBEX_FTP_UUID_LEN;
-	} else if (!g_ascii_strncasecmp(target, "PBAP", 4)) {
+	} else if (!g_ascii_strncasecmp(service, "PBAP", 4)) {
 		sdp_uuid16_create(&session->uuid, PBAP_PSE_SVCLASS_ID);
 		session->target = OBEX_PBAP_UUID;
 		session->target_len = OBEX_PBAP_UUID_LEN;
-	} else if (!g_ascii_strncasecmp(target, "SYNC", 4)) {
+	} else if (!g_ascii_strncasecmp(service, "SYNC", 4)) {
 		sdp_uuid16_create(&session->uuid, IRMC_SYNC_SVCLASS_ID);
 		session->target = OBEX_SYNC_UUID;
 		session->target_len = OBEX_SYNC_UUID_LEN;
-	} else if (!g_ascii_strncasecmp(target, "PCSUITE", 7)) {
+	} else if (!g_ascii_strncasecmp(service, "PCSUITE", 7)) {
 		sdp_uuid128_create(&session->uuid, pcsuite_uuid);
 	} else {
 		return NULL;
@@ -493,7 +554,10 @@ struct session_data *session_create(const char *source,
 	callback->func = function;
 	callback->data = user_data;
 
-	if (session->channel > 0) {
+	if (session->obex) {
+		g_idle_add(connection_complete, callback);
+		err = 0;
+	} else if (session->channel > 0) {
 		session->io = rfcomm_connect(&session->src, &session->dst,
 							session->channel,
 							rfcomm_callback,
@@ -511,21 +575,31 @@ struct session_data *session_create(const char *source,
 		return NULL;
 	}
 
+	if (owner)
+		session_set_owner(session, owner, owner_disconnected);
+
 	return session;
 }
 
 void session_shutdown(struct session_data *session)
 {
-	struct transfer_data *transfer;
-
 	DBG("%p", session);
-	transfer = session->pending ? session->pending->data : NULL;
 
 	session_ref(session);
 
 	/* Unregister any pending transfer */
 	g_slist_foreach(session->pending, (GFunc) transfer_unregister, NULL);
 
+	/* Unregister interfaces */
+	if (session->path)
+		session_unregistered(session);
+
+	/* Shutdown io */
+	if (session->io) {
+		int fd = g_io_channel_unix_get_fd(session->io);
+		shutdown(fd, SHUT_RDWR);
+	}
+
 	session_unref(session);
 }
 
@@ -589,13 +663,6 @@ static DBusMessage *release_agent(DBusConnection *connection,
 	return dbus_message_new_method_return(message);
 }
 
-static void owner_disconnected(DBusConnection *connection, void *user_data)
-{
-	struct session_data *session = user_data;
-
-	session_shutdown(session);
-}
-
 static void append_entry(DBusMessageIter *dict,
 				const char *key, int type, void *val)
 {
@@ -1469,25 +1536,6 @@ const char *session_get_agent(struct session_data *session)
 	return agent->name;
 }
 
-int session_set_owner(struct session_data *session, const char *name,
-			GDBusWatchFunction func)
-{
-	if (session == NULL)
-		return -EINVAL;
-
-	if (session->watch != 0)
-		return -EALREADY;
-
-	session->watch = g_dbus_add_disconnect_watch(session->conn, name, func,
-							session, NULL);
-	if (session->watch == 0)
-		return -EINVAL;
-
-	session->owner = g_strdup(name);
-
-	return 0;
-}
-
 const char *session_get_owner(struct session_data *session)
 {
 	if (session == NULL)
diff --git a/client/session.h b/client/session.h
index 546849e..6f8a434 100644
--- a/client/session.h
+++ b/client/session.h
@@ -36,6 +36,7 @@ struct session_data {
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint8_t channel;
+	char *service;		/* Service friendly name */
 	const char *target;	/* OBEX Target UUID */
 	int target_len;
 	uuid_t uuid;		/* Bluetooth Service Class */
@@ -56,9 +57,12 @@ typedef void (*session_callback_t) (struct session_data *session,
 					GError *err, void *user_data);
 
 struct session_data *session_create(const char *source,
-			const char *destination, const char *target,
-			uint8_t channel, session_callback_t function,
-			void *user_data);
+						const char *destination,
+						const char *service,
+						uint8_t channel,
+						const char *owner,
+						session_callback_t function,
+						void *user_data);
 
 struct session_data *session_ref(struct session_data *session);
 void session_unref(struct session_data *session);
-- 
1.7.1

