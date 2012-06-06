Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Sebastian.Chlad@tieto.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 01/13] AVRCP: Update constants
Date: Wed, 6 Jun 2012 18:04:38 +0200
Message-ID: <1338998690-18631-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change all specification constants to enum type.
Also update constants for AVRCP 1.4.
---
 audio/avrcp.c |  187 ++++++++++++++++++++++++++++++++++++---------------------
 audio/avrcp.h |  108 +++++++++++++++++++--------------
 audio/media.c |    2 +-
 3 files changed, 183 insertions(+), 114 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 89ee112..196d6a5 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -58,56 +58,109 @@
 #include "sdpd.h"
 #include "dbus-common.h"
 
-/* Company IDs for vendor dependent commands */
-#define IEEEID_BTSIG		0x001958
-
-/* Error codes for metadata transfer */
-#define E_INVALID_COMMAND	0x00
-#define E_INVALID_PARAM		0x01
-#define E_PARAM_NOT_FOUND	0x02
-#define E_INTERNAL		0x03
-
-/* Packet types */
-#define AVRCP_PACKET_TYPE_SINGLE	0x00
-#define AVRCP_PACKET_TYPE_START		0x01
-#define AVRCP_PACKET_TYPE_CONTINUING	0x02
-#define AVRCP_PACKET_TYPE_END		0x03
-
-/* PDU types for metadata transfer */
-#define AVRCP_GET_CAPABILITIES		0x10
-#define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
-#define AVRCP_LIST_PLAYER_VALUES	0x12
-#define AVRCP_GET_CURRENT_PLAYER_VALUE	0x13
-#define AVRCP_SET_PLAYER_VALUE		0x14
-#define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT	0x15
-#define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
-#define AVRCP_DISPLAYABLE_CHARSET	0x17
-#define AVRCP_CT_BATTERY_STATUS		0x18
-#define AVRCP_GET_ELEMENT_ATTRIBUTES	0x20
-#define AVRCP_GET_PLAY_STATUS		0x30
-#define AVRCP_REGISTER_NOTIFICATION	0x31
-#define AVRCP_REQUEST_CONTINUING	0x40
-#define AVRCP_ABORT_CONTINUING		0x41
-#define AVRCP_SET_ABSOLUTE_VOLUME	0x50
-
-/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
-#define CAP_COMPANY_ID		0x02
-#define CAP_EVENTS_SUPPORTED	0x03
-
 #define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
 
-#define AVRCP_FEATURE_CATEGORY_1	0x0001
-#define AVRCP_FEATURE_CATEGORY_2	0x0002
-#define AVRCP_FEATURE_CATEGORY_3	0x0004
-#define AVRCP_FEATURE_CATEGORY_4	0x0008
-#define AVRCP_FEATURE_PLAYER_SETTINGS	0x0010
+enum company_id {
+	IEEEID_BTSIG	 = 0x001958
+};
+
+enum status_code {
+	STATUS_INVALID_COMMAND		= 0x00,
+	STATUS_INVALID_PARAMETER	= 0x01,
+	STATUS_PARAMETER_NOT_FOUND	= 0x02,
+	STATUS_INTERNAL_ERROR		= 0x03,
+	STATUS_OK			= 0x04,
+	STATUS_UID_CHANGED		= 0x05,
+	STATUS_INVALID_DIRECTION	= 0x07,
+	STATUS_NOT_DIRECTORY		= 0x08,
+	STATUS_DOES_NOT_EXIST		= 0x09,
+	STATUS_INVALID_SCOPE		= 0x0A,
+	STATUS_RANGE_OUT_OF_BOUNDS	= 0x0B,
+	STATUS_UID_IS_DIRECTORY		= 0x0C,
+	STATUS_MEDIA_IN_USE		= 0x0D,
+	STATUS_NOW_PLAYING_LIST_FULL	= 0x0E,
+	STATUS_SEARCH_NOT_SUPPORTED	= 0x0F,
+	STATUS_SEARCH_IN_PROGRESS	= 0x10,
+	STATUS_INVALID_PLAYER_ID	= 0x11,
+	STATUS_PLAYER_NOT_BROWSABLE	= 0x12,
+	STATUS_PLAYER_NOT_ADDRESSED	= 0x13,
+	STATUS_NO_VALID_SEARCH_RESULTS	= 0x14,
+	STATUS_NO_AVAILABLE_PLAYERS	= 0x15,
+	STATUS_ADDRESSED_PLAYER_CHANGED	= 0x16
+};
+
+enum packet_type {
+	AVRCP_PACKET_TYPE_SINGLE	= 0x00,
+	AVRCP_PACKET_TYPE_START		= 0x01,
+	AVRCP_PACKET_TYPE_CONTINUING	= 0x02,
+	AVRCP_PACKET_TYPE_END		= 0x03
+};
+
+enum control_pdu_ieeeid_btsig {
+	AVRCP_GET_CAPABILITIES		= 0x10,
+	AVRCP_LIST_PLAYER_ATTRIBUTES	= 0X11,
+	AVRCP_LIST_PLAYER_VALUES	= 0x12,
+	AVRCP_GET_CURRENT_PLAYER_VALUE	= 0x13,
+	AVRCP_SET_PLAYER_VALUE		= 0x14,
+	AVRCP_GET_PLAYER_ATTRIBUTE_TEXT	= 0x15,
+	AVRCP_GET_PLAYER_VALUE_TEXT	= 0x16,
+	AVRCP_DISPLAYABLE_CHARSET	= 0x17,
+	AVRCP_CT_BATTERY_STATUS		= 0x18,
+	AVRCP_GET_ELEMENT_ATTRIBUTES	= 0x20,
+	AVRCP_GET_PLAY_STATUS		= 0x30,
+	AVRCP_REGISTER_NOTIFICATION	= 0x31,
+	AVRCP_REQUEST_CONTINUING	= 0x40,
+	AVRCP_ABORT_CONTINUING		= 0x41,
+	AVRCP_SET_ABSOLUTE_VOLUME	= 0x50,
+	AVRCP_SET_ADDRESSED_PLAYER	= 0x60,
+	AVRCP_PLAY_ITEM			= 0x74,
+	AVRCP_ADD_TO_NOW_PLAYING	= 0x90
+};
+
+enum browsing_pdu {
+	AVRCP_SET_BROWSED_PLAYER	= 0x70,
+	AVRCP_GET_FOLDER_ITEMS		= 0x71,
+	AVRCP_CHANGE_PATH		= 0x72,
+	AVRCP_GET_ITEM_ATTRIBUTES	= 0x73,
+	AVRCP_SEARCH			= 0x80,
+	AVRCP_GENERAL_REJECT		= 0xA0
+};
+
+enum capability {
+	CAP_COMPANY_ID		= 0x02,
+	CAP_EVENTS_SUPPORTED	= 0x03
+};
+
+enum sdp_feature {
+	AVRCP_FEATURE_CATEGORY_1	= 0x0001,
+	AVRCP_FEATURE_CATEGORY_2	= 0x0002,
+	AVRCP_FEATURE_CATEGORY_3	= 0x0004,
+	AVRCP_FEATURE_CATEGORY_4	= 0x0008,
+	AVRCP_FEATURE_PLAYER_SETTINGS	= 0x0010,
+	AVRCP_FEATURE_GROUP_NAVIGATION	= 0x0020,
+	AVRCP_FEATURE_BROWSING		= 0x0040,
+	AVRCP_FEATURE_MULTIPLE_PLAYERS	= 0x0080
+};
+
+enum scope {
+	AVRCP_SCOPE_MEDIA_PLAYER_LIST	= 0x00,
+	AVRCP_SCOPE_VFS			= 0x01,
+	AVRCP_SCOPE_SEARCH		= 0x02,
+	AVRCP_SCOPE_NOW_PLAYING		= 0x03
+};
 
 enum battery_status {
-	BATTERY_STATUS_NORMAL =		0,
-	BATTERY_STATUS_WARNING =	1,
-	BATTERY_STATUS_CRITICAL =	2,
-	BATTERY_STATUS_EXTERNAL =	3,
-	BATTERY_STATUS_FULL_CHARGE =	4,
+	BATTERY_STATUS_NORMAL		= 0,
+	BATTERY_STATUS_WARNING		= 1,
+	BATTERY_STATUS_CRITICAL		= 2,
+	BATTERY_STATUS_EXTERNAL		= 3,
+	BATTERY_STATUS_FULL_CHARGE	= 4
+};
+
+enum avrcp_version {
+	AVRCP_VERSION_UNKNOWN	= 0x0000,
+	AVRCP_VERSION_1_3	= 0x0103,
+	AVRCP_VERSION_1_4	= 0x0104
 };
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
@@ -396,7 +449,7 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	DBG("id=%u", id);
 
 	switch (id) {
-	case AVRCP_EVENT_STATUS_CHANGED:
+	case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
 		size = 2;
 		pdu->params[1] = *((uint8_t *)data);
 
@@ -581,7 +634,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
 		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
 		pdu->params[1] = 4;
-		pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
+		pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
 		pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
 		pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
 		pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
@@ -592,7 +645,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
 
 err:
 	pdu->params_len = htons(1);
-	pdu->params[0] = E_INVALID_PARAM;
+	pdu->params[0] = STATUS_INVALID_PARAMETER;
 
 	return AVC_CTYPE_REJECTED;
 }
@@ -606,7 +659,7 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp_player *player,
 
 	if (len != 0) {
 		pdu->params_len = htons(1);
-		pdu->params[0] = E_INVALID_PARAM;
+		pdu->params[0] = STATUS_INVALID_PARAMETER;
 		return AVC_CTYPE_REJECTED;
 	}
 
@@ -653,7 +706,7 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp_player *player,
 
 err:
 	pdu->params_len = htons(1);
-	pdu->params[0] = E_INVALID_PARAM;
+	pdu->params[0] = STATUS_INVALID_PARAMETER;
 	return AVC_CTYPE_REJECTED;
 }
 
@@ -724,7 +777,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 	return AVC_CTYPE_STABLE;
 err:
 	pdu->params_len = htons(1);
-	pdu->params[0] = E_INVALID_PARAM;
+	pdu->params[0] = STATUS_INVALID_PARAMETER;
 	return AVC_CTYPE_REJECTED;
 }
 
@@ -781,7 +834,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp_player *player
 
 err:
 	pdu->params_len = htons(1);
-	pdu->params[0] = E_INVALID_PARAM;
+	pdu->params[0] = STATUS_INVALID_PARAMETER;
 
 	return AVC_CTYPE_REJECTED;
 }
@@ -802,7 +855,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
 	 * and set the existent ones. Sec. 5.2.4 is not clear however how to
 	 * indicate that a certain ID was not accepted. If at least one
 	 * attribute is valid, we respond with no parameters. Otherwise an
-	 * E_INVALID_PARAM is sent.
+	 * STATUS_INVALID_PARAMETER is sent.
 	 */
 	for (len = 0, i = 0, param = &pdu->params[1]; i < pdu->params[0];
 							i++, param += 2) {
@@ -820,7 +873,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
 
 err:
 	pdu->params_len = htons(1);
-	pdu->params[0] = E_INVALID_PARAM;
+	pdu->params[0] = STATUS_INVALID_PARAMETER;
 	return AVC_CTYPE_REJECTED;
 }
 
@@ -832,7 +885,7 @@ static uint8_t avrcp_handle_displayable_charset(struct avrcp_player *player,
 
 	if (len < 3) {
 		pdu->params_len = htons(1);
-		pdu->params[0] = E_INVALID_PARAM;
+		pdu->params[0] = STATUS_INVALID_PARAMETER;
 		return AVC_CTYPE_REJECTED;
 	}
 
@@ -864,7 +917,7 @@ static uint8_t avrcp_handle_ct_battery_status(struct avrcp_player *player,
 
 err:
 	pdu->params_len = htons(1);
-	pdu->params[0] = E_INVALID_PARAM;
+	pdu->params[0] = STATUS_INVALID_PARAMETER;
 	return AVC_CTYPE_REJECTED;
 }
 
@@ -879,7 +932,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
 
 	if (len != 0) {
 		pdu->params_len = htons(1);
-		pdu->params[0] = E_INVALID_PARAM;
+		pdu->params[0] = STATUS_INVALID_PARAMETER;
 		return AVC_CTYPE_REJECTED;
 	}
 
@@ -918,7 +971,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 		goto err;
 
 	switch (pdu->params[0]) {
-	case AVRCP_EVENT_STATUS_CHANGED:
+	case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
 		len = 2;
 		pdu->params[1] = player->cb->get_status(player->user_data);
 
@@ -948,7 +1001,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 
 err:
 	pdu->params_len = htons(1);
-	pdu->params[0] = E_INVALID_PARAM;
+	pdu->params[0] = STATUS_INVALID_PARAMETER;
 	return AVC_CTYPE_REJECTED;
 }
 
@@ -988,7 +1041,7 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp_player *player,
 	return AVC_CTYPE_STABLE;
 err:
 	pdu->params_len = htons(1);
-	pdu->params[0] = E_INVALID_PARAM;
+	pdu->params[0] = STATUS_INVALID_PARAMETER;
 	return AVC_CTYPE_REJECTED;
 }
 
@@ -1014,7 +1067,7 @@ static uint8_t avrcp_handle_abort_continuing(struct avrcp_player *player,
 
 err:
 	pdu->params_len = htons(1);
-	pdu->params[0] = E_INVALID_PARAM;
+	pdu->params[0] = STATUS_INVALID_PARAMETER;
 	return AVC_CTYPE_REJECTED;
 }
 
@@ -1079,7 +1132,7 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 	pdu->rsvd = 0;
 
 	if (operand_count < AVRCP_HEADER_LENGTH) {
-		pdu->params[0] = E_INVALID_COMMAND;
+		pdu->params[0] = STATUS_INVALID_COMMAND;
 		goto err_metadata;
 	}
 
@@ -1089,12 +1142,12 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 	}
 
 	if (!handler || handler->code != *code) {
-		pdu->params[0] = E_INVALID_COMMAND;
+		pdu->params[0] = STATUS_INVALID_COMMAND;
 		goto err_metadata;
 	}
 
 	if (!handler->func) {
-		pdu->params[0] = E_INVALID_PARAM;
+		pdu->params[0] = STATUS_INVALID_PARAMETER;
 		goto err_metadata;
 	}
 
@@ -1122,7 +1175,7 @@ size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 
     *code = AVC_CTYPE_REJECTED;
     pdu->params_len = htons(1);
-    pdu->params[0] = E_INTERNAL;
+    pdu->params[0] = STATUS_INTERNAL_ERROR;
 
     DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
             pdu->pdu_id, company_id, pdu->params_len);
@@ -1236,7 +1289,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		desc = list->data;
 
-		if (desc && desc->version >= 0x0104)
+		if (desc && desc->version >= AVRCP_VERSION_1_4)
 			register_volume_notification(player);
 
 		sdp_list_free(list, free);
diff --git a/audio/avrcp.h b/audio/avrcp.h
index bf11a6c..0045a2c 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -22,59 +22,75 @@
  *
  */
 
-/* player attributes */
-#define AVRCP_ATTRIBUTE_ILEGAL		0x00
-#define AVRCP_ATTRIBUTE_EQUALIZER	0x01
-#define AVRCP_ATTRIBUTE_REPEAT_MODE	0x02
-#define AVRCP_ATTRIBUTE_SHUFFLE		0x03
-#define AVRCP_ATTRIBUTE_SCAN		0x04
+enum player_attribute {
+	AVRCP_ATTRIBUTE_ILEGAL		= 0x00,
+	AVRCP_ATTRIBUTE_EQUALIZER	= 0x01,
+	AVRCP_ATTRIBUTE_REPEAT_MODE	= 0x02,
+	AVRCP_ATTRIBUTE_SHUFFLE		= 0x03,
+	AVRCP_ATTRIBUTE_SCAN		= 0x04
+};
 
-/* equalizer values */
-#define AVRCP_EQUALIZER_OFF		0x01
-#define AVRCP_EQUALIZER_ON		0x02
+enum equalizer_value {
+	AVRCP_EQUALIZER_OFF		= 0x01,
+	AVRCP_EQUALIZER_ON		= 0x02
+};
 
-/* repeat mode values */
-#define AVRCP_REPEAT_MODE_OFF		0x01
-#define AVRCP_REPEAT_MODE_SINGLE	0x02
-#define AVRCP_REPEAT_MODE_ALL		0x03
-#define AVRCP_REPEAT_MODE_GROUP		0x04
+enum repeat_mode_value {
+	AVRCP_REPEAT_MODE_OFF		= 0x01,
+	AVRCP_REPEAT_MODE_SINGLE	= 0x02,
+	AVRCP_REPEAT_MODE_ALL		= 0x03,
+	AVRCP_REPEAT_MODE_GROUP		= 0x04
+};
 
-/* shuffle values */
-#define AVRCP_SHUFFLE_OFF		0x01
-#define AVRCP_SHUFFLE_ALL		0x02
-#define AVRCP_SHUFFLE_GROUP		0x03
+enum shuffle_value {
+	AVRCP_SHUFFLE_OFF		= 0x01,
+	AVRCP_SHUFFLE_ALL		= 0x02,
+	AVRCP_SHUFFLE_GROUP		= 0x03
+};
 
-/* scan values */
-#define AVRCP_SCAN_OFF			0x01
-#define AVRCP_SCAN_ALL			0x02
-#define AVRCP_SCAN_GROUP		0x03
+enum scan_value {
+	AVRCP_SCAN_OFF			= 0x01,
+	AVRCP_SCAN_ALL			= 0x02,
+	AVRCP_SCAN_GROUP		= 0x03
+};
 
-/* media attributes */
-#define AVRCP_MEDIA_ATTRIBUTE_ILLEGAL	0x00
-#define AVRCP_MEDIA_ATTRIBUTE_TITLE	0x01
-#define AVRCP_MEDIA_ATTRIBUTE_ARTIST	0x02
-#define AVRCP_MEDIA_ATTRIBUTE_ALBUM	0x03
-#define AVRCP_MEDIA_ATTRIBUTE_TRACK	0x04
-#define AVRCP_MEDIA_ATTRIBUTE_N_TRACKS	0x05
-#define AVRCP_MEDIA_ATTRIBUTE_GENRE	0x06
-#define AVRCP_MEDIA_ATTRIBUTE_DURATION	0x07
-#define AVRCP_MEDIA_ATTRIBUTE_LAST	AVRCP_MEDIA_ATTRIBUTE_DURATION
+enum media_attribute {
+	AVRCP_MEDIA_ATTRIBUTE_ILLEGAL	= 0x00,
+	AVRCP_MEDIA_ATTRIBUTE_TITLE	= 0x01,
+	AVRCP_MEDIA_ATTRIBUTE_ARTIST	= 0x02,
+	AVRCP_MEDIA_ATTRIBUTE_ALBUM	= 0x03,
+	AVRCP_MEDIA_ATTRIBUTE_TRACK	= 0x04,
+	AVRCP_MEDIA_ATTRIBUTE_N_TRACKS	= 0x05,
+	AVRCP_MEDIA_ATTRIBUTE_GENRE	= 0x06,
+	AVRCP_MEDIA_ATTRIBUTE_DURATION	= 0x07,
+	AVRCP_MEDIA_ATTRIBUTE_LAST	= AVRCP_MEDIA_ATTRIBUTE_DURATION
+};
 
-/* play status */
-#define AVRCP_PLAY_STATUS_STOPPED	0x00
-#define AVRCP_PLAY_STATUS_PLAYING	0x01
-#define AVRCP_PLAY_STATUS_PAUSED	0x02
-#define AVRCP_PLAY_STATUS_FWD_SEEK	0x03
-#define AVRCP_PLAY_STATUS_REV_SEEK	0x04
-#define AVRCP_PLAY_STATUS_ERROR		0xFF
+enum play_status {
+	AVRCP_PLAY_STATUS_STOPPED	= 0x00,
+	AVRCP_PLAY_STATUS_PLAYING	= 0x01,
+	AVRCP_PLAY_STATUS_PAUSED	= 0x02,
+	AVRCP_PLAY_STATUS_FWD_SEEK	= 0x03,
+	AVRCP_PLAY_STATUS_REV_SEEK	= 0x04,
+	AVRCP_PLAY_STATUS_ERROR		= 0xFF
+};
 
-/* Notification events */
-#define AVRCP_EVENT_STATUS_CHANGED	0x01
-#define AVRCP_EVENT_TRACK_CHANGED	0x02
-#define AVRCP_EVENT_TRACK_REACHED_END	0x03
-#define AVRCP_EVENT_TRACK_REACHED_START	0x04
-#define AVRCP_EVENT_VOLUME_CHANGED	0x0d
-#define AVRCP_EVENT_LAST		AVRCP_EVENT_VOLUME_CHANGED
+enum notification_event {
+	AVRCP_EVENT_PLAYBACK_STATUS_CHANGED		= 0x01,
+	AVRCP_EVENT_TRACK_CHANGED			= 0x02,
+	AVRCP_EVENT_TRACK_REACHED_END			= 0x03,
+	AVRCP_EVENT_TRACK_REACHED_START			= 0x04,
+	AVRCP_EVENT_PLAYBACK_POS_CHANGED		= 0x05,
+	AVRCP_EVENT_BATT_STATUS_CHANGED			= 0x06,
+	AVRCP_EVENT_SYSTEM_STATUS_CHANGED		= 0x07,
+	AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED	= 0x08,
+	AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED		= 0x09,
+	AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED		= 0x0A,
+	AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED		= 0x0B,
+	AVRCP_EVENT_UIDS_CHANGED			= 0x0C,
+	AVRCP_EVENT_VOLUME_CHANGED			= 0x0D,
+	AVRCP_EVENT_LAST				= AVRCP_EVENT_VOLUME_CHANGED
+};
 
 struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
diff --git a/audio/media.c b/audio/media.c
index 1956653..4e23273 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1414,7 +1414,7 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
 
 	mp->status = val;
 
-	avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, &val);
+	avrcp_player_event(mp->player, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED, &val);
 
 	return TRUE;
 }
-- 
on behalf of ST-Ericsson

