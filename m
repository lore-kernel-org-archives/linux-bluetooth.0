Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4] AVDTP: Do not keep a internal reference
Date: Fri, 26 Oct 2012 16:44:29 +0300
Message-Id: <1351259069-21516-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Don't initialize reference with 1, instead always start disconnect timer
when reference drops to 0, so in case nobody reclaims the session it
automatically disconnect after 1 second and frees the memory.
---
v2: Fix with stream_setup flag being ignored in disconnect_timeout
v3: Do avrcp_free on connection_lost to avoid having dangling sessions in
disconnected state waiting the timeout to be freed.
v4: Remove unnecessary reference when authorizing, disconnect timer is only
started when the session is really connected.

 audio/avdtp.c | 204 +++++++++++++++++++++++-----------------------------------
 1 file changed, 82 insertions(+), 122 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index bd91cb6..75b81fe 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -387,8 +387,7 @@ struct avdtp_stream {
 /* Structure describing an AVDTP connection between two devices */
 
 struct avdtp {
-	int ref;
-	int free_lock;
+	unsigned int ref;
 
 	uint16_t version;
 
@@ -657,50 +656,6 @@ static gboolean stream_open_timeout(gpointer user_data)
 	return FALSE;
 }
 
-static gboolean disconnect_timeout(gpointer user_data)
-{
-	struct avdtp *session = user_data;
-	struct audio_device *dev;
-	gboolean stream_setup;
-
-	session->dc_timer = 0;
-	stream_setup = session->stream_setup;
-	session->stream_setup = FALSE;
-
-	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
-
-	if (dev && dev->sink && stream_setup)
-		sink_setup_stream(dev->sink, session);
-	else if (dev && dev->source && stream_setup)
-		source_setup_stream(dev->source, session);
-	else
-		connection_lost(session, ETIMEDOUT);
-
-	return FALSE;
-}
-
-static void remove_disconnect_timer(struct avdtp *session)
-{
-	g_source_remove(session->dc_timer);
-	session->dc_timer = 0;
-	session->stream_setup = FALSE;
-}
-
-static void set_disconnect_timer(struct avdtp *session)
-{
-	if (session->dc_timer)
-		remove_disconnect_timer(session);
-
-	if (session->device_disconnect) {
-		session->dc_timer = g_idle_add(disconnect_timeout, session);
-		return;
-	}
-
-	session->dc_timer = g_timeout_add_seconds(DISCONNECT_TIMEOUT,
-						disconnect_timeout,
-						session);
-}
-
 void avdtp_error_init(struct avdtp_error *err, uint8_t category, int id)
 {
 	err->category = category;
@@ -780,8 +735,9 @@ static void avdtp_set_state(struct avdtp *session,
 	}
 }
 
-static void stream_free(struct avdtp_stream *stream)
+static void stream_free(void *data)
 {
+	struct avdtp_stream *stream = data;
 	struct avdtp_remote_sep *rsep;
 
 	stream->lsep->info.inuse = 0;
@@ -1148,33 +1104,34 @@ static int avdtp_cancel_authorization(struct avdtp *session)
 	return 0;
 }
 
-static void connection_lost(struct avdtp *session, int err)
+static void sep_free(gpointer data)
 {
-	char address[18];
-
-	ba2str(&session->dst, address);
-	DBG("Disconnected from %s", address);
+	struct avdtp_remote_sep *sep = data;
 
-	if (err != EACCES)
-		avdtp_cancel_authorization(session);
+	g_slist_free_full(sep->caps, g_free);
+	g_free(sep);
+}
 
-	session->free_lock = 1;
+static void remove_disconnect_timer(struct avdtp *session)
+{
+	g_source_remove(session->dc_timer);
+	session->dc_timer = 0;
+	session->stream_setup = FALSE;
+}
 
-	finalize_discovery(session, err);
+static void avdtp_free(void *data)
+{
+	struct avdtp *session = data;
 
-	g_slist_foreach(session->streams, (GFunc) release_stream, session);
-	session->streams = NULL;
+	DBG("%p", session);
 
-	session->free_lock = 0;
+	g_slist_free_full(session->streams, stream_free);
 
 	if (session->io) {
 		g_io_channel_shutdown(session->io, FALSE, NULL);
 		g_io_channel_unref(session->io);
-		session->io = NULL;
 	}
 
-	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
-
 	if (session->io_id) {
 		g_source_remove(session->io_id);
 		session->io_id = 0;
@@ -1183,69 +1140,91 @@ static void connection_lost(struct avdtp *session, int err)
 	if (session->dc_timer)
 		remove_disconnect_timer(session);
 
-	if (session->ref != 1)
-		error("connection_lost: ref count not 1 after all callbacks");
-	else
-		avdtp_unref(session);
+	if (session->req)
+		pending_req_free(session->req);
+
+	g_slist_free_full(session->seps, sep_free);
+
+	g_free(session->buf);
+
+	g_free(session);
 }
 
-static void sep_free(gpointer data)
+static gboolean disconnect_timeout(gpointer user_data)
 {
-	struct avdtp_remote_sep *sep = data;
+	struct avdtp *session = user_data;
+	struct audio_device *dev;
+	gboolean stream_setup;
 
-	g_slist_free_full(sep->caps, g_free);
-	g_free(sep);
+	session->dc_timer = 0;
+
+	stream_setup = session->stream_setup;
+	session->stream_setup = FALSE;
+	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
+
+	if (dev && dev->sink && stream_setup)
+		sink_setup_stream(dev->sink, session);
+	else if (dev && dev->source && stream_setup)
+		source_setup_stream(dev->source, session);
+	else
+		connection_lost(session, ETIMEDOUT);
+
+	return FALSE;
 }
 
-void avdtp_unref(struct avdtp *session)
+static void set_disconnect_timer(struct avdtp *session)
 {
-	struct avdtp_server *server;
+	if (session->dc_timer)
+		remove_disconnect_timer(session);
 
-	if (!session)
+	if (session->device_disconnect) {
+		session->dc_timer = g_idle_add(disconnect_timeout, session);
 		return;
+	}
 
-	session->ref--;
+	session->dc_timer = g_timeout_add_seconds(DISCONNECT_TIMEOUT,
+						disconnect_timeout,
+						session);
+}
 
-	DBG("%p: ref=%d", session, session->ref);
+static void connection_lost(struct avdtp *session, int err)
+{
+	struct avdtp_server *server = session->server;
+	char address[18];
 
-	if (session->ref == 1) {
-		if (session->state == AVDTP_SESSION_STATE_CONNECTING &&
-								session->io) {
-			avdtp_cancel_authorization(session);
-			g_io_channel_shutdown(session->io, TRUE, NULL);
-			g_io_channel_unref(session->io);
-			session->io = NULL;
-			avdtp_set_state(session,
-					AVDTP_SESSION_STATE_DISCONNECTED);
-		}
+	ba2str(&session->dst, address);
+	DBG("Disconnected from %s", address);
 
-		if (session->io)
-			set_disconnect_timer(session);
-		else if (!session->free_lock) /* Drop the local ref if we
-						 aren't connected */
-			session->ref--;
-	}
+	if (err != EACCES)
+		avdtp_cancel_authorization(session);
 
-	if (session->ref > 0)
-		return;
+	g_slist_foreach(session->streams, (GFunc) release_stream, session);
+	session->streams = NULL;
 
-	server = session->server;
+	finalize_discovery(session, err);
 
-	DBG("%p: freeing session and removing from list", session);
+	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
 
-	if (session->dc_timer)
-		remove_disconnect_timer(session);
+	if (session->ref > 0)
+		return;
 
 	server->sessions = g_slist_remove(server->sessions, session);
+	avdtp_free(session);
+}
 
-	if (session->req)
-		pending_req_free(session->req);
+void avdtp_unref(struct avdtp *session)
+{
+	if (!session)
+		return;
 
-	g_slist_free_full(session->seps, sep_free);
+	session->ref--;
 
-	g_free(session->buf);
+	DBG("%p: ref=%d", session, session->ref);
 
-	g_free(session);
+	if (session->ref > 0)
+		return;
+
+	set_disconnect_timer(session);
 }
 
 struct avdtp *avdtp_ref(struct avdtp *session)
@@ -2231,12 +2210,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 			goto failed;
 		}
 
-		if (session->ref == 1 && !session->streams && !session->req)
-			set_disconnect_timer(session);
-
-		if (session->streams && session->dc_timer)
-			remove_disconnect_timer(session);
-
 		if (session->req && session->req->collided) {
 			DBG("Collision detected");
 			goto next;
@@ -2383,7 +2356,6 @@ static struct avdtp *avdtp_get_internal(const bdaddr_t *src, const bdaddr_t *dst
 
 	session->server = server;
 	bacpy(&session->dst, dst);
-	session->ref = 1;
 	/* We don't use avdtp_set_state() here since this isn't a state change
 	 * but just setting of the initial state */
 	session->state = AVDTP_SESSION_STATE_DISCONNECTED;
@@ -2578,7 +2550,6 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 							auth_cb, session);
 	if (session->auth_id == 0) {
 		avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
-		avdtp_unref(session);
 		goto drop;
 	}
 
@@ -3949,23 +3920,12 @@ proceed:
 void avdtp_exit(const bdaddr_t *src)
 {
 	struct avdtp_server *server;
-	GSList *l;
 
 	server = find_server(servers, src);
 	if (!server)
 		return;
 
-	l = server->sessions;
-	while (l) {
-		struct avdtp *session = l->data;
-
-		l = l->next;
-		/* value of l pointer should be updated before invoking
-		 * connection_lost since it internally uses avdtp_unref
-		 * which operates on server->session list as well
-		 */
-		connection_lost(session, -ECONNABORTED);
-	}
+	g_slist_free_full(server->sessions, avdtp_free);
 
 	servers = g_slist_remove(servers, server);
 
-- 
1.7.11.7

