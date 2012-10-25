Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/11] AVRCP: Add support for settings changed event
Date: Thu, 25 Oct 2012 16:59:09 +0300
Message-Id: <1351173554-28039-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This event can be registered by the CT to get notified when any setting
is changed.

Per spec every single setting must be sent so the CT can track settings
being added or removed.
---
 audio/avrcp.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 audio/avrcp.h |  2 ++
 audio/media.c | 26 ++++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 88ba3aa..02e4581 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -431,12 +431,29 @@ static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
 	cid[2] = cid_in;
 }
 
+static int player_get_attribute(struct avrcp_player *player, uint8_t attr)
+{
+	int value;
+
+	DBG("attr %u", attr);
+
+	if (player == NULL)
+		return -ENOENT;
+
+	value = player->cb->get_setting(attr, player->user_data);
+	if (value < 0)
+		DBG("attr %u not supported by player", attr);
+
+	return value;
+}
+
 void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + 9];
 	struct avrcp_header *pdu = (void *) buf;
 	uint16_t size;
 	GSList *l;
+	GList *settings;
 
 	if (player->sessions == NULL)
 		return;
@@ -465,6 +482,22 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	case AVRCP_EVENT_TRACK_REACHED_START:
 		size = 1;
 		break;
+	case AVRCP_EVENT_SETTINGS_CHANGED:
+		size = 2;
+		settings = data;
+		pdu->params[1] = g_list_length(settings);
+		for (; settings; settings = settings->next) {
+			uint8_t attr = GPOINTER_TO_UINT(settings->data);
+			int val;
+
+			val = player_get_attribute(player, attr);
+			if (val < 0)
+				continue;
+
+			pdu->params[++size] = attr;
+			pdu->params[++size] = val;
+		}
+		break;
 	default:
 		error("Unknown event %u", id);
 		return;
@@ -641,11 +674,12 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 
 		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
-		pdu->params[1] = 4;
+		pdu->params[1] = 5;
 		pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
 		pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
 		pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
 		pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
+		pdu->params[6] = AVRCP_EVENT_SETTINGS_CHANGED;
 
 		pdu->params_len = htons(2 + pdu->params[1]);
 		return AVC_CTYPE_STABLE;
@@ -1011,6 +1045,14 @@ static uint64_t player_get_uid(struct avrcp_player *player)
 	return player->cb->get_uid(player->user_data);
 }
 
+static GList *player_list_settings(struct avrcp_player *player)
+{
+	if (player == NULL)
+		return NULL;
+
+	return player->cb->list_settings(player->user_data);
+}
+
 static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -1018,6 +1060,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	struct avrcp_player *player = session->player;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
+	GList *settings;
 
 	/*
 	 * 1 byte for EventID, 4 bytes for Playback interval but the latest
@@ -1043,6 +1086,23 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	case AVRCP_EVENT_TRACK_REACHED_START:
 		len = 1;
 		break;
+	case AVRCP_EVENT_SETTINGS_CHANGED:
+		settings = player_list_settings(player);
+
+		pdu->params[++len] = g_list_length(settings);
+		for (; settings; settings = settings->next) {
+			uint8_t attr = GPOINTER_TO_UINT(settings->data);
+			int val;
+
+			val = player_get_attribute(player, attr);
+			if (val < 0)
+				continue;
+
+			pdu->params[++len] = attr;
+			pdu->params[++len] = val;
+		}
+
+		break;
 	default:
 		/* All other events are not supported yet */
 		goto err;
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 31fdf8d..7f54adb 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -73,10 +73,12 @@
 #define AVRCP_EVENT_TRACK_CHANGED	0x02
 #define AVRCP_EVENT_TRACK_REACHED_END	0x03
 #define AVRCP_EVENT_TRACK_REACHED_START	0x04
+#define AVRCP_EVENT_SETTINGS_CHANGED	0x08
 #define AVRCP_EVENT_VOLUME_CHANGED	0x0d
 #define AVRCP_EVENT_LAST		AVRCP_EVENT_VOLUME_CHANGED
 
 struct avrcp_player_cb {
+	GList *(*list_settings) (void *user_data);
 	int (*get_setting) (uint8_t attr, void *user_data);
 	int (*set_setting) (uint8_t attr, uint8_t value, void *user_data);
 	uint64_t (*get_uid) (void *user_data);
diff --git a/audio/media.c b/audio/media.c
index 28ed942..7abf077 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1194,6 +1194,18 @@ static const char *metadata_to_str(uint32_t id)
 	return NULL;
 }
 
+static GList *list_settings(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	DBG("");
+
+	if (mp->settings == NULL)
+		return NULL;
+
+	return g_hash_table_get_keys(mp->settings);
+}
+
 static int get_setting(uint8_t attr, void *user_data)
 {
 	struct media_player *mp = user_data;
@@ -1344,6 +1356,7 @@ static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data
 }
 
 static struct avrcp_player_cb player_cb = {
+	.list_settings = list_settings,
 	.get_setting = get_setting,
 	.set_setting = set_setting,
 	.list_metadata = list_metadata,
@@ -1427,8 +1440,9 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
 							DBusMessageIter *entry)
 {
 	DBusMessageIter var;
-	const char *value;
+	const char *value, *curval;
 	int attr, val;
+	GList *settings;
 
 	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
 		return FALSE;
@@ -1454,11 +1468,21 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
 	if (val < 0)
 		return FALSE;
 
+	curval = g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr));
+	if (g_strcmp0(curval, value) == 0)
+		return TRUE;
+
 	DBG("%s=%s", key, value);
 
 	g_hash_table_replace(mp->settings, GUINT_TO_POINTER(attr),
 						GUINT_TO_POINTER(val));
 
+	settings = list_settings(mp);
+
+	avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED, settings);
+
+	g_list_free(settings);
+
 	return TRUE;
 }
 
-- 
1.7.11.7

