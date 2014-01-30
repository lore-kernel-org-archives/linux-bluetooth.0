Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] audio/AVRCP: Fix not setting playable flag for folder
Date: Thu, 30 Jan 2014 15:03:27 -0800
Message-Id: <1391123008-26767-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
References: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When listing items some folders may be set as playable but the code was
ignoring it making it impossible to play any folder.
---
 profiles/audio/avrcp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2cf6b41..ac861d2 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2141,16 +2141,19 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 {
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
+	struct media_item *item;
 	uint16_t namelen;
 	char name[255];
 	uint64_t uid;
 	uint8_t type;
+	uint8_t playable;
 
 	if (len < 12)
 		return NULL;
 
 	uid = bt_get_be64(&operands[0]);
 	type = operands[8];
+	playable = operands[9];
 
 	namelen = MIN(bt_get_be16(&operands[12]), sizeof(name) - 1);
 	if (namelen > 0) {
@@ -2158,7 +2161,13 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 		name[namelen] = '\0';
 	}
 
-	return media_player_create_folder(mp, name, type, uid);
+	item =  media_player_create_folder(mp, name, type, uid);
+	if (!item)
+		return NULL;
+
+	media_item_set_playable(item, playable & 0x01);
+
+	return item;
 }
 
 static void avrcp_list_items(struct avrcp *session, uint32_t start,
-- 
1.8.4.2

