Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 1/4] Add parsing for ATT Find By Type
Date: Mon, 21 Mar 2011 09:18:31 -0300
Message-Id: <1300709914-2838-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index a0fb135..134143c 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -330,6 +330,35 @@ static void att_find_info_resp_dump(int level, struct frame *frm)
 	}
 }
 
+static void att_find_by_type_req_dump(int level, struct frame *frm)
+{
+	uint16_t start = btohs(htons(get_u16(frm)));
+	uint16_t end = btohs(htons(get_u16(frm)));
+	uint16_t uuid = btohs(htons(get_u16(frm)));
+
+	p_indent(level, frm);
+	printf("start 0x%4.4x, end 0x%4.4x, uuid 0x%4.4x\n", start, end, uuid);
+
+	p_indent(level, frm);
+	printf("value");
+	while (frm->len > 0) {
+		printf(" 0x%2.2x", get_u8(frm));
+	}
+	printf("\n");
+}
+
+static void att_find_by_type_resp_dump(int level, struct frame *frm)
+{
+	while (frm->len > 0) {
+		uint16_t uuid = btohs(htons(get_u16(frm)));
+		uint16_t end = btohs(htons(get_u16(frm)));
+
+		p_indent(level, frm);
+		printf("Found attr 0x%4.4x, group end handle 0x%4.4x\n",
+								uuid, end);
+	}
+}
+
 static void att_read_by_type_req_dump(int level, struct frame *frm)
 {
 	uint16_t start = btohs(htons(get_u16(frm)));
@@ -426,6 +455,12 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_FIND_INFO_RESP:
 			att_find_info_resp_dump(level + 1, frm);
 			break;
+		case ATT_OP_FIND_BY_TYPE_REQ:
+			att_find_by_type_req_dump(level + 1, frm);
+			break;
+		case ATT_OP_FIND_BY_TYPE_RESP:
+			att_find_by_type_resp_dump(level + 1, frm);
+			break;
 		case ATT_OP_READ_BY_TYPE_REQ:
 			att_read_by_type_req_dump(level + 1, frm);
 			break;
-- 
1.7.1

