Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH v2 5/6] monitor/rfcomm: Add handlers for mcc frame type
Date: Mon, 03 Nov 2014 20:55:22 +0530
Message-id: <1415028323-13861-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415028323-13861-1-git-send-email-gowtham.ab@samsung.com>
References: <1415028323-13861-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Changes made to decode different mcc frame type in RFCOMM
---
 monitor/rfcomm.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index a43b2a2..b85e8fd 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -90,6 +90,51 @@ static void print_rfcomm_hdr(const struct l2cap_frame *frame,
 	print_field("FCS : (0x%2.2x)", fcs);
 }
 
+static inline void mcc_test(const struct l2cap_frame *frame,
+				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
+{
+}
+
+static inline void mcc_fcon(const struct l2cap_frame *frame,
+				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
+{
+}
+
+static inline void mcc_fcoff(const struct l2cap_frame *frame,
+				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
+{
+}
+
+static inline void mcc_msc(const struct l2cap_frame *frame,
+				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
+{
+	packet_hexdump(frame->data, frame->size);
+}
+
+static inline void mcc_rpn(const struct l2cap_frame *frame,
+				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
+{
+	packet_hexdump(frame->data, frame->size);
+}
+
+static inline void mcc_rls(const struct l2cap_frame *frame,
+				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
+{
+	packet_hexdump(frame->data, frame->size);
+}
+
+static inline void mcc_pn(const struct l2cap_frame *frame,
+				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
+{
+	packet_hexdump(frame->data, frame->size);
+}
+
+static inline void mcc_nsc(const struct l2cap_frame *frame,
+				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
+{
+	packet_hexdump(frame->data, frame->size);
+}
+
 static const char *type2str(uint8_t type)
 {
 	switch (type) {
@@ -141,8 +186,37 @@ static inline bool mcc_frame(const struct l2cap_frame *frame,
 	print_indent(7, opcode_color, "RFCOMM(s): ", "", COLOR_OFF, "%s %s",
 					type2str(type), CR_STR(mcc.type));
 
-	print_rfcomm_hdr(&rfcomm_frame, hdr);
-	packet_hexdump(rfcomm_frame.data, rfcomm_frame.size);
+	switch (type) {
+	case RFCOMM_TEST:
+		mcc_test(&rfcomm_frame, hdr, mcc);
+		packet_hexdump(rfcomm_frame.data, rfcomm_frame.size);
+		break;
+	case RFCOMM_FCON:
+		mcc_fcon(&rfcomm_frame, hdr, mcc);
+		break;
+	case RFCOMM_FCOFF:
+		mcc_fcoff(&rfcomm_frame, hdr, mcc);
+		break;
+	case RFCOMM_MSC:
+		mcc_msc(&rfcomm_frame, hdr, mcc);
+		break;
+	case RFCOMM_RPN:
+		mcc_rpn(&rfcomm_frame, hdr, mcc);
+		break;
+	case RFCOMM_RLS:
+		mcc_rls(&rfcomm_frame, hdr, mcc);
+		break;
+	case RFCOMM_PN:
+		mcc_pn(&rfcomm_frame, hdr, mcc);
+		break;
+	case RFCOMM_NSC:
+		mcc_nsc(&rfcomm_frame, hdr, mcc);
+		break;
+	default:
+		print_field("MCC message type 0x%02x: ", type);
+		print_rfcomm_hdr(&rfcomm_frame, hdr);
+		packet_hexdump(rfcomm_frame.data, rfcomm_frame.size);
+	}
 
 	return true;
 }
-- 
1.9.1

