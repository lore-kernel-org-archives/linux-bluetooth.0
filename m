Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 3/3 v2] Add basic parsing support for AVRCP PDU
Date: Tue, 28 Jun 2011 11:57:25 +0300
Message-Id: <1309251445-16053-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 109 insertions(+), 1 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 203d1d0..0fa38d1 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -86,6 +86,31 @@
 #define AVC_PANEL_FORWARD		0x4b
 #define AVC_PANEL_BACKWARD		0x4c
 
+/* pdu ids */
+#define AVRCP_GET_CAPABILITIES		0x10
+#define AVRCP_LIST_PLAYER_ATTRIBUTES	0x11
+#define AVRCP_LIST_PLAYER_VALUES	0x12
+#define AVRCP_GET_CURRENT_PLAYER_VALUE	0x13
+#define AVRCP_SET_PLAYER_VALUE		0x14
+#define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT	0x15
+#define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
+#define AVRCP_DISPLAYABLE_CHARSET	0x17
+#define AVRCP_CT_BATTERY_STATUS		0x18
+#define AVRCP_GET_ELEMENT_ATTRIBUTES	0x20
+#define AVRCP_GET_PLAY_STATUS		0x30
+#define AVRCP_REGISTER_NOTIFICATION	0x31
+#define AVRCP_REQUEST_CONTINUING	0x40
+#define AVRCP_ABORT_CONTINUING		0x41
+#define AVRCP_SET_ABSOLUTE_VOLUME	0x50
+#define AVRCP_SET_ADDRESSED_PLAYER	0x60
+#define AVRCP_SET_BROWSED_PLAYER	0x70
+#define AVRCP_GET_FOLDER_ITEMS		0x71
+#define AVRCP_CHANGE_PATH		0x72
+#define AVRCP_GET_ITEM_ATTRIBUTES	0x73
+#define AVRCP_PLAY_ITEM			0x74
+#define AVRCP_SEARCH			0x80
+#define AVRCP_ADD_TO_NOW_PLAYING	0x90
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -134,6 +159,76 @@ static const char *opcode2str(uint8_t opcode)
 	}
 }
 
+static const char *pdu2str(uint8_t pduid)
+{
+	switch (pduid) {
+	case AVRCP_GET_CAPABILITIES:
+		return "GetCapabilities";
+	case AVRCP_LIST_PLAYER_ATTRIBUTES:
+		return "ListPlayerApplicationSettingAttributes";
+	case AVRCP_LIST_PLAYER_VALUES:
+		return "ListPlayerApplicationSettingValues";
+	case AVRCP_GET_CURRENT_PLAYER_VALUE:
+		return "GetCurrentPlayerApplicationSettingValue";
+	case AVRCP_SET_PLAYER_VALUE:
+		return "SetPlayerApplicationSettingValue";
+	case AVRCP_GET_PLAYER_ATTRIBUTE_TEXT:
+		return "GetPlayerApplicationSettingAttributeText";
+	case AVRCP_GET_PLAYER_VALUE_TEXT:
+		return "GetPlayerApplicationSettingValueText";
+	case AVRCP_DISPLAYABLE_CHARSET:
+		return "InformDisplayableCharacterSet";
+	case AVRCP_CT_BATTERY_STATUS:
+		return "InformBatteryStatusOfCT";
+	case AVRCP_GET_ELEMENT_ATTRIBUTES:
+		return "GetElementAttributes";
+	case AVRCP_GET_PLAY_STATUS:
+		return "GetPlayStatus";
+	case AVRCP_REGISTER_NOTIFICATION:
+		return "RegisterNotification";
+	case AVRCP_REQUEST_CONTINUING:
+		return "RequestContinuingResponse";
+	case AVRCP_ABORT_CONTINUING:
+		return "AbortContinuingResponse";
+	case AVRCP_SET_ABSOLUTE_VOLUME:
+		return "SetAbsoluteVolume";
+	case AVRCP_SET_ADDRESSED_PLAYER:
+		return "SetAddressedPlayer";
+	case AVRCP_SET_BROWSED_PLAYER:
+		return "SetBrowsedPlayer";
+	case AVRCP_GET_FOLDER_ITEMS:
+		return "GetFolderItems";
+	case AVRCP_CHANGE_PATH:
+		return "ChangePath";
+	case AVRCP_GET_ITEM_ATTRIBUTES:
+		return "GetItemAttributes";
+	case AVRCP_PLAY_ITEM:
+		return "PlayItem";
+	case AVRCP_SEARCH:
+		return "Search";
+	case AVRCP_ADD_TO_NOW_PLAYING:
+		return "AddToNowPlaying";
+	default:
+		return "Unknown";
+	}
+}
+
+static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
+{
+	uint8_t pduid, pt;
+	uint16_t len;
+
+	p_indent(level, frm);
+
+	pduid = get_u8(frm);
+	pt = get_u8(frm);
+	len = get_u16(frm);
+
+	printf("AVRCP: %s: pt 0x%02x len 0x%04x\n", pdu2str(pduid), pt, len);
+
+	raw_dump(level, frm);
+}
+
 static char *op2str(uint8_t op)
 {
 	switch (op & 0x7f) {
@@ -224,7 +319,8 @@ static const char *subunit2str(uint8_t subunit)
 
 void avrcp_dump(int level, struct frame *frm)
 {
-	uint8_t ctype, address, subunit, opcode;
+	uint8_t ctype, address, subunit, opcode, company[3];
+	int i;
 
 	p_indent(level, frm);
 
@@ -254,6 +350,18 @@ void avrcp_dump(int level, struct frame *frm)
 	case AVC_OP_PASSTHROUGH:
 		avrcp_passthrough_dump(level + 1, frm);
 		break;
+	case AVC_OP_VENDORDEP:
+		p_indent(level + 1, frm);
+
+		printf("Company ID: 0x");
+		for (i = 0; i < 3; i++) {
+			company[i] = get_u8(frm);
+			printf("%02x", company[i]);
+		}
+		printf("\n");
+
+		avrcp_pdu_dump(level + 1, frm, ctype);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.5.4

