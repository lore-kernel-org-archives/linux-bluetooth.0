Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 12/14] AVRCP: Use NoAvailablePlayers status code for AVRCP 1.4 devices
Date: Wed, 27 Jun 2012 15:27:46 +0200
Message-ID: <1340803668-31686-12-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

DummyPlayer indicate there is no available players. For AVRCP 1.4
devices use NoAvailblePlayers status code, on the other side, for
AVRCP 1.3 devices use InternalError.
---
 audio/avrcp.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 audio/avrcp.h |    1 +
 audio/media.c |   13 ++++++++++++-
 3 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index baf9de5..a725142 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1159,6 +1159,41 @@ err_metadata:
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
+static size_t handle_dummy_player(struct avctp *session, uint8_t transaction,
+					uint8_t *code, uint8_t *subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct avrcp_header *pdu = (void *) operands;
+	uint32_t company_id = get_company_id(pdu->company_id);
+
+	if (player->server->session.version_ct < AVRCP_VERSION_1_4)
+		goto ignoring;
+
+	if (pdu->pdu_id == AVRCP_GET_CAPABILITIES ||
+		pdu->pdu_id == AVRCP_REGISTER_NOTIFICATION)
+		goto pass;
+
+	*code = AVC_CTYPE_REJECTED;
+	pdu->params_len = htons(1);
+
+	pdu->params[0] = STATUS_NO_AVAILABLE_PLAYERS;
+
+	DBG("cannot handle regard to no available players "
+		"AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
+		pdu->pdu_id, company_id, pdu->params_len);
+
+	return AVRCP_HEADER_LENGTH + 1;
+
+ignoring:
+	DBG("ignoring AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
+		pdu->pdu_id, company_id, pdu->params_len);
+pass:
+	return handle_vendordep_pdu(session, transaction, code, subunit,
+					operands, operand_count, user_data);
+}
+
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 {
 	struct avrcp_header *pdu = (void *) operands;
@@ -1166,6 +1201,7 @@ size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 
 	*code = AVC_CTYPE_REJECTED;
 	pdu->params_len = htons(1);
+
 	pdu->params[0] = STATUS_INTERNAL_ERROR;
 
 	DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
@@ -1269,11 +1305,19 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		player->dev = dev;
 
-		if (!player->handler)
-			player->handler = avctp_register_pdu_handler(
+		if (!player->handler) {
+			if (player->cb->is_dummy_player(player->user_data))
+				player->handler = avctp_register_pdu_handler(
+							AVC_OP_VENDORDEP,
+							handle_dummy_player,
+							player);
+			else
+				player->handler = avctp_register_pdu_handler(
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							player);
+		}
+
 		break;
 	case AVCTP_STATE_CONNECTED:
 		rec_tg = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
@@ -1611,8 +1655,13 @@ gboolean avrcp_set_addressed_player(struct avrcp_player *player, gboolean local)
 		avctp_unregister_pdu_handler(server->addressed_player->handler);
 		server->addressed_player->handler = 0;
 	}
-	player->handler = avctp_register_pdu_handler(AVC_OP_VENDORDEP,
-							handle_vendordep_pdu, player);
+
+	if (player->cb->is_dummy_player(player->user_data))
+		player->handler = avctp_register_pdu_handler(AVC_OP_VENDORDEP,
+						handle_dummy_player, player);
+	else
+		player->handler = avctp_register_pdu_handler(AVC_OP_VENDORDEP,
+						handle_vendordep_pdu, player);
 
 	server->addressed_player = player;
 
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 68e3098..148dc0e 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -101,6 +101,7 @@ struct avrcp_player_cb {
 	uint32_t (*get_position) (void *user_data);
 	void (*set_volume) (uint8_t volume, struct audio_device *dev,
 							void *user_data);
+	gboolean (*is_dummy_player) (void *user_data);
 };
 
 struct avrcp_player *player;
diff --git a/audio/media.c b/audio/media.c
index 97bf7df..0c11cf0 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1393,6 +1393,16 @@ static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data
 	}
 }
 
+static gboolean is_dummy_player(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	if (strcmp(mp->path, DUMMY_PLAYER) == 0)
+	    return TRUE;
+
+	return FALSE;
+}
+
 static struct avrcp_player_cb player_cb = {
 	.get_setting = get_setting,
 	.set_setting = set_setting,
@@ -1401,7 +1411,8 @@ static struct avrcp_player_cb player_cb = {
 	.get_metadata = get_metadata,
 	.get_position = get_position,
 	.get_status = get_status,
-	.set_volume = set_volume
+	.set_volume = set_volume,
+	.is_dummy_player = is_dummy_player
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
-- 
on behalf of ST-Ericsson

