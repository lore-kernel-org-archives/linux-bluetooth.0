Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1  5/5] monitor/rfcomm: Add support for NSC frame decoding
Date: Wed, 03 Dec 2014 17:31:21 +0530
Message-id: <1417608081-27926-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
References: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode NSC frame in RFCOMM for btmon.
Not able capture the output.
---
 monitor/rfcomm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 2a82001..e90fc1c 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -113,6 +113,10 @@ struct rfcomm_rls {
 	uint8_t error;
 } __attribute__((packed));
 
+struct rfcomm_nsc {
+	uint8_t cmd_type;
+} __attribute__((packed));
+
 struct rfcomm_lmcc {
 	uint8_t type;
 	uint16_t length;
@@ -279,6 +283,20 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
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
+
 struct mcc_data {
 	uint8_t type;
 	const char *str;
@@ -348,6 +366,8 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
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

