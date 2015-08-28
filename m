Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH v1 1/2] audio/avrcp: Set player properties
Date: Fri, 28 Aug 2015 20:02:31 +0530
Message-id: <1440772352-7564-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Populates player properties like player name, type, subtype
and feature bit mask in player registration.
---
 profiles/audio/media.c | 24 ++++++++++++++++++++++++
 test/simple-player     |  1 +
 2 files changed, 25 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index ed441d0..106b18a 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -112,6 +112,7 @@ struct media_player {
 	bool			next;
 	bool			previous;
 	bool			control;
+	char			*name;
 };
 
 static GSList *adapters = NULL;
@@ -1607,6 +1608,26 @@ static gboolean set_flag(struct media_player *mp, DBusMessageIter *iter,
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
+	if (mp->name)
+		g_free(mp->name);
+
+	mp->name = g_strdup(value);
+
+	return TRUE;
+}
+
 static gboolean set_player_property(struct media_player *mp, const char *key,
 							DBusMessageIter *entry)
 {
@@ -1647,6 +1668,9 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
 	if (strcasecmp(key, "CanControl") == 0)
 		return set_flag(mp, &var, &mp->control);
 
+	if (strcasecmp(key, "Identity") == 0)
+		return set_name(mp, &var);
+
 	DBG("%s not supported, ignoring", key);
 
 	return TRUE;
diff --git a/test/simple-player b/test/simple-player
index a8ae0b1..02754c2 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -43,6 +43,7 @@ class Player(dbus.service.Object):
 
 			self.properties = dbus.Dictionary({
 					"PlaybackStatus" : "playing",
+					"Identity" : "SimplePlayer",
 					"LoopStatus" : "None",
 					"Rate" : dbus.Double(1.0),
 					"Shuffle" : dbus.Boolean(False),
-- 
1.9.1

