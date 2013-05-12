Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] AVRCP: Fix crash when no A2DP role is detected
Date: Sun, 12 May 2013 09:59:12 +0300
Message-Id: <1368341952-5666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid read of size 4
   at 0x468370: btd_service_connecting_complete (service.c:315)
   by 0x41B70F: session_ct_init_control (avrcp.c:2790)
   by 0x41B1E0: state_changed (avrcp.c:2933)
   by 0x418054: avctp_set_state (avctp.c:548)
   by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
   by 0x44F989: accept_cb (btio.c:201)
   by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x40A8EE: main (main.c:583)
 Address 0x20 is not stack'd, malloc'd or (recently) free'd

 If no A2DP is found assume the controller is the initiator.
---
 profiles/audio/avctp.c | 7 +++++++
 profiles/audio/avctp.h | 1 +
 profiles/audio/avrcp.c | 7 ++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index db03456..314dbfb 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -201,6 +201,7 @@ struct avctp {
 
 	uint8_t key_quirks[256];
 	struct key_pressed key;
+	bool initiator;
 };
 
 struct avctp_passthrough_handler {
@@ -1931,6 +1932,7 @@ struct avctp *avctp_connect(struct audio_device *device)
 	}
 
 	session->control = avctp_channel_create(session, io, NULL);
+	session->initiator = true;
 	g_io_channel_unref(io);
 
 	return session;
@@ -1983,3 +1985,8 @@ struct avctp *avctp_get(struct audio_device *device)
 {
 	return avctp_get_internal(device->btd_dev);
 }
+
+bool avctp_is_initiator(struct avctp *session)
+{
+	return session->initiator;
+}
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 0a414af..cd575cc 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -120,6 +120,7 @@ void avctp_unregister(struct btd_adapter *adapter);
 
 struct avctp *avctp_connect(struct audio_device *device);
 struct avctp *avctp_get(struct audio_device *device);
+bool avctp_is_initiator(struct avctp *session);
 int avctp_connect_browsing(struct avctp *session);
 void avctp_disconnect(struct avctp *session);
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4acf396..4558407 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2863,7 +2863,12 @@ static struct avrcp *session_create(struct avrcp_server *server,
 
 	server->sessions = g_slist_append(server->sessions, session);
 
-	if (dev->sink && !dev->source)
+	/* If sink and source are not supported assume the controller must
+	 * be the initiator
+	 */
+	if (dev->sink == NULL && dev->source == NULL)
+		session->target = !avctp_is_initiator(session->conn);
+	else if (dev->sink && !dev->source)
 		session->target = TRUE;
 	else if (dev->source && !dev->sink)
 		session->target = FALSE;
-- 
1.8.1.4

