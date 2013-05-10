Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] AVCTP: Don't allocate memory for every key pressed
Date: Fri, 10 May 2013 14:02:01 +0300
Message-Id: <1368183727-24461-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
References: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The timer field can be used to detect if the key is currectly active
instead of relying on a pointer that needs to be allocated for every
single key press.
---
 profiles/audio/avctp.c | 54 ++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 705bf71..4224a9c 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -195,7 +195,7 @@ struct avctp {
 	struct avctp_passthrough_handler *handler;
 
 	uint8_t key_quirks[256];
-	struct key_pressed *key;
+	struct key_pressed key;
 };
 
 struct avctp_passthrough_handler {
@@ -288,7 +288,6 @@ static size_t handle_panel_passthrough(struct avctp *session,
 					uint8_t *subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
 {
-	struct key_pressed *key = session->key;
 	struct avctp_passthrough_handler *handler = session->handler;
 	const char *status;
 	int pressed, i;
@@ -309,7 +308,7 @@ static size_t handle_panel_passthrough(struct avctp *session,
 		pressed = 1;
 	}
 
-	if (key == NULL && handler != NULL) {
+	if (session->key.timer == 0 && handler != NULL) {
 		if (handler->cb(session, operands[0] & 0x7F,
 						pressed, handler->user_data))
 			goto done;
@@ -337,15 +336,8 @@ static size_t handle_panel_passthrough(struct avctp *session,
 			break;
 		}
 
-		if (pressed) {
-			if (key == NULL)
-				key = g_new0(struct key_pressed, 1);
-			key->op = key_map[i].avc;
-			session->key = key;
-		} else if (key && key->op == key_map[i].avc) {
-			g_free(key);
-			session->key = NULL;
-		}
+		if (pressed)
+			session->key.op = key_map[i].avc;
 
 		send_key(session->uinput, key_map[i].uinput, pressed);
 		break;
@@ -482,11 +474,8 @@ static void avctp_disconnected(struct avctp *session)
 		session->auth_id = 0;
 	}
 
-	if (session->key != NULL) {
-		if (session->key->timer > 0)
-			g_source_remove(session->key->timer);
-		g_free(session->key);
-	}
+	if (session->key.timer > 0)
+		g_source_remove(session->key.timer);
 
 	if (session->uinput >= 0) {
 		char address[18];
@@ -1597,33 +1586,27 @@ static int avctp_passthrough_release(struct avctp *session, uint8_t op)
 static gboolean repeat_timeout(gpointer user_data)
 {
 	struct avctp *session = user_data;
-	struct key_pressed *key = session->key;
 
-	avctp_passthrough_release(session, key->op);
-	avctp_passthrough_press(session, key->op);
+	avctp_passthrough_release(session, session->key.op);
+	avctp_passthrough_press(session, session->key.op);
 
 	return TRUE;
 }
 
 static void release_pressed(struct avctp *session)
 {
-	struct key_pressed *key = session->key;
-
-	avctp_passthrough_release(session, key->op);
+	avctp_passthrough_release(session, session->key.op);
 
-	if (key->timer > 0)
-		g_source_remove(key->timer);
+	if (session->key.timer > 0)
+		g_source_remove(session->key.timer);
 
-	g_free(key);
-	session->key = NULL;
+	session->key.timer = 0;
 }
 
 static bool set_pressed(struct avctp *session, uint8_t op)
 {
-	struct key_pressed *key;
-
-	if (session->key != NULL) {
-		if (session->key->op == op)
+	if (session->key.timer > 0) {
+		if (session->key.op == op)
 			return TRUE;
 		release_pressed(session);
 	}
@@ -1631,11 +1614,8 @@ static bool set_pressed(struct avctp *session, uint8_t op)
 	if (op != AVC_FAST_FORWARD && op != AVC_REWIND)
 		return FALSE;
 
-	key = g_new0(struct key_pressed, 1);
-	key->op = op;
-	key->timer = g_timeout_add_seconds(2, repeat_timeout, session);
-
-	session->key = key;
+	session->key.op = op;
+	session->key.timer = g_timeout_add_seconds(2, repeat_timeout, session);
 
 	return TRUE;
 }
@@ -1658,7 +1638,7 @@ static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
 int avctp_send_passthrough(struct avctp *session, uint8_t op)
 {
 	/* Auto release if key pressed */
-	if (session->key != NULL)
+	if (session->key.timer > 0)
 		release_pressed(session);
 
 	return avctp_passthrough_press(session, op);
-- 
1.8.1.4

