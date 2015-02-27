Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 20/20] audio/avdtp: Refactor freeing avdtp session
Date: Fri, 27 Feb 2015 17:03:08 +0200
Message-Id: <1425049388-18333-21-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avdtp.c | 43 +++++++++++++++++++++++++++++++++++++++----
 profiles/audio/avdtp.h |  2 ++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 25de5b3..1e3e817 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -425,6 +425,8 @@ struct avdtp {
 	struct pending_req *req;
 
 	GSList *disconnect;
+
+	bool shutdown;
 };
 
 static GSList *state_callbacks = NULL;
@@ -1031,6 +1033,11 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		DBG("stream %p removed from session %p", stream, session);
 		stream_free(stream);
 	}
+
+	if (session->io && session->shutdown && session->streams == NULL) {
+		int sock = g_io_channel_unix_get_fd(session->io);
+		shutdown(sock, SHUT_RDWR);
+	}
 }
 
 static void finalize_discovery(struct avdtp *session, int err)
@@ -1144,6 +1151,8 @@ void connection_lost(struct avdtp *session, int err)
 	g_slist_foreach(session->streams, (GFunc) release_stream, session);
 	session->streams = NULL;
 
+	avdtp_ref(session);
+
 	finalize_discovery(session, err);
 
 	g_slist_free_full(session->disconnect, process_disconnect);
@@ -1151,11 +1160,9 @@ void connection_lost(struct avdtp *session, int err)
 
 	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
 
-	if (session->ref > 0)
-		return;
-
 	avdtp_server_remove_session(session->server, session);
-	avdtp_free(session);
+
+	avdtp_unref(session);
 }
 
 void avdtp_unref(struct avdtp *session)
@@ -1171,6 +1178,8 @@ void avdtp_unref(struct avdtp *session)
 		return;
 
 	finalize_discovery(session, ECONNABORTED);
+
+	avdtp_free(session);
 }
 
 struct avdtp *avdtp_ref(struct avdtp *session)
@@ -2527,6 +2536,32 @@ gboolean avdtp_remove_disconnect_cb(struct avdtp *session, unsigned int id)
 	return FALSE;
 }
 
+void avdtp_shutdown(struct avdtp *session)
+{
+	GSList *l;
+	bool aborting = false;
+
+	if (!session->io)
+		return;
+
+	for (l = session->streams; l; l = g_slist_next(l)) {
+		struct avdtp_stream *stream = l->data;
+
+		if (stream->abort_int ||
+					avdtp_close(session, stream, TRUE) == 0)
+			aborting = true;
+	}
+
+	if (aborting) {
+		/* defer shutdown until all streams are aborted properly */
+		session->shutdown = true;
+	} else {
+		int sock = g_io_channel_unix_get_fd(session->io);
+
+		shutdown(sock, SHUT_RDWR);
+	}
+}
+
 static void queue_request(struct avdtp *session, struct pending_req *req,
 			gboolean priority)
 {
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 0fc8fe2..2fc471e 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -220,6 +220,8 @@ unsigned int avdtp_add_disconnect_cb(struct avdtp *session,
 						void *user_data);
 gboolean avdtp_remove_disconnect_cb(struct avdtp *session, unsigned int id);
 
+void avdtp_shutdown(struct avdtp *session);
+
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
-- 
2.1.0

