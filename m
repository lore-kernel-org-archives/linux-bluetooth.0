Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 2/7] Add dump for ATT MTU req/resp and notify value
Date: Wed,  9 Feb 2011 11:01:45 -0300
Message-Id: <1297260110-10515-2-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1297260110-10515-1-git-send-email-andre.dieb@signove.com>
References: <1297260110-10515-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index b670694..05f9c23 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -132,12 +132,35 @@ static const char *attop2str(uint8_t op)
 	}
 }
 
+static void att_mtu_req_dump(int level, struct frame *frm)
+{
+	uint16_t client_rx_mtu = btohs(htons(get_u16(frm)));
+
+	p_indent(level, frm);
+	printf("client rx mtu %d\n", client_rx_mtu);
+}
+
+static void att_mtu_resp_dump(int level, struct frame *frm)
+{
+	uint16_t server_rx_mtu = btohs(htons(get_u16(frm)));
+
+	p_indent(level, frm);
+	printf("server rx mtu %d\n", server_rx_mtu);
+}
+
 static void att_handle_notify_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
 
 	p_indent(level, frm);
 	printf("handle 0x%2.2x\n", handle);
+
+	p_indent(level, frm);
+	printf("value ");
+	while (frm->len > 0) {
+		printf("0x%.2x ", get_u8(frm));
+	}
+	printf("\n");
 }
 
 void att_dump(int level, struct frame *frm)
@@ -147,9 +170,15 @@ void att_dump(int level, struct frame *frm)
 	op = get_u8(frm);
 
 	p_indent(level, frm);
-	printf("Opcode: %d (%s)\n", op, attop2str(op));
+	printf("Opcode %d (%s)\n", op, attop2str(op));
 
 	switch (op) {
+		case ATT_OP_MTU_REQ:
+			att_mtu_req_dump(level + 1, frm);
+			break;
+		case ATT_OP_MTU_RESP:
+			att_mtu_resp_dump(level + 1, frm);
+			break;
 		case ATT_OP_HANDLE_NOTIFY:
 			att_handle_notify_dump(level + 1, frm);
 			break;
-- 
1.7.1

