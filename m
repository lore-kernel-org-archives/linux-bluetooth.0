Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/16] AVRCP: Add proper role init procedure
Date: Mon, 15 Oct 2012 16:05:33 +0200
Message-Id: <1350309936-31588-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/avrcp.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 10 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 85dd241..8336831 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -104,6 +104,7 @@
 #define CAP_EVENTS_SUPPORTED	0x03
 
 #define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
+#define AVRCP_GET_CAPABILITIES_PARAM_LENGTH 1
 
 #define AVRCP_FEATURE_CATEGORY_1	0x0001
 #define AVRCP_FEATURE_CATEGORY_2	0x0002
@@ -215,7 +216,7 @@ static uint32_t company_ids[] = {
 	IEEEID_BTSIG,
 };
 
-static void register_volume_notification(struct avrcp *session);
+static void register_notification(struct avrcp *session, uint8_t event);
 
 static sdp_record_t *avrcp_ct_record(void)
 {
@@ -1306,7 +1307,7 @@ static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
 	return NULL;
 }
 
-static gboolean avrcp_handle_volume_changed(struct avctp *conn,
+static gboolean avrcp_handle_event(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
@@ -1314,26 +1315,34 @@ static gboolean avrcp_handle_volume_changed(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu = (void *) operands;
+	uint8_t event;
 	uint8_t volume;
 
 	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
 		return FALSE;
 
-	volume = pdu->params[1] & 0x7F;
+	event = pdu->params[0];
 
-	if (player)
-		player->cb->set_volume(volume, session->dev,
+	switch (event) {
+	case AVRCP_EVENT_VOLUME_CHANGED:
+		volume = pdu->params[1] & 0x7F;
+
+		if (player)
+			player->cb->set_volume(volume, session->dev,
 							player->user_data);
 
+		break;
+	}
+
 	if (code == AVC_CTYPE_CHANGED) {
-		register_volume_notification(session);
+		register_notification(session, event);
 		return FALSE;
 	}
 
 	return TRUE;
 }
 
-static void register_volume_notification(struct avrcp *session)
+static void register_notification(struct avrcp *session, uint8_t event)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
 	struct avrcp_header *pdu = (void *) buf;
@@ -1344,14 +1353,89 @@ static void register_volume_notification(struct avrcp *session)
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
 	pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
-	pdu->params[0] = AVRCP_EVENT_VOLUME_CHANGED;
+	pdu->params[0] = event;
 	pdu->params_len = htons(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
 
 	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_NOTIFY,
 					AVC_SUBUNIT_PANEL, buf, length,
-					avrcp_handle_volume_changed, session);
+					avrcp_handle_event, session);
+}
+
+static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t count;
+
+	if (pdu->params[0] != CAP_EVENTS_SUPPORTED)
+		return FALSE;
+
+	count = pdu->params[1];
+
+	for (; count > 0; count--) {
+		uint8_t event = pdu->params[1 + count];
+
+		switch (event) {
+		case AVRCP_EVENT_STATUS_CHANGED:
+		case AVRCP_EVENT_TRACK_CHANGED:
+			register_notification(session, event);
+			break;
+		}
+	}
+
+	return FALSE;
+}
+
+static void avrcp_get_capabilities(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_GET_CAPABILITIES_PARAM_LENGTH];
+	struct avrcp_header *pdu = (void *) buf;
+	uint8_t length;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_GET_CAPABILITIES;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params[0] = CAP_EVENTS_SUPPORTED;
+	pdu->params_len = htons(AVRCP_GET_CAPABILITIES_PARAM_LENGTH);
+
+	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, length,
+					avrcp_get_capabilities_resp,
+					session);
+}
+
+static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	return FALSE;
+}
+
+static void avrcp_get_play_status(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH];
+	struct avrcp_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_GET_PLAY_STATUS;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					avrcp_get_play_status_rsp,
+					session);
 }
 
 static struct avrcp *find_session(GSList *list, struct audio_device *dev)
@@ -1370,11 +1454,13 @@ static void session_tg_init(struct avrcp *session)
 {
 	struct avrcp_server *server = session->server;
 
+	DBG("%p version 0x%04x", session, session->version);
+
 	session->player = g_slist_nth_data(server->players, 0);
 	session->control_handlers = tg_control_handlers;
 
 	if (session->version >= 0x0104) {
-		register_volume_notification(session);
+		register_notification(session, AVRCP_EVENT_VOLUME_CHANGED);
 		if (session->features & AVRCP_FEATURE_BROWSING)
 			avctp_connect_browsing(session->conn);
 	}
@@ -1393,6 +1479,13 @@ static void session_ct_init(struct avrcp *session)
 {
 	session->control_handlers = ct_control_handlers;
 
+	DBG("%p version 0x%04x", session, session->version);
+
+	if (session->version >= 0x0103) {
+		avrcp_get_capabilities(session);
+		avrcp_get_play_status(session);
+	}
+
 	session->control_id = avctp_register_pdu_handler(session->conn,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
-- 
1.7.11.4

