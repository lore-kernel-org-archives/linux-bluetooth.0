Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] AVRCP: Add support for GetItemAttributes
Date: Fri, 15 Feb 2013 16:02:51 +0200
Message-Id: <1360936972-12952-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1360936972-12952-1-git-send-email-luiz.dentz@gmail.com>
References: <1360936972-12952-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GetItemAttributes should be used instead of GetElementAttributes if
browsing is supported.
---
 profiles/audio/avrcp.c | 112 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 83 insertions(+), 29 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 3b9aad6..9833a3a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -100,6 +100,7 @@
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 #define AVRCP_SET_BROWSED_PLAYER	0x70
+#define AVRCP_GET_ITEM_ATTRIBUTES	0x73
 #define AVRCP_GET_FOLDER_ITEMS		0x71
 #define AVRCP_GENERAL_REJECT		0xA0
 
@@ -1788,42 +1789,23 @@ static void avrcp_list_player_attributes(struct avrcp *session)
 					session);
 }
 
-static gboolean avrcp_get_attributes_rsp(struct avctp *conn,
-					uint8_t code, uint8_t subunit,
-					uint8_t *operands, size_t operand_count,
-					void *user_data)
+static void avrcp_parse_attribute_list(struct avrcp_player *player,
+					uint8_t *operands, uint8_t count)
 {
-	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
 	struct media_player *mp = player->user_data;
-	struct avrcp_header *pdu = (void *) operands;
-	uint8_t count;
 	int i;
 
-	if (code == AVC_CTYPE_REJECTED)
-		return FALSE;
-
-	count = pdu->params[0];
-
-	if (ntohs(pdu->params_len) - 1 < count * 8) {
-		error("Invalid parameters");
-		return FALSE;
-	}
-
-	for (i = 1; count > 0; count--) {
+	for (i = 0; count > 0; count--) {
 		uint32_t id;
 		uint16_t charset, len;
 
-		memcpy(&id, &pdu->params[i], sizeof(uint32_t));
-		id = ntohl(id);
+		id = bt_get_be32(&operands[i]);
 		i += sizeof(uint32_t);
 
-		memcpy(&charset, &pdu->params[i], sizeof(uint16_t));
-		charset = ntohs(charset);
+		charset = bt_get_be16(&operands[i]);
 		i += sizeof(uint16_t);
 
-		memcpy(&len, &pdu->params[i], sizeof(uint16_t));
-		len = ntohs(len);
+		len = bt_get_be16(&operands[i]);
 		i += sizeof(uint16_t);
 
 		if (charset == 106) {
@@ -1832,11 +1814,35 @@ static gboolean avrcp_get_attributes_rsp(struct avctp *conn,
 			if (key != NULL)
 				media_player_set_metadata(mp,
 							metadata_to_str(id),
-							&pdu->params[i], len);
+							&operands[i], len);
 		}
 
 		i += len;
 	}
+}
+
+static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
+						uint8_t code, uint8_t subunit,
+						uint8_t *operands,
+						size_t operand_count,
+						void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t count;
+
+	if (code == AVC_CTYPE_REJECTED)
+		return FALSE;
+
+	count = pdu->params[0];
+
+	if (ntohs(pdu->params_len) - 1 < count * 8) {
+		error("Invalid parameters");
+		return FALSE;
+	}
+
+	avrcp_parse_attribute_list(player, &pdu->params[1], count);
 
 	return FALSE;
 }
@@ -1858,7 +1864,7 @@ static void avrcp_get_element_attributes(struct avrcp *session)
 
 	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
 					AVC_SUBUNIT_PANEL, buf, length,
-					avrcp_get_attributes_rsp,
+					avrcp_get_element_attributes_rsp,
 					session);
 }
 
@@ -1977,6 +1983,48 @@ static void avrcp_set_browsed_player(struct avrcp *session,
 				avrcp_set_browsed_player_rsp, session);
 }
 
+static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
+						uint8_t *operands,
+						size_t operand_count,
+						void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct avrcp_browsing_header *pdu = (void *) operands;
+	uint8_t count;
+
+	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 4)
+		return FALSE;
+
+	count = pdu->params[1];
+
+	if (ntohs(pdu->param_len) - 1 < count * 8) {
+		error("Invalid parameters");
+		return FALSE;
+	}
+
+	avrcp_parse_attribute_list(player, &pdu->params[2], count);
+
+	return FALSE;
+}
+
+static void avrcp_get_item_attributes(struct avrcp *session, uint64_t uid)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 12];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_GET_ITEM_ATTRIBUTES;
+	pdu->params[0] = 0x03;
+	bt_put_be64(uid, &pdu->params[1]);
+	bt_put_be16(session->player->uid_counter, &pdu->params[9]);
+	pdu->param_len = htons(12);
+
+	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+				avrcp_get_item_attributes_rsp, session);
+}
+
 static void avrcp_player_parse_features(struct avrcp_player *player,
 							uint8_t *features)
 {
@@ -2122,9 +2170,15 @@ static void avrcp_status_changed(struct avrcp *session,
 static void avrcp_track_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
-	avrcp_get_element_attributes(session);
-	avrcp_get_play_status(session);
+	uint64_t uid;
+
+	if (session->browsing_id) {
+		uid = bt_get_be64(&pdu->params[1]);
+		avrcp_get_item_attributes(session, uid);
+	} else
+		avrcp_get_element_attributes(session);
 
+	avrcp_get_play_status(session);
 }
 
 static void avrcp_setting_changed(struct avrcp *session,
-- 
1.8.1.2

