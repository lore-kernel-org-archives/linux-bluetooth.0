Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio: Remove avdtp_server struct
Date: Wed,  4 Mar 2015 15:46:50 +0200
Message-Id: <1425476811-25651-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1425476811-25651-1-git-send-email-luiz.dentz@gmail.com>
References: <1425476811-25651-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

avdtp_server struct doesn't make sense to exist since there exist an
equivalent in the form of a2dp_server which can be used as context for
incoming connections.
---
 android/avdtp.c        |   1 -
 profiles/audio/a2dp.c  | 372 +++++++++++++++++++++++++++++++++++--------------
 profiles/audio/avdtp.c | 120 ++++++----------
 profiles/audio/avdtp.h |   7 +-
 4 files changed, 314 insertions(+), 186 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 3e32e57..e4fd2b7 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2924,7 +2924,6 @@ gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, int fd,
 	g_io_channel_unref(io);
 
 	return TRUE;
-
 }
 
 gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 91b0285..986d95f 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -65,7 +65,6 @@
 
 struct a2dp_sep {
 	struct a2dp_server *server;
-	struct avdtp_server *avdtp_server;
 	struct a2dp_endpoint *endpoint;
 	uint8_t type;
 	uint8_t codec;
@@ -114,17 +113,22 @@ struct a2dp_server {
 	uint32_t sink_record_id;
 	gboolean sink_enabled;
 	gboolean source_enabled;
+	GIOChannel *io;
+	struct queue *seps;
+	struct queue *channels;
 };
 
-struct avdtp_server {
-	struct btd_adapter *adapter;
+struct a2dp_channel {
+	struct a2dp_server *server;
+	struct btd_device *device;
 	GIOChannel *io;
-	struct queue *seps;
-	GSList *sessions;
+	guint io_id;
+	unsigned int state_id;
+	unsigned int auth_id;
+	struct avdtp *session;
 };
 
 static GSList *servers = NULL;
-static GSList *avdtp_servers = NULL;
 static GSList *setups = NULL;
 static unsigned int cb_id = 0;
 
@@ -1200,112 +1204,217 @@ static struct a2dp_server *find_server(GSList *list, struct btd_adapter *a)
 	return NULL;
 }
 
-static struct avdtp_server *find_avdtp_server(GSList *list,
-							struct btd_adapter *a)
+static void channel_free(void *data)
 {
-	for (; list; list = list->next) {
-		struct avdtp_server *server = list->data;
+	struct a2dp_channel *chan = data;
 
-		if (server->adapter == a)
-			return server;
+	if (chan->auth_id > 0)
+		btd_cancel_authorization(chan->auth_id);
+
+	if (chan->io_id > 0)
+		g_source_remove(chan->io_id);
+
+	if (chan->io) {
+		g_io_channel_shutdown(chan->io, TRUE, NULL);
+		g_io_channel_unref(chan->io);
 	}
 
-	return NULL;
+	avdtp_remove_state_cb(chan->state_id);
+
+	g_free(chan);
 }
 
-struct avdtp *a2dp_avdtp_get(struct btd_device *device)
+static void channel_remove(struct a2dp_channel *chan)
 {
-	struct avdtp_server *server;
-	struct avdtp *session;
+	struct a2dp_server *server = chan->server;
 
-	server = find_avdtp_server(avdtp_servers, device_get_adapter(device));
-	if (server == NULL)
-		return NULL;
+	DBG("chan %p", chan);
 
-	session = avdtp_new(server, server->sessions, NULL, device);
-	if (!session)
-		return NULL;
+	queue_remove(server->channels, chan);
 
-	return avdtp_ref(session);
+	channel_free(chan);
 }
 
-static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter)
+static gboolean disconnect_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 {
-	struct a2dp_server *server;
+	struct a2dp_channel *chan = data;
 
-	server = g_new0(struct a2dp_server, 1);
-	server->adapter = btd_adapter_ref(adapter);
-	servers = g_slist_append(servers, server);
+	DBG("chan %p", chan);
 
-	return server;
+	chan->io_id = 0;
+
+	channel_remove(chan);
+
+	return FALSE;
 }
 
-static void avdtp_server_destroy(struct avdtp_server *server)
+static void avdtp_state_cb(struct btd_device *dev, struct avdtp *session,
+					avdtp_session_state_t old_state,
+					avdtp_session_state_t new_state,
+					void *user_data)
 {
-	g_slist_free_full(server->sessions, avdtp_free);
-
-	avdtp_servers = g_slist_remove(avdtp_servers, server);
+	struct a2dp_channel *chan = user_data;
 
-	g_io_channel_shutdown(server->io, TRUE, NULL);
-	g_io_channel_unref(server->io);
-	btd_adapter_unref(server->adapter);
-	queue_destroy(server->seps, NULL);
-	g_free(server);
+	switch (new_state) {
+	case AVDTP_SESSION_STATE_DISCONNECTED:
+		if (chan->session == session)
+			channel_remove(chan);
+		break;
+	case AVDTP_SESSION_STATE_CONNECTING:
+		break;
+	case AVDTP_SESSION_STATE_CONNECTED:
+		break;
+	}
 }
 
-static void a2dp_clean_lsep(struct a2dp_sep *sep)
+static struct a2dp_channel *channel_new(struct a2dp_server *server,
+					struct btd_device *device,
+					GIOChannel *io)
 {
-	struct avdtp_local_sep *lsep = sep->lsep;
-	struct avdtp_server *server = sep->avdtp_server;
+	struct a2dp_channel *chan;
+
+	chan = g_new0(struct a2dp_channel, 1);
+	chan->server = server;
+	chan->device = device;
+	chan->state_id = avdtp_add_state_cb(device, avdtp_state_cb, chan);
+
+	queue_push_tail(server->channels, chan);
 
-	avdtp_unregister_sep(server->seps, lsep);
+	if (!io)
+		return chan;
 
-	if (queue_isempty(server->seps))
-		avdtp_server_destroy(server);
+	chan->io = g_io_channel_ref(io);
+	chan->io_id = g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) disconnect_cb, chan);
+
+	return chan;
 }
 
-static void a2dp_unregister_sep(struct a2dp_sep *sep)
+static bool match_by_device(const void *data, const void *user_data)
 {
-	if (sep->destroy) {
-		sep->destroy(sep->user_data);
-		sep->endpoint = NULL;
-	}
+	const struct a2dp_channel *chan = data;
+	const struct btd_device *device = user_data;
 
-	a2dp_clean_lsep(sep);
+	return chan->device == device;
+}
 
-	g_free(sep);
+struct avdtp *a2dp_avdtp_get(struct btd_device *device)
+{
+	struct a2dp_server *server;
+	struct a2dp_channel *chan;
+
+	server = find_server(servers, device_get_adapter(device));
+	if (server == NULL)
+		return NULL;
+
+	chan = queue_find(server->channels, match_by_device, device);
+	if (!chan)
+		chan = channel_new(server, device, NULL);
+
+	if (chan->session)
+		return avdtp_ref(chan->session);
+
+	chan->session = avdtp_new(NULL, device, server->seps);
+	if (!chan->session) {
+		channel_remove(chan);
+		return NULL;
+	}
+
+	return avdtp_ref(chan->session);
 }
 
-static void a2dp_server_unregister(struct a2dp_server *server)
+static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
-	servers = g_slist_remove(servers, server);
-	btd_adapter_unref(server->adapter);
-	g_free(server);
+	struct a2dp_channel *chan = user_data;
+
+	if (err) {
+		error("%s", err->message);
+		goto fail;
+	}
+
+	chan->session = avdtp_new(chan->io, chan->device, chan->server->seps);
+	if (!chan->session) {
+		error("Unable to create AVDTP session");
+		goto fail;
+	}
+
+	g_io_channel_unref(chan->io);
+	chan->io = NULL;
+
+	g_source_remove(chan->io_id);
+	chan->io_id = 0;
+
+	return;
+
+fail:
+	channel_remove(chan);
 }
 
 static void auth_cb(DBusError *derr, void *user_data)
 {
-	struct avdtp *session = user_data;
+	struct a2dp_channel *chan = user_data;
+	GError *err = NULL;
+
+	chan->auth_id = 0;
 
 	if (derr && dbus_error_is_set(derr)) {
 		error("Access denied: %s", derr->message);
-		connection_lost(session, EACCES);
-		return;
+		goto fail;
 	}
 
-	avdtp_accept(session);
+	if (!bt_io_accept(chan->io, connect_cb, chan, NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		goto fail;
+	}
+
+	return;
+
+fail:
+	channel_remove(chan);
 }
 
-static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
+static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
-	struct avdtp *session;
+	struct a2dp_setup *setup = user_data;
+	uint16_t omtu, imtu;
+
+	if (err) {
+		error("%s", err->message);
+		goto drop;
+	}
+
+	bt_io_get(io, &err, BT_IO_OPT_OMTU, &omtu, BT_IO_OPT_IMTU, &imtu,
+							BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	if (!avdtp_stream_set_transport(setup->stream,
+					g_io_channel_unix_get_fd(io),
+					omtu, imtu))
+		goto drop;
+
+	g_io_channel_set_close_on_unref(io, FALSE);
+
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+
+}
+static void confirm_cb(GIOChannel *io, gpointer data)
+{
+	struct a2dp_server *server = data;
+	struct a2dp_channel *chan;
 	char address[18];
 	bdaddr_t src, dst;
 	GError *err = NULL;
 	struct btd_device *device;
-	struct avdtp_server *avdtp_server;
 
-	bt_io_get(chan, &err,
+	bt_io_get(io, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
 			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_DEST, address,
@@ -1323,64 +1432,113 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (!device)
 		goto drop;
 
-	avdtp_server = find_avdtp_server(avdtp_servers,
-						device_get_adapter(device));
-	if (!avdtp_server)
-		goto drop;
+	chan = queue_find(server->channels, match_by_device, device);
+	if (chan) {
+		struct a2dp_setup *setup;
 
-	session = avdtp_new(avdtp_server, avdtp_server->sessions, chan, device);
-	if (!session)
-		goto drop;
+		setup = find_setup_by_session(chan->session);
+		if (!setup || !setup->stream)
+			goto drop;
 
-	avdtp_request_authorization(session, &src, &dst, auth_cb);
+		if (!bt_io_accept(io, transport_cb, setup, NULL, &err)) {
+			error("bt_io_accept: %s", err->message);
+			g_error_free(err);
+			goto drop;
+		}
+
+		return;
+	}
+
+	chan = channel_new(server, device, io);
+
+	chan->auth_id = btd_request_authorization(&src, &dst,
+							ADVANCED_AUDIO_UUID,
+							auth_cb, chan);
+	if (chan->auth_id == 0 && !chan->session)
+		channel_remove(chan);
 
 	return;
 
 drop:
-	g_io_channel_shutdown(chan, TRUE, NULL);
+	g_io_channel_shutdown(io, TRUE, NULL);
 }
 
-static GIOChannel *avdtp_server_socket(const bdaddr_t *src, gboolean master)
+static bool a2dp_server_listen(struct a2dp_server *server)
 {
 	GError *err = NULL;
-	GIOChannel *io;
 
-	io = bt_io_listen(NULL, avdtp_confirm_cb,
-				NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
+	if (server->io)
+		return true;
+
+	server->io = bt_io_listen(NULL, confirm_cb, server, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(server->adapter),
 				BT_IO_OPT_PSM, AVDTP_PSM,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
+				BT_IO_OPT_MASTER, true,
 				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
-		g_error_free(err);
-	}
+	if (server->io)
+		return true;
+
+	error("%s", err->message);
+	g_error_free(err);
 
-	return io;
+	return false;
 }
 
-static struct avdtp_server *avdtp_server_init(struct btd_adapter *adapter)
+static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter)
 {
-	struct avdtp_server *server;
-
-	server = g_new0(struct avdtp_server, 1);
+	struct a2dp_server *server;
 
-	server->io = avdtp_server_socket(btd_adapter_get_address(adapter),
-									TRUE);
-	if (!server->io) {
-		g_free(server);
-		return NULL;
-	}
+	server = g_new0(struct a2dp_server, 1);
 
 	server->adapter = btd_adapter_ref(adapter);
 	server->seps = queue_new();
+	server->channels = queue_new();
 
-	avdtp_servers = g_slist_append(avdtp_servers, server);
+	servers = g_slist_append(servers, server);
 
 	return server;
 }
 
+static void a2dp_unregister_sep(struct a2dp_sep *sep)
+{
+	struct a2dp_server *server = sep->server;
+
+	if (sep->destroy) {
+		sep->destroy(sep->user_data);
+		sep->endpoint = NULL;
+	}
+
+	avdtp_unregister_sep(server->seps, sep->lsep);
+
+	g_free(sep);
+
+	if (!queue_isempty(server->seps))
+		return;
+
+	if (server->io) {
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+		server->io = NULL;
+	}
+}
+
+static void a2dp_server_unregister(struct a2dp_server *server)
+{
+	servers = g_slist_remove(servers, server);
+	queue_destroy(server->channels, channel_free);
+	queue_destroy(server->seps, NULL);
+
+	if (server->io) {
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+	}
+
+	btd_adapter_unref(server->adapter);
+	g_free(server);
+}
+
 struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
 				struct a2dp_endpoint *endpoint,
@@ -1388,7 +1546,6 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				int *err)
 {
 	struct a2dp_server *server;
-	struct avdtp_server *avdtp_server;
 	struct a2dp_sep *sep;
 	GSList **l;
 	uint32_t *record_id;
@@ -1415,14 +1572,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 
 	sep = g_new0(struct a2dp_sep, 1);
 
-	avdtp_server = find_avdtp_server(avdtp_servers, adapter);
-	if (!avdtp_server) {
-		avdtp_server = avdtp_server_init(adapter);
-		if (!avdtp_server)
-			return NULL;
-	}
-
-	sep->lsep = avdtp_register_sep(avdtp_server->seps, type,
+	sep->lsep = avdtp_register_sep(server->seps, type,
 					AVDTP_MEDIA_TYPE_AUDIO, codec,
 					delay_reporting, &endpoint_ind,
 					&cfm, sep);
@@ -1435,7 +1585,6 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	}
 
 	sep->server = server;
-	sep->avdtp_server = avdtp_server;
 	sep->endpoint = endpoint;
 	sep->codec = codec;
 	sep->type = type;
@@ -1457,8 +1606,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	record = a2dp_record(type);
 	if (!record) {
 		error("Unable to allocate new service record");
-		a2dp_clean_lsep(sep);
-		g_free(sep);
+		a2dp_unregister_sep(sep);
 		if (err)
 			*err = -EINVAL;
 		return NULL;
@@ -1467,12 +1615,20 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	if (adapter_service_add(server->adapter, record) < 0) {
 		error("Unable to register A2DP service record");
 		sdp_record_free(record);
-		a2dp_clean_lsep(sep);
-		g_free(sep);
+		a2dp_unregister_sep(sep);
 		if (err)
 			*err = -EINVAL;
 		return NULL;
 	}
+
+	if (!a2dp_server_listen(server)) {
+		sdp_record_free(record);
+		a2dp_unregister_sep(sep);
+		if (err)
+			*err = -EINVAL;
+		return NULL;
+	}
+
 	*record_id = record->handle;
 
 add:
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index c486519..acec28d 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -323,13 +323,6 @@ struct avdtp_remote_sep {
 	struct avdtp_stream *stream;
 };
 
-struct avdtp_server {
-	struct btd_adapter *adapter;
-	GIOChannel *io;
-	struct queue *seps;
-	GSList *sessions;
-};
-
 struct avdtp_local_sep {
 	avdtp_state_t state;
 	struct avdtp_stream *stream;
@@ -390,7 +383,7 @@ struct avdtp {
 
 	uint16_t version;
 
-	struct avdtp_server *server;
+	struct queue *lseps;
 	struct btd_device *device;
 
 	avdtp_session_state_t state;
@@ -696,9 +689,11 @@ static void avdtp_set_state(struct avdtp *session,
 
 	session->state = new_state;
 
-	for (l = state_callbacks; l != NULL; l = l->next) {
+	for (l = state_callbacks; l != NULL;) {
 		struct avdtp_state_callback *cb = l->data;
 
+		l = g_slist_next(l);
+
 		if (session->device != cb->dev)
 			continue;
 
@@ -1128,7 +1123,6 @@ void avdtp_free(void *data)
 
 void connection_lost(struct avdtp *session, int err)
 {
-	struct avdtp_server *server = session->server;
 	char address[18];
 
 	ba2str(device_get_address(session->device), address);
@@ -1147,7 +1141,6 @@ void connection_lost(struct avdtp *session, int err)
 	if (session->ref > 0)
 		return;
 
-	server->sessions = g_slist_remove(server->sessions, session);
 	avdtp_free(session);
 }
 
@@ -1221,10 +1214,10 @@ static bool match_by_seid(const void *data, const void *user_data)
 	return sep->info.seid == seid;
 }
 
-static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp_server *server,
+static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp *session,
 								uint8_t seid)
 {
-	return queue_find(server->seps, match_by_seid, INT_TO_PTR(seid));
+	return queue_find(session->lseps, match_by_seid, INT_TO_PTR(seid));
 }
 
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
@@ -1328,7 +1321,7 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 	struct seid_info *seps, *p;
 	gboolean ret;
 
-	sep_count = queue_length(session->server->seps);
+	sep_count = queue_length(session->lseps);
 
 	if (sep_count == 0) {
 		uint8_t err = AVDTP_NOT_SUPPORTED_COMMAND;
@@ -1341,7 +1334,7 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 	seps = g_new0(struct seid_info, sep_count);
 	p = seps;
 
-	queue_foreach(session->server->seps, copy_seps, &p);
+	queue_foreach(session->lseps, copy_seps, &p);
 
 	ret = avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 				AVDTP_DISCOVER, seps, rsp_size);
@@ -1367,7 +1360,7 @@ static gboolean avdtp_getcap_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1444,7 +1437,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1559,7 +1552,7 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 
 	memset(buf, 0, sizeof(buf));
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1675,7 +1668,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1735,7 +1728,7 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(session->server,
+		sep = find_local_sep_by_seid(session,
 					req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
@@ -1786,7 +1779,7 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1847,7 +1840,7 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(session->server,
+		sep = find_local_sep_by_seid(session,
 					req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
@@ -1895,7 +1888,7 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream)
 		return TRUE;
 
@@ -1933,7 +1926,7 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(session, req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -2256,18 +2249,6 @@ failed:
 	return FALSE;
 }
 
-static struct avdtp *find_session(GSList *list, struct btd_device *device)
-{
-	for (; list != NULL; list = g_slist_next(list)) {
-		struct avdtp *s = list->data;
-
-		if (s->device == device)
-			return s;
-	}
-
-	return NULL;
-}
-
 static uint16_t get_version(struct avdtp *session)
 {
 	const sdp_record_t *rec;
@@ -2373,65 +2354,39 @@ failed:
 		connection_lost(session, err_no);
 }
 
-struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
-						GIOChannel *chan,
-						struct btd_device *device)
+struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
+							struct queue *lseps)
 {
 	struct avdtp *session;
 
-	session = find_session(sessions, device);
-	if (session)
-		return session;
-
 	session = g_new0(struct avdtp, 1);
 
-	session->server = server;
 	session->device = btd_device_ref(device);
 	/* We don't use avdtp_set_state() here since this isn't a state change
 	 * but just setting of the initial state */
 	session->state = AVDTP_SESSION_STATE_DISCONNECTED;
+	session->lseps = lseps;
 
 	session->version = get_version(session);
 
-	server->sessions = g_slist_append(server->sessions, session);
-
 	if (!chan)
 		return session;
 
-	/* This state (ie, session is already *connecting*) happens when the
-	 * device initiates a connect (really a config'd L2CAP channel) even
-	 * though there is a connect we initiated in progress. In sink.c &
-	 * source.c, this state is referred to as XCASE connect:connect.
-	 * Abort the device's channel in favor of our own.
-	 */
-	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
-		DBG("connect already in progress (XCASE connect:connect)");
-		goto drop;
-	}
-
-	if (session->pending_open && session->pending_open->open_acp) {
-		if (!bt_io_accept(chan, avdtp_connect_cb, session, NULL, NULL))
-			goto drop;
-
-		return NULL;
-	}
-
-	if (session->io) {
-		error("Refusing unexpected connect");
-		goto drop;
-	}
+	avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTING);
 
 	btd_device_add_uuid(device, ADVANCED_AUDIO_UUID);
 
 	session->io = g_io_channel_ref(chan);
-	avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTING);
-
 	session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) session_cb, session);
 
+	/* This is so that avdtp_connect_cb will know to do the right thing
+	 * with respect to the disconnect timer */
+	session->stream_setup = TRUE;
+
+	avdtp_connect_cb(chan, NULL, session);
+
 	return session;
-drop:
-	return NULL;
 }
 
 bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
@@ -2454,7 +2409,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 	GIOChannel *io;
 	const bdaddr_t *src;
 
-	src = btd_adapter_get_address(session->server->adapter);
+	src = btd_adapter_get_address(device_get_adapter(session->device));
 
 	io = bt_io_connect(avdtp_connect_cb, session,
 				NULL, &err,
@@ -3154,6 +3109,23 @@ struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 	return NULL;
 }
 
+gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, int fd,
+						size_t imtu, size_t omtu)
+{
+	GIOChannel *io;
+
+	if (stream != stream->session->pending_open)
+		return FALSE;
+
+	io = g_io_channel_unix_new(fd);
+
+	handle_transport_connect(stream->session, io, imtu, omtu);
+
+	g_io_channel_unref(io);
+
+	return TRUE;
+}
+
 gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
 					uint16_t *imtu, uint16_t *omtu,
 					GSList **caps)
@@ -3704,7 +3676,7 @@ avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep)
 
 struct btd_adapter *avdtp_get_adapter(struct avdtp *session)
 {
-	return session->server->adapter;
+	return device_get_adapter(session->device);
 }
 
 struct btd_device *avdtp_get_device(struct avdtp *session)
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index c2c223a..e10805c 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -234,6 +234,8 @@ gboolean avdtp_stream_remove_cb(struct avdtp *session,
 				struct avdtp_stream *stream,
 				unsigned int id);
 
+gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, int fd,
+						size_t imtu, size_t omtu);
 gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
 					uint16_t *imtu, uint16_t *omtu,
 					GSList **caps);
@@ -293,9 +295,8 @@ struct btd_adapter *avdtp_get_adapter(struct avdtp *session);
 struct btd_device *avdtp_get_device(struct avdtp *session);
 struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep);
 
-struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
-						GIOChannel *chan,
-						struct btd_device *device);
+struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
+							struct queue *lseps);
 void avdtp_free(void *data);
 void connection_lost(struct avdtp *session, int err);
 void avdtp_accept(struct avdtp *session);
-- 
2.1.0

