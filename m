Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 2/3] monitor: Fix for GetElementAttributes when
 AttributeValueLength zero
Date: Wed, 12 Nov 2014 14:23:15 +0530
Message-id: <1415782396-28799-2-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1415782396-28799-1-git-send-email-vikram.pal@samsung.com>
References: <1415782396-28799-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      AVCTP Control: Response: type 0x00 label 0 PID 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetElementAttributes pt Single len 0x0019
            AttributeCount: 0x03
            Attribute: 0x00000001 (Title)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0000
            AttributeValue:
            Attribute: 0x00000002 (Artist)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0000
            AttributeValue:
            Attribute: 0x00000003 (Album)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0000
            AttributeValue:
---
 monitor/avctp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 11dc9b2..af91ecc 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1122,7 +1122,7 @@ response:
 		num = avrcp_continuing.num;
 
 		if (avrcp_continuing.size > 0) {
-			char attrval[UINT8_MAX];
+			char attrval[UINT8_MAX] = {0};
 			uint16_t size;
 			uint8_t idx;
 
@@ -1157,7 +1157,7 @@ response:
 		uint32_t attr;
 		uint16_t charset, attrlen;
 		uint8_t idx;
-		char attrval[UINT8_MAX];
+		char attrval[UINT8_MAX] = {0};
 
 		if (!l2cap_frame_get_be32(frame, &attr))
 			goto failed;
-- 
1.9.1

