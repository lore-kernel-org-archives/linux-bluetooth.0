Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 2/4] Add parsing for ATT Read Blob
Date: Mon, 21 Mar 2011 09:18:32 -0300
Message-Id: <1300709914-2838-2-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1300709914-2838-1-git-send-email-andre.dieb@signove.com>
References: <1300709914-2838-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 134143c..1cba543 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -415,6 +415,26 @@ static void att_read_req_dump(int level, struct frame *frm)
 	printf("handle 0x%2.2x\n", handle);
 }
 
+static void att_read_blob_req_dump(int level, struct frame *frm)
+{
+	uint16_t handle = btohs(htons(get_u16(frm)));
+	uint16_t offset = btohs(htons(get_u16(frm)));
+
+	p_indent(level, frm);
+	printf("handle 0x%4.4x offset 0x%4.4x\n", handle, offset);
+}
+
+static void att_read_blob_resp_dump(int level, struct frame *frm)
+{
+	p_indent(level, frm);
+	printf("value");
+
+	while (frm->len > 0) {
+		printf(" 0x%2.2x", get_u8(frm));
+	}
+	printf("\n");
+}
+
 static void att_handle_notify_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
@@ -473,6 +493,12 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_READ_RESP:
 			raw_dump(level + 1, frm);
 			break;
+		case ATT_OP_READ_BLOB_REQ:
+			att_read_blob_req_dump(level + 1, frm);
+			break;
+		case ATT_OP_READ_BLOB_RESP:
+			att_read_blob_resp_dump(level + 1, frm);
+			break;
 		case ATT_OP_HANDLE_NOTIFY:
 			att_handle_notify_dump(level + 1, frm);
 			break;
-- 
1.7.1

