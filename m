Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] AVRCP: Fix not parsing player name properly
Date: Thu,  7 Mar 2013 16:57:27 +0200
Message-Id: <1362668250-9123-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362668250-9123-1-git-send-email-luiz.dentz@gmail.com>
References: <1362668250-9123-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Player name length field is 2 bytes long not 1.
---
 profiles/audio/avrcp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 97961da..5836233 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2058,7 +2058,7 @@ static void avrcp_parse_media_player_item(struct avrcp *session,
 {
 	struct avrcp_player *player = session->player;
 	struct media_player *mp = player->user_data;
-	uint16_t id;
+	uint16_t id, namelen;
 	uint32_t subtype;
 	const char *curval, *strval;
 	char name[255];
@@ -2087,8 +2087,12 @@ static void avrcp_parse_media_player_item(struct avrcp *session,
 
 	avrcp_player_parse_features(player, &operands[8]);
 
-	if (operands[26] != 0) {
-		memcpy(name, &operands[27], operands[26]);
+	namelen = bt_get_be16(&operands[26]);
+	if (namelen != 0) {
+		if (namelen > sizeof(name) - 1)
+			namelen = sizeof(name) - 1;
+		memcpy(name, &operands[28], namelen);
+		name[namelen] = '\0';
 		media_player_set_name(mp, name);
 	}
 
-- 
1.8.1.4

