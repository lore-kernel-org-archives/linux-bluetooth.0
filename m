Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 02/13 v2] Add parsing for command type rejected AVRCP responses
Date: Mon,  1 Aug 2011 18:43:52 +0300
Message-Id: <1312213432-4364-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312213432-4364-1-git-send-email-luiz.dentz@gmail.com>
References: <1312213432-4364-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 1b3afad..2b1cb40 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -126,6 +126,30 @@
 #define AVRCP_EVENT_UIDS_CHANGED			0x0c
 #define AVRCP_EVENT_VOLUME_CHANGED			0x0d
 
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
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -274,6 +298,74 @@ static char *event2str(uint8_t event)
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
+static void avrcp_rejected_dump(int level, struct frame *frm, uint16_t len)
+{
+	uint8_t status;
+
+	p_indent(level, frm);
+
+	if (len < 1) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	status = get_u8(frm);
+	printf("Error: 0x%02x (%s)\n", status, error2str(status));
+}
+
 static void avrcp_get_capabilities_dump(int level, struct frame *frm, uint16_t len)
 {
 	uint8_t cap;
@@ -347,6 +439,11 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 		return;
 	}
 
+	if (ctype == AVC_CTYPE_REJECTED) {
+		avrcp_rejected_dump(level + 1, frm, len);
+		return;
+	}
+
 	switch (pduid) {
 	case AVRCP_GET_CAPABILITIES:
 		avrcp_get_capabilities_dump(level + 1, frm, len);
-- 
1.7.6

