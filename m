Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 1/3] Add basic AVCTP parsing
Date: Wed, 22 Jun 2011 17:22:41 +0300
Message-Id: <1308752563-16991-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avctp.c  |   29 +++++++++++++++++++++++++++--
 parser/parser.h |    1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/parser/avctp.c b/parser/avctp.c
index 4a8876c..aa2def1 100644
--- a/parser/avctp.c
+++ b/parser/avctp.c
@@ -36,10 +36,35 @@
 
 #include "parser.h"
 
+static char *pt2str(uint8_t hdr)
+{
+	switch (hdr & 0x0c) {
+	case 0x00:
+		return "";
+	case 0x04:
+		return "Start";
+	case 0x08:
+		return "Cont";
+	case 0x0c:
+		return "End";
+	default:
+		return "Unk";
+	}
+}
+
 void avctp_dump(int level, struct frame *frm)
 {
+	uint8_t hdr;
+	uint16_t pid;
+
 	p_indent(level, frm);
-	printf("AVCTP:\n");
 
-	raw_dump(level, frm);
+	hdr = get_u8(frm);
+	pid = get_u16(frm);
+
+	printf("AVCTP: %s %s: pt 0x%02x transaction %d pid 0x%04x \n",
+				hdr & 0x02 ? "Response" : "Command",
+				pt2str(hdr), hdr & 0x0c, hdr >> 4, pid);
+
+	raw_dump(level + 1, frm);
 }
diff --git a/parser/parser.h b/parser/parser.h
index bbdfc01..cf40034 100644
--- a/parser/parser.h
+++ b/parser/parser.h
@@ -231,6 +231,7 @@ void hidp_dump(int level, struct frame *frm);
 void hcrp_dump(int level, struct frame *frm);
 void avdtp_dump(int level, struct frame *frm);
 void avctp_dump(int level, struct frame *frm);
+void avrcp_dump(int level, struct frame *frm);
 void att_dump(int level, struct frame *frm);
 void smp_dump(int level, struct frame *frm);
 
-- 
1.7.5.4

