Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 02/13] AVRCP: Add browsed flag to player
Date: Tue, 28 May 2013 15:51:20 +0300
Message-Id: <1369745491-23897-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
References: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This flag indicates if the player is browsed and are checked to avoid
setting the same player as browsed multiple times.
---
 profiles/audio/avrcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 39882e4..5477016 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -182,6 +182,7 @@ struct avrcp_player {
 	GSList *sessions;
 	uint16_t id;
 	uint16_t uid_counter;
+	bool browsed;
 	uint8_t *features;
 
 	struct avrcp_player_cb *cb;
@@ -2030,6 +2031,7 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 		return FALSE;
 
 	player->uid_counter = bt_get_be16(&pdu->params[1]);
+	player->browsed = true;
 
 	items = bt_get_be32(&pdu->params[3]);
 
@@ -2375,7 +2377,7 @@ avrcp_parse_media_player_item(struct avrcp *session, uint8_t *operands,
 		media_player_set_name(mp, name);
 	}
 
-	if (session->player == player)
+	if (session->player == player && !player->browsed)
 		avrcp_set_browsed_player(session, player);
 
 	return player;
-- 
1.8.1.4

