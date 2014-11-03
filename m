Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com
Subject: [PATCH v1 6/6] monitor/rfcomm: Add mcc type handlers code
Date: Mon, 03 Nov 2014 16:11:33 +0530
Message-id: <1415011293-29661-7-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415011293-29661-1-git-send-email-gowtham.ab@samsung.com>
References: <1415011293-29661-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bharat Panda <bharat.panda@samsung.com>

Adds different mcc type handlers code to print in btmon.
---
 android/Android.mk |  1 +
 monitor/rfcomm.c   | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index aefe41c..eebd863 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -289,6 +289,7 @@ LOCAL_SRC_FILES := \
 	bluez/monitor/packet.c \
 	bluez/monitor/l2cap.c \
 	bluez/monitor/avctp.c \
+	bluez/monitor/rfcomm.c \
 	bluez/monitor/uuid.c \
 	bluez/monitor/sdp.c \
 	bluez/monitor/vendor.c \
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

