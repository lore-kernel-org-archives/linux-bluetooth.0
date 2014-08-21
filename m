Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v2 5/6] monitor: Add AVRCP GetPlayerApplicationSettingValueText
 support
Date: Thu, 21 Aug 2014 16:00:24 +0530
Message-id: <1408617025-6841-5-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1408617025-6841-1-git-send-email-vikram.pal@samsung.com>
References: <1408617025-6841-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetPlayerApplicationSettingValueText
added in Bluetooth monitor.
---
 monitor/avctp.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 7499c9c..e0ab981 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -754,6 +754,63 @@ static void avrcp_get_player_value_text(const struct l2cap_frame *frame,
 					uint8_t ctype, uint8_t len,
 					uint8_t indent)
 {
+	static uint8_t attr = 0;
+	uint8_t num, i, j;
+	uint8_t *data = (uint8_t *) frame->data;
+
+	if (len < 1) {
+		print_text(COLOR_ERROR, "PDU malformed");
+		packet_hexdump(frame->data, frame->size);
+		return;
+	}
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	attr = *data;
+	print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
+						attr, attr2str(attr));
+
+	num = *(data + 1);
+	print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (i = 0; num > 0; num--, i++) {
+		uint8_t value = *(data + 2 + i);
+		print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
+				' ', value, value2str(attr, value));
+	}
+
+	return;
+
+response:
+	num = *data;
+	print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (i = 0; num > 0; num--, i++) {
+		uint8_t value, len;
+		uint8_t totallen = 0;
+		uint16_t charset;
+
+		value = *(data + 1 + 4 * i + totallen);
+		print_field("%*cValueID: 0x%02x (%s)", (indent - 8), ' ',
+						value, value2str(attr, value));
+
+		charset = get_be16(data + 2 + 4 * i + totallen);
+		print_field("%*cCharsetIDID: 0x%02x (%s)", (indent - 8), ' ',
+						charset, charset2str(charset));
+
+		len = *(data + 4 + 4 * i + totallen);
+		print_field("%*cStringLength: 0x%02x", (indent - 8), ' ', len);
+
+		totallen =+ len;
+
+		printf("String: ");
+		for (j = 0; len > 0; len--, j++) {
+			uint8_t c = *(data + 5 + 4 * i + totallen + j);
+			printf("%1c", isprint(c) ? c : '.');
+		}
+		printf("\n");
+	}
 }
 
 static void avrcp_displayable_charset(const struct l2cap_frame *frame,
-- 
1.9.1

