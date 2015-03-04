Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio: Remove unused API
Date: Wed,  4 Mar 2015 15:46:51 +0200
Message-Id: <1425476811-25651-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1425476811-25651-1-git-send-email-luiz.dentz@gmail.com>
References: <1425476811-25651-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avdtp.c | 59 ++------------------------------------------------
 profiles/audio/avdtp.h |  6 -----
 2 files changed, 2 insertions(+), 63 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index acec28d..4be2d25 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -388,8 +388,6 @@ struct avdtp {
 
 	avdtp_session_state_t state;
 
-	guint auth_id;
-
 	GIOChannel *io;
 	guint io_id;
 
@@ -1053,25 +1051,6 @@ static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
 }
 
-static int avdtp_cancel_authorization(struct avdtp *session)
-{
-	int err;
-
-	if (session->state != AVDTP_SESSION_STATE_CONNECTING)
-		return 0;
-
-	if (session->auth_id == 0)
-		return 0;
-
-	err = btd_cancel_authorization(session->auth_id);
-	if (err < 0)
-		return err;
-
-	session->auth_id = 0;
-
-	return 0;
-}
-
 static void sep_free(gpointer data)
 {
 	struct avdtp_remote_sep *sep = data;
@@ -1087,7 +1066,7 @@ static void remove_disconnect_timer(struct avdtp *session)
 	session->stream_setup = FALSE;
 }
 
-void avdtp_free(void *data)
+static void avdtp_free(void *data)
 {
 	struct avdtp *session = data;
 
@@ -1121,16 +1100,13 @@ void avdtp_free(void *data)
 	g_free(session);
 }
 
-void connection_lost(struct avdtp *session, int err)
+static void connection_lost(struct avdtp *session, int err)
 {
 	char address[18];
 
 	ba2str(device_get_address(session->device), address);
 	DBG("Disconnected from %s", address);
 
-	if (err != EACCES)
-		avdtp_cancel_authorization(session);
-
 	g_slist_foreach(session->streams, (GFunc) release_stream, session);
 	session->streams = NULL;
 
@@ -2389,20 +2365,6 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 	return session;
 }
 
-bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
-					const bdaddr_t *dst, service_auth_cb cb)
-{
-	session->auth_id = btd_request_authorization(src, dst,
-							ADVANCED_AUDIO_UUID,
-							cb, session);
-	if (session->auth_id == 0) {
-		avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
-		return false;
-	}
-
-	return true;
-}
-
 static GIOChannel *l2cap_connect(struct avdtp *session)
 {
 	GError *err = NULL;
@@ -3552,23 +3514,6 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
-void avdtp_accept(struct avdtp *session)
-{
-	GError *err = NULL;
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
 struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 						uint8_t media_type,
 						uint8_t codec_type,
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index e10805c..1b02232 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -297,9 +297,3 @@ struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep);
 
 struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 							struct queue *lseps);
-void avdtp_free(void *data);
-void connection_lost(struct avdtp *session, int err);
-void avdtp_accept(struct avdtp *session);
-bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
-							const bdaddr_t *dst,
-							service_auth_cb cb);
-- 
2.1.0

