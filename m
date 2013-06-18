Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio/media: Fix setting player settings
Date: Tue, 18 Jun 2013 11:09:54 +0300
Message-Id: <1371542994-24510-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1371542994-24510-1-git-send-email-luiz.dentz@gmail.com>
References: <1371542994-24510-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The value has to be converted to MPRIS setting otherwise the player won't
recognize it and will probably discard the change.
---
 profiles/audio/avrcp.c |  4 ++--
 profiles/audio/media.c | 54 +++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index f028da9..ffc6415 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -661,8 +661,8 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		if (val < 0)
 			return;
 
-		pdu->params[++size] = attr;
-		pdu->params[++size] = val;
+		pdu->params[size++] = attr;
+		pdu->params[size++] = val;
 		break;
 	default:
 		error("Unknown event %u", id);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 45dfe53..d4d82cf 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1007,12 +1007,54 @@ static const char *get_setting(const char *key, void *user_data)
 	return g_hash_table_lookup(mp->settings, key);
 }
 
+static void set_shuffle_setting(DBusMessageIter *iter, const char *value)
+{
+	const char *key = "Shuffle";
+	dbus_bool_t val;
+	DBusMessageIter var;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						DBUS_TYPE_BOOLEAN_AS_STRING,
+						&var);
+	val = strcasecmp(value, "off") != 0;
+	dbus_message_iter_append_basic(&var, DBUS_TYPE_BOOLEAN, &val);
+	dbus_message_iter_close_container(iter, &var);
+}
+
+static const char *repeat_to_loop_status(const char *value)
+{
+	if (strcasecmp(value, "off") == 0)
+		return "None";
+	else if (strcasecmp(value, "singletrack") == 0)
+		return "Track";
+	else if (strcasecmp(value, "alltracks") == 0)
+		return "Playlist";
+
+	return NULL;
+}
+
+static void set_repeat_setting(DBusMessageIter *iter, const char *value)
+{
+	const char *key = "LoopStatus";
+	const char *val;
+	DBusMessageIter var;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						DBUS_TYPE_STRING_AS_STRING,
+						&var);
+	val = repeat_to_loop_status(value);
+	dbus_message_iter_append_basic(&var, DBUS_TYPE_STRING, &val);
+	dbus_message_iter_close_container(iter, &var);
+}
+
 static int set_setting(const char *key, const char *value, void *user_data)
 {
 	struct media_player *mp = user_data;
 	const char *iface = MEDIA_PLAYER_INTERFACE;
 	DBusMessage *msg;
-	DBusMessageIter iter, var;
+	DBusMessageIter iter;
 
 	DBG("%s = %s", key, value);
 
@@ -1028,13 +1070,11 @@ static int set_setting(const char *key, const char *value, void *user_data)
 
 	dbus_message_iter_init_append(msg, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &iface);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &key);
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
-						DBUS_TYPE_STRING_AS_STRING,
-						&var);
-	dbus_message_iter_append_basic(&var, DBUS_TYPE_STRING, &value);
-	dbus_message_iter_close_container(&iter, &var);
+	if (strcasecmp(key, "Shuffle") == 0)
+		set_shuffle_setting(&iter, value);
+	else if (strcasecmp(key, "Repeat") == 0)
+		set_repeat_setting(&iter, value);
 
 	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
-- 
1.8.1.4

