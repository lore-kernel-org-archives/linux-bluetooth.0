Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 2/6] monitor/rfcomm: Add support for RFCOMM commands
Date: Mon, 03 Nov 2014 16:11:29 +0530
Message-id: <1415011293-29661-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415011293-29661-1-git-send-email-gowtham.ab@samsung.com>
References: <1415011293-29661-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode RFCOMM specific commands in btmon.
---
 monitor/rfcomm.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 7d38a28..395a7b8 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -44,18 +44,87 @@
 #include "sdp.h"
 #include "rfcomm.h"
 
+#define GET_LEN8(length) ((length & 0xfe) >> 1)
+#define GET_LEN16(length) ((length & 0xfffe) >> 1)
+
+struct rfcomm_lhdr {
+	uint8_t address;
+	uint8_t control;
+	uint16_t length;
+} __attribute__((packed));
+
 const char *opcode_color;
 
+static void print_rfcomm_hdr(const struct l2cap_frame *frame,
+						struct rfcomm_lhdr hdr)
+{
+}
+
+static bool uih_frame(const struct l2cap_frame *frame, struct rfcomm_lhdr hdr)
+{
+	return true;
+}
+
 void rfcomm_packet(const struct l2cap_frame *frame)
 {
+	uint8_t ctr_type, length, ex_length;
+	const char *opcode_str;
+	struct rfcomm_lhdr hdr;
+	struct l2cap_frame rfcomm_frame;
+
+	l2cap_frame_pull(&rfcomm_frame, frame, 0);
+
+	if (!l2cap_frame_get_u8(&rfcomm_frame, &hdr.address) ||
+			!l2cap_frame_get_u8(&rfcomm_frame, &hdr.control) ||
+			!l2cap_frame_get_u8(&rfcomm_frame, &length))
+		goto fail;
+
+	if (RFCOMM_TEST_EA(length))
+		hdr.length = (uint16_t) GET_LEN8(length);
+	else {
+		if (!l2cap_frame_get_u8(&rfcomm_frame, &ex_length))
+			goto fail;
+		hdr.length = ((uint16_t)length << 8) | ex_length;
+		hdr.length = GET_LEN16(hdr.length);
+	}
+
 	if (frame->in)
 		opcode_color = COLOR_MAGENTA;
 	else
 		opcode_color = COLOR_BLUE;
 
-	print_indent(7, opcode_color, "RFCOMM: ", "", 
-							COLOR_OFF, "");
+	ctr_type = RFCOMM_GET_TYPE(hdr.control);
+
+	if (ctr_type == RFCOMM_UIH) {
+		if (uih_frame(&rfcomm_frame, hdr))
+			return;
+		goto fail;
+	} else {
+		switch (ctr_type) {
+		case RFCOMM_SABM:
+			opcode_str = "SABM";
+			break;
+		case RFCOMM_UA:
+			opcode_str = "UA";
+			break;
+		case RFCOMM_DM:
+			opcode_str = "DM";
+			break;
+		case RFCOMM_DISC:
+			opcode_str = "DISC";
+			break;
+		default:
+			opcode_str = "ERR";
+		}
+
+		print_indent(7, opcode_color, "RFCOMM(s): ", opcode_str,
+								COLOR_OFF, "");
+		print_rfcomm_hdr(&rfcomm_frame, hdr);
+		return;
+	}
 
+fail:
+	print_text(COLOR_ERROR, "Frame too short");
 	packet_hexdump(frame->data, frame->size);
 	return;
 }
-- 
1.9.1

