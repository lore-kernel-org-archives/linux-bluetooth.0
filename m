Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/avrcp-lib: Fix destroy callback handling
Date: Sat,  1 Mar 2014 20:04:18 +0100
Message-Id: <1393700658-14323-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393700658-14323-1-git-send-email-szymon.janc@tieto.com>
References: <1393700658-14323-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AVRCP destroy callback was directly passed as AVCTP destroy callback
resulting in struct avrcp not being freed on remote disconnect.

This fix following Valgrind report:

931 (36 direct, 895 indirect) bytes in 1 blocks are definitely lost in
     loss record 53 of 55
   at 0x4896DC8: calloc (in /system/lib/valgrind/
     vgpreload_memcheck-arm-linux.so)
   by 0x48C5DB7: g_malloc0 (gmem.c:189)
   by 0x118671: avrcp_new (avrcp-lib.c:219)
   by 0x117D4F: connect_cb (avrcp.c:346)
   by 0x12068B: connect_cb (btio.c:232)
   by 0x48BD9C7: g_io_unix_dispatch (giounix.c:166)
   by 0x48C2CCB: g_main_context_dispatch (gmain.c:2539)
   by 0x48C2ED9: g_main_context_iterate.isra.19 (gmain.c:3146)
   by 0x48C3167: g_main_loop_run (gmain.c:3340)
   by 0x10BA03: main (main.c:490)
---
 android/avrcp-lib.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index feab303..bdc85ed 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -112,6 +112,9 @@ struct avrcp {
 	const struct avrcp_passthrough_handler *passthrough_handlers;
 	void *passthrough_data;
 	unsigned int passthrough_id;
+
+	avrcp_destroy_cb_t destroy;
+	void *destroy_data;
 };
 
 void avrcp_shutdown(struct avrcp *session)
@@ -126,6 +129,9 @@ void avrcp_shutdown(struct avrcp *session)
 		avctp_shutdown(session->conn);
 	}
 
+	if (session->destroy)
+		session->destroy(session->destroy_data);
+
 	g_free(session->tx_buf);
 	g_free(session);
 }
@@ -213,6 +219,15 @@ static bool handle_passthrough_pdu(struct avctp *conn, uint8_t op,
 	return handler->func(session);
 }
 
+static void disconnect_cb(void *data)
+{
+	struct avrcp *session = data;
+
+	session->conn = NULL;
+
+	avrcp_shutdown(session);
+}
+
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 {
 	struct avrcp *session;
@@ -237,13 +252,16 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 							handle_vendordep_pdu,
 							session);
 
+	avctp_set_destroy_cb(session->conn, disconnect_cb, session);
+
 	return session;
 }
 
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 							void *user_data)
 {
-	avctp_set_destroy_cb(session->conn, cb, user_data);
+	session->destroy = cb;
+	session->destroy_data = user_data;
 }
 
 void avrcp_set_control_handlers(struct avrcp *session,
-- 
1.8.5.3

