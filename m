Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 4/7] monitor/rfcomm: Add support for mcc frame decoding
Date: Fri, 31 Oct 2014 20:38:31 +0530
Message-id: <1414768114-3775-5-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1414768114-3775-1-git-send-email-gowtham.ab@samsung.com>
References: <1414768114-3775-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode MCC frame in RFCOMM for btmon.
---
 monitor/rfcomm.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 6994ffd..a43b2a2 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -44,8 +44,15 @@
 #include "sdp.h"
 #include "rfcomm.h"
 
+static char *cr_str[] = {
+	"RSP",
+	"CMD"
+};
+
+#define CR_STR(type) cr_str[GET_CR(type)]
 #define GET_LEN8(length) ((length & 0xfe) >> 1)
 #define GET_LEN16(length) ((length & 0xfffe) >> 1)
+#define GET_CR(type)	((type & 0x02) >> 1)
 #define GET_PF(ctr) (((ctr) >> 4) & 0x1)
 
 struct rfcomm_lhdr {
@@ -54,17 +61,89 @@ struct rfcomm_lhdr {
 	uint16_t length;
 } __attribute__((packed));
 
+struct rfcomm_lmcc {
+	uint8_t type;
+	uint16_t length;
+} __attribute__((packed));
+
+
 const char *opcode_color;
 
 static void print_rfcomm_hdr(const struct l2cap_frame *frame,
 						struct rfcomm_lhdr hdr)
 {
+	uint8_t pf, dlci, fcs, cr, ilen;
+	const void *ptr;
+
+	dlci = RFCOMM_GET_DLCI(hdr.address);
+	pf = GET_PF(hdr.control);
+	cr = GET_CR(hdr.address);
+	ilen = hdr.length;
+	ptr = (frame->data)+frame->size-1;
+	fcs = *(uint8_t *)(ptr);
+
+	print_field("Address : (0x%2.2x)", hdr.address);
+	print_field("CR Bit: %d", cr);
+	print_field("DLCI : (0x%2.2x)", dlci);
+	print_field("Poll/FInal Bit : %d", pf);
+	print_field("Length : %d", ilen);
+	print_field("FCS : (0x%2.2x)", fcs);
+}
+
+static const char *type2str(uint8_t type)
+{
+	switch (type) {
+	case RFCOMM_TEST:
+		return "TEST";
+	case RFCOMM_FCON:
+		return "FCON";
+	case RFCOMM_FCOFF:
+		return "FCOFF";
+	case RFCOMM_MSC:
+		return "MSC";
+	case RFCOMM_RPN:
+		return "RPN";
+	case RFCOMM_RLS:
+		return "RLS";
+	case RFCOMM_PN:
+		return "PN";
+	case RFCOMM_NSC:
+		return "NSC";
+	default:
+		return "Unknown";
+	}
 }
 
 static inline bool mcc_frame(const struct l2cap_frame *frame,
 						struct rfcomm_lhdr hdr)
 {
-	packet_hexdump(frame->data, frame->size);
+	uint8_t length, ex_length, type;
+	struct l2cap_frame rfcomm_frame;
+	struct rfcomm_lmcc mcc;
+
+	l2cap_frame_pull(&rfcomm_frame, frame, 0);
+
+	if (!l2cap_frame_get_u8(&rfcomm_frame, &mcc.type) ||
+			!l2cap_frame_get_u8(&rfcomm_frame, &length))
+		return false;
+
+	if (RFCOMM_TEST_EA(length))
+		mcc.length = (uint16_t) GET_LEN8(length);
+	else {
+		if (!l2cap_frame_get_u8(&rfcomm_frame, &ex_length))
+			return false;
+		mcc.length = ((uint16_t) length << 8) | ex_length;
+		mcc.length = GET_LEN16(hdr.length);
+	}
+
+	type = RFCOMM_GET_MCC_TYPE(mcc.type);
+
+	print_indent(7, opcode_color, "RFCOMM(s): ", "", COLOR_OFF, "%s %s",
+					type2str(type), CR_STR(mcc.type));
+
+	print_rfcomm_hdr(&rfcomm_frame, hdr);
+	packet_hexdump(rfcomm_frame.data, rfcomm_frame.size);
+
 	return true;
 }
 
-- 
1.9.1

