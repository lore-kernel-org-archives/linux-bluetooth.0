Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Added more complete set of AVCTP/AVRCP defines
Date: Thu, 11 Aug 2011 09:12:01 -0500
Cc: luiz.dentz@gmail.com, lucas.demarchi@profusion.mobi,
	david_stockwell@att.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108110912.02268.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added more complete set of AVCTP/AVRCP defines:
  command type/response codes
  passthrough key operation codes (CT->TG)
  vendor-dependent message opcode (TG->CT)
  AVRCP 1.3+ Protocol Definition Unit codes
  AVRCP 1.3+ Event-IDs
  Bluetooth SIG Company ID
  1394 Trade Association AVC MTU for Control channel

Based on Release 4.96

---
 audio/control.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index c3ef737..188297a 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -67,28 +67,66 @@
 
 /* Packet types */
 #define AVCTP_PACKET_SINGLE	0
-#define AVCTP_PACKET_START	1
+#define AVCTP_PACKET_FIRST	1
 #define AVCTP_PACKET_CONTINUE	2
 #define AVCTP_PACKET_END	3
 
 /* ctype entries */
 #define CTYPE_CONTROL		0x0
 #define CTYPE_STATUS		0x1
+#define CTYPE_SPEC_INQUIRY	0x2
+#define CTYPE_NOTIFY		0x3
+#define CTYPE_GEN_INQUIRY	0x4
+
+/* ctype responses */
 #define CTYPE_NOT_IMPLEMENTED	0x8
 #define CTYPE_ACCEPTED		0x9
 #define CTYPE_REJECTED		0xA
+#define CTYPE_IN_TRANSITION	0xB
 #define CTYPE_STABLE		0xC
+#define CTYPE_CHANGED		0xD
+#define CTYPE_INTERIM		0xF
 
 /* opcodes */
 #define OP_VENDORDEP		0x00
 #define OP_UNITINFO		0x30
 #define OP_SUBUNITINFO		0x31
-#define OP_PASSTHROUGH		0x7c
+#define OP_PASSTHROUGH		0x7C
+#define OP_VENDOR_DEPENDENT	0x00
 
 /* subunits of interest */
 #define SUBUNIT_PANEL		0x09
 
 /* operands in passthrough commands */
+#define SELECT_OP		0x00
+#define UP_OP			0x01
+#define DOWN_OP			0x02
+#define LEFT_OP			0x03
+#define RIGHT_OP		0x04
+#define RIGHT_UP_OP		0x05
+#define RIGHT_DOWN_OP		0x06
+#define LEFT_UP_OP		0x07
+#define LEFT_DOWN_OP		0x08
+#define ROOT_MENU_OP		0x09
+#define SETUP_MENU_OP		0x0A
+#define CONTENTS_OP		0x0B
+#define FAVORITES_OP		0x0C
+
+#define NUMBER_0_OP		0x20
+#define NUMBER_1_OP		0x21
+#define NUMBER_2_OP		0x22
+#define NUMBER_3_OP		0x23
+#define NUMBER_4_OP		0x24
+#define NUMBER_5_OP		0x25
+#define NUMBER_6_OP		0x26
+#define NUMBER_7_OP		0x27
+#define NUMBER_8_OP		0x28
+#define NUMBER_9_OP		0x29
+#define DOT_OP			0x2A
+#define ENTER_OP		0x2B
+#define CLEAR_OP		0x2C
+
+#define POWER_OP		0x40
 #define VOL_UP_OP		0x41
 #define VOL_DOWN_OP		0x42
 #define MUTE_OP			0x43
@@ -98,9 +136,81 @@
 #define RECORD_OP		0x47
 #define REWIND_OP		0x48
 #define FAST_FORWARD_OP		0x49
-#define EJECT_OP		0x4a
-#define FORWARD_OP		0x4b
-#define BACKWARD_OP		0x4c
+#define EJECT_OP		0x4A
+#define FORWARD_OP		0x4B
+#define BACKWARD_OP		0x4C
+
+#define ANGLE_OP		0x50
+#define SUBPICTURE_OP		0x51
+
+#define F1_OP			0x71
+#define F2_OP			0x72
+#define F3_OP			0x73
+#define F4_OP			0x74
+#define F5_OP			0x75
+
+#define VENDOR_UNIQUE_OP	0x7E
+
+/* AVRCP 1.3 (and later) Protocol Definition Units (PDUs) */
+#define PDU_GET_CAPABILITIES			0x10
+
+#define	PDU_LIST_PLAYER_APP_SETTING_ATTRS	0x11
+#define	PDU_LIST_PLAYER_APP_SETTING_VALS	0x12
+#define	PDU_GET_CURR_PLAYER_APP_SETTING_VALUE	0x13
+#define	PDU_SET_PLAYER_APP_SETTING_VALUE	0x14
+#define	PDU_GET_PLAYER_APP_SETTING_ATTR_TEXT	0x15
+#define	PDU_GET_PLAYER_APP_SETTING_VALUE_TEXT	0x16
+
+#define	PDU_INFORM_DISPLAYABLE_CHAR_SET		0x17
+#define	PDU_INFORM_CT_BATTERY_STAT		0x18
+
+#define	PDU_GET_ELEMENT_ATTRS			0x20
+
+#define	PDU_GET_PLAY_STATUS			0x30
+#define	PDU_REGISTER_NOTIFICATION		0x31
+
+#define	PDU_REGISTER_CONTINUING_RESPONSE	0x40
+#define	PDU_ABORT_CONTINUING_RESPONSE		0x41
+
+/* AVRCP 1.4 Protocol Definition Units (PDUs) */
+#define	PDU_SET_ABSOLUTE_VOLUME			0x50
+
+#define	PDU_SET_ADDRESSED_PLAYER		0x60
+
+#define	PDU_SET_BROWSED_PLAYER			0x70
+#define	PDU_GET_FOLDER_ITEMS			0x71
+#define	PDU_CHANGE_PATH				0x72
+#define	PDU_GET_ITEM_ATTRS			0x73
+#define	PDU_PLAY_ITEM				0x74
+
+#define	PDU_SEARCH				0x80
+
+#define	PDU_ADD_TO_NOW_PLAYING			0x90
+
+#define	PDU_GENERAL_REJECT			0xA0
+
+/* AVRCP 1.3 (and later) Event-IDs */
+#define	EVENT_PLAYBACK_STATUS_CHANGED		0x01
+#define	EVENT_TRACK_CHANGED			0x02
+#define	EVENT_TRACK_REACHED_END			0x03
+#define	EVENT_TRACK_REACHED_START		0x04
+#define	EVENT_PLAYBACK_POS_CHANGED		0x05
+#define	EVENT_BATT_STATUS_CHANGED		0x06
+#define	EVENT_SYSTEM_STATUS_CHANGED		0x07
+#define	EVENT_PLAYER_APP_SETTING_CHANGED	0x08
+
+/* AVRCP 1.4 Event-IDs */
+#define	EVENT_NOW_PLAYING_CONTENT_CHANGED	0x09
+#define	EVENT_NOTIFY_AVBL_PLAYERS_CHANGED	0x0A
+#define	EVENT_ADDRESSED_PLAYER_CHANGED		0x0B
+#define	EVENT_UIDS_CHANGED			0x0C
+#define	EVENT_VOLUME_CHANGED			0x0D
+
+/* BT-SIG defined Company ID for Metadata */
+#define BTSIG_COMPANY_ID	0x001958
+
+/* 1394 Trade Association-defined AV/C MTU for Control channel */
+#define AVC_MTU			512
 
 #define QUIRK_NO_RELEASE	1 << 0
 
-- 
1.7.4.4

