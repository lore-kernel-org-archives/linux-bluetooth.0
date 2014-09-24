Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 2/6] Monitor: Add AVRCP RegisterNotification support
Date: Wed, 24 Sep 2014 17:10:28 +0530
Message-id: <1411558832-15458-2-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1411558832-15458-1-git-send-email-vikram.pal@samsung.com>
References: <1411558832-15458-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP RegisterNotification added in Bluetooth
monitor.
---
 monitor/avctp.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 352a744..6b43f41 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -552,6 +552,24 @@ static const char *playstatus2str(uint8_t status)
 	}
 }
 
+static const char *status2str(uint8_t status)
+{
+	switch (status) {
+	case 0x0:
+		return "NORMAL";
+	case 0x1:
+		return "WARNING";
+	case 0x2:
+		return "CRITICAL";
+	case 0x3:
+		return "EXTERNAL";
+	case 0x4:
+		return "FULL_CHARGE";
+	default:
+		return "Reserved";
+	}
+}
+
 static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
@@ -965,6 +983,148 @@ static bool avrcp_get_play_status(struct avctp_frame *avctp_frame,
 	return true;
 }
 
+static bool avrcp_register_notification(struct avctp_frame *avctp_frame,
+					uint8_t ctype, uint8_t len,
+					uint8_t indent)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint8_t event, status;
+	uint16_t uid;
+	uint32_t interval;
+	uint64_t id;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (!l2cap_frame_get_u8(frame, &event))
+		return false;
+
+	print_field("%*cEventID: 0x%02x (%s)", (indent - 8),
+						' ', event, event2str(event));
+
+	if (!l2cap_frame_get_be32(frame, &interval))
+		return false;
+
+	print_field("%*cInterval: 0x%08x (%u seconds)",
+					(indent - 8), ' ', interval, interval);
+
+	return true;
+
+response:
+	if (!l2cap_frame_get_u8(frame, &event))
+		return false;
+
+	print_field("%*cEventID: 0x%02x (%s)", (indent - 8),
+						' ', event, event2str(event));
+
+	switch (event) {
+	case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
+		if (!l2cap_frame_get_u8(frame, &status))
+			return false;
+
+		print_field("%*cPlayStatus: 0x%02x (%s)", (indent - 8),
+					' ', status, playstatus2str(status));
+		break;
+	case AVRCP_EVENT_TRACK_CHANGED:
+		if (!l2cap_frame_get_be64(frame, &id))
+			return false;
+
+		print_field("%*cIdentifier: 0x%16" PRIx64 " (%" PRIu64 ")",
+						(indent - 8), ' ', id, id);
+		break;
+	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
+		if (!l2cap_frame_get_be32(frame, &interval))
+			return false;
+
+		print_field("%*cPosition: 0x%08x (%u miliseconds)",
+					(indent - 8), ' ', interval, interval);
+		break;
+	case AVRCP_EVENT_BATT_STATUS_CHANGED:
+		if (!l2cap_frame_get_u8(frame, &status))
+			return false;
+
+		print_field("%*cBatteryStatus: 0x%02x (%s)", (indent - 8),
+					' ', status, status2str(status));
+
+		break;
+	case AVRCP_EVENT_SYSTEM_STATUS_CHANGED:
+		if (!l2cap_frame_get_u8(frame, &status))
+			return false;
+
+		print_field("%*cSystemStatus: 0x%02x ", (indent - 8),
+								' ', status);
+		switch (status) {
+		case 0x00:
+			printf("(POWER_ON)\n");
+			break;
+		case 0x01:
+			printf("(POWER_OFF)\n");
+			break;
+		case 0x02:
+			printf("(UNPLUGGED)\n");
+			break;
+		default:
+			printf("(UNKOWN)\n");
+			break;
+		}
+		break;
+	case AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED:
+		if (!l2cap_frame_get_u8(frame, &status))
+			return false;
+
+		print_field("%*cAttributeCount: 0x%02x", (indent - 8),
+								' ', status);
+
+		for (; status > 0; status--) {
+			uint8_t attr, value;
+
+			if (!l2cap_frame_get_u8(frame, &attr))
+				return false;
+
+			print_field("%*cAttributeID: 0x%02x (%s)",
+				(indent - 8), ' ', attr, attr2str(attr));
+
+			if (!l2cap_frame_get_u8(frame, &value))
+				return false;
+
+			print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
+					' ', value, value2str(attr, value));
+		}
+		break;
+	case AVRCP_EVENT_VOLUME_CHANGED:
+		if (!l2cap_frame_get_u8(frame, &status))
+			return false;
+
+		status &= 0x7F;
+
+		print_field("%*cVolume: %.2f%% (%d/127)", (indent - 8),
+						' ', status/1.27, status);
+		break;
+	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+		if (!l2cap_frame_get_be16(frame, &uid))
+			return false;
+
+		print_field("%*cPlayerID: 0x%04x (%u)", (indent - 8),
+								' ', uid, uid);
+
+		if (!l2cap_frame_get_be16(frame, &uid))
+			return false;
+
+		print_field("%*cUIDCounter: 0x%04x (%u)", (indent - 8),
+								' ', uid, uid);
+		break;
+	case AVRCP_EVENT_UIDS_CHANGED:
+		if (!l2cap_frame_get_be16(frame, &uid))
+			return false;
+
+		print_field("%*cUIDCounter: 0x%04x (%u)", (indent - 8),
+								' ', uid, uid);
+		break;
+	}
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct avctp_frame *avctp_frame, uint8_t ctype,
@@ -981,6 +1141,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x16, avrcp_get_player_value_text		},
 	{ 0x17, avrcp_displayable_charset		},
 	{ 0x30, avrcp_get_play_status			},
+	{ 0x31, avrcp_register_notification		},
 	{ }
 };
 
-- 
1.9.1

