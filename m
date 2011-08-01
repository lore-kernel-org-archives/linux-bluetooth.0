Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 12/13] Add parsing for AVRCP GetPlayStatus pdu
Date: Mon,  1 Aug 2011 11:42:17 +0300
Message-Id: <1312188138-32265-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 49a7145..07a93ad 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -168,6 +168,14 @@
 #define AVRCP_MEDIA_ATTRIBUTE_GENRE	0x6
 #define AVRCP_MEDIA_ATTRIBUTE_PROGRESS	0x7
 
+/* play status */
+#define AVRCP_PLAY_STATUS_STOPPED	0x00
+#define AVRCP_PLAY_STATUS_PLAYING	0x01
+#define AVRCP_PLAY_STATUS_PAUSED	0x02
+#define AVRCP_PLAY_STATUS_FWD_SEEK	0x03
+#define AVRCP_PLAY_STATUS_REV_SEEK	0x04
+#define AVRCP_PLAY_STATUS_ERROR		0xFF
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -990,6 +998,57 @@ response:
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
+static void avrcp_get_play_status_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint32_t interval;
+	uint8_t status;
+
+	if (ctype <= AVC_CTYPE_GENERAL_INQUIRY)
+		return;
+
+	p_indent(level, frm);
+
+	if (len < 9) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	interval = get_u32(frm);
+	printf("SongLength: 0x%08x (%u miliseconds)\n", interval, interval);
+
+	p_indent(level, frm);
+
+	interval = get_u32(frm);
+	printf("SongPosition: 0x%08x (%u miliconds)\n", interval, interval);
+
+	p_indent(level, frm);
+
+	status = get_u8(frm);
+	printf("PlayStatus: 0x%02x (%s)\n", status, playstatus2str(status));
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -1051,6 +1110,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_GET_ELEMENT_ATTRIBUTES:
 		avrcp_get_element_attributes_dump(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_GET_PLAY_STATUS:
+		avrcp_get_play_status_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

