Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] audio/AVRCP: Connect browsing channel when accepting the connection
Date: Mon, 29 Jul 2013 17:04:36 +0300
Message-Id: <1375106679-14645-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
References: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If remote stack for some reason don't connect the browsing channel
connect it after a timeout (1 sec.)
---
 profiles/audio/avrcp.c | 56 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 32b9615..8c39d96 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -131,6 +131,8 @@
 
 #define AVRCP_CHARSET_UTF8		106
 
+#define AVRCP_BROWSING_TIMEOUT		1
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 struct avrcp_header {
@@ -228,6 +230,7 @@ struct avrcp {
 	unsigned int passthrough_id;
 	unsigned int control_id;
 	unsigned int browsing_id;
+	unsigned int browsing_timer;
 	uint16_t supported_events;
 	uint16_t registered_events;
 	uint8_t transaction;
@@ -3267,6 +3270,11 @@ static void destroy_browsing(void *data)
 
 static void session_init_browsing(struct avrcp *session)
 {
+	if (session->browsing_timer > 0) {
+		g_source_remove(session->browsing_timer);
+		session->browsing_timer = 0;
+	}
+
 	session->browsing_id = avctp_register_browsing_pdu_handler(
 							session->conn,
 							handle_browsing_pdu,
@@ -3298,6 +3306,35 @@ static struct avrcp_data *data_init(struct avrcp *session, const char *uuid)
 	return data;
 }
 
+static gboolean connect_browsing(gpointer user_data)
+{
+	struct avrcp *session = user_data;
+
+	session->browsing_timer = 0;
+
+	avctp_connect_browsing(session->conn);
+
+	return FALSE;
+}
+
+static void avrcp_connect_browsing(struct avrcp *session)
+{
+	/* Immediately connect browsing channel if initiator otherwise delay
+	 * it to avoid possible collisions
+	 */
+	if (avctp_is_initiator(session->conn)) {
+		avctp_connect_browsing(session->conn);
+		return;
+	}
+
+	if (session->browsing_timer > 0)
+		return;
+
+	session->browsing_timer = g_timeout_add_seconds(AVRCP_BROWSING_TIMEOUT,
+							connect_browsing,
+							session);
+}
+
 static void target_init(struct avrcp *session)
 {
 	struct avrcp_server *server = session->server;
@@ -3339,10 +3376,10 @@ static void target_init(struct avrcp *session)
 	if (session->controller == NULL)
 		avrcp_get_capabilities(session);
 
-	/* Auto-connect browsing channel only if initiator */
-	if (avctp_is_initiator(session->conn) &&
-				target->features & AVRCP_FEATURE_BROWSING)
-		avctp_connect_browsing(session->conn);
+	if (!(target->features & AVRCP_FEATURE_BROWSING))
+		return;
+
+	avrcp_connect_browsing(session);
 }
 
 static void controller_init(struct avrcp *session)
@@ -3382,10 +3419,10 @@ static void controller_init(struct avrcp *session)
 	if (controller->version < 0x0104)
 		return;
 
-	/* Auto-connect browsing channel only if initiator */
-	if (avctp_is_initiator(session->conn) &&
-				controller->features & AVRCP_FEATURE_BROWSING)
-		avctp_connect_browsing(session->conn);
+	if (!(controller->features & AVRCP_FEATURE_BROWSING))
+		return;
+
+	avrcp_connect_browsing(session);
 }
 
 static void session_init_control(struct avrcp *session)
@@ -3454,6 +3491,9 @@ static void session_destroy(struct avrcp *session)
 
 	server->sessions = g_slist_remove(server->sessions, session);
 
+	if (session->browsing_timer > 0)
+		g_source_remove(session->browsing_timer);
+
 	if (session->controller != NULL)
 		controller_destroy(session);
 
-- 
1.8.3.1

