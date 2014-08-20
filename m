Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 5/7] monitor: Add AVRCP GetPlayerApplicationSettingValueText
 support
Date: Wed, 20 Aug 2014 14:54:05 +0530
Message-id: <1408526647-23894-5-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1408526647-23894-1-git-send-email-vikram.pal@samsung.com>
References: <1408526647-23894-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetPlayerApplicationSettingValueText
added in Bluetooth monitor.
---
 monitor/avctp.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index a3a2d84..6444c28 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -750,6 +750,62 @@ static void avrcp_get_player_value_text(const struct l2cap_frame *frame,
 					uint8_t ctype, uint8_t len,
 					uint8_t indent)
 {
+	static uint8_t attr = 0;
+	uint8_t num, i, j;
+
+	if (len < 1) {
+		print_text(COLOR_ERROR, "PDU malformed");
+		packet_hexdump(frame->data, frame->size);
+		return;
+	}
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY) {
+		num = *((uint8_t *) frame->data);
+		print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
+
+		for (i = 0; num > 0; num--, i++) {
+			uint8_t value, len;
+			uint8_t totallen = 0;
+			uint16_t charset;
+
+			value = *((uint8_t *) (frame->data + 1 + 4 * i + totallen));
+			print_field("%*cValueID: 0x%02x (%s)", (indent - 8), ' ',
+						value, value2str(attr, value));
+
+			charset = get_be16(frame->data + 2 + 4 * i + totallen);
+			print_field("%*cCharsetIDID: 0x%02x (%s)",
+					(indent - 8), ' ',
+					charset, charset2str(charset));
+
+			len = *((uint8_t *) (frame->data + 4 + 4 * i + totallen));
+			print_field("%*cStringLength: 0x%02x", (indent - 8), ' ', len);
+
+			totallen =+ len;
+
+			printf("String: ");
+			for (j = 0; len > 0; len--, j++) {
+				uint8_t c =
+					*((uint8_t *) (frame->data + 5 + 4 * i + totallen + j));
+				printf("%1c", isprint(c) ? c : '.');
+			}
+			printf("\n");
+		}
+	} else {
+		attr = *((uint8_t *) frame->data);
+		print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
+							attr, attr2str(attr));
+
+		num = *((uint8_t *) (frame->data + 1));
+		print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
+
+		for (i = 0; num > 0; num--, i++) {
+			uint8_t value;
+
+			value = *((uint8_t *) (frame->data + 2 + i));
+			print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
+					' ', value, value2str(attr, value));
+		}
+	}
 }
 
 static void avrcp_displayable_charset(const struct l2cap_frame *frame,
-- 
1.9.1

