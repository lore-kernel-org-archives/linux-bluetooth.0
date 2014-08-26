Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v3 3/5] monitor: Add AVRCP
 GetPlayerApplicationSettingAttributeText support
Date: Tue, 26 Aug 2014 19:50:50 +0530
Message-id: <1409062852-29295-3-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1409062852-29295-1-git-send-email-vikram.pal@samsung.com>
References: <1409062852-29295-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetPlayerApplicationSettingAttributeText
added in Bluetooth monitor.
---
 monitor/avctp.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index d7476a4..3e02676 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 #include <inttypes.h>
 
 #include <bluetooth/bluetooth.h>
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
 static bool avrcp_passthrough_packet(struct l2cap_frame *frame)
 {
 	packet_hexdump(frame->data, frame->size);
@@ -691,6 +725,69 @@ static bool avrcp_set_player_value(struct l2cap_frame *frame, uint8_t ctype,
 	return true;
 }
 
+static bool avrcp_get_player_attribute_text(struct l2cap_frame *frame,
+						uint8_t ctype, uint8_t len,
+						uint8_t indent)
+{
+	uint8_t num;
+
+	if (!l2cap_frame_get_u8(frame, &num))
+		return false;
+
+	print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	for (; num > 0; num--) {
+		uint8_t attr;
+
+		if (!l2cap_frame_get_u8(frame, &attr))
+			return false;
+
+		print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8),
+						' ', attr, attr2str(attr));
+	}
+
+	return true;
+
+response:
+	for (; num > 0; num--) {
+		uint8_t attr, len;
+		uint16_t charset;
+
+		if (!l2cap_frame_get_u8(frame, &attr))
+			return false;
+
+		print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8),
+						' ', attr, attr2str(attr));
+
+		if (!l2cap_frame_get_be16(frame, &charset))
+			return false;
+
+		print_field("%*cCharsetID: 0x%04x (%s)", (indent - 8),
+					' ', charset, charset2str(charset));
+
+		if (!l2cap_frame_get_u8(frame, &len))
+			return false;
+
+		print_field("%*cStringLength: 0x%02x", (indent - 8), ' ', len);
+
+		printf("String: ");
+		for (; len > 0; len--) {
+			uint8_t c;
+
+			if (!l2cap_frame_get_u8(frame, &c))
+				return false;
+
+			printf("%1c", isprint(c) ? c : '.');
+		}
+		printf("\n");
+	}
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct l2cap_frame *frame, uint8_t ctype, uint8_t len,
@@ -703,6 +800,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x12, avrcp_list_player_values		},
 	{ 0x13, avrcp_get_current_player_value		},
 	{ 0x14, avrcp_set_player_value			},
+	{ 0x15, avrcp_get_player_attribute_text		},
 	{ }
 };
 
-- 
1.9.1

