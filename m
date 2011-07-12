Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 1/2] Add check to verify AVRCP pdu length matches frame length
Date: Tue, 12 Jul 2011 11:07:53 +0300
Message-Id: <1310458074-27360-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 0fa38d1..43e8a8b 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -226,6 +226,11 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 
 	printf("AVRCP: %s: pt 0x%02x len 0x%04x\n", pdu2str(pduid), pt, len);
 
+	if (len != frm->len) {
+		p_indent(level, frm);
+		printf("PDU Malformed\n");
+	}
+
 	raw_dump(level, frm);
 }
 
-- 
1.7.6

