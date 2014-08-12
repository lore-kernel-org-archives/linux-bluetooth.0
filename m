Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v2 4/6] monitor: Add AVRCP specific AV/C PDUs' macros and
 helper functions
Date: Tue, 12 Aug 2014 17:24:18 +0530
Message-id: <1407844460-11497-4-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1407844460-11497-1-git-send-email-vikram.pal@samsung.com>
References: <1407844460-11497-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added AVRCP specific AV/C PDUs related stuffs such as macros and
helper functions in Bluetooth monitor.
---
 monitor/avctp.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 8b60695..d22dfcf 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -79,6 +79,38 @@
 #define AVC_OP_SUBUNITINFO		0x31
 #define AVC_OP_PASSTHROUGH		0x7c
 
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
+#define AVRCP_GENERAL_REJECT		0xA0
+
+/* Packet types */
+#define AVRCP_PACKET_TYPE_SINGLE	0x00
+#define AVRCP_PACKET_TYPE_START		0x01
+#define AVRCP_PACKET_TYPE_CONTINUING	0x02
+#define AVRCP_PACKET_TYPE_END		0x03
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -165,12 +197,74 @@ static const char *opcode2str(uint8_t opcode)
 
 static const char *pdu2str(uint8_t pduid)
 {
-	return "Unknown";
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
+	case AVRCP_GENERAL_REJECT:
+		return "GeneralReject";
+	default:
+		return "Unknown";
+	}
 }
 
 static const char *pt2str(uint8_t pt)
 {
-	return "Unknown";
+	switch (pt) {
+	case AVRCP_PACKET_TYPE_SINGLE:
+		return "Single";
+	case AVRCP_PACKET_TYPE_START:
+		return "Start";
+	case AVRCP_PACKET_TYPE_CONTINUING:
+		return "Continuing";
+	case AVRCP_PACKET_TYPE_END:
+		return "End";
+	default:
+		return "Unknown";
+	}
 }
 
 static void avrcp_passthrough_packet(const struct l2cap_frame *frame)
-- 
1.9.1

