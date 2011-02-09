Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH -v3 3/6] Add ATT error pdu dump
Date: Wed,  9 Feb 2011 14:28:52 -0300
Message-Id: <1297272535-14890-3-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1297272535-14890-1-git-send-email-andre.dieb@signove.com>
References: <1297272535-14890-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 261dfe6..3717839 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -66,6 +66,26 @@
 #define ATT_OP_HANDLE_CNF		0x1E
 #define ATT_OP_SIGNED_WRITE_CMD		0xD2
 
+/* Error codes for Error response PDU */
+#define ATT_ECODE_INVALID_HANDLE		0x01
+#define ATT_ECODE_READ_NOT_PERM			0x02
+#define ATT_ECODE_WRITE_NOT_PERM		0x03
+#define ATT_ECODE_INVALID_PDU			0x04
+#define ATT_ECODE_INSUFF_AUTHEN			0x05
+#define ATT_ECODE_REQ_NOT_SUPP			0x06
+#define ATT_ECODE_INVALID_OFFSET		0x07
+#define ATT_ECODE_INSUFF_AUTHO			0x08
+#define ATT_ECODE_PREP_QUEUE_FULL		0x09
+#define ATT_ECODE_ATTR_NOT_FOUND		0x0A
+#define ATT_ECODE_ATTR_NOT_LONG			0x0B
+#define ATT_ECODE_INSUFF_ENCR_KEY_SIZE		0x0C
+#define ATT_ECODE_INVAL_ATTR_VALUE_LEN		0x0D
+#define ATT_ECODE_UNLIKELY			0x0E
+#define ATT_ECODE_INSUFF_ENC			0x0F
+#define ATT_ECODE_UNSUPP_GRP_TYPE		0x10
+#define ATT_ECODE_INSUFF_RESOURCES		0x11
+#define ATT_ECODE_IO				0xFF
+
 
 /* Attribute Protocol Opcodes */
 static const char *attop2str(uint8_t op)
@@ -132,6 +152,63 @@ static const char *attop2str(uint8_t op)
 	}
 }
 
+static const char * atterror2str(uint8_t err)
+{
+	switch (err) {
+	case ATT_ECODE_INVALID_HANDLE:
+		return "Invalid handle";
+	case ATT_ECODE_READ_NOT_PERM:
+		return "Read not permitted";
+	case ATT_ECODE_WRITE_NOT_PERM:
+		return "Write not permitted";
+	case ATT_ECODE_INVALID_PDU:
+		return "Invalid PDU";
+	case ATT_ECODE_INSUFF_AUTHEN:
+		return "Insufficient authentication";
+	case ATT_ECODE_REQ_NOT_SUPP:
+		return "Request not supported";
+	case ATT_ECODE_INVALID_OFFSET:
+		return "Invalid offset";
+	case ATT_ECODE_INSUFF_AUTHO:
+		return "Insufficient authorization";
+	case ATT_ECODE_PREP_QUEUE_FULL:
+		return "Prepare queue full";
+	case ATT_ECODE_ATTR_NOT_FOUND:
+		return "Attribute not found";
+	case ATT_ECODE_ATTR_NOT_LONG:
+		return "Attribute not long";
+	case ATT_ECODE_INSUFF_ENCR_KEY_SIZE:
+		return "Insufficient encryption key size";
+	case ATT_ECODE_INVAL_ATTR_VALUE_LEN:
+		return "Invalid attribute value length";
+	case ATT_ECODE_UNLIKELY:
+		return "Unlikely error";
+	case ATT_ECODE_INSUFF_ENC:
+		return "Insufficient encryption";
+	case ATT_ECODE_UNSUPP_GRP_TYPE:
+		return "Unsupported group type";
+	case ATT_ECODE_INSUFF_RESOURCES:
+		return "Insufficient resources";
+	case ATT_ECODE_IO:
+		return "Application Error";
+	default:
+		return "Reserved";
+	}
+}
+
+static void att_error_dump(int level, struct frame *frm)
+{
+	uint8_t op = get_u8(frm);
+	uint16_t handle = btohs(htons(get_u16(frm)));
+	uint8_t err = get_u8(frm);
+
+	p_indent(level, frm);
+	printf("Error: %s 0x%.2x\n", atterror2str(err), err);
+
+	p_indent(level, frm);
+	printf("opcode %d (%s) on handle 0x%2.2x\n", op, attop2str(op), handle);
+}
+
 static void att_mtu_req_dump(int level, struct frame *frm)
 {
 	uint16_t client_rx_mtu = btohs(htons(get_u16(frm)));
@@ -173,6 +250,9 @@ void att_dump(int level, struct frame *frm)
 	printf("ATT: %s (0x%.2x)\n", attop2str(op), op);
 
 	switch (op) {
+		case ATT_OP_ERROR:
+			att_error_dump(level + 1, frm);
+			break;
 		case ATT_OP_MTU_REQ:
 			att_mtu_req_dump(level + 1, frm);
 			break;
-- 
1.7.1

