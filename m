Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v2 2/4] monitor/rfcomm: Add support for printing RFCOMM hdr
Date: Fri, 07 Nov 2014 21:13:36 +0530
Message-id: <1415375018-21866-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415375018-21866-1-git-send-email-gowtham.ab@samsung.com>
References: <1415375018-21866-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode RFCOMM hdr and print the same.

      RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
         Address: 0x01 cr 0 dlci 0x00
         Control: 0xef poll/final 0
         Length: 10
         FCS: 0xaa
        81 11 20 e0 27 00 9a 02 00 07 aa                 .. .'......
---
 monitor/rfcomm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 155bde2..8149ab7 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -44,6 +44,11 @@
 #include "sdp.h"
 #include "rfcomm.h"
 
+#define GET_LEN8(length) ((length & 0xfe) >> 1)
+#define GET_LEN16(length) ((length & 0xfffe) >> 1)
+#define GET_CR(type)	((type & 0x02) >> 1)
+#define GET_PF(ctr) (((ctr) >> 4) & 0x1)
+
 struct rfcomm_lhdr {
 	uint8_t address;
 	uint8_t control;
@@ -57,6 +62,24 @@ struct rfcomm_frame {
 	struct l2cap_frame l2cap_frame;
 };
 
+static void print_rfcomm_hdr(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
+{
+	struct rfcomm_lhdr hdr = rfcomm_frame->hdr;
+
+	/* Address field */
+	print_field("%*cAddress: 0x%2.2x cr %d dlci 0x%2.2x", indent, ' ',
+					hdr.address, GET_CR(hdr.address),
+					RFCOMM_GET_DLCI(hdr.address));
+
+	/* Control field */
+	print_field("%*cControl: 0x%2.2x poll/final %d", indent, ' ',
+					hdr.control, GET_PF(hdr.control));
+
+	/* Length and FCS */
+	print_field("%*cLength: %d", indent, ' ', hdr.length);
+	print_field("%*cFCS: 0x%2.2x", indent, ' ', hdr.fcs);
+}
+
 struct rfcomm_data {
 	uint8_t frame;
 	const char *str;
@@ -73,9 +96,9 @@ static const struct rfcomm_data rfcomm_table[] = {
 
 void rfcomm_packet(const struct l2cap_frame *frame)
 {
-	uint8_t ctype;
+	uint8_t ctype, length, ex_length, indent = 1;
 	const char *frame_str, *frame_color;
-	struct l2cap_frame *l2cap_frame;
+	struct l2cap_frame *l2cap_frame, tmp_frame;
 	struct rfcomm_frame rfcomm_frame;
 	struct rfcomm_lhdr hdr;
 	const struct rfcomm_data *rfcomm_data = NULL;
@@ -89,7 +112,23 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 		goto fail;
 
 	if (!l2cap_frame_get_u8(l2cap_frame, &hdr.address) ||
-			!l2cap_frame_get_u8(l2cap_frame, &hdr.control))
+			!l2cap_frame_get_u8(l2cap_frame, &hdr.control) ||
+			!l2cap_frame_get_u8(l2cap_frame, &length))
+		goto fail;
+
+	/* length maybe 1 or 2 octets */
+	if (RFCOMM_TEST_EA(length))
+		hdr.length = (uint16_t) GET_LEN8(length);
+	else {
+		if (!l2cap_frame_get_u8(l2cap_frame, &ex_length))
+			goto fail;
+		hdr.length = ((uint16_t)length << 8) | ex_length;
+		hdr.length = GET_LEN16(hdr.length);
+	}
+
+	l2cap_frame_pull(&tmp_frame, l2cap_frame, l2cap_frame->size-1);
+
+	if(!l2cap_frame_get_u8(&tmp_frame, &hdr.fcs))
 		goto fail;
 
 	/* Decoding frame type */
@@ -122,7 +161,12 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 						"(0x%2.2x)", ctype);
 
 	rfcomm_frame.hdr = hdr;
-	packet_hexdump(l2cap_frame->data, l2cap_frame->size);
+	print_rfcomm_hdr(&rfcomm_frame, indent);
+
+	/* UIH frame */
+	if(ctype == 0xef)
+		packet_hexdump(l2cap_frame->data, l2cap_frame->size);
+
 	return;
 
 fail:
-- 
1.9.1

