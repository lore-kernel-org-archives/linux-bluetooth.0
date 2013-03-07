Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] AVRCP: Fix not checking for invalid player name length
Date: Thu,  7 Mar 2013 16:57:29 +0200
Message-Id: <1362668250-9123-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362668250-9123-1-git-send-email-luiz.dentz@gmail.com>
References: <1362668250-9123-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds checks for invalid player name length that could cause crashes
while reading invalid memory.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e059cff..e4f83b6 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2093,7 +2093,7 @@ static void avrcp_parse_media_player_item(struct avrcp *session,
 	avrcp_player_parse_features(player, &operands[8]);
 
 	namelen = bt_get_be16(&operands[26]);
-	if (namelen != 0) {
+	if (namelen != 0 && namelen + 28 == len) {
 		if (namelen > sizeof(name) - 1)
 			namelen = sizeof(name) - 1;
 		memcpy(name, &operands[28], namelen);
-- 
1.8.1.4

