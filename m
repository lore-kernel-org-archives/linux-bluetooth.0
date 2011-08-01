Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 13/13] Add parsing for AVRCP RegisterNotification pdu
Date: Mon,  1 Aug 2011 11:42:18 +0300
Message-Id: <1312188138-32265-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 07a93ad..8412ccf 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1049,6 +1049,104 @@ static void avrcp_get_play_status_dump(int level, struct frame *frm,
 	printf("PlayStatus: 0x%02x (%s)\n", status, playstatus2str(status));
 }
 
+static void avrcp_register_notification_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint8_t event, status;
+	uint32_t interval;
+	uint64_t id;
+
+	p_indent(level, frm);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (len < 5) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	event = get_u8(frm);
+	printf("EventID: 0x%02x (%s)\n", event, event2str(event));
+
+	p_indent(level, frm);
+
+	interval = get_u32(frm);
+	printf("Interval: 0x%08x (%u seconds)\n", interval, interval);
+
+	return;
+
+response:
+	if (len < 1) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	event = get_u8(frm);
+	printf("EventID: 0x%02x (%s)\n", event, event2str(event));
+
+	p_indent(level, frm);
+
+	switch (event) {
+	case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
+		status = get_u8(frm);
+		printf("PlayStatus: 0x%02x (%s)\n", status,
+						playstatus2str(status));
+		break;
+	case AVRCP_EVENT_TRACK_CHANGED:
+		id = get_u64(frm);
+		printf("Identifier: 0x%jx (%s)\n", id,
+						id ? "Reserved" : "PLAYING");
+		break;
+	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
+		interval = get_u32(frm);
+		printf("Position: 0x%08x (%u miliseconds)\n", interval,
+								interval);
+		break;
+	case AVRCP_EVENT_BATT_STATUS_CHANGED:
+		status = get_u8(frm);
+		printf("BatteryStatus: 0x%02x (%s)\n", status,
+							status2str(status));
+		break;
+	case AVRCP_EVENT_SYSTEM_STATUS_CHANGED:
+		status = get_u8(frm);
+		printf("SystemStatus: 0x%02x ", status);
+		switch (status) {
+		case 0x00:
+			printf("(POWER_ON)\n");
+		case 0x01:
+			printf("(POWER_OFF)\n");
+		case 0x02:
+			printf("(UNPLUGGED)\n");
+		default:
+			printf("(UNKOWN)\n");
+		}
+		break;
+	case AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED:
+		status = get_u8(frm);
+		printf("AttributeCount: 0x%02x\n", status);
+
+		for (; status > 0; status--) {
+			uint8_t attr, value;
+
+			p_indent(level, frm);
+
+			attr = get_u8(frm);
+			printf("AttributeID: 0x%02x (%s)\n", attr,
+							attr2str(attr));
+
+			p_indent(level, frm);
+
+			value = get_u8(frm);
+			printf("ValueID: 0x%02x (%s)\n", value,
+						value2str(attr, value));
+		}
+		break;
+	}
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -1113,6 +1211,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_GET_PLAY_STATUS:
 		avrcp_get_play_status_dump(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_REGISTER_NOTIFICATION:
+		avrcp_register_notification_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

