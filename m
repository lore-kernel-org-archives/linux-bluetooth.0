Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/16] android/avrcp-lib: Fix not passing user data of passthrough callback
Date: Sun,  2 Mar 2014 20:48:20 +0200
Message-Id: <1393786109-6554-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 2 +-
 android/avrcp-lib.h | 2 +-
 unit/test-avrcp.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 7b89ee2..8854263 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -209,7 +209,7 @@ static bool handle_passthrough_pdu(struct avctp *conn, uint8_t op,
 	if (!pressed)
 		return true;
 
-	return handler->func(session);
+	return handler->func(session, session->passthrough_data);
 }
 
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index df9f1c6..430f545 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -86,7 +86,7 @@ struct avrcp_control_handler {
 
 struct avrcp_passthrough_handler {
 	uint8_t op;
-	bool (*func) (struct avrcp *session);
+	bool (*func) (struct avrcp *session, void *user_data);
 };
 
 typedef void (*avrcp_destroy_cb_t) (void *user_data);
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index d8484cd..ac267bb 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -257,28 +257,28 @@ static void execute_context(struct context *context)
 	destroy_context(context);
 }
 
-static bool handle_play(struct avrcp *session)
+static bool handle_play(struct avrcp *session, void *user_data)
 {
 	DBG("");
 
 	return true;
 }
 
-static bool handle_volume_up(struct avrcp *session)
+static bool handle_volume_up(struct avrcp *session, void *user_data)
 {
 	DBG("");
 
 	return true;
 }
 
-static bool handle_channel_up(struct avrcp *session)
+static bool handle_channel_up(struct avrcp *session, void *user_data)
 {
 	DBG("");
 
 	return true;
 }
 
-static bool handle_select(struct avrcp *session)
+static bool handle_select(struct avrcp *session, void *user_data)
 {
 	DBG("");
 
-- 
1.8.5.3

