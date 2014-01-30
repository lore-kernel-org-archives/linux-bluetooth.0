Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] audio/AVRCP: Fix using the wrong octet for folder type
Date: Thu, 30 Jan 2014 15:03:26 -0800
Message-Id: <1391123008-26767-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
References: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Folder type is the 9 octet not the 10.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 63a6f7e..2cf6b41 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2150,7 +2150,7 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 		return NULL;
 
 	uid = bt_get_be64(&operands[0]);
-	type = operands[9];
+	type = operands[8];
 
 	namelen = MIN(bt_get_be16(&operands[12]), sizeof(name) - 1);
 	if (namelen > 0) {
-- 
1.8.4.2

