Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 3/6] Monitor: Add AVRCP SetAbsoluteVolume support
Date: Thu, 25 Sep 2014 15:48:20 +0530
Message-id: <1411640303-8491-3-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1411640303-8491-1-git-send-email-vikram.pal@samsung.com>
References: <1411640303-8491-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP SetAbsoluteVolume added in Bluetooth
monitor.
---
 monitor/avctp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 1ffcb7e..98304dc 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1291,6 +1291,23 @@ response:
 	return true;
 }
 
+static bool avrcp_set_absolute_volume(struct avctp_frame *avctp_frame,
+						uint8_t ctype, uint8_t len,
+						uint8_t indent)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint8_t value;
+
+	if (!l2cap_frame_get_u8(frame, &value))
+		return false;
+
+	value &= 0x7F;
+	print_field("%*cVolume: %.2f%% (%d/127)", (indent - 8),
+						' ', value/1.27, value);
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct avctp_frame *avctp_frame, uint8_t ctype,
@@ -1309,6 +1326,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x20, avrcp_get_element_attributes		},
 	{ 0x30, avrcp_get_play_status			},
 	{ 0x31, avrcp_register_notification		},
+	{ 0x50, avrcp_set_absolute_volume		},
 	{ }
 };
 
-- 
1.9.1

