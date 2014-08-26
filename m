Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v3 4/5] monitor: Add AVRCP GetPlayerApplicationSettingValueText
 support
Date: Tue, 26 Aug 2014 19:50:51 +0530
Message-id: <1409062852-29295-4-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1409062852-29295-1-git-send-email-vikram.pal@samsung.com>
References: <1409062852-29295-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetPlayerApplicationSettingValueText
added in Bluetooth monitor.
---
 monitor/avctp.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 3e02676..1bfd9cf 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -788,6 +788,81 @@ response:
 	return true;
 }
 
+static bool avrcp_get_player_value_text(struct l2cap_frame *frame,
+					uint8_t ctype, uint8_t len,
+					uint8_t indent)
+{
+	static uint8_t attr = 0;
+	uint8_t num;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (!l2cap_frame_get_u8(frame, &attr))
+		return false;
+
+	print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
+						attr, attr2str(attr));
+
+	if (!l2cap_frame_get_u8(frame, &num))
+		return false;
+
+	print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (; num > 0; num--) {
+		uint8_t value;
+
+		if (!l2cap_frame_get_u8(frame, &value))
+			return false;
+
+		print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
+				' ', value, value2str(attr, value));
+	}
+
+	return true;
+
+response:
+	if (!l2cap_frame_get_u8(frame, &num))
+		return false;
+
+	print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (; num > 0; num--) {
+		uint8_t value, len;
+		uint16_t charset;
+
+		if (!l2cap_frame_get_u8(frame, &value))
+			return false;
+
+		print_field("%*cValueID: 0x%02x (%s)", (indent - 8), ' ',
+						value, value2str(attr, value));
+
+		if (!l2cap_frame_get_be16(frame, &charset))
+			return false;
+
+		print_field("%*cCharsetIDID: 0x%02x (%s)", (indent - 8), ' ',
+						charset, charset2str(charset));
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
@@ -801,6 +876,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x13, avrcp_get_current_player_value		},
 	{ 0x14, avrcp_set_player_value			},
 	{ 0x15, avrcp_get_player_attribute_text		},
+	{ 0x16, avrcp_get_player_value_text		},
 	{ }
 };
 
-- 
1.9.1

