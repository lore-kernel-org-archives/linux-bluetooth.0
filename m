Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 4/4] Add parsing for Read Multiple
Date: Mon, 21 Mar 2011 09:18:34 -0300
Message-Id: <1300709914-2838-4-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1300709914-2838-1-git-send-email-andre.dieb@signove.com>
References: <1300709914-2838-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 124aaa7..329a0dc 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -435,6 +435,28 @@ static void att_read_blob_resp_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
+static void att_read_multi_req_dump(int level, struct frame *frm)
+{
+	p_indent(level, frm);
+	printf("Handles\n");
+
+	while (frm->len > 0) {
+		p_indent(level, frm);
+		printf("handle 0x%4.4x\n", btohs(htons(get_u16(frm))));
+	}
+}
+
+static void att_read_multi_resp_dump(int level, struct frame *frm)
+{
+	p_indent(level, frm);
+	printf("values");
+
+	while (frm->len > 0) {
+		printf(" 0x%2.2x", get_u8(frm));
+	}
+	printf("\n");
+}
+
 static void att_read_by_group_resp_dump(int level, struct frame *frm)
 {
 	uint8_t length = get_u8(frm);
@@ -522,6 +544,12 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_READ_BLOB_RESP:
 			att_read_blob_resp_dump(level + 1, frm);
 			break;
+		case ATT_OP_READ_MULTI_REQ:
+			att_read_multi_req_dump(level + 1, frm);
+			break;
+		case ATT_OP_READ_MULTI_RESP:
+			att_read_multi_resp_dump(level + 1, frm);
+			break;
 		case ATT_OP_READ_BY_GROUP_RESP:
 			att_read_by_group_resp_dump(level + 1, frm);
 			break;
-- 
1.7.1

