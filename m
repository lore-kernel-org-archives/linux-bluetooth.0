Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  2/2] audio/avrcp: Set Media Player Properties
Date: Thu, 20 Aug 2015 14:33:10 +0530
Message-id: <1440061390-32664-2-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1440061390-32664-1-git-send-email-bharat.panda@samsung.com>
References: <1440061390-32664-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add methods to set missing media player properties value, like
player name, type, sub-type and features.
---
 profiles/audio/media.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index ed441d0..f55ecc1 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -112,6 +112,10 @@ struct media_player {
 	bool			next;
 	bool			previous;
 	bool			control;
+	char			*name;
+	char			*type;
+	char			*subtype;
+	unsigned int		features[16];
 };
 
 static GSList *adapters = NULL;
@@ -1607,6 +1611,71 @@ static gboolean set_flag(struct media_player *mp, DBusMessageIter *iter,
 	return TRUE;
 }
 
+static gboolean set_name(struct media_player *mp, DBusMessageIter *iter)
+{
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	if (g_strcmp0(mp->name, value) == 0)
+		return TRUE;
+
+	mp->name = g_strdup(value);
+
+	return TRUE;
+}
+
+static gboolean set_type(struct media_player *mp, DBusMessageIter *iter)
+{
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	mp->type = g_strdup(value);
+
+	return TRUE;
+}
+
+static gboolean set_features(struct media_player *mp, DBusMessageIter *iter)
+{
+	const char *value;
+	uint8_t i = 0;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	memset(&mp->features, 0x00, 16);
+
+	while ((i < (strlen(value)/2))) {
+		sscanf(value+(2*i), "%02x", &mp->features[i]);
+		i++;
+	}
+
+	return TRUE;
+}
+
+static gboolean set_subtype(struct media_player *mp, DBusMessageIter *iter)
+{
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	mp->subtype = g_strdup(value);
+
+	return TRUE;
+}
+
 static gboolean set_player_property(struct media_player *mp, const char *key,
 							DBusMessageIter *entry)
 {
@@ -1647,6 +1716,18 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
 	if (strcasecmp(key, "CanControl") == 0)
 		return set_flag(mp, &var, &mp->control);
 
+	if (strcasecmp(key, "DisplayName") == 0)
+		return set_name(mp, &var);
+
+	if (strcasecmp(key, "Type") == 0)
+		return set_type(mp, &var);
+
+	if (strcasecmp(key, "SubType") == 0)
+		return set_subtype(mp, &var);
+
+	if (strcasecmp(key, "Features") == 0)
+		return set_features(mp, &var);
+
 	DBG("%s not supported, ignoring", key);
 
 	return TRUE;
-- 
1.9.1

