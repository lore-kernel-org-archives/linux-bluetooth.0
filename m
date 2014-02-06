Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/6] android/a2dp: Close AVDTP gracefully
Date: Thu, 6 Feb 2014 18:54:05 +0100
Message-ID: <1391709250-8047-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When closing AVDTP we should wait for for CLOSE request to complete
(so stream go to idle state) before disconnecting signalling socket.
In case CLOSE is rejected, we simply abort stream.
---
 android/a2dp.c  |  4 +++-
 android/avdtp.c | 21 +++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 8cff535..8d6e7bf 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1166,8 +1166,10 @@ static void sep_close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	DBG("");
 
-	if (err)
+	if (err) {
+		avdtp_abort(session, stream);
 		return;
+	}
 
 	setup_remove_by_id(endpoint->id);
 }
diff --git a/android/avdtp.c b/android/avdtp.c
index e26d6ec..b9d1992 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -398,6 +398,8 @@ struct avdtp {
 	struct pending_req *req;
 
 	GSList *disconnect;
+
+	bool shutdown;
 };
 
 static GSList *lseps = NULL;
@@ -913,6 +915,11 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		session->streams = g_slist_remove(session->streams, stream);
 		stream_free(stream);
 	}
+
+	if (session->io && session->shutdown && session->streams == NULL) {
+		int sock = g_io_channel_unix_get_fd(session->io);
+		shutdown(sock, SHUT_RDWR);
+	}
 }
 
 static void finalize_discovery(struct avdtp *session, int err)
@@ -2141,7 +2148,7 @@ gboolean avdtp_remove_disconnect_cb(struct avdtp *session, unsigned int id)
 void avdtp_shutdown(struct avdtp *session)
 {
 	GSList *l;
-	int sock;
+	bool closing = false;
 
 	if (!session->io)
 		return;
@@ -2149,12 +2156,18 @@ void avdtp_shutdown(struct avdtp *session)
 	for (l = session->streams; l; l = g_slist_next(l)) {
 		struct avdtp_stream *stream = l->data;
 
-		avdtp_close(session, stream, TRUE);
+		if (avdtp_close(session, stream, TRUE) == 0)
+			closing = true;
 	}
 
-	sock = g_io_channel_unix_get_fd(session->io);
+	if (closing) {
+		/* defer shutdown until all streams closed */
+		session->shutdown = true;
+	} else {
+		int sock = g_io_channel_unix_get_fd(session->io);
 
-	shutdown(sock, SHUT_RDWR);
+		shutdown(sock, SHUT_RDWR);
+	}
 }
 
 static void queue_request(struct avdtp *session, struct pending_req *req,
-- 
1.8.5.3

