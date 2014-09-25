Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 5/6] Monitor: Add AVRCP PlayItem support
Date: Thu, 25 Sep 2014 15:48:22 +0530
Message-id: <1411640303-8491-5-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1411640303-8491-1-git-send-email-vikram.pal@samsung.com>
References: <1411640303-8491-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP PlayItem added in Bluetooth monitor.
---
 monitor/avctp.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index bb78a11..feb61b4 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -176,6 +176,12 @@
 #define AVRCP_PLAY_STATUS_REV_SEEK	0x04
 #define AVRCP_PLAY_STATUS_ERROR		0xFF
 
+/* media scope */
+#define AVRCP_MEDIA_PLAYER_LIST		0x00
+#define AVRCP_MEDIA_PLAYER_VFS		0x01
+#define AVRCP_MEDIA_SEARCH		0x02
+#define AVRCP_MEDIA_NOW_PLAYING		0x03
+
 struct avctp_frame {
 	uint8_t hdr;
 	uint8_t pt;
@@ -609,6 +615,22 @@ static const char *status2str(uint8_t status)
 	}
 }
 
+static const char *scope2str(uint8_t scope)
+{
+	switch (scope) {
+	case AVRCP_MEDIA_PLAYER_LIST:
+		return "Media Player List";
+	case AVRCP_MEDIA_PLAYER_VFS:
+		return "Media Player Virtual Filesystem";
+	case AVRCP_MEDIA_SEARCH:
+		return "Search";
+	case AVRCP_MEDIA_NOW_PLAYING:
+		return "Now Playing";
+	default:
+		return "Unknown";
+	}
+}
+
 static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
@@ -1336,6 +1358,47 @@ response:
 	return true;
 }
 
+static bool avrcp_play_item(struct avctp_frame *avctp_frame, uint8_t ctype,
+						uint8_t len, uint8_t indent)
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
@@ -1356,6 +1419,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x31, avrcp_register_notification		},
 	{ 0x50, avrcp_set_absolute_volume		},
 	{ 0x60, avrcp_set_addressed_player		},
+	{ 0x74, avrcp_play_item				},
 	{ }
 };
 
-- 
1.9.1

