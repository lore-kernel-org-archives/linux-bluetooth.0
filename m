Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5 v2] AVRCP: Fix reading wrong field as folder depth
Date: Thu,  7 Mar 2013 17:11:55 +0200
Message-Id: <1362669119-10890-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Folder depth is bit 10 of the parameters not the PDU operands
---
v2: Make use of MIN macro to check player name length and fix zero length
check for folder.

 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 85da0c0..97961da 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1943,7 +1943,7 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 
 	items = bt_get_be32(&pdu->params[3]);
 
-	depth = operands[9];
+	depth = pdu->params[9];
 
 	folders = g_new0(char *, depth + 2);
 	folders[0] = g_strdup("/Filesystem");
-- 
1.8.1.4

