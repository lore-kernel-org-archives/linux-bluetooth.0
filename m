Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 1/2] monitor/rfcomm: Add support for decoding Test command
Date: Wed, 17 Dec 2014 17:29:44 +0530
Message-id: <1418817585-26816-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1418817585-26816-1-git-send-email-gowtham.ab@samsung.com>
References: <1418817585-26816-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

          RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
             Address: 0x01 cr 0 dlci 0x00
             Control: 0xef poll/final 0
             Length: 6
             FCS: 0xaa
             MCC Message type: Test Command RSP(0x08)
               Length: 4
               Test Data: 0x 5f 54 65 73
---
 monitor/rfcomm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 7d22fa0..be215a1 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -146,6 +146,23 @@ static void print_rfcomm_hdr(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	print_field("%*cFCS: 0x%2.2x", indent, ' ', hdr.fcs);
 }
 
+static inline bool mcc_test(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
+	uint8_t data;
+
+	printf("%*cTest Data: 0x ", indent, ' ');
+
+	while (frame->size > 1) {
+		if (!l2cap_frame_get_u8(frame, &data))
+			return false;
+		printf("%2.2x ", data);
+	}
+
+	printf("\n");
+	return true;
+}
+
 static inline bool mcc_msc(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 {
 	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
@@ -358,6 +375,8 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	rfcomm_frame->mcc = mcc;
 
 	switch (type) {
+	case RFCOMM_TEST:
+		return mcc_test(rfcomm_frame, indent+10);
 	case RFCOMM_MSC:
 		return mcc_msc(rfcomm_frame, indent+2);
 	case RFCOMM_RPN:
-- 
1.9.1

