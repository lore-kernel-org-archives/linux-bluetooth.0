Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  1/2] audio/avrcp: Add support for SetAddressedPlayer
Date: Mon, 10 Aug 2015 16:37:40 +0530
Message-id: <1439204861-4716-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Supprot added to handle SetAddressedPlayer(0x60) command PDU
in AVRCP TG.

  AVCTP Control: Command: type 0x00 label 12 PID 0x110e
    AV/C: Control: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: SetAddressedPlayer pt Single len 0x0002
        PlayerID: 0xffff (65535)

  AVCTP Control: Response: type 0x00 label 12 PID 0x110e
    AV/C: Rejected: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: SetAddressedPlayer pt Single len 0x0001
        Error: 0x11 (Invalid Player ID)
---
 profiles/audio/avrcp.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d66f670..003e978 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -103,6 +103,7 @@
 #define AVRCP_REQUEST_CONTINUING	0x40
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
+#define AVRCP_SET_ADDRESSED_PLAYER	0x60
 #define AVRCP_SET_BROWSED_PLAYER	0x70
 #define AVRCP_GET_FOLDER_ITEMS		0x71
 #define AVRCP_CHANGE_PATH		0x72
@@ -204,6 +205,7 @@ struct avrcp_player {
 	uint64_t uid;
 	uint16_t uid_counter;
 	bool browsed;
+	bool addressed;
 	uint8_t *features;
 	char *path;
 
@@ -1617,6 +1619,57 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static struct avrcp_player *find_tg_player(struct avrcp *session, uint16_t id)
+{
+	struct avrcp_server *server = session->server;
+	GSList *l;
+
+	for (l = server->players; l; l = l->next) {
+		struct avrcp_player *player = l->data;
+
+		if (player->id == id)
+			return player;
+	}
+
+	return NULL;
+}
+
+static uint8_t avrcp_handle_set_addressed_player(struct avrcp *session,
+						struct avrcp_header *pdu,
+						uint8_t transaction)
+{
+	struct avrcp_player *player;
+	uint16_t len = ntohs(pdu->params_len);
+	uint16_t player_id = 0;
+	uint8_t status;
+
+	if (len < 1) {
+		status = AVRCP_STATUS_INVALID_PARAM;
+		goto err;
+	}
+
+	player_id = ntohs(pdu->params);
+	player = find_tg_player(session, player_id);
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	if (player) {
+		player->addressed = true;
+		status = AVRCP_STATUS_SUCCESS;
+		pdu->params_len = htons(len);
+		pdu->params[0] = status;
+	} else {
+		status = AVRCP_STATUS_INVALID_PLAYER_ID;
+		goto err;
+	}
+
+	return AVC_CTYPE_ACCEPTED;
+
+err:
+	pdu->params_len = htons(sizeof(status));
+	pdu->params[0] = status;
+	return AVC_CTYPE_REJECTED;
+}
+
 static const struct control_pdu_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_capabilities },
@@ -1648,6 +1701,8 @@ static const struct control_pdu_handler control_handlers[] = {
 					avrcp_handle_request_continuing },
 		{ AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
 					avrcp_handle_abort_continuing },
+		{ AVRCP_SET_ADDRESSED_PLAYER, AVC_CTYPE_CONTROL,
+					avrcp_handle_set_addressed_player },
 		{ },
 };
 
-- 
1.9.1

