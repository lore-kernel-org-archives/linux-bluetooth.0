Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v4] monitor: Add AVRCP GetCurrentPlayerApplicationSettingValue
 support
Date: Thu, 04 Sep 2014 14:10:13 +0530
Message-id: <1409820013-7468-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetCurrentPlayerApplicationSettingValue
added in Bluetooth monitor.
---
 monitor/avctp.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 64d4b58..c462381 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -609,6 +609,54 @@ response:
 	return true;
 }
 
+static bool avrcp_get_current_player_value(struct l2cap_frame *frame,
+						uint8_t ctype, uint8_t len,
+						uint8_t indent)
+{
+	uint8_t num;
+
+	if (!l2cap_frame_get_u8(frame, &num))
+		return false;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
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
+	print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (; num > 0; num--) {
+		uint8_t attr, value;
+
+		if (!l2cap_frame_get_u8(frame, &attr))
+			return false;
+
+		print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8),
+						' ', attr, attr2str(attr));
+
+		if (!l2cap_frame_get_u8(frame, &value))
+			return false;
+
+		print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
+					' ', value, value2str(attr, value));
+	}
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct l2cap_frame *frame, uint8_t ctype, uint8_t len,
@@ -619,6 +667,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x10, avrcp_get_capabilities			},
 	{ 0x11, avrcp_list_player_attributes		},
 	{ 0x12, avrcp_list_player_values		},
+	{ 0x13, avrcp_get_current_player_value		},
 	{ }
 };
 
-- 
1.9.1

