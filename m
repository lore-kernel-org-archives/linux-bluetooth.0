Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Fix response for GetCurrentPlayerApplicationSettingValue
Date: Mon,  8 Aug 2011 11:48:47 -0300
Message-Id: <1312814927-2371-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to AVRCP spec there's no player id in response.
---
 parser/avrcp.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 485bb55..f8e4443 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -612,7 +612,7 @@ response:
 	printf("ValueCount: 0x%02x\n", num);
 
 	for (; num > 0; num--) {
-		uint8_t attr, player, value;
+		uint8_t attr, value;
 
 		p_indent(level, frm);
 
@@ -621,11 +621,6 @@ response:
 
 		p_indent(level, frm);
 
-		player = get_u8(frm);
-		printf("Player: 0x%02x\n", player);
-
-		p_indent(level, frm);
-
 		value = get_u8(frm);
 		printf("ValueID: 0x%02x (%s)\n", value,
 						value2str(attr, value));
-- 
1.7.6

