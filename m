Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 4/6] Monitor: Add AVRCP SetAddressedPlayer support
Date: Thu, 25 Sep 2014 15:48:21 +0530
Message-id: <1411640303-8491-4-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1411640303-8491-1-git-send-email-vikram.pal@samsung.com>
References: <1411640303-8491-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP SetAddressedPlayer added in Bluetooth
monitor.
---
 monitor/avctp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 98304dc..bb78a11 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1308,6 +1308,34 @@ static bool avrcp_set_absolute_volume(struct avctp_frame *avctp_frame,
 	return true;
 }
 
+static bool avrcp_set_addressed_player(struct avctp_frame *avctp_frame,
+						uint8_t ctype, uint8_t len,
+						uint8_t indent)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint16_t id;
+	uint8_t status;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (!l2cap_frame_get_be16(frame, &id))
+		return false;
+
+	print_field("%*cPlayerID: 0x%04x (%u)", (indent - 8), ' ', id, id);
+
+	return true;
+
+response:
+	if (!l2cap_frame_get_u8(frame, &status))
+		return false;
+
+	print_field("%*cStatus: 0x%02x (%s)", (indent - 8), ' ',
+						status, error2str(status));
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct avctp_frame *avctp_frame, uint8_t ctype,
@@ -1327,6 +1355,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x30, avrcp_get_play_status			},
 	{ 0x31, avrcp_register_notification		},
 	{ 0x50, avrcp_set_absolute_volume		},
+	{ 0x60, avrcp_set_addressed_player		},
 	{ }
 };
 
-- 
1.9.1

