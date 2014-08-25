Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v3] monitor: Add AVRCP ListPlayerApplicationSettingValues
 support
Date: Mon, 25 Aug 2014 16:46:22 +0530
Message-id: <1408965382-4897-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP ListPlayerApplicationSettingValues
added in Bluetooth monitor.
---
 monitor/avctp.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index ec2adcd..123b229 100644
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
@@ -504,6 +558,47 @@ static void avrcp_list_player_values(const struct l2cap_frame *frame,
 					uint8_t ctype, uint8_t len,
 					uint8_t indent)
 {
+	struct l2cap_frame avrcp_frame;
+	static uint8_t attr = 0;
+	uint8_t num;
+
+	if (len < 1)
+		goto error;
+
+	l2cap_frame_pull(&avrcp_frame, frame, 0);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (l2cap_frame_get_u8(&avrcp_frame, &attr))
+		goto error;
+
+	print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
+						attr, attr2str(attr));
+
+	return;
+
+response:
+	if (l2cap_frame_get_u8(&avrcp_frame, &num))
+		goto error;
+
+	print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (; num > 0; num--) {
+		uint8_t value;
+
+		if (l2cap_frame_get_u8(&avrcp_frame, &value))
+			goto error;
+
+		print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
+					' ', value, value2str(attr, value));
+	}
+
+	return;
+
+error:
+	print_text(COLOR_ERROR, "PDU malformed");
+	packet_hexdump(frame->data, frame->size);
 }
 
 static void avrcp_get_current_player_value(const struct l2cap_frame *frame,
-- 
1.9.1

