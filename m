Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/16] AVRCP: Fix handling TG PDUs as they were CT PDUs
Date: Mon, 15 Oct 2012 16:05:32 +0200
Message-Id: <1350309936-31588-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

PDU handling needs to different depending on the acting role.
---
 audio/avrcp.c | 81 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 8abb426..85dd241 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -188,6 +188,10 @@ struct avrcp {
 	uint16_t version;
 	int features;
 
+	void (*init) (struct avrcp *session);
+
+	const struct control_pdu_handler *control_handlers;
+
 	unsigned int control_id;
 	unsigned int browsing_id;
 	uint16_t registered_events;
@@ -196,6 +200,13 @@ struct avrcp {
 	struct pending_pdu *pending_pdu;
 };
 
+struct control_pdu_handler {
+	uint8_t pdu_id;
+	uint8_t code;
+	uint8_t (*func) (struct avrcp *session, struct avrcp_header *pdu,
+							uint8_t transaction);
+};
+
 static GSList *servers = NULL;
 static unsigned int avctp_id = 0;
 
@@ -1128,12 +1139,7 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
-static struct control_pdu_handler {
-	uint8_t pdu_id;
-	uint8_t code;
-	uint8_t (*func) (struct avrcp *session, struct avrcp_header *pdu,
-							uint8_t transaction);
-} control_handlers[] = {
+static const struct control_pdu_handler tg_control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_capabilities },
 		{ AVRCP_LIST_PLAYER_ATTRIBUTES, AVC_CTYPE_STATUS,
@@ -1165,6 +1171,10 @@ static struct control_pdu_handler {
 		{ },
 };
 
+static const struct control_pdu_handler ct_control_handlers[] = {
+		{ },
+};
+
 /* handle vendordep pdu inside an avctp packet */
 static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
@@ -1172,7 +1182,7 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct control_pdu_handler *handler;
+	const struct control_pdu_handler *handler;
 	struct avrcp_header *pdu = (void *) operands;
 	uint32_t company_id = get_company_id(pdu->company_id);
 
@@ -1192,7 +1202,7 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 		goto err_metadata;
 	}
 
-	for (handler = control_handlers; handler->pdu_id; handler++) {
+	for (handler = session->control_handlers; handler->pdu_id; handler++) {
 		if (handler->pdu_id == pdu->pdu_id)
 			break;
 	}
@@ -1356,6 +1366,39 @@ static struct avrcp *find_session(GSList *list, struct audio_device *dev)
 	return NULL;
 }
 
+static void session_tg_init(struct avrcp *session)
+{
+	struct avrcp_server *server = session->server;
+
+	session->player = g_slist_nth_data(server->players, 0);
+	session->control_handlers = tg_control_handlers;
+
+	if (session->version >= 0x0104) {
+		register_volume_notification(session);
+		if (session->features & AVRCP_FEATURE_BROWSING)
+			avctp_connect_browsing(session->conn);
+	}
+
+	session->control_id = avctp_register_pdu_handler(session->conn,
+							AVC_OP_VENDORDEP,
+							handle_vendordep_pdu,
+							session);
+	session->browsing_id = avctp_register_browsing_pdu_handler(
+							session->conn,
+							handle_browsing_pdu,
+							session);
+}
+
+static void session_ct_init(struct avrcp *session)
+{
+	session->control_handlers = ct_control_handlers;
+
+	session->control_id = avctp_register_pdu_handler(session->conn,
+							AVC_OP_VENDORDEP,
+							handle_vendordep_pdu,
+							session);
+}
+
 static struct avrcp *session_create(struct avrcp_server *server,
 						struct audio_device *dev)
 {
@@ -1368,7 +1411,6 @@ static struct avrcp *session_create(struct avrcp_server *server,
 	session->server = server;
 	session->conn = avctp_connect(&dev->src, &dev->dst);
 	session->dev = dev;
-	session->player = g_slist_nth_data(server->players, 0);
 
 	server->sessions = g_slist_append(server->sessions, session);
 
@@ -1381,10 +1423,13 @@ static struct avrcp *session_create(struct avrcp_server *server,
 	else
 		session->target = FALSE;
 
-	if (session->target)
+	if (session->target) {
+		session->init = session_tg_init;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
-	else
+	} else {
+		session->init = session_ct_init;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
+	}
 
 	if (rec == NULL)
 		return session;
@@ -1451,20 +1496,8 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (session == NULL)
 			break;
 
-		if (session->version >= 0x0104) {
-			register_volume_notification(session);
-			if (session->features & AVRCP_FEATURE_BROWSING)
-				avctp_connect_browsing(session->conn);
-		}
+		session->init(session);
 
-		session->control_id = avctp_register_pdu_handler(session->conn,
-							AVC_OP_VENDORDEP,
-							handle_vendordep_pdu,
-							session);
-		session->browsing_id = avctp_register_browsing_pdu_handler(
-							session->conn,
-							handle_browsing_pdu,
-							session);
 	default:
 		return;
 	}
-- 
1.7.11.4

