Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1  4/5] monitor/rfcomm: Add support for PN frame decoding
Date: Wed, 03 Dec 2014 17:31:20 +0530
Message-id: <1417608081-27926-5-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
References: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode PN frame in RFCOMM for btmon.

      RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
         Address: 0x01 cr 0 dlci 0x00
         Control: 0xef poll/final 0
         Length: 10
         FCS: 0xaa
         MCC Message type: DLC Parameter Negotiation RSP(0x20)
           Length: 8
           dlci 32 frame_type 0 credit_flow 14 pri 39
           ack_timer 0 frame_size 666 max_retrans 0 credits 7
---
 monitor/rfcomm.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 848bad7..2a82001 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -78,6 +78,12 @@ static char *cr_str[] = {
 /* RLS macro */
 #define GET_ERROR(err)		(err & 0x0f)
 
+/* PN macros */
+#define GET_FRM_TYPE(ctrl)	((ctrl & 0x0f))
+#define GET_CRT_FLOW(ctrl)	((ctrl & 0xf0) >> 4)
+#define GET_PRIORITY(prio)	((prio & 0x3f))
+#define GET_PN_DLCI(dlci)	((dlci & 0x3f))
+
 struct rfcomm_lhdr {
 	uint8_t address;
 	uint8_t control;
@@ -234,6 +240,45 @@ static inline bool mcc_rls(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	return true;
 }
 
+static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
+	struct rfcomm_pn pn;
+
+	/* rfcomm_pn struct is defined in rfcomm.h */
+
+	if (!l2cap_frame_get_u8(frame, &pn.dlci))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &pn.flow_ctrl))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &pn.priority))
+		return false;
+
+	print_field("%*cdlci %d frame_type %d credit_flow %d pri %d", indent,
+			' ', GET_PN_DLCI(pn.dlci), GET_FRM_TYPE(pn.flow_ctrl),
+			GET_CRT_FLOW(pn.flow_ctrl), GET_PRIORITY(pn.priority));
+
+	if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
+		return false;
+
+	if (!l2cap_frame_get_be16(frame, &pn.mtu))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &pn.credits))
+		return false;
+
+	print_field("%*cack_timer %d frame_size %d max_retrans %d credits %d",
+			indent, ' ', pn.ack_timer, __bswap_16(pn.mtu),
+			pn.max_retrans, pn.credits);
+
+	return true;
+}
+
 struct mcc_data {
 	uint8_t type;
 	const char *str;
@@ -301,6 +346,8 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 		return mcc_rpn(rfcomm_frame, indent+2);
 	case RFCOMM_RLS:
 		return mcc_rls(rfcomm_frame, indent+2);
+	case RFCOMM_PN:
+		return mcc_pn(rfcomm_frame, indent+2);
 	default:
 		packet_hexdump(frame->data, frame->size);
 	}
-- 
1.9.1

