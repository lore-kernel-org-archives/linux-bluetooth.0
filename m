Return-Path: <cyrus@holtmann.org>
From: Anurag GUPTA-1 <anurag.gupta@stericsson.com>
To: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 27 Feb 2012 11:10:12 +0100
Subject: RE: [RFC : PATCH] - AVRCP 1.4 AbsoluteVolume
Message-ID: <4E253D605AF50140A55CF6396EC99A2421C3751F67@EXDCVYMBSTM005.EQ1STM.local>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B21A747F38A@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B21A747F38A@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

-----Original Message-----
From: Vani-dineshbhai PATEL X 
Sent: Monday, February 27, 2012 3:32 PM
To: linux-bluetooth@vger.kernel.org
Cc: Anurag GUPTA-1
Subject: [RFC : PATCH] - AVRCP 1.4 AbsoluteVolume

Hi All,

I would like to propose this patch for the implementation of Absolute Volume functionality.
When CT sends SetAbsoluteVolume request, a DBus call is made to the player to change the value of its property - volume.
This value is saved in the media_player instance so that it can be sent for Interim response for VolumeChanged Notification.
Your comments shall be appreciated.

>From 9863d379f3f39faf28105f9ad222acef65765d3d Mon Sep 17 00:00:00 2001
From: Vani Patel <vani.patel@stericsson.com>
Date: Mon, 27 Feb 2012 12:53:53 +0530
Subject: [PATCH] Absolute Volume Functions Implemented.

---
 audio/avrcp.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/avrcp.h |    3 +++
 audio/media.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 108 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c index c9ec314..70ebf8e 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -63,6 +63,8 @@
 #define E_INVALID_PARAM		0x01
 #define E_PARAM_NOT_FOUND	0x02
 #define E_INTERNAL		0x03
+#define E_NO_ERR		0x04
+#define E_NO_AVAIL_PLAYER	0x15
 
 /* Packet types */
 #define AVRCP_PACKET_TYPE_SINGLE	0x00
@@ -85,10 +87,12 @@
 #define AVRCP_REGISTER_NOTIFICATION	0x31
 #define AVRCP_REQUEST_CONTINUING	0x40
 #define AVRCP_ABORT_CONTINUING		0x41
+#define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
+#define MAX_ABSOLUTE_VOLUME	255
 
 enum battery_status {
 	BATTERY_STATUS_NORMAL =		0,
@@ -387,6 +391,10 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	case AVRCP_EVENT_TRACK_REACHED_START:
 		size = 1;
 		break;
+	case AVRCP_EVENT_VOLUME_CHANGED:
+ 		size = 2;
+ 		memcpy(&pdu->params[1], data, sizeof(uint8_t));
+ 		break;
 	default:
 		error("Unknown event %u", id);
 		return -EINVAL;
@@ -884,6 +892,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,  {
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
+	uint8_t volume=0;
 
 	/*
 	 * 1 byte for EventID, 4 bytes for Playback interval but the latest @@ -909,6 +918,11 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 	case AVRCP_EVENT_TRACK_REACHED_START:
 		len = 1;
 		break;
+ 	case AVRCP_EVENT_VOLUME_CHANGED:
+ 		len = 2;
+ 		volume = player->cb->get_volume(player->user_data);
+ 		memcpy(&pdu->params[1], &volume, sizeof(uint8_t));
+ 		break;
 	default:
 		/* All other events are not supported yet */
 		goto err;
@@ -994,6 +1008,40 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_set_absolute_volume(struct avrcp_player *player,
+ 						struct avrcp_header *pdu,
+ 						uint8_t transaction)
+{
+ 	uint16_t len = ntohs(pdu->params_len);
+ 	uint8_t abs_volume = 0;
+ 	if (len != 1){
+ 		pdu->params[0] = E_PARAM_NOT_FOUND;
+ 		DBG("Param not Found \n");
+ 		goto err;
+ 	}
+ /*	if (NULL == addressed_player) {
+ 		status = E_NO_AVAIL_PLAYER;
+ 		goto err;
+ 	}
+ */  /*This shall be addressed once AddressedPlayer is implemented */
You should remove unused code before pushing it, moreover do you have some variable named "addressed_player"
+ 
+ 	abs_volume = pdu->params[0];
+ 	if (abs_volume > MAX_ABSOLUTE_VOLUME){
+ 		pdu->params[0] = E_INVALID_PARAM;
+ 		goto err;
+ 	}
+ 
+ 	player->cb->set_volume(abs_volume, player->user_data);
+ 	pdu->params[0] = abs_volume;
+ 	pdu->params_len = htons(len);
+ 	return AVC_CTYPE_ACCEPTED;
+ 
+ 	err:
Label should start from the beginning of line.
+ 	pdu->params_len = htons(1);
+ 	return AVC_CTYPE_REJECTED;
+ 
+}
 
 static struct pdu_handler {
 	uint8_t pdu_id;
@@ -1030,6 +1078,8 @@ static struct pdu_handler {
 					avrcp_handle_request_continuing },
 		{ AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
 					avrcp_handle_abort_continuing },
+		{ AVRCP_SET_ABSOLUTE_VOLUME, AVC_CTYPE_CONTROL,
+ 					avrcp_set_absolute_volume },
 		{ },
 };
 
diff --git a/audio/avrcp.h b/audio/avrcp.h index fb64f3b..1df6103 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -73,6 +73,7 @@
 #define AVRCP_EVENT_TRACK_CHANGED	0x02
 #define AVRCP_EVENT_TRACK_REACHED_END	0x03
 #define AVRCP_EVENT_TRACK_REACHED_START	0x04
+#define AVRCP_EVENT_VOLUME_CHANGED	0x0d
 #define AVRCP_EVENT_LAST		AVRCP_EVENT_TRACK_REACHED_START

AVRCP_EVEN_LAST should be updated to AVRCP_EVENT_VOLUME_CHANGED
 
 struct avrcp_player_cb {
@@ -83,6 +84,8 @@ struct avrcp_player_cb {
 	GList *(*list_metadata) (void *user_data);
 	uint8_t (*get_status) (void *user_data);
 	uint32_t (*get_position) (void *user_data);
+	void (*set_volume)(uint8_t volume, void *user_data);
+ 	uint8_t (*get_volume)(void *user_data);
 };
 
 int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config); diff --git a/audio/media.c b/audio/media.c index c0fd0c3..738adbf 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -102,6 +102,7 @@ struct media_player {
 	guint			track_watch;
 	uint8_t			status;
 	uint32_t		position;
+	uint8_t         	volume;
 	GTimer			*timer;
 };
 
@@ -1255,6 +1256,36 @@ static uint32_t get_position(void *user_data)
 	return mp->position + sec * 1000 + msec;  }
 
+static uint8_t get_volume(void *user_data) {
+ 	struct media_player *mp = user_data;
+ 	return mp->volume;
+}
+
+static void set_volume(uint16_t volume, void *user_data) {
+ 	struct media_player *mp = user_data;
+ 	DBusMessage *msg; 
+ 	DBusMessageIter iter, var;
+ 	const char *property = "InputGain";
+ 	msg = dbus_message_new_method_call(mp->sender, mp->path,
+ 						MEDIA_PLAYER_INTERFACE,
+ 						"SetProperty");
+ 	if (msg == NULL) {
+ 		DBG("Couldn't allocate D-Bus message");
+ 		return ;
+ 	}
+ 	dbus_message_iter_init_append(msg, &iter);
+ 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &property);
+ 	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
+ 						DBUS_TYPE_BYTE_AS_STRING,
+ 						&var);
+ 	dbus_message_iter_append_basic(&var, DBUS_TYPE_BYTE, &volume);
+ 	dbus_message_iter_close_container(&iter, &var);
+ 	g_dbus_send_message(mp->adapter->conn, msg);
+ 	return ;	
+}
+
 static struct avrcp_player_cb player_cb = {
 	.get_setting = get_setting,
 	.set_setting = set_setting,
@@ -1262,7 +1293,9 @@ static struct avrcp_player_cb player_cb = {
 	.get_uid = get_uid,
 	.get_metadata = get_metadata,
 	.get_position = get_position,
-	.get_status = get_status
+	.get_status = get_status,
+ 	.set_volume = set_volume,
+ 	.get_volume = get_volume
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data) @@ -1338,6 +1371,24 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	return TRUE;
 }
 
+static gboolean set_media_volume(struct media_player *mp, 
+DBusMessageIter *iter) {

Correct Minor indentation problem

+ 	uint8_t *value;
+ 	int val;
+ 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BYTE)
+ 		return FALSE;
+ 
+ 	dbus_message_iter_get_basic(iter, &value);
+ 
+ 	if (mp->volume == *value)
+ 		return TRUE;
+ 
+ 	mp->volume = *value;
+ 	avrcp_player_event(mp->player, AVRCP_EVENT_VOLUME_CHANGED, value);
+ 
+ 	return TRUE;
+}
+
 static gboolean set_property(struct media_player *mp, const char *key,
 							DBusMessageIter *entry)
 {
@@ -1355,6 +1406,9 @@ static gboolean set_property(struct media_player *mp, const char *key,
 
 	if (strcasecmp(key, "Position") == 0)
 		return set_position(mp, &var);
+	
+	if (strcasecmp(key, "Volume") == 0)
+ 		return set_media_volume(mp, &var);
 
 	attr = attr_to_val(key);
 	if (attr < 0)
--
1.7.5.4

Vani

Anurag
