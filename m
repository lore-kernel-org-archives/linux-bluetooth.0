Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/16] android/avrcp-lib: Add pressed status to passthrough handler callback
Date: Sun,  2 Mar 2014 20:48:21 +0200
Message-Id: <1393786109-6554-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds pressed status to passthrough handler callback which is
required by Android HAL for certain keys such as fast forward and rewind.
---
 android/avrcp-lib.c |  6 +-----
 android/avrcp-lib.h |  2 +-
 unit/test-avrcp.c   | 10 ++++++----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 8854263..40ff7b3 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -205,11 +205,7 @@ static bool handle_passthrough_pdu(struct avctp *conn, uint8_t op,
 	if (handler->func == NULL)
 		return false;
 
-	/* Do not trigger handler on release */
-	if (!pressed)
-		return true;
-
-	return handler->func(session, session->passthrough_data);
+	return handler->func(session, pressed, session->passthrough_data);
 }
 
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 430f545..3df5897 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -86,7 +86,7 @@ struct avrcp_control_handler {
 
 struct avrcp_passthrough_handler {
 	uint8_t op;
-	bool (*func) (struct avrcp *session, void *user_data);
+	bool (*func) (struct avrcp *session, bool pressed, void *user_data);
 };
 
 typedef void (*avrcp_destroy_cb_t) (void *user_data);
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index ac267bb..0294973 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -257,28 +257,30 @@ static void execute_context(struct context *context)
 	destroy_context(context);
 }
 
-static bool handle_play(struct avrcp *session, void *user_data)
+static bool handle_play(struct avrcp *session, bool pressed, void *user_data)
 {
 	DBG("");
 
 	return true;
 }
 
-static bool handle_volume_up(struct avrcp *session, void *user_data)
+static bool handle_volume_up(struct avrcp *session, bool pressed,
+							void *user_data)
 {
 	DBG("");
 
 	return true;
 }
 
-static bool handle_channel_up(struct avrcp *session, void *user_data)
+static bool handle_channel_up(struct avrcp *session, bool pressed,
+							void *user_data)
 {
 	DBG("");
 
 	return true;
 }
 
-static bool handle_select(struct avrcp *session, void *user_data)
+static bool handle_select(struct avrcp *session, bool pressed, void *user_data)
 {
 	DBG("");
 
-- 
1.8.5.3

