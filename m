Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 5/5] audio/avdtp: Refactor avdtp and a2dp code
Date: Thu, 19 Feb 2015 17:46:47 +0200
Message-Id: <1424360807-14402-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424360807-14402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424360807-14402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Move connection-related code from avdtp to a2dp. This shall help to use
same avdtp library in profiles/ and android/ code.
---
 profiles/audio/a2dp.c  | 163 +++++++++++++++++++++++++++++++++++++++++++++--
 profiles/audio/avdtp.c | 168 ++++++++++++++-----------------------------------
 profiles/audio/avdtp.h |  14 ++++-
 3 files changed, 219 insertions(+), 126 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 75503f3..33e66a7 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -46,6 +46,8 @@
 #include "src/log.h"
 #include "src/sdpd.h"
 
+#include "btio/btio.h"
+
 #include "avdtp.h"
 #include "sink.h"
 #include "source.h"
@@ -58,6 +60,8 @@
 #define SUSPEND_TIMEOUT 5
 #define RECONFIGURE_TIMEOUT 500
 
+#define AVDTP_PSM 25
+
 struct a2dp_sep {
 	struct a2dp_server *server;
 	struct a2dp_endpoint *endpoint;
@@ -110,7 +114,15 @@ struct a2dp_server {
 	gboolean source_enabled;
 };
 
+struct avdtp_server {
+	struct btd_adapter *adapter;
+	GIOChannel *io;
+	GSList *seps;
+	GSList *sessions;
+};
+
 static GSList *servers = NULL;
+static GSList *avdtp_servers = NULL;
 static GSList *setups = NULL;
 static unsigned int cb_id = 0;
 
@@ -1186,6 +1198,19 @@ static struct a2dp_server *find_server(GSList *list, struct btd_adapter *a)
 	return NULL;
 }
 
+static struct avdtp_server *find_avdtp_server(GSList *list,
+							struct btd_adapter *a)
+{
+	for (; list; list = list->next) {
+		struct avdtp_server *server = list->data;
+
+		if (server->adapter == a)
+			return server;
+	}
+
+	return NULL;
+}
+
 static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter)
 {
 	struct a2dp_server *server;
@@ -1197,6 +1222,30 @@ static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter)
 	return server;
 }
 
+static void avdtp_server_destroy(struct avdtp_server *server)
+{
+	g_slist_free_full(server->sessions, avdtp_free);
+
+	avdtp_servers = g_slist_remove(avdtp_servers, server);
+
+	g_io_channel_shutdown(server->io, TRUE, NULL);
+	g_io_channel_unref(server->io);
+	btd_adapter_unref(server->adapter);
+	g_free(server);
+}
+
+static void a2dp_clean_lsep(struct avdtp_local_sep *lsep)
+{
+	struct avdtp_server *server = avdtp_get_server(lsep);
+
+
+	server->seps = g_slist_remove(server->seps, lsep);
+	if (!server->seps)
+		avdtp_server_destroy(server);
+
+	avdtp_unregister_sep(lsep);
+}
+
 static void a2dp_unregister_sep(struct a2dp_sep *sep)
 {
 	if (sep->destroy) {
@@ -1204,7 +1253,8 @@ static void a2dp_unregister_sep(struct a2dp_sep *sep)
 		sep->endpoint = NULL;
 	}
 
-	avdtp_unregister_sep(sep->lsep);
+	a2dp_clean_lsep(sep->lsep);
+
 	g_free(sep);
 }
 
@@ -1215,6 +1265,103 @@ static void a2dp_server_unregister(struct a2dp_server *server)
 	g_free(server);
 }
 
+static void auth_cb(DBusError *derr, void *user_data)
+{
+	struct avdtp *session = user_data;
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		connection_lost(session, EACCES);
+		return;
+	}
+
+	avdtp_accept(session);
+}
+
+static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
+{
+	struct avdtp *session;
+	char address[18];
+	bdaddr_t src, dst;
+	GError *err = NULL;
+	struct btd_device *device;
+	struct avdtp_server *avdtp_server;
+
+	bt_io_get(chan, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	DBG("AVDTP: incoming connect from %s", address);
+
+	device = btd_adapter_find_device(adapter_find(&src), &dst,
+								BDADDR_BREDR);
+	if (!device)
+		goto drop;
+
+	avdtp_server = find_avdtp_server(avdtp_servers,
+						device_get_adapter(device));
+	if (!avdtp_server)
+		goto drop;
+
+	session = avdtp_new(avdtp_server, avdtp_server->sessions, chan, device);
+	if (!session)
+		goto drop;
+
+	avdtp_request_authorization(session, &src, &dst, auth_cb);
+
+	return;
+
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
+static GIOChannel *avdtp_server_socket(const bdaddr_t *src, gboolean master)
+{
+	GError *err = NULL;
+	GIOChannel *io;
+
+	io = bt_io_listen(NULL, avdtp_confirm_cb,
+				NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_PSM, AVDTP_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_MASTER, master,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
+	return io;
+}
+
+static struct avdtp_server *avdtp_server_init(struct btd_adapter *adapter)
+{
+	struct avdtp_server *server;
+
+	server = g_new0(struct avdtp_server, 1);
+
+	server->io = avdtp_server_socket(btd_adapter_get_address(adapter),
+									TRUE);
+	if (!server->io) {
+		g_free(server);
+		return NULL;
+	}
+
+	server->adapter = btd_adapter_ref(adapter);
+
+	avdtp_servers = g_slist_append(avdtp_servers, server);
+
+	return server;
+}
+
 struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
 				struct a2dp_endpoint *endpoint,
@@ -1222,6 +1369,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				int *err)
 {
 	struct a2dp_server *server;
+	struct avdtp_server *avdtp_server;
 	struct a2dp_sep *sep;
 	GSList **l;
 	uint32_t *record_id;
@@ -1248,7 +1396,14 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 
 	sep = g_new0(struct a2dp_sep, 1);
 
-	sep->lsep = avdtp_register_sep(adapter, type,
+	avdtp_server = find_avdtp_server(avdtp_servers, adapter);
+	if (!avdtp_server) {
+		avdtp_server = avdtp_server_init(adapter);
+		if (!server)
+			return NULL;
+	}
+
+	sep->lsep = avdtp_register_sep(avdtp_server, type,
 					AVDTP_MEDIA_TYPE_AUDIO, codec,
 					delay_reporting, &endpoint_ind,
 					&cfm, sep);
@@ -1282,7 +1437,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	record = a2dp_record(type);
 	if (!record) {
 		error("Unable to allocate new service record");
-		avdtp_unregister_sep(sep->lsep);
+		a2dp_clean_lsep(sep->lsep);
 		g_free(sep);
 		if (err)
 			*err = -EINVAL;
@@ -1292,7 +1447,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	if (adapter_service_add(server->adapter, record) < 0) {
 		error("Unable to register A2DP service record");
 		sdp_record_free(record);
-		avdtp_unregister_sep(sep->lsep);
+		a2dp_clean_lsep(sep->lsep);
 		g_free(sep);
 		if (err)
 			*err = -EINVAL;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 825fb79..1f996db 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1107,7 +1107,7 @@ static void remove_disconnect_timer(struct avdtp *session)
 	session->stream_setup = FALSE;
 }
 
-static void avdtp_free(void *data)
+void avdtp_free(void *data)
 {
 	struct avdtp *session = data;
 
@@ -1141,7 +1141,7 @@ static void avdtp_free(void *data)
 	g_free(session);
 }
 
-static void connection_lost(struct avdtp *session, int err)
+void connection_lost(struct avdtp *session, int err)
 {
 	struct avdtp_server *server = session->server;
 	char address[18];
@@ -2424,59 +2424,27 @@ failed:
 		connection_lost(session, err_no);
 }
 
-static void auth_cb(DBusError *derr, void *user_data)
-{
-	struct avdtp *session = user_data;
-	GError *err = NULL;
-
-	if (derr && dbus_error_is_set(derr)) {
-		error("Access denied: %s", derr->message);
-		connection_lost(session, EACCES);
-		return;
-	}
-
-	if (!bt_io_accept(session->io, avdtp_connect_cb, session, NULL,
-								&err)) {
-		error("bt_io_accept: %s", err->message);
-		connection_lost(session, EACCES);
-		g_error_free(err);
-		return;
-	}
-
-	/* This is so that avdtp_connect_cb will know to do the right thing
-	 * with respect to the disconnect timer */
-	session->stream_setup = TRUE;
-}
-
-static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
+struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
+						GIOChannel *chan,
+						struct btd_device *device)
 {
 	struct avdtp *session;
-	char address[18];
-	bdaddr_t src, dst;
-	GError *err = NULL;
-	struct btd_device *device;
 
-	bt_io_get(chan, &err,
-			BT_IO_OPT_SOURCE_BDADDR, &src,
-			BT_IO_OPT_DEST_BDADDR, &dst,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		goto drop;
-	}
+	session = find_session(sessions, device);
+	if (session)
+		return session;
 
-	DBG("AVDTP: incoming connect from %s", address);
+	session = g_new0(struct avdtp, 1);
 
-	device = btd_adapter_find_device(adapter_find(&src), &dst,
-								BDADDR_BREDR);
-	if (!device)
-		goto drop;
+	session->server = server;
+	session->device = btd_device_ref(device);
+	/* We don't use avdtp_set_state() here since this isn't a state change
+	 * but just setting of the initial state */
+	session->state = AVDTP_SESSION_STATE_DISCONNECTED;
 
-	session = avdtp_get_internal(device);
-	if (!session)
-		goto drop;
+	session->version = get_version(session);
+
+	sessions = g_slist_append(sessions, session);
 
 	/* This state (ie, session is already *connecting*) happens when the
 	 * device initiates a connect (really a config'd L2CAP channel) even
@@ -2492,11 +2460,12 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (session->pending_open && session->pending_open->open_acp) {
 		if (!bt_io_accept(chan, avdtp_connect_cb, session, NULL, NULL))
 			goto drop;
-		return;
+
+		return NULL;
 	}
 
 	if (session->io) {
-		error("Refusing unexpected connect from %s", address);
+		error("Refusing unexpected connect");
 		goto drop;
 	}
 
@@ -2508,18 +2477,23 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) session_cb, session);
 
-	session->auth_id = btd_request_authorization(&src, &dst,
+	return session;
+drop:
+	return NULL;
+}
+
+bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
+					const bdaddr_t *dst, service_auth_cb cb)
+{
+	session->auth_id = btd_request_authorization(src, dst,
 							ADVANCED_AUDIO_UUID,
-							auth_cb, session);
+							cb, session);
 	if (session->auth_id == 0) {
 		avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
-		goto drop;
+		return false;
 	}
 
-	return;
-
-drop:
-	g_io_channel_shutdown(chan, TRUE, NULL);
+	return true;
 }
 
 static GIOChannel *l2cap_connect(struct avdtp *session)
@@ -3654,47 +3628,24 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
-static GIOChannel *avdtp_server_socket(const bdaddr_t *src, gboolean master)
+void avdtp_accept(struct avdtp *session)
 {
 	GError *err = NULL;
-	GIOChannel *io;
 
-	io = bt_io_listen(NULL, avdtp_confirm_cb,
-				NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_PSM, AVDTP_PSM,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
-				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
+	if (!bt_io_accept(session->io, avdtp_connect_cb, session, NULL,
+								&err)) {
+		error("bt_io_accept: %s", err->message);
+		connection_lost(session, EACCES);
 		g_error_free(err);
+		return;
 	}
 
-	return io;
-}
-
-static struct avdtp_server *avdtp_server_init(struct btd_adapter *adapter)
-{
-	struct avdtp_server *server;
-
-	server = g_new0(struct avdtp_server, 1);
-
-	server->io = avdtp_server_socket(btd_adapter_get_address(adapter),
-									TRUE);
-	if (!server->io) {
-		g_free(server);
-		return NULL;
-	}
-
-	server->adapter = btd_adapter_ref(adapter);
-
-	servers = g_slist_append(servers, server);
-
-	return server;
+	/* This is so that avdtp_connect_cb will know to do the right thing
+	 * with respect to the disconnect timer */
+	session->stream_setup = TRUE;
 }
 
-struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
+struct avdtp_local_sep *avdtp_register_sep(struct avdtp_server *server,
 						uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
@@ -3703,20 +3654,12 @@ struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
 						struct avdtp_sep_cfm *cfm,
 						void *user_data)
 {
-	struct avdtp_server *server;
 	struct avdtp_local_sep *sep;
 	uint8_t seid = util_get_uid(&seids, MAX_SEID);
 
 	if (!seid)
 		return NULL;
 
-	server = find_server(servers, adapter);
-	if (!server) {
-		server = avdtp_server_init(adapter);
-		if (!server)
-			return NULL;
-	}
-
 	sep = g_new0(struct avdtp_local_sep, 1);
 
 	sep->state = AVDTP_STATE_IDLE;
@@ -3737,28 +3680,11 @@ struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
 	return sep;
 }
 
-static void avdtp_server_destroy(struct avdtp_server *server)
-{
-	g_slist_free_full(server->sessions, avdtp_free);
-
-	servers = g_slist_remove(servers, server);
-
-	g_io_channel_shutdown(server->io, TRUE, NULL);
-	g_io_channel_unref(server->io);
-	btd_adapter_unref(server->adapter);
-	g_free(server);
-}
-
 int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 {
-	struct avdtp_server *server;
-
 	if (!sep)
 		return -EINVAL;
 
-	server = sep->server;
-	server->seps = g_slist_remove(server->seps, sep);
-
 	if (sep->stream)
 		release_stream(sep->stream, sep->stream->session);
 
@@ -3768,11 +3694,6 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 	util_clear_uid(&seids, sep->info.seid);
 	g_free(sep);
 
-	if (server->seps)
-		return 0;
-
-	avdtp_server_destroy(server);
-
 	return 0;
 }
 
@@ -3836,6 +3757,11 @@ struct btd_device *avdtp_get_device(struct avdtp *session)
 	return session->device;
 }
 
+struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep)
+{
+	return lsep->server;
+}
+
 gboolean avdtp_has_stream(struct avdtp *session, struct avdtp_stream *stream)
 {
 	return g_slist_find(session->streams, stream) ? TRUE : FALSE;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 390c154..8bf6611 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -29,6 +29,7 @@ typedef enum {
 } avdtp_session_state_t;
 
 struct avdtp;
+struct avdtp_server;
 struct avdtp_stream;
 struct avdtp_local_sep;
 struct avdtp_remote_sep;
@@ -268,7 +269,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							uint16_t delay);
 
-struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
+struct avdtp_local_sep *avdtp_register_sep(struct avdtp_server *server,
 						uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
@@ -293,3 +294,14 @@ int avdtp_error_posix_errno(struct avdtp_error *err);
 
 struct btd_adapter *avdtp_get_adapter(struct avdtp *session);
 struct btd_device *avdtp_get_device(struct avdtp *session);
+struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep);
+
+struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
+						GIOChannel *chan,
+						struct btd_device *device);
+void avdtp_free(void *data);
+void connection_lost(struct avdtp *session, int err);
+void avdtp_accept(struct avdtp *session);
+bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
+							const bdaddr_t *dst,
+							service_auth_cb cb);
-- 
2.1.0

