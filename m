Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 6/7] monitor: Add AVRCP InformDisplayableCharacterSet support
Date: Wed, 20 Aug 2014 14:54:06 +0530
Message-id: <1408526647-23894-6-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1408526647-23894-1-git-send-email-vikram.pal@samsung.com>
References: <1408526647-23894-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP InformDisplayableCharacterSet added
in Bluetooth monitor.
---
 monitor/avctp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 6444c28..c75b3ff 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -812,6 +812,28 @@ static void avrcp_displayable_charset(const struct l2cap_frame *frame,
 					uint8_t ctype, uint8_t len,
 					uint8_t indent)
 {
+	uint8_t num, i;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		return;
+
+	if (len < 2) {
+		print_text(COLOR_ERROR, "PDU malformed");
+		packet_hexdump(frame->data, frame->size);
+		return;
+	}
+
+	num = *((uint8_t *) frame->data);
+	print_field("%*cCharsetCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (i = 0; num > 0; num--, i++) {
+		uint16_t charset;
+
+		charset = get_be16(frame->data + 1 + (2 * i));
+		print_field("%*cCharsetID: 0x%04x (%s)",
+					(indent - 8), ' ', charset,
+					charset2str(charset));
+	}
 }
 
 static void avrcp_ct_battery_status(const struct l2cap_frame *frame,
-- 
1.9.1

