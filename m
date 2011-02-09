Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 4/6] Better ATT dump format
Date: Wed,  9 Feb 2011 10:53:37 -0300
Message-Id: <1297259619-10325-4-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1297259619-10325-1-git-send-email-andre.dieb@signove.com>
References: <1297259619-10325-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 79a74b5..b172f95 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -265,10 +265,10 @@ static void att_error_dump(int level, struct frame *frm)
 	uint8_t err = get_u8(frm);
 
 	p_indent(level, frm);
-	printf("Error: %s 0x%.2x\n", atterror2str(err), err);
+	printf("Error: %s (%d)\n", atterror2str(err), err);
 
 	p_indent(level, frm);
-	printf("opcode %d (%s) on handle 0x%2.2x\n", op, attop2str(op), handle);
+	printf("%s (0x%.2x) on handle 0x%2.2x\n", attop2str(op), op, handle);
 }
 
 static void att_mtu_req_dump(int level, struct frame *frm)
@@ -353,7 +353,7 @@ void att_dump(int level, struct frame *frm)
 	op = get_u8(frm);
 
 	p_indent(level, frm);
-	printf("Opcode %d (%s)\n", op, attop2str(op));
+	printf("ATT: %s (0x%.2x)\n", attop2str(op), op);
 
 	switch (op) {
 		case ATT_OP_ERROR:
-- 
1.7.1

