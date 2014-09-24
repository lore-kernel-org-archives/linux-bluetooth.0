Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 6/6] Monitor: Add AVRCP AddToNowPlaying support
Date: Wed, 24 Sep 2014 17:10:32 +0530
Message-id: <1411558832-15458-6-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1411558832-15458-1-git-send-email-vikram.pal@samsung.com>
References: <1411558832-15458-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP AddToNowPlaying added in Bluetooth
monitor.
---
 monitor/avctp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 00f84cd..88f531b 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1233,6 +1233,48 @@ response:
 	return true;
 }
 
+static bool avrcp_add_to_now_playing(struct avctp_frame *avctp_frame,
+						uint8_t ctype, uint8_t len,
+						uint8_t indent)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint64_t uid;
+	uint16_t uidcounter;
+	uint8_t scope, status;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (!l2cap_frame_get_u8(frame, &scope))
+		return false;
+
+	print_field("%*cScope: 0x%02x (%s)", (indent - 8), ' ',
+						scope, scope2str(scope));
+
+	if (!l2cap_frame_get_be64(frame, &uid))
+		return false;
+
+	print_field("%*cUID: 0x%16" PRIx64 " (%" PRIu64 ")", (indent - 8),
+								' ', uid, uid);
+
+	if (!l2cap_frame_get_be16(frame, &uidcounter))
+		return false;
+
+	print_field("%*cUIDCounter: 0x%04x (%u)", (indent - 8), ' ',
+							uidcounter, uidcounter);
+
+	return true;
+
+response:
+	if (!l2cap_frame_get_u8(frame, &status))
+		return false;
+
+	print_field("%*cStatus: 0x%02x (%s)", (indent - 8), ' ', status,
+							error2str(status));
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct avctp_frame *avctp_frame, uint8_t ctype,
@@ -1253,6 +1295,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x50, avrcp_set_absolute_volume		},
 	{ 0x60, avrcp_set_addressed_player		},
 	{ 0x74, avrcp_play_item				},
+	{ 0x90, avrcp_add_to_now_playing		},
 	{ }
 };
 
-- 
1.9.1

