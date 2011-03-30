Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.dieb@signove.com
Subject: [PATCH v2 6/6] Add parsing for ATT Execute Write command
Date: Wed, 30 Mar 2011 11:01:34 -0300
Message-Id: <1301493694-10957-6-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
References: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BT's Core V4.0 document is buggy regarding Execute Write Response, so we'll
leave it out until a proper description is given.
---
 parser/att.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 7046357..a6f42df 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -523,6 +523,19 @@ static void att_prep_write_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
+static void att_exec_write_req_dump(int level, struct frame *frm)
+{
+	uint8_t flags = get_u8(frm);
+
+	p_indent(level, frm);
+	if (flags == 0x00)
+		printf("cancel all prepared writes ");
+	else
+		printf("immediatelly write all pending prepared values ");
+
+	printf("(0x%2.2x)\n", flags);
+}
+
 static void att_handle_notify_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
@@ -607,6 +620,9 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_PREP_WRITE_RESP:
 			att_prep_write_dump(level + 1, frm);
 			break;
+		case ATT_OP_EXEC_WRITE_REQ:
+			att_exec_write_req_dump(level + 1, frm);
+			break;
 		case ATT_OP_HANDLE_NOTIFY:
 			att_handle_notify_dump(level + 1, frm);
 			break;
-- 
1.7.1

