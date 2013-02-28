Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 9/9 v2] AVRCP: Fix storing wrong UID counter
Date: Thu, 28 Feb 2013 14:22:08 +0200
Message-Id: <1362054128-20569-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362054128-20569-1-git-send-email-luiz.dentz@gmail.com>
References: <1362054128-20569-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

By the AVRCP spec all messages uses big endian not little endian.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 10bedc0..29b6eb1 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2220,7 +2220,7 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 		return;
 
 	player->id = id;
-	player->uid_counter = bt_get_le16(&pdu->params[3]);
+	player->uid_counter = bt_get_be16(&pdu->params[3]);
 	avrcp_get_media_player_list(session);
 }
 
-- 
1.8.1.2

