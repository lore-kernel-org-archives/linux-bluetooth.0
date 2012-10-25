Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/11] AVRCP: Add initial support for controller player
Date: Thu, 25 Oct 2012 16:59:10 +0300
Message-Id: <1351173554-28039-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This also bump controller record to 1.3.
---
 Makefile.am    |   1 +
 audio/avrcp.c  | 686 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 audio/player.c | 404 +++++++++++++++++++++++++++++++++
 audio/player.h |  46 ++++
 4 files changed, 1047 insertions(+), 90 deletions(-)
 create mode 100644 audio/player.c
 create mode 100644 audio/player.h

diff --git a/Makefile.am b/Makefile.am
index 35b1520..6ac6a73 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -148,6 +148,7 @@ builtin_sources += audio/main.c \
 			audio/avdtp.h audio/avdtp.c \
 			audio/media.h audio/media.c \
 			audio/transport.h audio/transport.c \
+			audio/player.h audio/player.c \
 			audio/telephony.h audio/a2dp-codecs.h
 builtin_nodist += audio/telephony.c
 
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 02e4581..35fc249 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -61,6 +61,9 @@
 #include "control.h"
 #include "avdtp.h"
 #include "sink.h"
+#include "player.h"
+
+#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
 
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
@@ -190,6 +193,7 @@ struct avrcp {
 	int features;
 
 	void (*init) (struct avrcp *session);
+	void (*destroy) (struct avrcp *sesion);
 
 	const struct control_pdu_handler *control_handlers;
 
@@ -216,7 +220,7 @@ static uint32_t company_ids[] = {
 	IEEEID_BTSIG,
 };
 
-static void register_notification(struct avrcp *session, uint8_t event);
+static void avrcp_register_notification(struct avrcp *session, uint8_t event);
 
 static sdp_record_t *avrcp_ct_record(void)
 {
@@ -227,7 +231,7 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_CONTROL_PSM;
-	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
+	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 						AVRCP_FEATURE_CATEGORY_2 |
 						AVRCP_FEATURE_CATEGORY_3 |
@@ -431,20 +435,12 @@ static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
 	cid[2] = cid_in;
 }
 
-static int player_get_attribute(struct avrcp_player *player, uint8_t attr)
+static int player_get_setting(struct avrcp_player *player, uint8_t id)
 {
-	int value;
-
-	DBG("attr %u", attr);
-
 	if (player == NULL)
 		return -ENOENT;
 
-	value = player->cb->get_setting(attr, player->user_data);
-	if (value < 0)
-		DBG("attr %u not supported by player", attr);
-
-	return value;
+	return player->cb->get_setting(id, player->user_data);
 }
 
 void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
@@ -490,7 +486,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 			uint8_t attr = GPOINTER_TO_UINT(settings->data);
 			int val;
 
-			val = player_get_attribute(player, attr);
+			val = player_get_setting(player, attr);
 			if (val < 0)
 				continue;
 
@@ -642,14 +638,6 @@ static int player_set_setting(struct avrcp_player *player, uint8_t id,
 	return player->cb->set_setting(id, val, player->user_data);
 }
 
-static int player_get_setting(struct avrcp_player *player, uint8_t id)
-{
-	if (player == NULL)
-		return -ENOENT;
-
-	return player->cb->get_setting(id, player->user_data);
-}
-
 static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -1094,7 +1082,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 			uint8_t attr = GPOINTER_TO_UINT(settings->data);
 			int val;
 
-			val = player_get_attribute(player, attr);
+			val = player_get_setting(player, attr);
 			if (val < 0)
 				continue;
 
@@ -1356,6 +1344,330 @@ static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
 	return NULL;
 }
 
+static const char *status_to_string(uint8_t status)
+{
+	switch (status) {
+	case AVRCP_PLAY_STATUS_STOPPED:
+		return "stopped";
+	case AVRCP_PLAY_STATUS_PLAYING:
+		return "playing";
+	case AVRCP_PLAY_STATUS_PAUSED:
+		return "paused";
+	case AVRCP_PLAY_STATUS_FWD_SEEK:
+		return "forward-seek";
+	case AVRCP_PLAY_STATUS_REV_SEEK:
+		return "reverse-seek";
+	case AVRCP_PLAY_STATUS_ERROR:
+		return "error";
+	default:
+		return NULL;
+	}
+}
+
+static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	struct avrcp_header *pdu = (void *) operands;
+	uint32_t duration;
+	uint32_t position;
+	uint8_t status;
+
+	if (code == AVC_CTYPE_REJECTED || pdu->params_len != 9)
+		return FALSE;
+
+	memcpy(&duration, pdu->params, sizeof(uint32_t));
+	duration = ntohl(duration);
+
+	memcpy(&position, pdu->params + 4, sizeof(uint32_t));
+	position = ntohl(position);
+	media_player_set_position(mp, position);
+
+	memcpy(&status, pdu->params + 8, sizeof(uint8_t));
+	media_player_set_status(mp, status_to_string(status));
+
+	return FALSE;
+}
+
+static void avrcp_get_play_status(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH];
+	struct avrcp_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_GET_PLAY_STATUS;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					avrcp_get_play_status_rsp,
+					session);
+}
+
+static const char *attrval_to_str(uint8_t attr, uint8_t value)
+{
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		switch (value) {
+		case AVRCP_EQUALIZER_ON:
+			return "on";
+		case AVRCP_EQUALIZER_OFF:
+			return "off";
+		}
+
+		break;
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		switch (value) {
+		case AVRCP_REPEAT_MODE_OFF:
+			return "off";
+		case AVRCP_REPEAT_MODE_SINGLE:
+			return "singletrack";
+		case AVRCP_REPEAT_MODE_ALL:
+			return "alltracks";
+		case AVRCP_REPEAT_MODE_GROUP:
+			return "group";
+		}
+
+		break;
+	/* Shuffle and scan have the same values */
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+	case AVRCP_ATTRIBUTE_SCAN:
+		switch (value) {
+		case AVRCP_SCAN_OFF:
+			return "off";
+		case AVRCP_SCAN_ALL:
+			return "alltracks";
+		case AVRCP_SCAN_GROUP:
+			return "group";
+		}
+
+		break;
+	}
+
+	return NULL;
+}
+
+static const char *attr_to_str(uint8_t attr)
+{
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		return "Equalizer";
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		return "Repeat";
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		return "Shuffle";
+	case AVRCP_ATTRIBUTE_SCAN:
+		return "Scan";
+	}
+
+	return NULL;
+}
+
+static gboolean avrcp_player_value_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t count;
+	int i;
+
+	if (code == AVC_CTYPE_REJECTED)
+		return FALSE;
+
+	count = pdu->params[0];
+
+	if (pdu->params_len < count * 2)
+		return FALSE;
+
+	for (i = 1; count > 0; count--, i += 2) {
+		const char *key;
+		const char *value;
+
+		key = attr_to_str(pdu->params[i]);
+		if (key == NULL)
+			continue;
+
+		value = attrval_to_str(pdu->params[i], pdu->params[i + 1]);
+		if (value == NULL)
+			continue;
+
+		media_player_set_setting(mp, key, value);
+	}
+
+	return FALSE;
+}
+
+static void avrcp_get_current_player_value(struct avrcp *session,
+						uint8_t *attrs, uint8_t count)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 5];
+	struct avrcp_header *pdu = (void *) buf;
+	int i;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_GET_CURRENT_PLAYER_VALUE;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params_len = htons(count + 1);
+	pdu->params[0] = count;
+
+	for (i = 0; count > 0; count--, i++)
+		pdu->params[i + 1] = attrs[i];
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					avrcp_player_value_rsp, session);
+}
+
+static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t count;
+
+	if (code == AVC_CTYPE_REJECTED)
+		return FALSE;
+
+	count = pdu->params[0];
+
+	if (ntohs(pdu->params_len) < count) {
+		error("Invalid parameters");
+		return FALSE;
+	}
+
+	avrcp_get_current_player_value(session, &pdu->params[1],
+							pdu->params[0]);
+
+	return FALSE;
+}
+
+static void avrcp_list_player_attributes(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH];
+	struct avrcp_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_LIST_PLAYER_ATTRIBUTES;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					avrcp_list_player_attributes_rsp,
+					session);
+}
+
+static const char *metadata_to_str(uint32_t id)
+{
+	switch (id) {
+	case AVRCP_MEDIA_ATTRIBUTE_TITLE:
+		return "Title";
+	case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
+		return "Artist";
+	case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
+		return "Album";
+	case AVRCP_MEDIA_ATTRIBUTE_GENRE:
+		return "Genre";
+	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
+		return "Track";
+	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
+		return "NumberOfTracks";
+	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
+		return "Duration";
+	}
+
+	return NULL;
+}
+
+static gboolean avrcp_get_attributes_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t count;
+	int i;
+
+	if (code == AVC_CTYPE_REJECTED)
+		return FALSE;
+
+	count = pdu->params[0];
+
+	if (ntohs(pdu->params_len) - 1 < count * 8) {
+		error("Invalid parameters");
+		return FALSE;
+	}
+
+	for (i = 1; count > 0; count--) {
+		uint32_t id;
+		uint16_t charset, len;
+
+		memcpy(&id, &pdu->params[i], sizeof(uint32_t));
+		id = ntohl(id);
+		i += sizeof(uint32_t);
+
+		memcpy(&charset, &pdu->params[i], sizeof(uint16_t));
+		charset = ntohs(charset);
+		i += sizeof(uint16_t);
+
+		memcpy(&len, &pdu->params[i], sizeof(uint16_t));
+		len = ntohs(len);
+		i += sizeof(uint16_t);
+
+		if (charset == 106) {
+			const char *key = metadata_to_str(id);
+
+			if (key != NULL)
+				media_player_set_metadata(mp,
+							metadata_to_str(id),
+							&pdu->params[i], len);
+		}
+
+		i += len;
+	}
+
+	return FALSE;
+}
+
+static void avrcp_get_element_attributes(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 9];
+	struct avrcp_header *pdu = (void *) buf;
+	uint16_t length;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_GET_ELEMENT_ATTRIBUTES;
+	pdu->params_len = htons(9);
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, length,
+					avrcp_get_attributes_rsp,
+					session);
+}
+
 static gboolean avrcp_handle_event(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -1364,8 +1676,12 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu = (void *) operands;
+	struct media_player *mp;
 	uint8_t event;
-	uint8_t volume;
+	uint8_t value;
+	uint8_t count;
+	const char *curval, *strval;
+	int i;
 
 	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
 		return FALSE;
@@ -1374,24 +1690,70 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 
 	switch (event) {
 	case AVRCP_EVENT_VOLUME_CHANGED:
-		volume = pdu->params[1] & 0x7F;
+		value = pdu->params[1] & 0x7F;
 
 		if (player)
-			player->cb->set_volume(volume, session->dev,
+			player->cb->set_volume(value, session->dev,
 							player->user_data);
 
 		break;
+	case AVRCP_EVENT_STATUS_CHANGED:
+		mp = player->user_data;
+		value = pdu->params[1];
+
+		curval = media_player_get_status(mp);
+		strval = status_to_string(value);
+
+		if (g_strcmp0(curval, strval) != 0) {
+			media_player_set_status(mp, strval);
+			avrcp_get_play_status(session);
+		}
+
+		break;
+	case AVRCP_EVENT_TRACK_CHANGED:
+		mp = player->user_data;
+		if (code == AVC_CTYPE_CHANGED)
+			media_player_set_position(mp, 0);
+
+		avrcp_get_element_attributes(session);
+
+		break;
+
+	case AVRCP_EVENT_SETTINGS_CHANGED:
+		mp = player->user_data;
+		count = pdu->params[1];
+
+		for (i = 2; count > 0; count--, i += 2) {
+			const char *key;
+			const char *value;
+
+			key = attr_to_str(pdu->params[i]);
+			if (key == NULL)
+				continue;
+
+			value = attrval_to_str(pdu->params[i],
+						pdu->params[i + 1]);
+			if (value == NULL)
+				continue;
+
+			media_player_set_setting(mp, key, value);
+		}
+
+		break;
 	}
 
 	if (code == AVC_CTYPE_CHANGED) {
-		register_notification(session, event);
+		session->registered_events ^= (1 << event);
+		avrcp_register_notification(session, event);
 		return FALSE;
 	}
 
+	session->registered_events |= (1 << event);
+
 	return TRUE;
 }
 
-static void register_notification(struct avrcp *session, uint8_t event)
+static void avrcp_register_notification(struct avrcp *session, uint8_t event)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
 	struct avrcp_header *pdu = (void *) buf;
@@ -1412,14 +1774,139 @@ static void register_notification(struct avrcp *session, uint8_t event)
 					avrcp_handle_event, session);
 }
 
+static int attr_to_val(const char *str)
+{
+	if (!strcasecmp(str, "Equalizer"))
+		return AVRCP_ATTRIBUTE_EQUALIZER;
+	else if (!strcasecmp(str, "Repeat"))
+		return AVRCP_ATTRIBUTE_REPEAT_MODE;
+	else if (!strcasecmp(str, "Shuffle"))
+		return AVRCP_ATTRIBUTE_SHUFFLE;
+	else if (!strcasecmp(str, "Scan"))
+		return AVRCP_ATTRIBUTE_SCAN;
+
+	return -EINVAL;
+}
+
+static int attrval_to_val(uint8_t attr, const char *value)
+{
+	int ret;
+
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_EQUALIZER_OFF;
+		else if (!strcmp(value, "on"))
+			ret = AVRCP_EQUALIZER_ON;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_REPEAT_MODE_OFF;
+		else if (!strcmp(value, "singletrack"))
+			ret = AVRCP_REPEAT_MODE_SINGLE;
+		else if (!strcmp(value, "alltracks"))
+			ret = AVRCP_REPEAT_MODE_ALL;
+		else if (!strcmp(value, "group"))
+			ret = AVRCP_REPEAT_MODE_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_SHUFFLE_OFF;
+		else if (!strcmp(value, "alltracks"))
+			ret = AVRCP_SHUFFLE_ALL;
+		else if (!strcmp(value, "group"))
+			ret = AVRCP_SHUFFLE_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case AVRCP_ATTRIBUTE_SCAN:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_SCAN_OFF;
+		else if (!strcmp(value, "alltracks"))
+			ret = AVRCP_SCAN_ALL;
+		else if (!strcmp(value, "group"))
+			ret = AVRCP_SCAN_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static void avrcp_set_player_value(struct avrcp *session, uint8_t attr,
+								uint8_t val)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 3];
+	struct avrcp_header *pdu = (void *) buf;
+	uint8_t length;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_SET_PLAYER_VALUE;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params[0] = 1;
+	pdu->params[1] = attr;
+	pdu->params[2] = val;
+	pdu->params_len = htons(3);
+
+	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_NOTIFY,
+					AVC_SUBUNIT_PANEL, buf, length,
+					avrcp_player_value_rsp, session);
+}
+
+static bool ct_set_setting(struct media_player *mp, const char *key,
+					const char *value, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	int attr = attr_to_val(key);
+	int val = attrval_to_val(attr, value);
+	struct avrcp *session;
+
+	session = player->sessions->data;
+	if (session == NULL)
+		return false;
+
+	attr = attr_to_val(key);
+	if (attr < 0)
+		return false;
+
+	val = attrval_to_val(attr, value);
+	if (val < 0)
+		return false;
+
+	avrcp_set_player_value(session, attr, val);
+
+	return true;
+}
+
+static const struct media_player_callback ct_cbs = {
+	.set_setting = ct_set_setting,
+};
+
 static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp;
 	struct avrcp_header *pdu = (void *) operands;
+	uint16_t events = 0;
 	uint8_t count;
+	const char *path;
 
 	if (pdu->params[0] != CAP_EVENTS_SUPPORTED)
 		return FALSE;
@@ -1429,14 +1916,29 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 	for (; count > 0; count--) {
 		uint8_t event = pdu->params[1 + count];
 
+		events |= (1 << event);
+
 		switch (event) {
 		case AVRCP_EVENT_STATUS_CHANGED:
 		case AVRCP_EVENT_TRACK_CHANGED:
-			register_notification(session, event);
+		case AVRCP_EVENT_SETTINGS_CHANGED:
+			avrcp_register_notification(session, event);
 			break;
 		}
 	}
 
+	path = device_get_path(session->dev->btd_dev);
+	mp = media_player_controller_create(path);
+	media_player_set_callbacks(mp, &ct_cbs, player);
+	player->user_data = mp;
+	player->destroy = (GDestroyNotify) media_player_destroy;
+
+	if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
+		avrcp_list_player_attributes(session);
+
+	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
+		avrcp_get_play_status(session);
+
 	return FALSE;
 }
 
@@ -1462,31 +1964,6 @@ static void avrcp_get_capabilities(struct avrcp *session)
 					session);
 }
 
-static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
-					uint8_t code, uint8_t subunit,
-					uint8_t *operands, size_t operand_count,
-					void *user_data)
-{
-	return FALSE;
-}
-
-static void avrcp_get_play_status(struct avrcp *session)
-{
-	uint8_t buf[AVRCP_HEADER_LENGTH];
-	struct avrcp_header *pdu = (void *) buf;
-
-	memset(buf, 0, sizeof(buf));
-
-	set_company_id(pdu->company_id, IEEEID_BTSIG);
-	pdu->pdu_id = AVRCP_GET_PLAY_STATUS;
-	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
-
-	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
-					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
-					avrcp_get_play_status_rsp,
-					session);
-}
-
 static struct avrcp *find_session(GSList *list, struct audio_device *dev)
 {
 	for (; list; list = list->next) {
@@ -1515,7 +1992,8 @@ static void session_tg_init(struct avrcp *session)
 	session->control_handlers = tg_control_handlers;
 
 	if (session->version >= 0x0104) {
-		register_notification(session, AVRCP_EVENT_VOLUME_CHANGED);
+		avrcp_register_notification(session,
+						AVRCP_EVENT_VOLUME_CHANGED);
 		if (session->features & AVRCP_FEATURE_BROWSING)
 			avctp_connect_browsing(session->conn);
 	}
@@ -1532,19 +2010,75 @@ static void session_tg_init(struct avrcp *session)
 
 static void session_ct_init(struct avrcp *session)
 {
+	struct avrcp_player *player;
+
 	session->control_handlers = ct_control_handlers;
 
 	DBG("%p version 0x%04x", session, session->version);
 
-	if (session->version >= 0x0103) {
-		avrcp_get_capabilities(session);
-		avrcp_get_play_status(session);
-	}
-
 	session->control_id = avctp_register_pdu_handler(session->conn,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							session);
+
+	if (session->version < 0x0103)
+		return;
+
+	player = g_new0(struct avrcp_player, 1);
+	player->sessions = g_slist_prepend(player->sessions, session);
+	session->player = player;
+
+	avrcp_get_capabilities(session);
+}
+
+static void session_destroy(struct avrcp *session)
+{
+	struct avrcp_server *server = session->server;
+
+	server->sessions = g_slist_remove(server->sessions, session);
+
+	if (session->control_id > 0)
+		avctp_unregister_pdu_handler(session->control_id);
+
+	if (session->browsing_id > 0)
+		avctp_unregister_browsing_pdu_handler(session->browsing_id);
+
+	g_free(session);
+}
+
+static void session_tg_destroy(struct avrcp *session)
+{
+	struct avrcp_player *player = session->player;
+
+	DBG("%p", session);
+
+	if (player != NULL)
+		player->sessions = g_slist_remove(player->sessions, session);
+
+	session_destroy(session);
+}
+
+static void player_destroy(gpointer data)
+{
+	struct avrcp_player *player = data;
+
+	if (player->destroy)
+		player->destroy(player->user_data);
+
+	g_slist_free(player->sessions);
+	g_free(player);
+}
+
+static void session_ct_destroy(struct avrcp *session)
+{
+	struct avrcp_player *player = session->player;
+
+	DBG("%p", session);
+
+	if (player != NULL)
+		player_destroy(player);
+
+	session_destroy(session);
 }
 
 static struct avrcp *session_create(struct avrcp_server *server,
@@ -1573,9 +2107,11 @@ static struct avrcp *session_create(struct avrcp_server *server,
 
 	if (session->target) {
 		session->init = session_tg_init;
+		session->destroy = session_tg_destroy;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
 	} else {
 		session->init = session_ct_init;
+		session->destroy = session_ct_destroy;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
 	}
 
@@ -1594,25 +2130,6 @@ static struct avrcp *session_create(struct avrcp_server *server,
 	return session;
 }
 
-static void session_destroy(struct avrcp *session)
-{
-	struct avrcp_server *server = session->server;
-	struct avrcp_player *player = session->player;
-
-	server->sessions = g_slist_remove(server->sessions, session);
-
-	if (session->control_id > 0)
-		avctp_unregister_pdu_handler(session->control_id);
-
-	if (session->browsing_id > 0)
-		avctp_unregister_browsing_pdu_handler(session->browsing_id);
-
-	if (player != NULL)
-		player->sessions = g_slist_remove(player->sessions, session);
-
-	g_free(session);
-}
-
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 				avctp_state_t new_state, void *user_data)
 {
@@ -1630,7 +2147,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (session == NULL)
 			break;
 
-		session_destroy(session);
+		session->destroy(session);
 
 		break;
 	case AVCTP_STATE_CONNECTING:
@@ -1739,17 +2256,6 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 	return 0;
 }
 
-static void player_destroy(gpointer data)
-{
-	struct avrcp_player *player = data;
-
-	if (player->destroy)
-		player->destroy(player->user_data);
-
-	g_slist_free(player->sessions);
-	g_free(player);
-}
-
 void avrcp_unregister(const bdaddr_t *src)
 {
 	struct avrcp_server *server;
diff --git a/audio/player.c b/audio/player.c
new file mode 100644
index 0000000..d6e499c
--- /dev/null
+++ b/audio/player.c
@@ -0,0 +1,404 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2007  Nokia Corporation
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2012-2012  Intel Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus.h>
+
+#include "log.h"
+#include "player.h"
+#include "dbus-common.h"
+#include "error.h"
+
+#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
+
+struct player_callback {
+	const struct media_player_callback *cbs;
+	void *user_data;
+};
+
+struct media_player {
+	char			*path;		/* Player object path */
+	GHashTable		*settings;	/* Player settings */
+	GHashTable		*track;		/* Player current track */
+	char			*status;
+	uint32_t		position;
+	GTimer			*progress;
+	guint			process_id;
+	struct player_callback	*cb;
+	GSList			*pending;
+};
+
+static void append_settings(void *key, void *value, void *user_data)
+{
+	DBusMessageIter *dict = user_data;
+
+	dict_append_entry(dict, key, DBUS_TYPE_STRING, &value);
+}
+
+static void append_metadata(void *key, void *value, void *user_data)
+{
+	DBusMessageIter *dict = user_data;
+
+	if (strcasecmp((char *) key, "Duration") == 0 ||
+			strcasecmp((char *) key, "Track") == 0 ||
+			strcasecmp((char *) key, "NumberOfTracks") == 0)  {
+		uint32_t num = atoi(value);
+		dict_append_entry(dict, key, DBUS_TYPE_UINT32, &num);
+		return;
+	}
+
+	dict_append_entry(dict, key, DBUS_TYPE_STRING, &value);
+}
+
+static DBusMessage *media_player_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct media_player *mp = data;
+	DBusMessage *reply;
+	DBusMessageIter iter, dict;
+	uint32_t position;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	position = media_player_get_position(mp);
+	dict_append_entry(&dict, "Position", DBUS_TYPE_UINT32, &position);
+
+	dict_append_entry(&dict, "Status", DBUS_TYPE_STRING, &mp->status);
+
+	g_hash_table_foreach(mp->settings, append_settings, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *media_player_get_track(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct media_player *mp = data;
+	DBusMessage *reply;
+	DBusMessageIter iter, dict;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	g_hash_table_foreach(mp->track, append_metadata, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *media_player_set_property(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *key, *value, *curval;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &key);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&var, &value);
+
+	if (g_strcmp0(key, "Equalizer") != 0 &&
+				g_strcmp0(key, "Repeat") != 0 &&
+				g_strcmp0(key, "Shuffle") != 0 &&
+				g_strcmp0(key, "Scan") != 0)
+		return btd_error_invalid_args(msg);
+
+	if (cb == NULL || cb->cbs->set_setting == NULL)
+		return btd_error_not_supported(msg);
+
+	curval = g_hash_table_lookup(mp->settings, key);
+	if (g_strcmp0(curval, value) == 0)
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	if (!cb->cbs->set_setting(mp, key, value, cb->user_data))
+		return btd_error_invalid_args(msg);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static const GDBusMethodTable media_player_methods[] = {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			media_player_get_properties) },
+	{ GDBUS_METHOD("GetTrack",
+			NULL, GDBUS_ARGS({ "metadata", "a{sv}" }),
+			media_player_get_track) },
+	{ GDBUS_METHOD("SetProperty",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }),
+			NULL, media_player_set_property) },
+	{ }
+};
+
+static const GDBusSignalTable media_player_signals[] = {
+	{ GDBUS_SIGNAL("PropertyChanged",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ GDBUS_SIGNAL("TrackChanged",
+			GDBUS_ARGS({ "metadata", "a{sv}" })) },
+	{ }
+};
+
+void media_player_destroy(struct media_player *mp)
+{
+	DBG("%s", mp->path);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(), mp->path,
+						MEDIA_PLAYER_INTERFACE);
+
+	if (mp->track)
+		g_hash_table_unref(mp->track);
+
+	if (mp->settings)
+		g_hash_table_unref(mp->settings);
+
+	if (mp->process_id > 0)
+		g_source_remove(mp->process_id);
+
+	g_timer_destroy(mp->progress);
+	g_free(mp->cb);
+	g_free(mp->status);
+	g_free(mp->path);
+	g_free(mp);
+}
+
+struct media_player *media_player_controller_create(const char *path)
+{
+	struct media_player *mp;
+
+	mp = g_new0(struct media_player, 1);
+	mp->path = g_strdup_printf("%s/player1", path);
+	mp->settings = g_hash_table_new_full(g_str_hash, g_str_equal,
+							g_free, g_free);
+	mp->track = g_hash_table_new_full(g_str_hash, g_str_equal,
+							g_free, g_free);
+	mp->progress = g_timer_new();
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					media_player_methods,
+					media_player_signals,
+					NULL, mp, NULL)) {
+		error("D-Bus failed to register %s path", mp->path);
+		media_player_destroy(mp);
+		return NULL;
+	}
+
+	DBG("%s", mp->path);
+
+	return mp;
+}
+
+uint32_t media_player_get_position(struct media_player *mp)
+{
+	double timedelta;
+	uint32_t sec, msec;
+
+	if (g_strcmp0(mp->status, "playing") != 0)
+		return mp->position;
+
+	timedelta = g_timer_elapsed(mp->progress, NULL);
+
+	sec = (uint32_t) timedelta;
+	msec = (uint32_t) ((timedelta - sec) * 1000);
+
+	return mp->position + sec * 1000 + msec;
+}
+
+void media_player_set_position(struct media_player *mp, uint32_t position)
+{
+	DBG("%u", position);
+
+	if (mp->position == position)
+		return;
+
+	mp->position = position;
+	g_timer_start(mp->progress);
+
+	emit_property_changed(mp->path, MEDIA_PLAYER_INTERFACE, "Position",
+					DBUS_TYPE_UINT32, &mp->position);
+}
+
+void media_player_set_setting(struct media_player *mp, const char *key,
+							const char *value)
+{
+	char *curval;
+
+	DBG("%s: %s", key, value);
+
+	curval = g_hash_table_lookup(mp->settings, key);
+	if (g_strcmp0(curval, value) == 0)
+		return;
+
+	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
+
+	emit_property_changed(mp->path, MEDIA_PLAYER_INTERFACE, key,
+					DBUS_TYPE_STRING, &value);
+}
+
+const char *media_player_get_status(struct media_player *mp)
+{
+	return mp->status;
+}
+
+void media_player_set_status(struct media_player *mp, const char *status)
+{
+	DBG("%s", status);
+
+	if (g_strcmp0(mp->status, status) == 0)
+		return;
+
+	g_free(mp->status);
+	mp->status = g_strdup(status);
+
+	emit_property_changed(mp->path, MEDIA_PLAYER_INTERFACE, "Status",
+					DBUS_TYPE_STRING, &status);
+
+	mp->position = media_player_get_position(mp);
+	g_timer_start(mp->progress);
+}
+
+static gboolean process_metadata_changed(void *user_data)
+{
+	struct media_player *mp = user_data;
+	DBusMessage *signal;
+	DBusMessageIter iter, dict;
+
+	mp->process_id = 0;
+
+	signal = dbus_message_new_signal(mp->path, MEDIA_PLAYER_INTERFACE,
+							"TrackChanged");
+	if (signal == NULL) {
+		error("Unable to allocate TrackChanged signal");
+		return FALSE;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+
+	g_hash_table_foreach(mp->track, append_metadata, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(btd_get_dbus_connection(), signal);
+
+	return FALSE;
+}
+
+void media_player_set_metadata(struct media_player *mp, const char *key,
+						void *data, size_t len)
+{
+	char *value, *curval;
+
+	value = g_strndup(data, len);
+
+	DBG("%s: %s", key, value);
+
+	curval = g_hash_table_lookup(mp->track, key);
+	if (g_strcmp0(curval, value) == 0) {
+		g_free(value);
+		return;
+	}
+
+	if (mp->process_id == 0) {
+		g_hash_table_remove_all(mp->track);
+		mp->process_id = g_idle_add(process_metadata_changed, mp);
+	}
+
+	g_hash_table_replace(mp->track, g_strdup(key), value);
+}
+
+void media_player_set_callbacks(struct media_player *mp,
+				const struct media_player_callback *cbs,
+				void *user_data)
+{
+	struct player_callback *cb;
+
+	if (mp->cb)
+		g_free(mp->cb);
+
+	cb = g_new0(struct player_callback, 1);
+	cb->cbs = cbs;
+	cb->user_data = user_data;
+
+	mp->cb = cb;
+}
diff --git a/audio/player.h b/audio/player.h
new file mode 100644
index 0000000..4a6a9cc
--- /dev/null
+++ b/audio/player.h
@@ -0,0 +1,46 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2007  Nokia Corporation
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2012-2012  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct media_player;
+
+struct media_player_callback {
+	bool (*set_setting) (struct media_player *mp, const char *key,
+				const char *value, void *user_data);
+};
+
+struct media_player *media_player_controller_create(const char *path);
+void media_player_destroy(struct media_player *mp);
+uint32_t media_player_get_position(struct media_player *mp);
+void media_player_set_position(struct media_player *mp, uint32_t position);
+void media_player_set_setting(struct media_player *mp, const char *key,
+							const char *value);
+const char *media_player_get_status(struct media_player *mp);
+void media_player_set_status(struct media_player *mp, const char *status);
+void media_player_set_metadata(struct media_player *mp, const char *key,
+						void *data, size_t len);
+
+void media_player_set_callbacks(struct media_player *mp,
+				const struct media_player_callback *cbs,
+				void *user_data);
-- 
1.7.11.7

