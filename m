Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v3 2/5] monitor: Add AVRCP SetPlayerApplicationSettingValue
 support
Date: Tue, 26 Aug 2014 19:50:49 +0530
Message-id: <1409062852-29295-2-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1409062852-29295-1-git-send-email-vikram.pal@samsung.com>
References: <1409062852-29295-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP SetPlayerApplicationSettingValue
added in Bluetooth monitor.
---
 monitor/avctp.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 936c40d..d7476a4 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -659,6 +659,38 @@ response:
 	return true;
 }
 
+static bool avrcp_set_player_value(struct l2cap_frame *frame, uint8_t ctype,
+					uint8_t len, uint8_t indent)
+{
+	uint8_t num;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		return true;
+
+	if (!l2cap_frame_get_u8(frame, &num))
+		return false;
+
+	print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (; num > 0; num--) {
+		uint8_t attr, value;
+
+		if (!l2cap_frame_get_u8(frame, &attr))
+			return false;
+
+		print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
+							attr, attr2str(attr));
+
+		if (!l2cap_frame_get_u8(frame, &value))
+			return false;
+
+		print_field("%*cValueID: 0x%02x (%s)", (indent - 8), ' ',
+						value, value2str(attr, value));
+	}
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct l2cap_frame *frame, uint8_t ctype, uint8_t len,
@@ -670,6 +702,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x11, avrcp_list_player_attributes		},
 	{ 0x12, avrcp_list_player_values		},
 	{ 0x13, avrcp_get_current_player_value		},
+	{ 0x14, avrcp_set_player_value			},
 	{ }
 };
 
-- 
1.9.1

