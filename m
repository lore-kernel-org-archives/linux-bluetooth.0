Return-Path: <cyrus@holtmann.org>
From: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Subject: [PATCH 2/2] audio/avrcp: Handle SetAddressedPlayer command
Date: Thu, 22 Jan 2015 18:27:31 +0530
Message-id: <1421931451-13806-1-git-send-email-s.nageshmurt@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch handles the SetAddressedPlayer command for TG role.
---
 profiles/audio/avrcp.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 3826a91..cea081c 100644
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
@@ -1610,6 +1611,44 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_handle_set_addressed_player(struct avrcp *session,
+						struct avrcp_header *pdu,
+							uint8_t transaction)
+{
+	uint16_t player_id;
+	uint16_t len = ntohs(pdu->params_len);
+	struct avrcp_server *server = session->server;
+	GSList *l;
+
+	if (len != 2)
+		goto err;
+
+	player_id = bt_get_be16(&pdu->params[0]);
+
+	DBG("id = %d", player_id);
+
+	for (l = server->players; l; l = l->next) {
+		struct avrcp_player *player = l->data;
+
+		if (player->id == player_id) {
+			session->target->player = player;
+			pdu->params_len = htons(1);
+			pdu->params[0] = AVRCP_STATUS_SUCCESS;
+			return AVC_CTYPE_ACCEPTED;
+		}
+
+	}
+
+	pdu->params_len = htons(1);
+	pdu->params[0] = AVRCP_STATUS_PARAM_NOT_FOUND;
+	return AVC_CTYPE_REJECTED;
+err:
+	pdu->params_len = htons(1);
+	pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
+
+	return AVC_CTYPE_REJECTED;
+}
+
 static const struct control_pdu_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_capabilities },
@@ -1641,6 +1680,8 @@ static const struct control_pdu_handler control_handlers[] = {
 					avrcp_handle_request_continuing },
 		{ AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
 					avrcp_handle_abort_continuing },
+		{ AVRCP_SET_ADDRESSED_PLAYER, AVC_CTYPE_CONTROL,
+					avrcp_handle_set_addressed_player },
 		{ },
 };
 
-- 
1.7.9.5

