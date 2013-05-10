Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] AVCTP: Add timeout for pass-through commands with value pressed
Date: Fri, 10 May 2013 14:02:02 +0300
Message-Id: <1368183727-24461-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
References: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

>From AV/C spec 1.23, page 76:

"A command with the pressed value is valid for two seconds from the time
when a target sends back a response of the command. The controller shall
continue sending pressed value with identical operation id value in the
operation_id field while the command is wished to stay valid. Either if
the target has not received the pressed command within two seconds or the
target receives the pressed command with another operation id, then the
target regards that the released command was sent but missed to receive."
---
 profiles/audio/avctp.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 4224a9c..6372709 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -58,6 +58,11 @@
 #include "avctp.h"
 #include "avrcp.h"
 
+/* AV/C Panel 1.23, page 76:
+ * command with the pressed value is valid for two seconds
+ */
+#define AVC_PRESS_TIMEOUT	2
+
 #define QUIRK_NO_RELEASE 1 << 0
 
 /* Message types */
@@ -283,6 +288,19 @@ static void send_key(int fd, uint16_t key, int pressed)
 	send_event(fd, EV_SYN, SYN_REPORT, 0);
 }
 
+static gboolean auto_release(gpointer user_data)
+{
+	struct avctp *session = user_data;
+
+	session->key.timer = 0;
+
+	DBG("AV/C: key press timeout");
+
+	send_key(session->uinput, session->key.op, 0);
+
+	return FALSE;
+}
+
 static size_t handle_panel_passthrough(struct avctp *session,
 					uint8_t transaction, uint8_t *code,
 					uint8_t *subunit, uint8_t *operands,
@@ -336,8 +354,21 @@ static size_t handle_panel_passthrough(struct avctp *session,
 			break;
 		}
 
-		if (pressed)
-			session->key.op = key_map[i].avc;
+		if (pressed) {
+			if (session->key.timer > 0) {
+				g_source_remove(session->key.timer);
+				send_key(session->uinput, session->key.op, 0);
+			}
+
+			session->key.op = key_map[i].uinput;
+			session->key.timer = g_timeout_add_seconds(
+							AVC_PRESS_TIMEOUT,
+							auto_release,
+							session);
+		} else if (session->key.timer > 0) {
+			g_source_remove(session->key.timer);
+			session->key.timer = 0;
+		}
 
 		send_key(session->uinput, key_map[i].uinput, pressed);
 		break;
@@ -1615,7 +1646,9 @@ static bool set_pressed(struct avctp *session, uint8_t op)
 		return FALSE;
 
 	session->key.op = op;
-	session->key.timer = g_timeout_add_seconds(2, repeat_timeout, session);
+	session->key.timer = g_timeout_add_seconds(AVC_PRESS_TIMEOUT,
+							repeat_timeout,
+							session);
 
 	return TRUE;
 }
-- 
1.8.1.4

