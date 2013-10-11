Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] audio/AVCTP: Fix crash after disconnecting
Date: Fri, 11 Oct 2013 14:42:41 +0300
Message-Id: <1381491762-25395-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

  at 0x414C08: finalize_discovery (avdtp.c:1050)
  by 0x414C5A: process_discover (avdtp.c:3346)
  by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
  by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
  by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
  by 0x40A3B6: main (main.c:595)
Address 0x5e25de8 is 1,144 bytes inside a block of size 1,176 free'd
at 0x4A074C4: free (in
/usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
  by 0x3D4604D9AE: g_free (in /usr/lib64/libglib-2.0.so.0.3600.3)
  by 0x4152F2: connection_lost (avdtp.c:1206)
  by 0x4162C4: cancel_request (avdtp.c:2662)
  by 0x4164BD: request_timeout (avdtp.c:2672)
  by 0x3D46048962: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
  by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
  by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
  by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
  by 0x40A3B6: main (main.c:595)
---
 profiles/audio/avdtp.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 622dff8..b938ee7 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -354,6 +354,12 @@ struct avdtp_state_callback {
 	void *user_data;
 };
 
+struct discover_callback {
+	unsigned int id;
+	avdtp_discover_cb_t cb;
+	void *user_data;
+};
+
 struct avdtp_stream {
 	GIOChannel *io;
 	uint16_t imtu;
@@ -412,9 +418,7 @@ struct avdtp {
 
 	char *buf;
 
-	avdtp_discover_cb_t discov_cb;
-	void *user_data;
-
+	struct discover_callback *discover;
 	struct pending_req *req;
 
 	guint dc_timer;
@@ -1041,19 +1045,21 @@ static void avdtp_sep_set_state(struct avdtp *session,
 
 static void finalize_discovery(struct avdtp *session, int err)
 {
+	struct discover_callback *discover = session->discover;
 	struct avdtp_error avdtp_err;
 
-	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, err);
-
-	if (!session->discov_cb)
+	if (!discover)
 		return;
 
-	session->discov_cb(session, session->seps,
-				err ? &avdtp_err : NULL,
-				session->user_data);
+	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, err);
 
-	session->discov_cb = NULL;
-	session->user_data = NULL;
+	if (discover->id > 0)
+		g_source_remove(discover->id);
+
+	discover->cb(session, session->seps, err ? &avdtp_err : NULL,
+							discover->user_data);
+	g_free(discover);
+	session->discover = NULL;
 }
 
 static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
@@ -3332,20 +3338,22 @@ int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
 {
 	int err;
 
-	if (session->discov_cb)
+	if (session->discover)
 		return -EBUSY;
 
+	session->discover = g_new0(struct discover_callback, 1);
+
 	if (session->seps) {
-		session->discov_cb = cb;
-		session->user_data = user_data;
-		g_idle_add(process_discover, session);
+		session->discover->cb = cb;
+		session->discover->user_data = user_data;
+		session->discover->id = g_idle_add(process_discover, session);
 		return 0;
 	}
 
 	err = send_request(session, FALSE, NULL, AVDTP_DISCOVER, NULL, 0);
 	if (err == 0) {
-		session->discov_cb = cb;
-		session->user_data = user_data;
+		session->discover->cb = cb;
+		session->discover->user_data = user_data;
 	}
 
 	return err;
-- 
1.8.3.1

