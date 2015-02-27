Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 18/20] audio/avdtp: Remove disconnect timer code
Date: Fri, 27 Feb 2015 17:03:06 +0200
Message-Id: <1425049388-18333-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

disconnect timer code setup streams instead of disconnecting as it
mentioned in the related comment. That does not look very right thing to
do in this situation and this is not used in android code. Removing it
simplifies avdtp code a lot and makes it easily to merge with android
code base.
---
 profiles/audio/avdtp.c | 67 +-------------------------------------------------
 1 file changed, 1 insertion(+), 66 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index c0ded8d..25de5b3 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -425,11 +425,6 @@ struct avdtp {
 	struct pending_req *req;
 
 	GSList *disconnect;
-
-	guint dc_timer;
-
-	/* Attempt stream setup instead of disconnecting */
-	gboolean stream_setup;
 };
 
 static GSList *state_callbacks = NULL;
@@ -1098,13 +1093,6 @@ static void sep_free(gpointer data)
 	g_free(sep);
 }
 
-static void remove_disconnect_timer(struct avdtp *session)
-{
-	g_source_remove(session->dc_timer);
-	session->dc_timer = 0;
-	session->stream_setup = FALSE;
-}
-
 void avdtp_free(void *data)
 {
 	struct avdtp *session = data;
@@ -1123,9 +1111,6 @@ void avdtp_free(void *data)
 		session->io_id = 0;
 	}
 
-	if (session->dc_timer)
-		remove_disconnect_timer(session);
-
 	if (session->req)
 		pending_req_free(session->req);
 
@@ -1173,44 +1158,6 @@ void connection_lost(struct avdtp *session, int err)
 	avdtp_free(session);
 }
 
-static gboolean disconnect_timeout(gpointer user_data)
-{
-	struct avdtp *session = user_data;
-	struct btd_service *service;
-	gboolean stream_setup;
-
-	session->dc_timer = 0;
-
-	stream_setup = session->stream_setup;
-	session->stream_setup = FALSE;
-
-	service = btd_device_get_service(session->device, A2DP_SINK_UUID);
-	if (service && stream_setup) {
-		sink_setup_stream(service, session);
-		return FALSE;
-	}
-
-	service = btd_device_get_service(session->device, A2DP_SOURCE_UUID);
-	if (service && stream_setup) {
-		source_setup_stream(service, session);
-		return FALSE;
-	}
-
-	connection_lost(session, ETIMEDOUT);
-
-	return FALSE;
-}
-
-static void set_disconnect_timer(struct avdtp *session)
-{
-	if (session->dc_timer)
-		remove_disconnect_timer(session);
-
-	session->dc_timer = g_timeout_add_seconds(DISCONNECT_TIMEOUT,
-						disconnect_timeout,
-						session);
-}
-
 void avdtp_unref(struct avdtp *session)
 {
 	if (!session)
@@ -1224,8 +1171,6 @@ void avdtp_unref(struct avdtp *session)
 		return;
 
 	finalize_discovery(session, ECONNABORTED);
-
-	set_disconnect_timer(session);
 }
 
 struct avdtp *avdtp_ref(struct avdtp *session)
@@ -1233,8 +1178,7 @@ struct avdtp *avdtp_ref(struct avdtp *session)
 	session->ref++;
 
 	DBG("%p: ref=%d", session, session->ref);
-	if (session->dc_timer)
-		remove_disconnect_timer(session);
+
 	return session;
 }
 
@@ -2375,9 +2319,6 @@ bool avdtp_set_control(struct avdtp *session, int fd, size_t imtu, size_t omtu)
 						(GIOFunc) session_cb, session,
 						NULL);
 
-	if (session->stream_setup)
-		set_disconnect_timer(session);
-
 	process_queue(session);
 
 	return true;
@@ -2448,8 +2389,6 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 						(GIOFunc) session_cb, session,
 						NULL);
 
-		if (session->stream_setup)
-			set_disconnect_timer(session);
 	} else if (session->pending_open)
 		handle_transport_connect(session, chan, session->imtu,
 								session->omtu);
@@ -3773,10 +3712,6 @@ void avdtp_accept(struct avdtp *session, BtIOConnect cb)
 		g_error_free(err);
 		return;
 	}
-
-	/* This is so that connect_cb will know to do the right thing
-	 * with respect to the disconnect timer */
-	session->stream_setup = TRUE;
 }
 
 struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
-- 
2.1.0

