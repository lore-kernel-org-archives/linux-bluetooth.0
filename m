Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2 v2] Add parsing for AVRCP GetCapabilities
Date: Tue, 12 Jul 2011 17:50:45 +0300
Message-Id: <1310482245-2734-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |  124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 123 insertions(+), 1 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 43e8a8b..ff6862d 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -111,6 +111,21 @@
 #define AVRCP_SEARCH			0x80
 #define AVRCP_ADD_TO_NOW_PLAYING	0x90
 
+/* notification events */
+#define AVRCP_EVENT_PLAYBACK_STATUS_CHANGED		0x01
+#define AVRCP_EVENT_TRACK_CHANGED			0x02
+#define AVRCP_EVENT_TRACK_REACHED_END			0x03
+#define AVRCP_EVENT_TRACK_REACHED_START			0x04
+#define AVRCP_EVENT_PLAYBACK_POS_CHANGED		0x05
+#define AVRCP_EVENT_BATT_STATUS_CHANGED			0x06
+#define AVRCP_EVENT_SYSTEM_STATUS_CHANGED		0x07
+#define AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED	0x08
+#define AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED		0x09
+#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED		0x0a
+#define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED		0x0b
+#define AVRCP_EVENT_UIDS_CHANGED			0x0c
+#define AVRCP_EVENT_VOLUME_CHANGED			0x0d
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -213,6 +228,105 @@ static const char *pdu2str(uint8_t pduid)
 	}
 }
 
+static char *cap2str(uint8_t cap)
+{
+	switch (cap) {
+	case 0x2:
+		return "CompanyID";
+	case 0x3:
+		return "EventsID";
+	default:
+		return "Unknown";
+	}
+}
+
+static char *event2str(uint8_t event)
+{
+	switch (event) {
+	case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
+		return "EVENT_PLAYBACK_STATUS_CHANGED";
+	case AVRCP_EVENT_TRACK_CHANGED:
+		return "EVENT_TRACK_CHANGED";
+	case AVRCP_EVENT_TRACK_REACHED_END:
+		return "EVENT_TRACK_REACHED_END";
+	case AVRCP_EVENT_TRACK_REACHED_START:
+		return "EVENT_TRACK_REACHED_START";
+	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
+		return "EVENT_PLAYBACK_POS_CHANGED";
+	case AVRCP_EVENT_BATT_STATUS_CHANGED:
+		return "EVENT_BATT_STATUS_CHANGED";
+	case AVRCP_EVENT_SYSTEM_STATUS_CHANGED:
+		return "EVENT_SYSTEM_STATUS_CHANGED";
+	case AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED:
+		return "EVENT_PLAYER_APPLICATION_SETTING_CHANGED";
+	case AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED:
+		return "EVENT_NOW_PLAYING_CONTENT_CHANGED";
+	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
+		return "EVENT_AVAILABLE_PLAYERS_CHANGED";
+	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+		return "EVENT_ADDRESSED_PLAYER_CHANGED";
+	case AVRCP_EVENT_UIDS_CHANGED:
+		return "EVENT_UIDS_CHANGED";
+	case AVRCP_EVENT_VOLUME_CHANGED:
+		return "EVENT_VOLUME_CHANGED";
+	default:
+		return "Reserved";
+	}
+}
+
+static void avrcp_get_capabilities_dump(int level, struct frame *frm, uint16_t len)
+{
+	uint8_t cap;
+	uint8_t count;
+
+	p_indent(level, frm);
+
+	if (len < 1) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	cap = get_u8(frm);
+	printf("CapabilityID: 0x%02x (%s)\n", cap, cap2str(cap));
+
+	if (len == 1)
+		return;
+
+	p_indent(level, frm);
+
+	count = get_u8(frm);
+	printf("CapabilityCount: 0x%02x\n", count);
+
+	switch (cap) {
+	case 0x2:
+		for (; count > 0; count--) {
+			int i;
+
+			p_indent(level, frm);
+
+			printf("%s: 0x", cap2str(cap));
+			for (i = 0; i < 3; i++)
+				printf("%02x", get_u8(frm));
+			printf("\n");
+		}
+		break;
+	case 0x3:
+		for (; count > 0; count--) {
+			uint8_t event;
+
+			p_indent(level, frm);
+
+			event = get_u8(frm);
+			printf("%s: 0x%02x (%s)\n", cap2str(cap), event,
+							event2str(event));
+		}
+		break;
+	default:
+		raw_dump(level, frm);
+	}
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -229,9 +343,17 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	if (len != frm->len) {
 		p_indent(level, frm);
 		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
 	}
 
-	raw_dump(level, frm);
+	switch (pduid) {
+	case AVRCP_GET_CAPABILITIES:
+		avrcp_get_capabilities_dump(level + 1, frm, len);
+		break;
+	default:
+		raw_dump(level, frm);
+	}
 }
 
 static char *op2str(uint8_t op)
-- 
1.7.6

