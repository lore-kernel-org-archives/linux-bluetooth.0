Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 5/5] monitor/rfcomm: Add support for NSC frame decoding
Date: Tue, 02 Dec 2014 15:07:37 +0530
Message-id: <1417513057-16037-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1417513057-16037-1-git-send-email-gowtham.ab@samsung.com>
References: <1417513057-16037-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode NSC frame in RFCOMM for btmon.
Not able capture the output.
---
 monitor/rfcomm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index b448527..69ca195 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -118,6 +118,9 @@ struct rfcomm_rls {
 	uint8_t error;
 } __attribute__((packed));
 
+struct rfcomm_nsc {
+	uint8_t cmd_type;
+} __attribute__((packed));
 
 struct rfcomm_lmcc {
 	uint8_t type;
@@ -290,6 +293,19 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	return true;
 }
 
+static inline bool mcc_nsc(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
+	struct rfcomm_nsc nsc;
+
+	if (!l2cap_frame_get_u8(frame, &nsc.cmd_type))
+		return false;
+
+	print_field("%*ccr %d, mcc_cmd_type %x", indent, ' ',
+		GET_CR(nsc.cmd_type), RFCOMM_GET_MCC_TYPE(nsc.cmd_type));
+
+	return true;
+}
 
 struct mcc_data {
 	uint8_t type;
@@ -360,6 +376,8 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 		return mcc_rls(rfcomm_frame, indent+2);
 	case RFCOMM_PN:
 		return mcc_pn(rfcomm_frame, indent+2);
+	case RFCOMM_NSC:
+		return mcc_nsc(rfcomm_frame, indent+2);
 	default:
 		packet_hexdump(frame->data, frame->size);
 	}
-- 
1.9.1

