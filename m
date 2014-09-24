Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 1/6] Monitor: Add AVRCP GetPlayStatus support
Date: Wed, 24 Sep 2014 17:10:27 +0530
Message-id: <1411558832-15458-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetPlayStatus added in Bluetooth
monitor.
---
 monitor/avctp.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index f366b87..352a744 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -158,6 +158,14 @@
 #define AVRCP_ATTRIBUTE_SHUFFLE		0x03
 #define AVRCP_ATTRIBUTE_SCAN		0x04
 
+/* play status */
+#define AVRCP_PLAY_STATUS_STOPPED	0x00
+#define AVRCP_PLAY_STATUS_PLAYING	0x01
+#define AVRCP_PLAY_STATUS_PAUSED	0x02
+#define AVRCP_PLAY_STATUS_FWD_SEEK	0x03
+#define AVRCP_PLAY_STATUS_REV_SEEK	0x04
+#define AVRCP_PLAY_STATUS_ERROR		0xFF
+
 struct avctp_frame {
 	uint8_t hdr;
 	uint8_t pt;
@@ -524,6 +532,26 @@ static const char *charset2str(uint16_t charset)
 	}
 }
 
+static const char *playstatus2str(uint8_t status)
+{
+	switch (status) {
+	case AVRCP_PLAY_STATUS_STOPPED:
+		return "STOPPED";
+	case AVRCP_PLAY_STATUS_PLAYING:
+		return "PLAYING";
+	case AVRCP_PLAY_STATUS_PAUSED:
+		return "PAUSED";
+	case AVRCP_PLAY_STATUS_FWD_SEEK:
+		return "FWD_SEEK";
+	case AVRCP_PLAY_STATUS_REV_SEEK:
+		return "REV_SEEK";
+	case AVRCP_PLAY_STATUS_ERROR:
+		return "ERROR";
+	default:
+		return "Unknown";
+	}
+}
+
 static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
@@ -905,6 +933,38 @@ static bool avrcp_displayable_charset(struct avctp_frame *avctp_frame,
 	return true;
 }
 
+static bool avrcp_get_play_status(struct avctp_frame *avctp_frame,
+					uint8_t ctype, uint8_t len,
+					uint8_t indent)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint32_t interval;
+	uint8_t status;
+
+	if (ctype <= AVC_CTYPE_GENERAL_INQUIRY)
+		return true;
+
+	if (!l2cap_frame_get_be32(frame, &interval))
+		return false;
+
+	print_field("%*cSongLength: 0x%08x (%u miliseconds)",
+					(indent - 8), ' ', interval, interval);
+
+	if (!l2cap_frame_get_be32(frame, &interval))
+		return false;
+
+	print_field("%*cSongPosition: 0x%08x (%u miliseconds)",
+					(indent - 8), ' ', interval, interval);
+
+	if (!l2cap_frame_get_u8(frame, &status))
+		return false;
+
+	print_field("%*cPlayStatus: 0x%02x (%s)", (indent - 8),
+					' ', status, playstatus2str(status));
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct avctp_frame *avctp_frame, uint8_t ctype,
@@ -920,6 +980,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x15, avrcp_get_player_attribute_text		},
 	{ 0x16, avrcp_get_player_value_text		},
 	{ 0x17, avrcp_displayable_charset		},
+	{ 0x30, avrcp_get_play_status			},
 	{ }
 };
 
-- 
1.9.1

