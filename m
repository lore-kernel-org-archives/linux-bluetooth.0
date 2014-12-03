Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1  3/5] monitor/rfcomm: Add support for RLS frame decoding
Date: Wed, 03 Dec 2014 17:31:19 +0530
Message-id: <1417608081-27926-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
References: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode RLS frame in RFCOMM for btmon.

      RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
         Address: 0x03 cr 1 dlci 0x00
         Control: 0xef poll/final 0
         Length: 4
         FCS: 0x70
         MCC Message type: Remote Line Status CMD(0x14)
           Length: 2
           dlci 32 error: 5
---
 monitor/rfcomm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 62b52cc..848bad7 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -75,6 +75,9 @@ static char *cr_str[] = {
 #define GET_RPN_RTCI(io)	((io & 0x10) >> 4)
 #define GET_RPN_RTCO(io)	((io & 0x20) >> 5)
 
+/* RLS macro */
+#define GET_ERROR(err)		(err & 0x0f)
+
 struct rfcomm_lhdr {
 	uint8_t address;
 	uint8_t control;
@@ -99,6 +102,11 @@ struct rfcomm_rpn {
 	uint16_t pm;
 } __attribute__ ((packed));
 
+struct rfcomm_rls {
+	uint8_t dlci;
+	uint8_t error;
+} __attribute__((packed));
+
 struct rfcomm_lmcc {
 	uint8_t type;
 	uint16_t length;
@@ -209,6 +217,23 @@ done:
 	return true;
 }
 
+static inline bool mcc_rls(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
+	struct rfcomm_rls rls;
+
+	if (!l2cap_frame_get_u8(frame, &rls.dlci))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &rls.error))
+		return false;
+
+	print_field("%*cdlci %d error: %d", indent, ' ',
+			RFCOMM_GET_DLCI(rls.dlci), GET_ERROR(rls.error));
+
+	return true;
+}
+
 struct mcc_data {
 	uint8_t type;
 	const char *str;
@@ -274,6 +299,8 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 		return mcc_msc(rfcomm_frame, indent+2);
 	case RFCOMM_RPN:
 		return mcc_rpn(rfcomm_frame, indent+2);
+	case RFCOMM_RLS:
+		return mcc_rls(rfcomm_frame, indent+2);
 	default:
 		packet_hexdump(frame->data, frame->size);
 	}
-- 
1.9.1

