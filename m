Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.dieb@signove.com
Subject: [PATCH v2 5/6] Add parsing for ATT Prepare Write
Date: Wed, 30 Mar 2011 11:01:33 -0300
Message-Id: <1301493694-10957-5-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
References: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index a1cd9af..7046357 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -507,6 +507,22 @@ static void att_signed_write_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
+static void att_prep_write_dump(int level, struct frame *frm)
+{
+	uint16_t handle = btohs(htons(get_u16(frm)));
+	uint16_t val_offset = btohs(htons(get_u16(frm)));
+
+	p_indent(level, frm);
+	printf("attr handle 0x%4.4x, value offset 0x%4.4x\n", handle,
+								val_offset);
+
+	p_indent(level, frm);
+	printf("part attr value ");
+	while (frm->len > 0)
+		printf(" 0x%2.2x", get_u8(frm));
+	printf("\n");
+}
+
 static void att_handle_notify_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
@@ -587,6 +603,10 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_SIGNED_WRITE_CMD:
 			att_signed_write_dump(level + 1, frm);
 			break;
+		case ATT_OP_PREP_WRITE_REQ:
+		case ATT_OP_PREP_WRITE_RESP:
+			att_prep_write_dump(level + 1, frm);
+			break;
 		case ATT_OP_HANDLE_NOTIFY:
 			att_handle_notify_dump(level + 1, frm);
 			break;
-- 
1.7.1

