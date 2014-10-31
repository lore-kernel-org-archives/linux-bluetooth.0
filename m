Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 3/7] monitor/rfcomm: Add support for UIH frame decoding
Date: Fri, 31 Oct 2014 20:38:30 +0530
Message-id: <1414768114-3775-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1414768114-3775-1-git-send-email-gowtham.ab@samsung.com>
References: <1414768114-3775-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode UIH frame in btmon.
---
 monitor/rfcomm.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 395a7b8..6994ffd 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -46,6 +46,7 @@
 
 #define GET_LEN8(length) ((length & 0xfe) >> 1)
 #define GET_LEN16(length) ((length & 0xfffe) >> 1)
+#define GET_PF(ctr) (((ctr) >> 4) & 0x1)
 
 struct rfcomm_lhdr {
 	uint8_t address;
@@ -60,8 +61,36 @@ static void print_rfcomm_hdr(const struct l2cap_frame *frame,
 {
 }
 
+static inline bool mcc_frame(const struct l2cap_frame *frame,
+						struct rfcomm_lhdr hdr)
+{
+	packet_hexdump(frame->data, frame->size);
+	return true;
+}
+
 static bool uih_frame(const struct l2cap_frame *frame, struct rfcomm_lhdr hdr)
 {
+	uint8_t credits;
+
+	struct l2cap_frame rfcomm_frame;
+
+	l2cap_frame_pull(&rfcomm_frame, frame, 0);
+
+	if (!RFCOMM_GET_CHANNEL(hdr.address)) {
+		return mcc_frame(&rfcomm_frame, hdr);
+	} else {
+		print_indent(7, opcode_color, "RFCOMM(d): UIH ", "",
+								COLOR_OFF, "");
+		print_rfcomm_hdr(&rfcomm_frame, hdr);
+		if (GET_PF(hdr.control)) {
+			if (!l2cap_frame_get_u8(&rfcomm_frame, &credits))
+				return false;
+			print_field("Credits %d", credits);
+			return true;
+		}
+	}
+
+	packet_hexdump(rfcomm_frame.data, rfcomm_frame.size);
 	return true;
 }
 
-- 
1.9.1

