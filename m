Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] audio/AVDTP: Remove avdtp_init and avdtp_exit
Date: Mon, 11 Nov 2013 18:17:55 +0200
Message-Id: <1384186675-14940-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is now done on demand by avdtp_register_sep and avdtp_unregister_sep
so the server socket is only registered when there is an endpoint
available and the record is properly registered.
---
v2: Fix return of avdtp_server_init

 profiles/audio/a2dp.c  |  11 -----
 profiles/audio/avdtp.c | 118 +++++++++++++++++++++++++------------------------
 profiles/audio/avdtp.h |   3 --
 3 files changed, 60 insertions(+), 72 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 8477b5d..6b3d6b2 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1187,17 +1187,8 @@ static struct a2dp_server *find_server(GSList *list, struct btd_adapter *a)
 static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter)
 {
 	struct a2dp_server *server;
-	int av_err;
 
 	server = g_new0(struct a2dp_server, 1);
-
-	av_err = avdtp_init(adapter);
-	if (av_err < 0) {
-		DBG("AVDTP not registered");
-		g_free(server);
-		return NULL;
-	}
-
 	server->adapter = btd_adapter_ref(adapter);
 	servers = g_slist_append(servers, server);
 
@@ -1217,8 +1208,6 @@ static void a2dp_unregister_sep(struct a2dp_sep *sep)
 
 static void a2dp_server_unregister(struct a2dp_server *server)
 {
-	avdtp_exit(server->adapter);
-
 	servers = g_slist_remove(servers, server);
 	btd_adapter_unref(server->adapter);
 	g_free(server);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index dab8f1c..9378350 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3683,6 +3683,45 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
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
+	server->io = avdtp_server_socket(adapter_get_address(adapter), TRUE);
+	if (!server->io) {
+		g_free(server);
+		return NULL;
+	}
+
+	server->adapter = btd_adapter_ref(adapter);
+
+	servers = g_slist_append(servers, server);
+
+	return server;
+}
+
 struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
 						uint8_t type,
 						uint8_t media_type,
@@ -3696,8 +3735,11 @@ struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
 	struct avdtp_local_sep *sep;
 
 	server = find_server(servers, adapter);
-	if (!server)
-		return NULL;
+	if (!server) {
+		server = avdtp_server_init(adapter);
+		if (!server)
+			return NULL;
+	}
 
 	if (g_slist_length(server->seps) > MAX_SEID)
 		return NULL;
@@ -3722,6 +3764,18 @@ struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
 	return sep;
 }
 
+static void avdtp_server_destroy(struct avdtp_server *server)
+{
+	g_slist_free_full(server->sessions, avdtp_free);
+
+	servers = g_slist_remove(servers, server);
+
+	g_io_channel_shutdown(server->io, TRUE, NULL);
+	g_io_channel_unref(server->io);
+	btd_adapter_unref(server->adapter);
+	g_free(server);
+}
+
 int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 {
 	struct avdtp_server *server;
@@ -3740,27 +3794,12 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 
 	g_free(sep);
 
-	return 0;
-}
-
-static GIOChannel *avdtp_server_socket(const bdaddr_t *src, gboolean master)
-{
-	GError *err = NULL;
-	GIOChannel *io;
+	if (server->seps)
+		return 0;
 
-	io = bt_io_listen(NULL, avdtp_confirm_cb,
-				NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_PSM, AVDTP_PSM,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
-				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
-		g_error_free(err);
-	}
+	avdtp_server_destroy(server);
 
-	return io;
+	return 0;
 }
 
 const char *avdtp_strerror(struct avdtp_error *err)
@@ -3823,43 +3862,6 @@ struct btd_device *avdtp_get_device(struct avdtp *session)
 	return session->device;
 }
 
-int avdtp_init(struct btd_adapter *adapter)
-{
-	struct avdtp_server *server;
-
-	server = g_new0(struct avdtp_server, 1);
-
-	server->io = avdtp_server_socket(adapter_get_address(adapter), TRUE);
-	if (!server->io) {
-		g_free(server);
-		return -1;
-	}
-
-	server->adapter = btd_adapter_ref(adapter);
-
-	servers = g_slist_append(servers, server);
-
-	return 0;
-}
-
-void avdtp_exit(struct btd_adapter *adapter)
-{
-	struct avdtp_server *server;
-
-	server = find_server(servers, adapter);
-	if (!server)
-		return;
-
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
 gboolean avdtp_has_stream(struct avdtp *session, struct avdtp_stream *stream)
 {
 	return g_slist_find(session->streams, stream) ? TRUE : FALSE;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 3bf7503..5606506 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -308,6 +308,3 @@ struct btd_adapter *avdtp_get_adapter(struct avdtp *session);
 struct btd_device *avdtp_get_device(struct avdtp *session);
 
 void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc);
-
-int avdtp_init(struct btd_adapter *adapter);
-void avdtp_exit(struct btd_adapter *adapter);
-- 
1.8.3.1

