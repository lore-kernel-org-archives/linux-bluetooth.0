Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2] Add parsing for AVRCP GetCapabilities
Date: Tue, 12 Jul 2011 11:07:54 +0300
Message-Id: <1310458074-27360-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1310458074-27360-1-git-send-email-luiz.dentz@gmail.com>
References: <1310458074-27360-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 43e8a8b..9529b33 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -213,6 +213,54 @@ static const char *pdu2str(uint8_t pduid)
 	}
 }
 
+static char *cap2str(uint8_t cap)
+{
+	switch (cap) {
+	case 0x2:
+		return "CompanyID";
+	case 0x3:
+		return "EventsID";
+	default:
+		return "Unknown";
+	}
+}
+
+static void avrcp_get_capabilities_dump(int level, struct frame *frm, uint16_t len)
+{
+	uint8_t cap;
+	uint8_t count;
+
+	p_indent(level, frm);
+
+	if (len < 1) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	cap = get_u8(frm);
+	printf("Capability ID: 0x%02x (%s)\n", cap, cap2str(cap));
+
+	if (len == 1)
+		return;
+
+	p_indent(level, frm);
+
+	count = get_u8(frm);
+	printf("Capability Count: 0x%02x\n", count);
+
+	for (; count > 0; count--) {
+		int i;
+
+		p_indent(level, frm);
+
+		printf("%s: 0x", cap2str(cap));
+		for (i = 0; i < 3; i++)
+			printf("0x%02x", get_u8(frm));
+		printf("\n");
+	}
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -229,9 +277,17 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	if (len != frm->len) {
 		p_indent(level, frm);
 		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
 	}
 
-	raw_dump(level, frm);
+	switch (pduid) {
+	case AVRCP_GET_CAPABILITIES:
+		avrcp_get_capabilities_dump(level + 1, frm, len);
+		break;
+	default:
+		raw_dump(level, frm);
+	}
 }
 
 static char *op2str(uint8_t op)
-- 
1.7.6

