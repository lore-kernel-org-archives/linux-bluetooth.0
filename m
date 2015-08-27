Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio/avrcp: Fix crash on RegisterNotification
Date: Thu, 27 Aug 2015 16:36:04 +0300
Message-Id: <1440682565-23653-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1440682565-23653-1-git-send-email-luiz.dentz@gmail.com>
References: <1440682565-23653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When registering AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED there may not be
any player available causing a crash.
---
 profiles/audio/avrcp.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index fa95bf9..5a1c8a3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1326,6 +1326,22 @@ static uint8_t player_get_status(struct avrcp_player *player)
 	return play_status_to_val(value);
 }
 
+static uint16_t player_get_id(struct avrcp_player *player)
+{
+	if (player == NULL)
+		return 0x0000;
+
+	return player->id;
+}
+
+static uint16_t player_get_uid_counter(struct avrcp_player *player)
+{
+	if (player == NULL)
+		return 0x0000;
+
+	return player->uid_counter;
+}
+
 static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -1516,8 +1532,10 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		len = 5;
-		memcpy(&pdu->params[1], &player->id, sizeof(uint16_t));
-		memcpy(&pdu->params[3], &player->uid_counter, sizeof(uint16_t));
+		memset(&pdu->params[1], player_get_id(player),
+							sizeof(uint16_t));
+		memset(&pdu->params[3], player_get_uid_counter(player),
+							sizeof(uint16_t));
 		break;
 	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 		len = 1;
-- 
2.4.3

