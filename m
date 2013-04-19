Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] media: Implement new callbacks for pass-through operations
Date: Fri, 19 Apr 2013 15:31:10 +0300
Message-Id: <1366374673-24937-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1366374673-24937-1-git-send-email-luiz.dentz@gmail.com>
References: <1366374673-24937-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements newly introduced callbacks for pass-through operation so
they are directly sent to the active player.
---
 profiles/audio/media.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 59fc840..972af50 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1126,6 +1126,67 @@ static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data
 	}
 }
 
+static bool media_player_send(struct media_player *mp, const char *name)
+{
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(mp->sender, mp->path,
+					MEDIA_PLAYER_INTERFACE, name);
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return false;
+	}
+
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
+
+	return true;
+}
+
+static bool play(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	DBG("");
+
+	return media_player_send(mp, "Play");
+}
+
+static bool stop(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	DBG("");
+
+	return media_player_send(mp, "Stop");
+}
+
+static bool pause(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	DBG("");
+
+	return media_player_send(mp, "Pause");
+}
+
+static bool next(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	DBG("");
+
+	return media_player_send(mp, "Next");
+}
+
+static bool previous(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	DBG("");
+
+	return media_player_send(mp, "Previous");
+}
+
 static struct avrcp_player_cb player_cb = {
 	.list_settings = list_settings,
 	.get_setting = get_setting,
@@ -1136,7 +1197,12 @@ static struct avrcp_player_cb player_cb = {
 	.get_position = get_position,
 	.get_duration = get_duration,
 	.get_status = get_status,
-	.set_volume = set_volume
+	.set_volume = set_volume,
+	.play = play,
+	.stop = stop,
+	.pause = pause,
+	.next = next,
+	.previous = previous,
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
-- 
1.8.1.4

