Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 04/20] audio/avdtp: Remove avdtp_server from avdtp code
Date: Fri, 27 Feb 2015 17:02:52 +0200
Message-Id: <1425049388-18333-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Finishing removing avdtp_server code from avdtp.c. At the moment code is
moved to a2dp.c
---
 profiles/audio/a2dp.c  | 22 ++++++++++++++++++----
 profiles/audio/a2dp.h  |  3 +++
 profiles/audio/avdtp.c | 41 ++++++++++++++++++-----------------------
 profiles/audio/avdtp.h |  5 +++--
 4 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index e669f43..c96971f 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -120,7 +120,7 @@ struct avdtp_server {
 	struct btd_adapter *adapter;
 	GIOChannel *io;
 	struct queue *seps;
-	GSList *sessions;
+	struct queue *sessions;
 };
 
 static GSList *servers = NULL;
@@ -1222,7 +1222,7 @@ struct avdtp *a2dp_avdtp_get(struct btd_device *device)
 	if (server == NULL)
 		return NULL;
 
-	session = avdtp_new(server, server->sessions, device);
+	session = avdtp_new(server, server->sessions, device, server->seps);
 	if (!session)
 		return NULL;
 
@@ -1240,9 +1240,20 @@ static struct a2dp_server *a2dp_server_register(struct btd_adapter *adapter)
 	return server;
 }
 
+void avdtp_server_remove_session(struct avdtp_server *server,
+							struct avdtp *session)
+{
+	queue_remove(server->sessions, session);
+}
+
+struct btd_adapter *avdtp_server_get_adapter(struct avdtp_server *server)
+{
+	return server->adapter;
+}
+
 static void avdtp_server_destroy(struct avdtp_server *server)
 {
-	g_slist_free_full(server->sessions, avdtp_free);
+	queue_destroy(server->sessions, avdtp_free);
 
 	avdtp_servers = g_slist_remove(avdtp_servers, server);
 
@@ -1250,6 +1261,7 @@ static void avdtp_server_destroy(struct avdtp_server *server)
 	g_io_channel_unref(server->io);
 	btd_adapter_unref(server->adapter);
 	queue_destroy(server->seps, NULL);
+	queue_destroy(server->sessions, NULL);
 	g_free(server);
 }
 
@@ -1328,7 +1340,8 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (!avdtp_server)
 		goto drop;
 
-	session = avdtp_new(avdtp_server, avdtp_server->sessions, device);
+	session = avdtp_new(avdtp_server, avdtp_server->sessions, device,
+							avdtp_server->seps);
 	if (!session)
 		goto drop;
 
@@ -1379,6 +1392,7 @@ static struct avdtp_server *avdtp_server_init(struct btd_adapter *adapter)
 
 	server->adapter = btd_adapter_ref(adapter);
 	server->seps = queue_new();
+	server->sessions = queue_new();
 
 	avdtp_servers = g_slist_append(avdtp_servers, server);
 
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 544eea1..fdcc528 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -88,3 +88,6 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session);
 struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep);
 struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup);
 struct avdtp *a2dp_avdtp_get(struct btd_device *device);
+void avdtp_server_remove_session(struct avdtp_server *server,
+							struct avdtp *session);
+struct btd_adapter *avdtp_server_get_adapter(struct avdtp_server *server);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 0296700..05b3d2c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -50,6 +50,7 @@
 #include "src/device.h"
 
 #include "avdtp.h"
+#include "a2dp.h"
 #include "sink.h"
 #include "source.h"
 
@@ -324,13 +325,6 @@ struct avdtp_remote_sep {
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
@@ -1132,7 +1126,6 @@ void avdtp_free(void *data)
 
 void connection_lost(struct avdtp *session, int err)
 {
-	struct avdtp_server *server = session->server;
 	char address[18];
 
 	ba2str(device_get_address(session->device), address);
@@ -1151,7 +1144,7 @@ void connection_lost(struct avdtp *session, int err)
 	if (session->ref > 0)
 		return;
 
-	server->sessions = g_slist_remove(server->sessions, session);
+	avdtp_server_remove_session(session->server, session);
 	avdtp_free(session);
 }
 
@@ -2262,16 +2255,18 @@ failed:
 	return FALSE;
 }
 
-static struct avdtp *find_session(GSList *list, struct btd_device *device)
+static bool match_by_device(const void *data, const void *user_data)
 {
-	for (; list != NULL; list = g_slist_next(list)) {
-		struct avdtp *s = list->data;
+	const struct avdtp *session = data;
+	const struct btd_device *device = user_data;
 
-		if (s->device == device)
-			return s;
-	}
+	return session->device == device;
+}
 
-	return NULL;
+static struct avdtp *find_session(struct queue *sessions,
+						struct btd_device *device)
+{
+	return queue_find(sessions, match_by_device, device);
 }
 
 static uint16_t get_version(struct avdtp *session)
@@ -2379,8 +2374,9 @@ failed:
 		connection_lost(session, err_no);
 }
 
-struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
-						struct btd_device *device)
+struct avdtp *avdtp_new(struct avdtp_server *server, struct queue *sessions,
+						struct btd_device *device,
+						struct queue *lseps)
 {
 	struct avdtp *session;
 
@@ -2397,10 +2393,9 @@ struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
 	session->state = AVDTP_SESSION_STATE_DISCONNECTED;
 
 	session->version = get_version(session);
+	session->lseps = lseps;
 
-	server->sessions = g_slist_append(server->sessions, session);
-
-	session->lseps = server->seps;
+	queue_push_tail(sessions, session);
 
 	DBG("Created session %p added to server %p", session, server);
 
@@ -2465,7 +2460,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 	GIOChannel *io;
 	const bdaddr_t *src;
 
-	src = btd_adapter_get_address(session->server->adapter);
+	src = btd_adapter_get_address(avdtp_get_adapter(session));
 
 	io = bt_io_connect(avdtp_connect_cb, session,
 				NULL, &err,
@@ -3724,7 +3719,7 @@ avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep)
 
 struct btd_adapter *avdtp_get_adapter(struct avdtp *session)
 {
-	return session->server->adapter;
+	return avdtp_server_get_adapter(session->server);
 }
 
 struct btd_device *avdtp_get_device(struct avdtp *session)
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 4aa3936..28277cc 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -293,8 +293,9 @@ struct btd_adapter *avdtp_get_adapter(struct avdtp *session);
 struct btd_device *avdtp_get_device(struct avdtp *session);
 struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep);
 
-struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
-						struct btd_device *device);
+struct avdtp *avdtp_new(struct avdtp_server *server, struct queue *sessions,
+						struct btd_device *device,
+						struct queue *lseps);
 bool avdtp_transport_connect(struct avdtp *session, GIOChannel *chan);
 void avdtp_free(void *data);
 void connection_lost(struct avdtp *session, int err);
-- 
2.1.0

