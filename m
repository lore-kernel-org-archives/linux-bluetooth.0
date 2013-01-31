Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] hcidump: Fix parsing of SetBrowsedPlayer
Date: Thu, 31 Jan 2013 09:33:56 -0600
Message-Id: <1359646436-8113-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
References: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/parser/avrcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/parser/avrcp.c b/tools/parser/avrcp.c
index 1029287..4d88b41 100644
--- a/tools/parser/avrcp.c
+++ b/tools/parser/avrcp.c
@@ -1294,7 +1294,7 @@ static void avrcp_set_browsed_player_dump(int level, struct frame *frm,
 	}
 
 	id = get_u16(frm);
-	printf("PlayerID: 0x%04x (%u)", id, id);
+	printf("PlayerID: 0x%04x (%u)\n", id, id);
 	return;
 
 response:
@@ -1313,12 +1313,12 @@ response:
 	p_indent(level, frm);
 
 	uids = get_u16(frm);
-	printf("UIDCounter: 0x%04x (%u)", uids, uids);
+	printf("UIDCounter: 0x%04x (%u)\n", uids, uids);
 
 	p_indent(level, frm);
 
 	items = get_u32(frm);
-	printf("Number of Items: 0x%04x (%u)", items, items);
+	printf("Number of Items: 0x%04x (%u)\n", items, items);
 
 	p_indent(level, frm);
 
@@ -1328,7 +1328,7 @@ response:
 	p_indent(level, frm);
 
 	folders = get_u8(frm);
-	printf("Folder Depth: 0x%02x (%u)", folders, folders);
+	printf("Folder Depth: 0x%02x (%u)\n", folders, folders);
 
 	for (; folders > 0; folders--) {
 		uint16_t len;
-- 
1.8.1

