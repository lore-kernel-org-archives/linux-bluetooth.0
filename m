Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] hcidump: Distinct Control and Browsing AVCTP channels
Date: Thu, 31 Jan 2013 09:33:50 -0600
Message-Id: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the respective channel of the trafic
---
 tools/parser/avctp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/parser/avctp.c b/tools/parser/avctp.c
index 60a5f69..58b181d 100644
--- a/tools/parser/avctp.c
+++ b/tools/parser/avctp.c
@@ -60,7 +60,8 @@ void avctp_dump(int level, struct frame *frm, uint16_t psm)
 	hdr = get_u8(frm);
 	pid = get_u16(frm);
 
-	printf("AVCTP: %s %s: pt 0x%02x transaction %d pid 0x%04x \n",
+	printf("AVCTP %s: %s %s: pt 0x%02x transaction %d pid 0x%04x\n",
+				psm == 23 ? "Control" : "Browsing",
 				hdr & 0x02 ? "Response" : "Command",
 				pt2str(hdr), hdr & 0x0c, hdr >> 4, pid);
 
-- 
1.8.1

