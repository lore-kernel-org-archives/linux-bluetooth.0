Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] AVDTP: Remove auto_dc flag
Date: Fri, 29 Jun 2012 14:02:24 +0300
Message-Id: <1340967745-17458-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

auto_dc flag is no longer useful as all the users of it just reset it
to FALSE, also this was first introduced to maintain the stream for
some time as the clients disconnected frequently, but this is not the
case anymore.
---
 audio/avdtp.c  |   33 +--------------------------------
 audio/avdtp.h  |    1 -
 audio/sink.c   |    2 --
 audio/source.c |    2 --
 4 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 041abc3..ffc3f70 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -395,9 +395,6 @@ struct avdtp {
 
 	avdtp_session_state_t state;
 
-	/* True if the session should be automatically disconnected */
-	gboolean auto_dc;
-
 	/* True if the entire device is being disconnected */
 	gboolean device_disconnect;
 
@@ -805,19 +802,6 @@ static void stream_free(struct avdtp_stream *stream)
 	g_free(stream);
 }
 
-static gboolean stream_timeout(gpointer user_data)
-{
-	struct avdtp_stream *stream = user_data;
-	struct avdtp *session = stream->session;
-
-	if (avdtp_close(session, stream, FALSE) < 0)
-		error("stream_timeout: closing AVDTP stream failed");
-
-	stream->idle_timer = 0;
-
-	return FALSE;
-}
-
 static gboolean transport_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
@@ -1068,11 +1052,6 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		break;
 	case AVDTP_STATE_OPEN:
 		stream->starting = FALSE;
-		if ((old_state > AVDTP_STATE_OPEN && session->auto_dc) ||
-							stream->open_acp)
-			stream->idle_timer = g_timeout_add_seconds(STREAM_TIMEOUT,
-								stream_timeout,
-								stream);
 		break;
 	case AVDTP_STATE_STREAMING:
 		if (stream->idle_timer) {
@@ -1196,8 +1175,6 @@ static void connection_lost(struct avdtp *session, int err)
 	if (session->dc_timer)
 		remove_disconnect_timer(session);
 
-	session->auto_dc = TRUE;
-
 	if (session->ref != 1)
 		error("connection_lost: ref count not 1 after all callbacks");
 	else
@@ -2394,7 +2371,6 @@ static struct avdtp *avdtp_get_internal(const bdaddr_t *src, const bdaddr_t *dst
 	/* We don't use avdtp_set_state() here since this isn't a state change
 	 * but just setting of the initial state */
 	session->state = AVDTP_SESSION_STATE_DISCONNECTED;
-	session->auto_dc = TRUE;
 
 	session->version = get_version(session);
 
@@ -2467,10 +2443,8 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 						(GIOFunc) session_cb, session,
 						NULL);
 
-		if (session->stream_setup) {
+		if (session->stream_setup)
 			set_disconnect_timer(session);
-			avdtp_set_auto_disconnect(session, FALSE);
-		}
 	} else if (session->pending_open)
 		handle_transport_connect(session, chan, session->imtu,
 								session->omtu);
@@ -4008,11 +3982,6 @@ gboolean avdtp_has_stream(struct avdtp *session, struct avdtp_stream *stream)
 	return g_slist_find(session->streams, stream) ? TRUE : FALSE;
 }
 
-void avdtp_set_auto_disconnect(struct avdtp *session, gboolean auto_dc)
-{
-	session->auto_dc = auto_dc;
-}
-
 gboolean avdtp_stream_setup_active(struct avdtp *session)
 {
 	return session->stream_setup;
diff --git a/audio/avdtp.h b/audio/avdtp.h
index dac093b..e294ded 100644
--- a/audio/avdtp.h
+++ b/audio/avdtp.h
@@ -308,7 +308,6 @@ int avdtp_error_posix_errno(struct avdtp_error *err);
 
 void avdtp_get_peers(struct avdtp *session, bdaddr_t *src, bdaddr_t *dst);
 
-void avdtp_set_auto_disconnect(struct avdtp *session, gboolean auto_dc);
 gboolean avdtp_stream_setup_active(struct avdtp *session);
 void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc);
 
diff --git a/audio/sink.c b/audio/sink.c
index 6b21e47..8ba4e2a 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -415,8 +415,6 @@ gboolean sink_setup_stream(struct sink *sink, struct avdtp *session)
 	if (!sink->session)
 		return FALSE;
 
-	avdtp_set_auto_disconnect(sink->session, FALSE);
-
 	if (avdtp_discover(sink->session, discovery_complete, sink) < 0)
 		return FALSE;
 
diff --git a/audio/source.c b/audio/source.c
index dbba5b9..a5fa859 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -366,8 +366,6 @@ gboolean source_setup_stream(struct source *source, struct avdtp *session)
 	if (!source->session)
 		return FALSE;
 
-	avdtp_set_auto_disconnect(source->session, FALSE);
-
 	if (avdtp_discover(source->session, discovery_complete, source) < 0)
 		return FALSE;
 
-- 
1.7.10.2

