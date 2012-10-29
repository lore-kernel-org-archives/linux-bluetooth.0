Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] audio: Export remote player as children object path of device
Date: Mon, 29 Oct 2012 16:41:44 +0200
Message-Id: <1351521709-4063-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351521709-4063-1-git-send-email-luiz.dentz@gmail.com>
References: <1351521709-4063-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The object implements org.bluez.MediaPlayer similar to the target role.
---
 Makefile.am       |   1 +
 audio/avrcp.c     | 260 ++++++++++++++++++++++++++---------------
 audio/player.c    | 343 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/player.h    |  37 ++++++
 doc/media-api.txt |  20 +++-
 5 files changed, 564 insertions(+), 97 deletions(-)
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
index 4f14513..7c26491 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -61,6 +61,7 @@
 #include "control.h"
 #include "avdtp.h"
 #include "sink.h"
+#include "player.h"
 
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
@@ -432,6 +433,36 @@ static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
 	cid[2] = cid_in;
 }
 
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
 static int player_get_setting(struct avrcp_player *player, uint8_t id)
 {
 	if (player == NULL)
@@ -440,6 +471,24 @@ static int player_get_setting(struct avrcp_player *player, uint8_t id)
 	return player->cb->get_setting(id, player->user_data);
 }
 
+static int play_status_to_val(const char *status)
+{
+	if (!strcasecmp(status, "stopped"))
+		return AVRCP_PLAY_STATUS_STOPPED;
+	else if (!strcasecmp(status, "playing"))
+		return AVRCP_PLAY_STATUS_PLAYING;
+	else if (!strcasecmp(status, "paused"))
+		return AVRCP_PLAY_STATUS_PAUSED;
+	else if (!strcasecmp(status, "forward-seek"))
+		return AVRCP_PLAY_STATUS_FWD_SEEK;
+	else if (!strcasecmp(status, "reverse-seek"))
+		return AVRCP_PLAY_STATUS_REV_SEEK;
+	else if (!strcasecmp(status, "error"))
+		return AVRCP_PLAY_STATUS_ERROR;
+
+	return -EINVAL;
+}
+
 void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + 9];
@@ -463,7 +512,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	switch (id) {
 	case AVRCP_EVENT_STATUS_CHANGED:
 		size = 2;
-		pdu->params[1] = *((uint8_t *)data);
+		pdu->params[1] = play_status_to_val(data);
 
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
@@ -480,9 +529,14 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 		settings = data;
 		pdu->params[1] = g_list_length(settings);
 		for (; settings; settings = settings->next) {
-			uint8_t attr = GPOINTER_TO_UINT(settings->data);
+			const char *key = settings->data;
+			int attr;
 			int val;
 
+			attr = attr_to_val(key);
+			if (attr < 0)
+				continue;
+
 			val = player_get_setting(player, attr);
 			if (val < 0)
 				continue;
@@ -519,13 +573,35 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	return;
 }
 
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
 static const char *player_get_metadata(struct avrcp_player *player,
-								uint32_t attr)
+								uint32_t id)
 {
 	if (player != NULL)
-		return player->cb->get_metadata(attr, player->user_data);
+		return player->cb->get_metadata(id, player->user_data);
 
-	if (attr == AVRCP_MEDIA_ATTRIBUTE_TITLE)
+	if (id == AVRCP_MEDIA_ATTRIBUTE_TITLE)
 		return "";
 
 	return NULL;
@@ -627,6 +703,49 @@ static gboolean session_abort_pending_pdu(struct avrcp *session)
 	return TRUE;
 }
 
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
 static int player_set_setting(struct avrcp_player *player, uint8_t id,
 								uint8_t val)
 {
@@ -1077,7 +1196,8 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 
 		pdu->params[++len] = g_list_length(settings);
 		for (; settings; settings = settings->next) {
-			uint8_t attr = GPOINTER_TO_UINT(settings->data);
+			const char *key = settings->data;
+			uint8_t attr = attr_to_val(key);
 			int val;
 
 			val = player_get_setting(player, attr);
@@ -1367,6 +1487,9 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
 	struct avrcp_header *pdu = (void *) operands;
 	uint32_t duration;
 	uint32_t position;
@@ -1380,9 +1503,10 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
 
 	memcpy(&position, pdu->params + 4, sizeof(uint32_t));
 	position = ntohl(position);
+	media_player_set_position(mp, position);
 
 	memcpy(&status, pdu->params + 8, sizeof(uint8_t));
-	DBG("%s", status_to_string(status));
+	media_player_set_status(mp, status_to_string(status));
 
 	return FALSE;
 }
@@ -1404,70 +1528,14 @@ static void avrcp_get_play_status(struct avrcp *session)
 					session);
 }
 
-static const char *attrval_to_str(uint8_t attr, uint8_t value)
-{
-	switch (attr) {
-	case AVRCP_ATTRIBUTE_EQUALIZER:
-		switch (value) {
-		case AVRCP_EQUALIZER_ON:
-			return "on";
-		case AVRCP_EQUALIZER_OFF:
-			return "off";
-		}
-
-		break;
-	case AVRCP_ATTRIBUTE_REPEAT_MODE:
-		switch (value) {
-		case AVRCP_REPEAT_MODE_OFF:
-			return "off";
-		case AVRCP_REPEAT_MODE_SINGLE:
-			return "singletrack";
-		case AVRCP_REPEAT_MODE_ALL:
-			return "alltracks";
-		case AVRCP_REPEAT_MODE_GROUP:
-			return "group";
-		}
-
-		break;
-	/* Shuffle and scan have the same values */
-	case AVRCP_ATTRIBUTE_SHUFFLE:
-	case AVRCP_ATTRIBUTE_SCAN:
-		switch (value) {
-		case AVRCP_SCAN_OFF:
-			return "off";
-		case AVRCP_SCAN_ALL:
-			return "alltracks";
-		case AVRCP_SCAN_GROUP:
-			return "group";
-		}
-
-		break;
-	}
-
-	return NULL;
-}
-
-static const char *attr_to_str(uint8_t attr)
-{
-	switch (attr) {
-	case AVRCP_ATTRIBUTE_EQUALIZER:
-		return "Equalizer";
-	case AVRCP_ATTRIBUTE_REPEAT_MODE:
-		return "Repeat";
-	case AVRCP_ATTRIBUTE_SHUFFLE:
-		return "Shuffle";
-	case AVRCP_ATTRIBUTE_SCAN:
-		return "Scan";
-	}
-
-	return NULL;
-}
-
 static gboolean avrcp_player_value_rsp(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
 	struct avrcp_header *pdu = (void *) operands;
 	uint8_t count;
 	int i;
@@ -1492,7 +1560,7 @@ static gboolean avrcp_player_value_rsp(struct avctp *conn,
 		if (value == NULL)
 			continue;
 
-		DBG("%s: %s", key, value);
+		media_player_set_setting(mp, key, value);
 	}
 
 	return FALSE;
@@ -1563,33 +1631,14 @@ static void avrcp_list_player_attributes(struct avrcp *session)
 					session);
 }
 
-static const char *metadata_to_str(uint32_t id)
-{
-	switch (id) {
-	case AVRCP_MEDIA_ATTRIBUTE_TITLE:
-		return "Title";
-	case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
-		return "Artist";
-	case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
-		return "Album";
-	case AVRCP_MEDIA_ATTRIBUTE_GENRE:
-		return "Genre";
-	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
-		return "Track";
-	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
-		return "NumberOfTracks";
-	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
-		return "Duration";
-	}
-
-	return NULL;
-}
-
 static gboolean avrcp_get_attributes_rsp(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
 {
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
 	struct avrcp_header *pdu = (void *) operands;
 	uint8_t count;
 	int i;
@@ -1622,10 +1671,11 @@ static gboolean avrcp_get_attributes_rsp(struct avctp *conn,
 
 		if (charset == 106) {
 			const char *key = metadata_to_str(id);
-			char *value = g_strndup((char *) &pdu->params[i], len);
 
-			DBG("%s: %s", key , value);
-			g_free(value);
+			if (key != NULL)
+				media_player_set_metadata(mp,
+							metadata_to_str(id),
+							&pdu->params[i], len);
 		}
 
 		i += len;
@@ -1663,9 +1713,11 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu = (void *) operands;
+	struct media_player *mp;
 	uint8_t event;
 	uint8_t value;
 	uint8_t count;
+	const char *curval, *strval;
 	int i;
 
 	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
@@ -1683,17 +1735,29 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 
 		break;
 	case AVRCP_EVENT_STATUS_CHANGED:
+		mp = player->user_data;
 		value = pdu->params[1];
 
-		avrcp_get_play_status(session);
+		curval = media_player_get_status(mp);
+		strval = status_to_string(value);
+
+		if (g_strcmp0(curval, strval) != 0) {
+			media_player_set_status(mp, strval);
+			avrcp_get_play_status(session);
+		}
 
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
+		mp = player->user_data;
+		if (code == AVC_CTYPE_CHANGED)
+			media_player_set_position(mp, 0);
+
 		avrcp_get_element_attributes(session);
 
 		break;
 
 	case AVRCP_EVENT_SETTINGS_CHANGED:
+		mp = player->user_data;
 		count = pdu->params[1];
 
 		for (i = 2; count > 0; count--, i += 2) {
@@ -1709,7 +1773,7 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 			if (value == NULL)
 				continue;
 
-			DBG("%s: %s", key, value);
+			media_player_set_setting(mp, key, value);
 		}
 
 		break;
@@ -1753,9 +1817,12 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp;
 	struct avrcp_header *pdu = (void *) operands;
 	uint16_t events = 0;
 	uint8_t count;
+	const char *path;
 
 	if (pdu->params[0] != CAP_EVENTS_SUPPORTED)
 		return FALSE;
@@ -1776,6 +1843,11 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 		}
 	}
 
+	path = device_get_path(session->dev->btd_dev);
+	mp = media_player_controller_create(path);
+	player->user_data = mp;
+	player->destroy = (GDestroyNotify) media_player_destroy;
+
 	if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
 		avrcp_list_player_attributes(session);
 
diff --git a/audio/player.c b/audio/player.c
new file mode 100644
index 0000000..1957594
--- /dev/null
+++ b/audio/player.c
@@ -0,0 +1,343 @@
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
diff --git a/audio/player.h b/audio/player.h
new file mode 100644
index 0000000..f3a421a
--- /dev/null
+++ b/audio/player.h
@@ -0,0 +1,37 @@
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
diff --git a/doc/media-api.txt b/doc/media-api.txt
index d15d22a..b4f2fc6 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -126,11 +126,25 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 MediaPlayer hierarchy
 =====================
 
-Service		unique name
+Service		unique name (Target role)
+		org.bluez (Controller role)
 Interface	org.bluez.MediaPlayer
-Object path	freely definable
+Object path	freely definable (Target role)
+		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
+		(Controller role)
+
+Methods		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+		dict GetTrack()
+
+			Returns known metadata of the current track.
+
+			See TrackChanged for possible values.
 
-Methods		void SetProperty(string property, variant value)
+		void SetProperty(string property, variant value)
 
 			Changes the value of the specified property. Only
 			properties that are listed as read-write can be changed.
-- 
1.7.11.7

