Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6 v2] AVRCP: Split event handing to its own functions
Date: Fri,  1 Feb 2013 15:28:24 -0600
Message-Id: <1359754105-8185-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359754105-8185-1-git-send-email-luiz.dentz@gmail.com>
References: <1359754105-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avrcp.c | 141 +++++++++++++++++++++++++++++--------------------
 1 file changed, 85 insertions(+), 56 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 793b5cf..d1eb8ce 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2005,21 +2005,94 @@ static void avrcp_get_media_player_list(struct avrcp *session)
 				avrcp_get_media_player_list_rsp, session);
 }
 
+static void avrcp_volume_changed(struct avrcp *session,
+						struct avrcp_header *pdu)
+{
+	struct avrcp_player *player = session->player;
+	uint8_t volume;
+
+	if (player == NULL)
+		return;
+
+	volume = pdu->params[1] & 0x7F;
+
+	player->cb->set_volume(volume, session->dev, player->user_data);
+}
+
+static void avrcp_status_changed(struct avrcp *session,
+						struct avrcp_header *pdu)
+{
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	uint8_t value;
+	const char *curval, *strval;
+
+	value = pdu->params[1];
+
+	curval = media_player_get_status(mp);
+	strval = status_to_string(value);
+
+	if (g_strcmp0(curval, strval) == 0)
+		return;
+
+	media_player_set_status(mp, strval);
+	avrcp_get_play_status(session);
+}
+
+static void avrcp_track_changed(struct avrcp *session,
+						struct avrcp_header *pdu)
+{
+	avrcp_get_element_attributes(session);
+	avrcp_get_play_status(session);
+
+}
+
+static void avrcp_setting_changed(struct avrcp *session,
+						struct avrcp_header *pdu)
+{
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	uint8_t count = pdu->params[1];
+	int i;
+
+	for (i = 2; count > 0; count--, i += 2) {
+		const char *key;
+		const char *value;
+
+		key = attr_to_str(pdu->params[i]);
+		if (key == NULL)
+			continue;
+
+		value = attrval_to_str(pdu->params[i], pdu->params[i + 1]);
+		if (value == NULL)
+			continue;
+
+		media_player_set_setting(mp, key, value);
+	}
+}
+
+static void avrcp_addressed_player_changed(struct avrcp *session,
+						struct avrcp_header *pdu)
+{
+	struct avrcp_player *player = session->player;
+	uint16_t id = bt_get_be16(&pdu->params[1]);
+
+	if (player->id == id)
+		return;
+
+	player->id = id;
+	player->uid_counter = bt_get_le16(&pdu->params[3]);
+	avrcp_get_media_player_list(session);
+}
+
 static gboolean avrcp_handle_event(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu = (void *) operands;
-	struct media_player *mp;
 	uint8_t event;
-	uint8_t value;
-	uint8_t count;
-	uint16_t id;
-	const char *curval, *strval;
-	int i;
 
 	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
 		return FALSE;
@@ -2034,63 +2107,19 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 
 	switch (event) {
 	case AVRCP_EVENT_VOLUME_CHANGED:
-		value = pdu->params[1] & 0x7F;
-
-		if (player)
-			player->cb->set_volume(value, session->dev,
-							player->user_data);
-
+		avrcp_volume_changed(session, pdu);
 		break;
 	case AVRCP_EVENT_STATUS_CHANGED:
-		mp = player->user_data;
-		value = pdu->params[1];
-
-		curval = media_player_get_status(mp);
-		strval = status_to_string(value);
-
-		if (g_strcmp0(curval, strval) != 0) {
-			media_player_set_status(mp, strval);
-			avrcp_get_play_status(session);
-		}
-
+		avrcp_status_changed(session, pdu);
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
-		avrcp_get_element_attributes(session);
-		avrcp_get_play_status(session);
-
+		avrcp_track_changed(session, pdu);
 		break;
-
 	case AVRCP_EVENT_SETTINGS_CHANGED:
-		mp = player->user_data;
-		count = pdu->params[1];
-
-		for (i = 2; count > 0; count--, i += 2) {
-			const char *key;
-			const char *value;
-
-			key = attr_to_str(pdu->params[i]);
-			if (key == NULL)
-				continue;
-
-			value = attrval_to_str(pdu->params[i],
-						pdu->params[i + 1]);
-			if (value == NULL)
-				continue;
-
-			media_player_set_setting(mp, key, value);
-		}
-
+		avrcp_setting_changed(session, pdu);
 		break;
-
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
-		id = bt_get_be16(&pdu->params[1]);
-
-		if (player->id == id)
-			break;
-
-		player->id = id;
-		player->uid_counter = bt_get_be16(&pdu->params[3]);
-		avrcp_get_media_player_list(session);
+		avrcp_addressed_player_changed(session, pdu);
 		break;
 	}
 
-- 
1.8.1

