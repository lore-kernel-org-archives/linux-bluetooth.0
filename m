Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 2/5] Add parsing for ATT Write Request
Date: Wed, 23 Mar 2011 11:46:38 -0300
Message-Id: <1300891601-11412-2-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
References: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Note we do not need extra parsing for ATT Write Response as it only has one
field (opcode).
---
 parser/att.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 6c1d0d8..6a1b1b5 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -476,6 +476,18 @@ static inline void att_read_by_group_resp_dump(int level, struct frame *frm)
 	}
 }
 
+static inline void att_write_req_dump(int level, struct frame *frm)
+{
+	uint16_t handle = btohs(htons(get_u16(frm)));
+
+	p_indent(level, frm);
+	printf("handle 0x%4.4x value ", handle);
+
+	while (frm->len > 0)
+		printf(" 0x%2.2x", get_u8(frm));
+	printf("\n");
+}
+
 static inline void att_handle_notify_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
@@ -549,6 +561,9 @@ void att_dump(int level, struct frame *frm)
 		case ATT_OP_READ_BY_GROUP_RESP:
 			att_read_by_group_resp_dump(level + 1, frm);
 			break;
+		case ATT_OP_WRITE_REQ:
+			att_write_req_dump(level + 1, frm);
+			break;
 		case ATT_OP_HANDLE_NOTIFY:
 			att_handle_notify_dump(level + 1, frm);
 			break;
-- 
1.7.1

