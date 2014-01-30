Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] audio/AVRCP: Fix coding style
Date: Thu, 30 Jan 2014 15:03:28 -0800
Message-Id: <1391123008-26767-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
References: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ac861d2..4521bc4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2161,7 +2161,7 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 		name[namelen] = '\0';
 	}
 
-	item =  media_player_create_folder(mp, name, type, uid);
+	item = media_player_create_folder(mp, name, type, uid);
 	if (!item)
 		return NULL;
 
-- 
1.8.4.2

