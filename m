Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 3/4] Add parsing for ATT Read By Group
Date: Mon, 21 Mar 2011 09:18:33 -0300
Message-Id: <1300709914-2838-3-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1300709914-2838-1-git-send-email-andre.dieb@signove.com>
References: <1300709914-2838-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Additionally, fix Read By Type printf formatting for handles.
---
 parser/att.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 1cba543..124aaa7 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -366,11 +366,11 @@ static void att_read_by_type_req_dump(int level, struct frame *frm)
 	int i;
 
 	p_indent(level, frm);
-	printf("start 0x%2.2x, end 0x%2.2x\n", start, end);
+	printf("start 0x%4.4x, end 0x%4.4x\n", start, end);
 
 	p_indent(level, frm);
 	if (frm->len == 2) {
-		printf("type-uuid 0x%2.2x\n", btohs(htons(get_u16(frm))));
+		printf("type-uuid 0x%4.4x\n", btohs(htons(get_u16(frm))));
 	} else if (frm->len == 16) {
 		printf("type-uuid ");
 		for (i = 0; i < 16; i++) {
@@ -435,6 +435,28 @@ static void att_read_blob_resp_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
+static void att_read_by_group_resp_dump(int level, struct frame *frm)
+{
+	uint8_t length = get_u8(frm);
+
+	while (frm->len > 0) {
+		uint16_t attr_handle = btohs(htons(get_u16(frm)));
+		uint16_t end_grp_handle = btohs(htons(get_u16(frm)));
+		uint8_t remaining = length - 4;
+
+		p_indent(level, frm);
+		printf("attr handle 0x%4.4x, end group handle 0x%4.4x\n",
+						attr_handle, end_grp_handle);
+
+		p_indent(level, frm);
+		printf("value");
+		while (remaining > 0) {
+			printf(" 0x%2.2x", get_u8(frm));
+		}
+		printf("\n");
+	}
+}
+
 static void att_handle_notify_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
@@ -482,6 +504,7 @@ void att_dump(int level, struct frame *frm)
 			att_find_by_type_resp_dump(level + 1, frm);
 			break;
 		case ATT_OP_READ_BY_TYPE_REQ:
+		case ATT_OP_READ_BY_GROUP_REQ: /* exact same parsing */
 			att_read_by_type_req_dump(level + 1, frm);
 			break;
 		case ATT_OP_READ_BY_TYPE_RESP:
@@ -499,6 +522,9 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_READ_BLOB_RESP:
 			att_read_blob_resp_dump(level + 1, frm);
 			break;
+		case ATT_OP_READ_BY_GROUP_RESP:
+			att_read_by_group_resp_dump(level + 1, frm);
+			break;
 		case ATT_OP_HANDLE_NOTIFY:
 			att_handle_notify_dump(level + 1, frm);
 			break;
-- 
1.7.1

