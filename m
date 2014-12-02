Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 1/5] monitor/rfcomm.c: Add support for MSC frame decoding
Date: Tue, 02 Dec 2014 15:07:33 +0530
Message-id: <1417513057-16037-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1417513057-16037-1-git-send-email-gowtham.ab@samsung.com>
References: <1417513057-16037-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode MSC frame in RFCOMM for btmon.

      RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
         Address: 0x01 cr 0 dlci 0x00
         Control: 0xef poll/final 0
         Length: 4
         FCS: 0xaa
         MCC Message type: Modem Status Command CMD(0x38)
           Length: 2
           dlci 32
           fc 0 rtc 1 rtr 1 ic 0 dv 1
---
 monitor/rfcomm.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index b3db98b..969b29f 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -49,11 +49,24 @@ static char *cr_str[] = {
 	"CMD"
 };
 
-#define CR_STR(type) cr_str[GET_CR(type)]
-#define GET_LEN8(length) ((length & 0xfe) >> 1)
-#define GET_LEN16(length) ((length & 0xfffe) >> 1)
-#define GET_CR(type)	((type & 0x02) >> 1)
-#define GET_PF(ctr) (((ctr) >> 4) & 0x1)
+/* RFCOMM frame parsing macros */
+#define CR_STR(type)		cr_str[GET_CR(type)]
+#define GET_LEN8(length)	((length & 0xfe) >> 1)
+#define GET_LEN16(length)	((length & 0xfffe) >> 1)
+#define GET_CR(type)		((type & 0x02) >> 1)
+#define GET_PF(ctr)		(((ctr) >> 4) & 0x1)
+
+/* MSC macros */
+#define GET_V24_FC(sigs)	((sigs & 0x02) >> 1)
+#define GET_V24_RTC(sigs)	((sigs & 0x04) >> 2)
+#define GET_V24_RTR(sigs)	((sigs & 0x08) >> 3)
+#define GET_V24_IC(sigs)	((sigs & 0x40) >> 6)
+#define GET_V24_DV(sigs)	((sigs & 0x80) >> 7)
+
+#define GET_BRK_SIG1(sigs)	((sigs & 0x02) >> 1)
+#define GET_BRK_SIG2(sigs)	((sigs & 0x04) >> 2)
+#define GET_BRK_SIG3(sigs)	((sigs & 0x08) >> 3)
+#define GET_BRK_SIG_LEN(sigs)	((sigs & 0xf0) >> 4)
 
 struct rfcomm_lhdr {
 	uint8_t address;
@@ -63,6 +76,12 @@ struct rfcomm_lhdr {
 	uint8_t credits; /* only for UIH frame */
 } __attribute__((packed));
 
+struct rfcomm_lmsc {
+	uint8_t dlci;
+	uint8_t v24_sig;
+	uint8_t break_sig;
+} __attribute__((packed));
+
 struct rfcomm_lmcc {
 	uint8_t type;
 	uint16_t length;
@@ -92,6 +111,43 @@ static void print_rfcomm_hdr(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	print_field("%*cFCS: 0x%2.2x", indent, ' ', hdr.fcs);
 }
 
+static inline bool mcc_msc(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
+	struct rfcomm_lmsc msc;
+
+	if (!l2cap_frame_get_u8(frame, &msc.dlci))
+		return false;
+
+	print_field("%*cdlci %d ", indent, ' ', RFCOMM_GET_DLCI(msc.dlci));
+
+	if (!l2cap_frame_get_u8(frame, &msc.v24_sig))
+		return false;
+
+	/* v24 control signals */
+	print_field("%*cfc %d rtc %d rtr %d ic %d dv %d", indent, ' ',
+		GET_V24_FC(msc.v24_sig), GET_V24_RTC(msc.v24_sig),
+		GET_V24_RTR(msc.v24_sig), GET_V24_IC(msc.v24_sig),
+					GET_V24_DV(msc.v24_sig));
+
+	if (frame->size < 2)
+		goto done;
+
+	/* break signals (optional) */
+
+	if (!l2cap_frame_get_u8(frame, &msc.break_sig))
+		return false;
+
+	printf("%2.2x", msc.break_sig);
+
+	print_field("%*cb1 %d b2 %d b3 %d len %d", indent, ' ',
+		GET_BRK_SIG1(msc.break_sig), GET_BRK_SIG2(msc.break_sig),
+		GET_BRK_SIG3(msc.break_sig), GET_BRK_SIG_LEN(msc.break_sig));
+
+done:
+	return true;
+}
+
 struct mcc_data {
 	uint8_t type;
 	const char *str;
@@ -151,7 +207,13 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	print_field("%*cLength: %d", indent+2, ' ', mcc.length);
 
 	rfcomm_frame->mcc = mcc;
-	packet_hexdump(frame->data, frame->size);
+
+	switch (type) {
+	case RFCOMM_MSC:
+		return mcc_msc(rfcomm_frame, indent+2);
+	default:
+		packet_hexdump(frame->data, frame->size);
+	}
 
 	return true;
 }
@@ -225,7 +287,7 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 
 	l2cap_frame_pull(&tmp_frame, l2cap_frame, l2cap_frame->size-1);
 
-	if(!l2cap_frame_get_u8(&tmp_frame, &hdr.fcs))
+	if (!l2cap_frame_get_u8(&tmp_frame, &hdr.fcs))
 		goto fail;
 
 	/* Decoding frame type */
-- 
1.9.1

