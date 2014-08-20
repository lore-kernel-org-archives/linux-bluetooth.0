Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 1/7] monitor: Add AVRCP ListPlayerApplicationSettingValues
 support
Date: Wed, 20 Aug 2014 14:54:01 +0530
Message-id: <1408526647-23894-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP ListPlayerApplicationSettingValues
added in Bluetooth monitor.
---
 monitor/avctp.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 9df8e75..ff1de1e 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -429,6 +429,60 @@ static const char *attr2str(uint8_t attr)
 	}
 }
 
+static const char *value2str(uint8_t attr, uint8_t value)
+{
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_ILEGAL:
+		return "Illegal";
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		switch (value) {
+		case 0x01:
+			return "OFF";
+		case 0x02:
+			return "ON";
+		default:
+			return "Reserved";
+		}
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		switch (value) {
+		case 0x01:
+			return "OFF";
+		case 0x02:
+			return "Single Track Repeat";
+		case 0x03:
+			return "All Track Repeat";
+		case 0x04:
+			return "Group Repeat";
+		default:
+			return "Reserved";
+		}
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		switch (value) {
+		case 0x01:
+			return "OFF";
+		case 0x02:
+			return "All Track Suffle";
+		case 0x03:
+			return "Group Suffle";
+		default:
+			return "Reserved";
+		}
+	case AVRCP_ATTRIBUTE_SCAN:
+		switch (value) {
+		case 0x01:
+			return "OFF";
+		case 0x02:
+			return "All Track Scan";
+		case 0x03:
+			return "Group Scan";
+		default:
+			return "Reserved";
+		}
+	default:
+		return "Unknown";
+	}
+}
+
 static void avrcp_passthrough_packet(const struct l2cap_frame *frame)
 {
 }
@@ -504,6 +558,31 @@ static void avrcp_list_player_values(const struct l2cap_frame *frame,
 					uint8_t ctype, uint8_t len,
 					uint8_t indent)
 {
+	static uint8_t attr = 0;
+	uint8_t num, i;
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
+			uint8_t value;
+
+			value = *((uint8_t *) (frame->data + 1 + i));
+			print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
+					' ', value, value2str(attr, value));
+		}
+	} else {
+		attr = *((uint8_t *) frame->data);
+		print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
+							attr, attr2str(attr));
+	}
 }
 
 static void avrcp_get_current_player_value(const struct l2cap_frame *frame,
-- 
1.9.1

