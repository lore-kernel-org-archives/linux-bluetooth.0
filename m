Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] hcidump: Fix parsing of GetCurrentPlayerApplicationSettingValue
Date: Thu, 31 Jan 2013 09:33:54 -0600
Message-Id: <1359646436-8113-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
References: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/parser/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/parser/avrcp.c b/tools/parser/avrcp.c
index 1d4a319..1029287 100644
--- a/tools/parser/avrcp.c
+++ b/tools/parser/avrcp.c
@@ -618,7 +618,7 @@ static void avrcp_get_current_player_value_dump(int level, struct frame *frm,
 
 	p_indent(level, frm);
 
-	if (len < 2) {
+	if (len < 1) {
 		printf("PDU Malformed\n");
 		raw_dump(level, frm);
 		return;
-- 
1.8.1

