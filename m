Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH v2 6/6] monitor/rfcomm: Add mcc type handlers code
Date: Mon, 03 Nov 2014 20:55:23 +0530
Message-id: <1415028323-13861-7-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415028323-13861-1-git-send-email-gowtham.ab@samsung.com>
References: <1415028323-13861-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Adds different mcc type handlers code to print in btmon.
---
Below provided is the btmon rfcomm logs.
> ACL Data RX: Handle 75 flags 0x02 dlen 8                     [hci0] 22.280283
      Channel: 65 len 4 [PSM 3 mode 0] {chan 1}
       RFCOMM(s): SABM
        Address : (0x83)
        CR Bit: 1
        DLCI : (0x20)
        Poll/FInal Bit : 1
        Length : 0
        FCS : (0xca)
< ACL Data TX: Handle 75 flags 0x00 dlen 8                     [hci0] 22.317803
      Channel: 65 len 4 [PSM 3 mode 0] {chan 1}
       RFCOMM(s): UA
        Address : (0x83)
        CR Bit: 1
        DLCI : (0x20)
        Poll/FInal Bit : 1
        Length : 0
        FCS : (0x01)
< ACL Data TX: Handle 75 flags 0x00 dlen 12                    [hci0] 22.317822
      Channel: 65 len 8 [PSM 3 mode 0] {chan 1}
       RFCOMM(s): MSC CMD
        Address : (0x01)
        CR Bit: 0
        DLCI : (0x00)
        Poll/FInal Bit : 0
        Length : 4
        FCS : (0xaa)
        MCC Length 2
        83 8d aa                                         ...             
< ACL Data TX: Handle 75 flags 0x00 dlen 9                     [hci0] 22.346681
      Channel: 65 len 5 [PSM 3 mode 0] {chan 1}
       RFCOMM(d): UIH 
        Address : (0x81)
        CR Bit: 0
        DLCI : (0x20)
        Poll/FInal Bit : 1
        Length : 0
        FCS : (0x1e)
        Credits 33
---
 monitor/rfcomm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index b85e8fd..10dc4e8 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -90,48 +90,69 @@ static void print_rfcomm_hdr(const struct l2cap_frame *frame,
 	print_field("FCS : (0x%2.2x)", fcs);
 }
 
+static void print_mcc(struct rfcomm_lmcc mcc)
+{
+	print_field("MCC Length %d", mcc.length);
+}
+
 static inline void mcc_test(const struct l2cap_frame *frame,
 				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
 {
+	print_rfcomm_hdr(frame, hdr);
+	print_mcc(mcc);
 }
 
 static inline void mcc_fcon(const struct l2cap_frame *frame,
 				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
 {
+	print_rfcomm_hdr(frame, hdr);
+	print_mcc(mcc);
 }
 
 static inline void mcc_fcoff(const struct l2cap_frame *frame,
 				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
 {
+	print_rfcomm_hdr(frame, hdr);
+	print_mcc(mcc);
 }
 
 static inline void mcc_msc(const struct l2cap_frame *frame,
 				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
 {
+	print_rfcomm_hdr(frame, hdr);
+	print_mcc(mcc);
 	packet_hexdump(frame->data, frame->size);
 }
 
 static inline void mcc_rpn(const struct l2cap_frame *frame,
 				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
 {
+	print_rfcomm_hdr(frame, hdr);
+	print_mcc(mcc);
 	packet_hexdump(frame->data, frame->size);
 }
 
 static inline void mcc_rls(const struct l2cap_frame *frame,
 				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
 {
+	print_rfcomm_hdr(frame, hdr);
+	print_mcc(mcc);
 	packet_hexdump(frame->data, frame->size);
 }
 
 static inline void mcc_pn(const struct l2cap_frame *frame,
 				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
 {
+	print_rfcomm_hdr(frame, hdr);
+	print_mcc(mcc);
 	packet_hexdump(frame->data, frame->size);
 }
 
 static inline void mcc_nsc(const struct l2cap_frame *frame,
 				struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
 {
+	print_rfcomm_hdr(frame, hdr);
+	print_mcc(mcc);
 	packet_hexdump(frame->data, frame->size);
 }
 
-- 
1.9.1

