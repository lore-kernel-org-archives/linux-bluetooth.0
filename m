Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v2 5/6] monitor: Add AV/C specific PDUs' error macros and
 functions
Date: Tue, 12 Aug 2014 17:24:19 +0530
Message-id: <1407844460-11497-5-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1407844460-11497-1-git-send-email-vikram.pal@samsung.com>
References: <1407844460-11497-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added AV/C specific PDUs' error macros and functions in
Bluetooth monitor.
---
 monitor/avctp.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index d22dfcf..b07eea7 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -79,6 +79,30 @@
 #define AVC_OP_SUBUNITINFO		0x31
 #define AVC_OP_PASSTHROUGH		0x7c
 
+/* error statuses */
+#define AVRCP_STATUS_INVALID_COMMAND			0x00
+#define AVRCP_STATUS_INVALID_PARAMETER			0x01
+#define AVRCP_STATUS_NOT_FOUND				0x02
+#define AVRCP_STATUS_INTERNAL_ERROR			0x03
+#define AVRCP_STATUS_SUCCESS				0x04
+#define AVRCP_STATUS_UID_CHANGED			0x05
+#define AVRCP_STATUS_INVALID_DIRECTION			0x07
+#define AVRCP_STATUS_NOT_DIRECTORY			0x08
+#define AVRCP_STATUS_DOES_NOT_EXIST			0x09
+#define AVRCP_STATUS_INVALID_SCOPE			0x0a
+#define AVRCP_STATUS_OUT_OF_BOUNDS			0x0b
+#define AVRCP_STATUS_IS_DIRECTORY			0x0c
+#define AVRCP_STATUS_MEDIA_IN_USE			0x0d
+#define AVRCP_STATUS_NOW_PLAYING_LIST_FULL		0x0e
+#define AVRCP_STATUS_SEARCH_NOT_SUPPORTED		0x0f
+#define AVRCP_STATUS_SEARCH_IN_PROGRESS			0x10
+#define AVRCP_STATUS_INVALID_PLAYER_ID			0x11
+#define AVRCP_STATUS_PLAYER_NOT_BROWSABLE		0x12
+#define AVRCP_STATUS_PLAYER_NOT_ADDRESSED		0x13
+#define AVRCP_STATUS_NO_VALID_SEARCH_RESULTS		0x14
+#define AVRCP_STATUS_NO_AVAILABLE_PLAYERS		0x15
+#define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED		0x16
+
 /* pdu ids */
 #define AVRCP_GET_CAPABILITIES		0x10
 #define AVRCP_LIST_PLAYER_ATTRIBUTES	0x11
@@ -195,6 +219,58 @@ static const char *opcode2str(uint8_t opcode)
 	}
 }
 
+static const char *error2str(uint8_t status)
+{
+	switch (status) {
+	case AVRCP_STATUS_INVALID_COMMAND:
+		return "Invalid Command";
+	case AVRCP_STATUS_INVALID_PARAMETER:
+		return "Invalid Parameter";
+	case AVRCP_STATUS_NOT_FOUND:
+		return "Not Found";
+	case AVRCP_STATUS_INTERNAL_ERROR:
+		return "Internal Error";
+	case AVRCP_STATUS_SUCCESS:
+		return "Success";
+	case AVRCP_STATUS_UID_CHANGED:
+		return "UID Changed";
+	case AVRCP_STATUS_INVALID_DIRECTION:
+		return "Invalid Direction";
+	case AVRCP_STATUS_NOT_DIRECTORY:
+		return "Not a Directory";
+	case AVRCP_STATUS_DOES_NOT_EXIST:
+		return "Does Not Exist";
+	case AVRCP_STATUS_INVALID_SCOPE:
+		return "Invalid Scope";
+	case AVRCP_STATUS_OUT_OF_BOUNDS:
+		return "Range Out of Bonds";
+	case AVRCP_STATUS_MEDIA_IN_USE:
+		return "Media in Use";
+	case AVRCP_STATUS_IS_DIRECTORY:
+		return "UID is a Directory";
+	case AVRCP_STATUS_NOW_PLAYING_LIST_FULL:
+		return "Now Playing List Full";
+	case AVRCP_STATUS_SEARCH_NOT_SUPPORTED:
+		return "Seach Not Supported";
+	case AVRCP_STATUS_SEARCH_IN_PROGRESS:
+		return "Search in Progress";
+	case AVRCP_STATUS_INVALID_PLAYER_ID:
+		return "Invalid Player ID";
+	case AVRCP_STATUS_PLAYER_NOT_BROWSABLE:
+		return "Player Not Browsable";
+	case AVRCP_STATUS_PLAYER_NOT_ADDRESSED:
+		return "Player Not Addressed";
+	case AVRCP_STATUS_NO_VALID_SEARCH_RESULTS:
+		return "No Valid Search Result";
+	case AVRCP_STATUS_NO_AVAILABLE_PLAYERS:
+		return "No Available Players";
+	case AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED:
+		return "Addressed Player Changed";
+	default:
+		return "Unknown";
+	}
+}
+
 static const char *pdu2str(uint8_t pduid)
 {
 	switch (pduid) {
@@ -395,6 +471,16 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 
 static void avrcp_rejected_packet(const struct l2cap_frame *frame)
 {
+	uint8_t status;
+
+	if (frame->size < 1) {
+		print_text(COLOR_ERROR, "PDU malformed");
+		packet_hexdump(frame->data, frame->size);
+		return;
+	}
+
+	status = *((uint8_t *) frame->data);
+	print_field("Error: 0x%02x (%s)", status, error2str(status));
 }
 
 static void avrcp_pdu_packet(const struct l2cap_frame *frame, uint8_t ctype,
-- 
1.9.1

