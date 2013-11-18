Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] audio/AVDTP: Remove unused avdtp_set_device_disconnect
Date: Mon, 18 Nov 2013 13:50:15 +0200
Message-Id: <1384775415-10159-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384775415-10159-1-git-send-email-luiz.dentz@gmail.com>
References: <1384775415-10159-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avdtp.c | 13 -------------
 profiles/audio/avdtp.h |  2 --
 2 files changed, 15 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index de31e12..b7a7d9c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -394,9 +394,6 @@ struct avdtp {
 
 	avdtp_session_state_t state;
 
-	/* True if the entire device is being disconnected */
-	gboolean device_disconnect;
-
 	guint auth_id;
 
 	GIOChannel *io;
@@ -1200,11 +1197,6 @@ static void set_disconnect_timer(struct avdtp *session)
 	if (session->dc_timer)
 		remove_disconnect_timer(session);
 
-	if (session->device_disconnect) {
-		session->dc_timer = g_idle_add(disconnect_timeout, session);
-		return;
-	}
-
 	session->dc_timer = g_timeout_add_seconds(DISCONNECT_TIMEOUT,
 						disconnect_timeout,
 						session);
@@ -3841,11 +3833,6 @@ gboolean avdtp_has_stream(struct avdtp *session, struct avdtp_stream *stream)
 	return g_slist_find(session->streams, stream) ? TRUE : FALSE;
 }
 
-void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc)
-{
-	session->device_disconnect = dev_dc;
-}
-
 unsigned int avdtp_add_state_cb(struct btd_device *dev,
 				avdtp_session_state_cb cb, void *user_data)
 {
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 3c30d78..390c154 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -293,5 +293,3 @@ int avdtp_error_posix_errno(struct avdtp_error *err);
 
 struct btd_adapter *avdtp_get_adapter(struct avdtp *session);
 struct btd_device *avdtp_get_device(struct avdtp *session);
-
-void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc);
-- 
1.8.3.1

