Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 6/6] Add ATT read by type req/resp dump
Date: Wed,  9 Feb 2011 10:53:39 -0300
Message-Id: <1297259619-10325-6-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1297259619-10325-1-git-send-email-andre.dieb@signove.com>
References: <1297259619-10325-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 2a9da30..3c57d23 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -331,6 +331,54 @@ static void att_find_info_resp_dump(int level, struct frame *frm)
 	}
 }
 
+static void att_read_by_type_req_dump(int level, struct frame *frm)
+{
+	uint16_t start = btohs(htons(get_u16(frm)));
+	uint16_t end = btohs(htons(get_u16(frm)));
+	int i;
+
+	p_indent(level, frm);
+	printf("start 0x%2.2x, end 0x%2.2x\n", start, end);
+
+	p_indent(level, frm);
+	if (frm->len == 2) {
+		printf("type-uuid 0x%2.2x\n", btohs(htons(get_u16(frm))));
+	} else if (frm->len == 16) {
+		printf("type-uuid ");
+		for (i = 0; i < 16; i++) {
+			printf("%02x", get_u8(frm));
+			if (i == 3 || i == 5 || i == 7 || i == 9)
+				printf("-");
+		}
+		printf("\n");
+	} else {
+		printf("malformed uuid (expected 2 or 16 octets)\n");
+		p_indent(level, frm);
+		raw_dump(level, frm);
+	}
+}
+
+static void att_read_by_type_resp_dump(int level, struct frame *frm)
+{
+	uint8_t length = get_u8(frm);
+
+	p_indent(level, frm);
+	printf("length: %d\n", length);
+
+	while (frm->len > 0) {
+		uint16_t handle = btohs(htons(get_u16(frm)));
+		int val_len = length - 2;
+		int i;
+
+		p_indent(level + 1, frm);
+		printf("handle 0x%2.2x, value ", handle);
+		for (i = 0; i < val_len; i++) {
+			printf("0x%.2x ", get_u8(frm));
+		}
+		printf("\n");
+	}
+}
+
 static void att_read_req_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
@@ -379,6 +427,12 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_FIND_INFO_RESP:
 			att_find_info_resp_dump(level + 1, frm);
 			break;
+		case ATT_OP_READ_BY_TYPE_REQ:
+			att_read_by_type_req_dump(level + 1, frm);
+			break;
+		case ATT_OP_READ_BY_TYPE_RESP:
+			att_read_by_type_resp_dump(level + 1, frm);
+			break;
 		case ATT_OP_READ_REQ:
 			att_read_req_dump(level + 1, frm);
 			break;
-- 
1.7.1

