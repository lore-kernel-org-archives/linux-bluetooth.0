Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v2 4/6] monitor: Add AVRCP
 GetPlayerApplicationSettingAttributeText support
Date: Thu, 21 Aug 2014 16:00:23 +0530
Message-id: <1408617025-6841-4-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1408617025-6841-1-git-send-email-vikram.pal@samsung.com>
References: <1408617025-6841-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetPlayerApplicationSettingAttributeText
added in Bluetooth monitor.
---
 monitor/avctp.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 9d41d0b..7499c9c 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -28,6 +28,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <ctype.h>
 #include <string.h>
 #include <inttypes.h>
 
@@ -483,6 +484,39 @@ static const char *value2str(uint8_t attr, uint8_t value)
 	}
 }
 
+static const char *charset2str(uint16_t charset)
+{
+	switch (charset) {
+	case 1:
+	case 2:
+		return "Reserved";
+	case 3:
+		return "ASCII";
+	case 4:
+		return "ISO_8859-1";
+	case 5:
+		return "ISO_8859-2";
+	case 6:
+		return "ISO_8859-3";
+	case 7:
+		return "ISO_8859-4";
+	case 8:
+		return "ISO_8859-5";
+	case 9:
+		return "ISO_8859-6";
+	case 10:
+		return "ISO_8859-7";
+	case 11:
+		return "ISO_8859-8";
+	case 12:
+		return "ISO_8859-9";
+	case 106:
+		return "UTF-8";
+	default:
+		return "Unknown";
+	}
+}
+
 static void avrcp_passthrough_packet(const struct l2cap_frame *frame)
 {
 }
@@ -662,6 +696,58 @@ static void avrcp_get_player_attribute_text(const struct l2cap_frame *frame,
 						uint8_t ctype, uint8_t len,
 						uint8_t indent)
 {
+	uint8_t num, i, j;
+	uint8_t *data = (uint8_t *) frame->data;
+
+	if (len < 1) {
+		print_text(COLOR_ERROR, "PDU malformed");
+		packet_hexdump(frame->data, frame->size);
+		return;
+	}
+
+	num = *data;
+	print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	for (i = 0; num > 0; num--, i++) {
+		uint8_t attr;
+
+		attr = *(data + 1 + i);
+		print_field("%*cAttributeID: 0x%02x (%s)",
+				(indent - 8), ' ', attr, attr2str(attr));
+	}
+
+	return;
+
+response:
+	for (i = 0; num > 0; num--, i++) {
+		uint8_t attr, len;
+		uint8_t totallen = 0;
+		uint16_t charset;
+
+		attr = *(data + 1 + 4 * i + totallen);
+		print_field("%*cAttributeID: 0x%02x (%s)",
+				(indent - 8), ' ', attr, attr2str(attr));
+
+		charset = get_be16(data + 2 + 4 * i + totallen);
+		print_field("%*cCharsetID: 0x%04x (%s)",
+					(indent - 8), ' ', charset,
+					charset2str(charset));
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
 
 static void avrcp_get_player_value_text(const struct l2cap_frame *frame,
-- 
1.9.1

