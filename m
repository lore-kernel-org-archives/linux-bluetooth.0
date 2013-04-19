Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] media: Check MPRIS Can* properties before calling the respective method
Date: Fri, 19 Apr 2013 15:31:13 +0300
Message-Id: <1366374673-24937-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1366374673-24937-1-git-send-email-luiz.dentz@gmail.com>
References: <1366374673-24937-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With MPRIS the player can disable support for certain control using
properties such as CanPlay, CanPause..., in this case these methods
should not be called and the code should fallback to uinput method.
---
 profiles/audio/media.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 48c7a52..4db76d8 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -102,6 +102,11 @@ struct media_player {
 	uint32_t		duration;
 	uint8_t			volume;
 	GTimer			*timer;
+	bool			play;
+	bool			pause;
+	bool			next;
+	bool			previous;
+	bool			control;
 };
 
 static GSList *adapters = NULL;
@@ -1148,6 +1153,9 @@ static bool play(void *user_data)
 
 	DBG("");
 
+	if (!mp->play || !mp->control)
+		return false;
+
 	return media_player_send(mp, "Play");
 }
 
@@ -1157,6 +1165,9 @@ static bool stop(void *user_data)
 
 	DBG("");
 
+	if (!mp->control)
+		return false;
+
 	return media_player_send(mp, "Stop");
 }
 
@@ -1166,6 +1177,9 @@ static bool pause(void *user_data)
 
 	DBG("");
 
+	if (!mp->pause || !mp->control)
+		return false;
+
 	return media_player_send(mp, "Pause");
 }
 
@@ -1175,6 +1189,9 @@ static bool next(void *user_data)
 
 	DBG("");
 
+	if (!mp->next || !mp->control)
+		return false;
+
 	return media_player_send(mp, "Next");
 }
 
@@ -1184,6 +1201,9 @@ static bool previous(void *user_data)
 
 	DBG("");
 
+	if (!mp->previous || !mp->control)
+		return false;
+
 	return media_player_send(mp, "Previous");
 }
 
@@ -1505,6 +1525,21 @@ static gboolean set_repeat(struct media_player *mp, DBusMessageIter *iter)
 	return set_property(mp, "Repeat", value);
 }
 
+static gboolean set_flag(struct media_player *mp, DBusMessageIter *iter,
+								bool *var)
+{
+	dbus_bool_t value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	*var = value;
+
+	return TRUE;
+}
+
 static gboolean set_player_property(struct media_player *mp, const char *key,
 							DBusMessageIter *entry)
 {
@@ -1530,6 +1565,21 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
 	if (strcasecmp(key, "LoopStatus") == 0)
 		return set_repeat(mp, &var);
 
+	if (strcasecmp(key, "CanPlay") == 0)
+		return set_flag(mp, &var, &mp->play);
+
+	if (strcasecmp(key, "CanPause") == 0)
+		return set_flag(mp, &var, &mp->pause);
+
+	if (strcasecmp(key, "CanGoNext") == 0)
+		return set_flag(mp, &var, &mp->next);
+
+	if (strcasecmp(key, "CanGoPrevious") == 0)
+		return set_flag(mp, &var, &mp->previous);
+
+	if (strcasecmp(key, "CanControl") == 0)
+		return set_flag(mp, &var, &mp->control);
+
 	DBG("%s not supported, ignoring", key);
 
 	return TRUE;
-- 
1.8.1.4

