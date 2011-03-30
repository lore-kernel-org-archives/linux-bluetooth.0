Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.dieb@signove.com
Subject: [PATCH v2 3/6] Add parsing for ATT Signed Write
Date: Wed, 30 Mar 2011 11:01:31 -0300
Message-Id: <1301493694-10957-3-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
References: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 595c984..5bff925 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -488,6 +488,25 @@ static void att_write_req_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
+static void att_signed_write_dump(int level, struct frame *frm)
+{
+	uint16_t handle = btohs(htons(get_u16(frm)));
+	int value_len = frm->len - 12; /* handle:2 already accounted, sig: 12 */
+
+	p_indent(level, frm);
+	printf("handle 0x%4.4x value ", handle);
+
+	while (value_len--)
+		printf(" 0x%2.2x", get_u8(frm));
+	printf("\n");
+
+	p_indent(level, frm);
+	printf("auth signature ");
+	while (frm->len > 0)
+		printf(" 0x%2.2x", get_u8(frm));
+	printf("\n");
+}
+
 static void att_handle_notify_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
@@ -565,6 +584,9 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_WRITE_CMD:
 			att_write_req_dump(level + 1, frm);
 			break;
+		case ATT_OP_SIGNED_WRITE_CMD:
+			att_signed_write_dump(level + 1, frm);
+			break;
 		case ATT_OP_HANDLE_NOTIFY:
 			att_handle_notify_dump(level + 1, frm);
 			break;
-- 
1.7.1

