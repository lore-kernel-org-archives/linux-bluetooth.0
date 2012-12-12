Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/16] avdtp: Use refs to adapter and device instead of bdaddr_t
Date: Wed, 12 Dec 2012 11:28:00 +0100
Message-ID: <1355308088-9080-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use local refs to device and adapter object instead of addresses.
This allows a2dp code to pass adapter object instead of address
and minimise need for finding adapter again with manager API.
---
 profiles/audio/a2dp.c  |  14 +++----
 profiles/audio/avdtp.c | 101 +++++++++++++++++++++----------------------------
 profiles/audio/avdtp.h |   7 ++--
 3 files changed, 54 insertions(+), 68 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 51119b7..593fbf6 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1160,7 +1160,7 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
 	return NULL;
 }
 
-static struct a2dp_server *a2dp_server_register(const bdaddr_t *src,
+static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter,
 							GKeyFile *config)
 {
 	struct a2dp_server *server;
@@ -1168,14 +1168,14 @@ static struct a2dp_server *a2dp_server_register(const bdaddr_t *src,
 
 	server = g_new0(struct a2dp_server, 1);
 
-	av_err = avdtp_init(src, config);
+	av_err = avdtp_init(adapter, config);
 	if (av_err < 0) {
 		DBG("AVDTP not registered");
 		g_free(server);
 		return NULL;
 	}
 
-	bacpy(&server->src, src);
+	bacpy(&server->src, adapter_get_address(adapter));
 	servers = g_slist_append(servers, server);
 
 	return server;
@@ -1189,7 +1189,7 @@ int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config)
 	if (server != NULL)
 		goto done;
 
-	server = a2dp_server_register(adapter_get_address(adapter), config);
+	server = a2dp_server_register(adapter, config);
 	if (server == NULL)
 		return -EPROTONOSUPPORT;
 
@@ -1207,7 +1207,7 @@ int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config)
 	if (server != NULL)
 		goto done;
 
-	server = a2dp_server_register(adapter_get_address(adapter), config);
+	server = a2dp_server_register(adapter, config);
 	if (server == NULL)
 		return -EPROTONOSUPPORT;
 
@@ -1240,7 +1240,7 @@ void a2dp_unregister(struct btd_adapter *adapter)
 	g_slist_free_full(server->sources,
 					(GDestroyNotify) a2dp_unregister_sep);
 
-	avdtp_exit(adapter_get_address(adapter));
+	avdtp_exit(adapter);
 
 	servers = g_slist_remove(servers, server);
 
@@ -1286,7 +1286,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 
 	sep = g_new0(struct a2dp_sep, 1);
 
-	sep->lsep = avdtp_register_sep(&server->src, type,
+	sep->lsep = avdtp_register_sep(adapter, type,
 					AVDTP_MEDIA_TYPE_AUDIO, codec,
 					delay_reporting, &endpoint_ind,
 					&cfm, sep);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1d6c71e..20fdf25 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -330,7 +330,7 @@ struct avdtp_remote_sep {
 };
 
 struct avdtp_server {
-	bdaddr_t src;
+	struct btd_adapter *adapter;
 	GIOChannel *io;
 	GSList *seps;
 	GSList *sessions;
@@ -391,7 +391,7 @@ struct avdtp {
 	uint16_t version;
 
 	struct avdtp_server *server;
-	bdaddr_t dst;
+	struct btd_device *device;
 
 	avdtp_session_state_t state;
 
@@ -454,12 +454,12 @@ static void avdtp_sep_set_state(struct avdtp *session,
 				avdtp_state_t state);
 static void auth_cb(DBusError *derr, void *user_data);
 
-static struct avdtp_server *find_server(GSList *list, const bdaddr_t *src)
+static struct avdtp_server *find_server(GSList *list, struct btd_adapter *a)
 {
 	for (; list; list = list->next) {
 		struct avdtp_server *server = list->data;
 
-		if (bacmp(&server->src, src) == 0)
+		if (server->adapter == a)
 			return server;
 	}
 
@@ -1157,7 +1157,9 @@ static gboolean disconnect_timeout(gpointer user_data)
 
 	stream_setup = session->stream_setup;
 	session->stream_setup = FALSE;
-	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
+	dev = manager_get_device(adapter_get_address(session->server->adapter),
+					device_get_address(session->device),
+					FALSE);
 
 	if (dev && dev->sink && stream_setup)
 		sink_setup_stream(dev->sink, session);
@@ -1189,7 +1191,7 @@ static void connection_lost(struct avdtp *session, int err)
 	struct avdtp_server *server = session->server;
 	char address[18];
 
-	ba2str(&session->dst, address);
+	ba2str(device_get_address(session->device), address);
 	DBG("Disconnected from %s", address);
 
 	if (err != EACCES)
@@ -1206,6 +1208,7 @@ static void connection_lost(struct avdtp *session, int err)
 		return;
 
 	server->sessions = g_slist_remove(server->sessions, session);
+	btd_device_unref(session->device);
 	avdtp_free(session);
 }
 
@@ -2273,15 +2276,13 @@ failed:
 	return FALSE;
 }
 
-static struct avdtp *find_session(GSList *list, const bdaddr_t *dst)
+static struct avdtp *find_session(GSList *list, struct btd_device *device)
 {
 	for (; list != NULL; list = g_slist_next(list)) {
 		struct avdtp *s = list->data;
 
-		if (bacmp(dst, &s->dst))
-			continue;
-
-		return s;
+		if (s->device == device)
+			return s;
 	}
 
 	return NULL;
@@ -2289,26 +2290,14 @@ static struct avdtp *find_session(GSList *list, const bdaddr_t *dst)
 
 static uint16_t get_version(struct avdtp *session)
 {
-	struct btd_adapter *adapter;
-	struct btd_device *device;
 	const sdp_record_t *rec;
 	sdp_list_t *protos;
 	sdp_data_t *proto_desc;
-	char addr[18];
 	uint16_t ver = 0x0100;
 
-	adapter = manager_find_adapter(&session->server->src);
-	if (!adapter)
-		return ver;
-
-	ba2str(&session->dst, addr);
-	device = adapter_find_device(adapter, addr);
-	if (!device)
-		return ver;
-
-	rec = btd_device_get_record(device, A2DP_SINK_UUID);
+	rec = btd_device_get_record(session->device, A2DP_SINK_UUID);
 	if (!rec)
-		rec = btd_device_get_record(device, A2DP_SOURCE_UUID);
+		rec = btd_device_get_record(session->device, A2DP_SOURCE_UUID);
 
 	if (!rec)
 		return ver;
@@ -2326,19 +2315,16 @@ static uint16_t get_version(struct avdtp *session)
 	return ver;
 }
 
-static struct avdtp *avdtp_get_internal(const bdaddr_t *src, const bdaddr_t *dst)
+static struct avdtp *avdtp_get_internal(struct btd_device *device)
 {
 	struct avdtp_server *server;
 	struct avdtp *session;
 
-	assert(src != NULL);
-	assert(dst != NULL);
-
-	server = find_server(servers, src);
+	server = find_server(servers, device_get_adapter(device));
 	if (server == NULL)
 		return NULL;
 
-	session = find_session(server->sessions, dst);
+	session = find_session(server->sessions, device);
 	if (session) {
 		if (session->pending_auth)
 			return NULL;
@@ -2349,7 +2335,7 @@ static struct avdtp *avdtp_get_internal(const bdaddr_t *src, const bdaddr_t *dst
 	session = g_new0(struct avdtp, 1);
 
 	session->server = server;
-	bacpy(&session->dst, dst);
+	session->device = btd_device_ref(device);
 	/* We don't use avdtp_set_state() here since this isn't a state change
 	 * but just setting of the initial state */
 	session->state = AVDTP_SESSION_STATE_DISCONNECTED;
@@ -2364,13 +2350,8 @@ static struct avdtp *avdtp_get_internal(const bdaddr_t *src, const bdaddr_t *dst
 struct avdtp *avdtp_get(struct audio_device *device)
 {
 	struct avdtp *session;
-	const bdaddr_t *src;
-	const bdaddr_t *dst;
 
-	src = adapter_get_address(device_get_adapter(device->btd_dev));
-	dst = device_get_address(device->btd_dev);
-
-	session = avdtp_get_internal(src, dst);
+	session = avdtp_get_internal(device->btd_dev);
 
 	if (!session)
 		return NULL;
@@ -2403,7 +2384,7 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
-	ba2str(&session->dst, address);
+	ba2str(device_get_address(session->device), address);
 	DBG("AVDTP: connected %s channel to %s",
 			session->pending_open ? "transport" : "signaling",
 			address);
@@ -2487,6 +2468,7 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	char address[18];
 	bdaddr_t src, dst;
 	GError *err = NULL;
+	struct btd_device *device;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
@@ -2501,7 +2483,11 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 
 	DBG("AVDTP: incoming connect from %s", address);
 
-	session = avdtp_get_internal(&src, &dst);
+	device = adapter_find_device(manager_find_adapter(&src), address);
+	if (!device)
+		goto drop;
+
+	session = avdtp_get_internal(device);
 	if (!session)
 		goto drop;
 
@@ -2565,8 +2551,10 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 
 	io = bt_io_connect(avdtp_connect_cb, session,
 				NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &session->server->src,
-				BT_IO_OPT_DEST_BDADDR, &session->dst,
+				BT_IO_OPT_SOURCE_BDADDR,
+				adapter_get_address(session->server->adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				device_get_address(session->device),
 				BT_IO_OPT_PSM, AVDTP_PSM,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
@@ -3201,17 +3189,12 @@ gboolean avdtp_is_connected(struct audio_device *device)
 {
 	struct avdtp_server *server;
 	struct avdtp *session;
-	const bdaddr_t *src;
-	const bdaddr_t *dst;
-
-	src = adapter_get_address(device_get_adapter(device->btd_dev));
-	dst = device_get_address(device->btd_dev);
 
-	server = find_server(servers, src);
+	server = find_server(servers, device_get_adapter(device->btd_dev));
 	if (!server)
 		return FALSE;
 
-	session = find_session(server->sessions, dst);
+	session = find_session(server->sessions, device->btd_dev);
 	if (!session)
 		return FALSE;
 
@@ -3732,7 +3715,8 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
-struct avdtp_local_sep *avdtp_register_sep(const bdaddr_t *src, uint8_t type,
+struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
+						uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
@@ -3743,7 +3727,7 @@ struct avdtp_local_sep *avdtp_register_sep(const bdaddr_t *src, uint8_t type,
 	struct avdtp_server *server;
 	struct avdtp_local_sep *sep;
 
-	server = find_server(servers, src);
+	server = find_server(servers, adapter);
 	if (!server)
 		return NULL;
 
@@ -3864,12 +3848,12 @@ avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep)
 void avdtp_get_peers(struct avdtp *session, bdaddr_t *src, bdaddr_t *dst)
 {
 	if (src)
-		bacpy(src, &session->server->src);
+		bacpy(src, adapter_get_address(session->server->adapter));
 	if (dst)
-		bacpy(dst, &session->dst);
+		bacpy(dst, device_get_address(session->device));
 }
 
-int avdtp_init(const bdaddr_t *src, GKeyFile *config)
+int avdtp_init(struct btd_adapter *adapter, GKeyFile *config)
 {
 	GError *err = NULL;
 	gboolean tmp, master = TRUE;
@@ -3889,24 +3873,24 @@ int avdtp_init(const bdaddr_t *src, GKeyFile *config)
 proceed:
 	server = g_new0(struct avdtp_server, 1);
 
-	server->io = avdtp_server_socket(src, master);
+	server->io = avdtp_server_socket(adapter_get_address(adapter), master);
 	if (!server->io) {
 		g_free(server);
 		return -1;
 	}
 
-	bacpy(&server->src, src);
+	server->adapter = btd_adapter_ref(adapter);
 
 	servers = g_slist_append(servers, server);
 
 	return 0;
 }
 
-void avdtp_exit(const bdaddr_t *src)
+void avdtp_exit(struct btd_adapter *adapter)
 {
 	struct avdtp_server *server;
 
-	server = find_server(servers, src);
+	server = find_server(servers, adapter);
 	if (!server)
 		return;
 
@@ -3916,6 +3900,7 @@ void avdtp_exit(const bdaddr_t *src)
 
 	g_io_channel_shutdown(server->io, TRUE, NULL);
 	g_io_channel_unref(server->io);
+	btd_adapter_unref(server->adapter);
 	g_free(server);
 }
 
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index e014623..dbdf8f4 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -282,7 +282,8 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							uint16_t delay);
 
-struct avdtp_local_sep *avdtp_register_sep(const bdaddr_t *src, uint8_t type,
+struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
+						uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
@@ -309,5 +310,5 @@ void avdtp_get_peers(struct avdtp *session, bdaddr_t *src, bdaddr_t *dst);
 gboolean avdtp_stream_setup_active(struct avdtp *session);
 void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc);
 
-int avdtp_init(const bdaddr_t *src, GKeyFile *config);
-void avdtp_exit(const bdaddr_t *src);
+int avdtp_init(struct btd_adapter *adapter, GKeyFile *config);
+void avdtp_exit(struct btd_adapter *adapter);
-- 
1.8.0

