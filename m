Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 2/5] monitor/rfcomm: Add support for RPN frame decoding
Date: Tue, 02 Dec 2014 15:07:34 +0530
Message-id: <1417513057-16037-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1417513057-16037-1-git-send-email-gowtham.ab@samsung.com>
References: <1417513057-16037-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode RPN frame in RFCOMM for btmon.

      RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
         Address: 0x03 cr 1 dlci 0x00
         Control: 0xef poll/final 0
         Length: 10
         FCS: 0x70
         MCC Message type: Remote Port Negotiation Command CMD(0x24)
           Length: 8
           dlci 32
           br 3 db 2 sb 0 p 0 pt 0 xi 0 xo 0
           rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19
           pm 0x3f7f
---
 monitor/rfcomm.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 969b29f..5e5545c 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -68,6 +68,18 @@ static char *cr_str[] = {
 #define GET_BRK_SIG3(sigs)	((sigs & 0x08) >> 3)
 #define GET_BRK_SIG_LEN(sigs)	((sigs & 0xf0) >> 4)
 
+/* RPN macros */
+#define GET_RPN_DB(parity)	(parity & 0x03)
+#define GET_RPN_SB(parity)	((parity & 0x04) >> 2)
+#define GET_RPN_PARITY(parity)	((parity & 0x08) >> 3)
+#define GET_RPN_PTYPE(parity)	((parity & 0x03) >> 3)
+#define GET_RPN_XIN(io)		(io & 0x01)
+#define GET_RPN_XOUT(io)	((io & 0x02) >> 1)
+#define GET_RPN_RTRI(io)	((io & 0x04) >> 2)
+#define GET_RPN_RTRO(io)	((io & 0x08) >> 3)
+#define GET_RPN_RTCI(io)	((io & 0x10) >> 4)
+#define GET_RPN_RTCO(io)	((io & 0x20) >> 5)
+
 struct rfcomm_lhdr {
 	uint8_t address;
 	uint8_t control;
@@ -82,6 +94,16 @@ struct rfcomm_lmsc {
 	uint8_t break_sig;
 } __attribute__((packed));
 
+struct rfcomm_rpn {
+	uint8_t dlci;
+	uint8_t bit_rate;
+	uint8_t parity;
+	uint8_t io;
+	uint8_t xon;
+	uint8_t xoff;
+	uint16_t pm;
+} __attribute__ ((packed));
+
 struct rfcomm_lmcc {
 	uint8_t type;
 	uint16_t length;
@@ -148,6 +170,55 @@ done:
 	return true;
 }
 
+static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
+	struct rfcomm_rpn rpn;
+
+	if (!l2cap_frame_get_u8(frame, &rpn.dlci))
+		return false;
+
+	print_field("%*cdlci %d", indent, ' ', RFCOMM_GET_DLCI(rpn.dlci));
+
+	if (frame->size < 7)
+		goto done;
+
+	/* port value octets (optional) */
+
+	if (!l2cap_frame_get_u8(frame, &rpn.bit_rate))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &rpn.parity))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &rpn.io))
+		return false;
+
+	print_field("%*cbr %d db %d sb %d p %d pt %d xi %d xo %d", indent, ' ',
+		rpn.bit_rate, GET_RPN_DB(rpn.parity), GET_RPN_SB(rpn.parity),
+		GET_RPN_PARITY(rpn.parity), GET_RPN_PTYPE(rpn.parity),
+		GET_RPN_XIN(rpn.io), GET_RPN_XOUT(rpn.io));
+
+	if (!l2cap_frame_get_u8(frame, &rpn.xon))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &rpn.xoff))
+		return false;
+
+	print_field("%*crtri %d rtro %d rtci %d rtco %d xon %d xoff %d",
+		indent, ' ', GET_RPN_RTRI(rpn.io), GET_RPN_RTRO(rpn.io),
+		GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
+		rpn.xoff);
+
+	if (!l2cap_frame_get_be16(frame, &rpn.pm))
+		return false;
+
+	print_field("%*cpm 0x%04x", indent, ' ', __bswap_16(rpn.pm));
+
+done:
+	return true;
+}
+
 struct mcc_data {
 	uint8_t type;
 	const char *str;
@@ -211,6 +282,8 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	switch (type) {
 	case RFCOMM_MSC:
 		return mcc_msc(rfcomm_frame, indent+2);
+	case RFCOMM_RPN:
+		return mcc_rpn(rfcomm_frame, indent+2);
 	default:
 		packet_hexdump(frame->data, frame->size);
 	}
-- 
1.9.1

