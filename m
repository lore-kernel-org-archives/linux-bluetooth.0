Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] Add MediaPlayer.Release method
Date: Fri, 28 Oct 2011 10:49:20 +0300
Message-Id: <1319788162-5606-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1319788162-5606-1-git-send-email-luiz.dentz@gmail.com>
References: <1319788162-5606-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is similar to MediaEndpoint.Release which is useful to notify the
player that it is no longer registered/active.
---
 audio/media.c     |   26 +++++++++++++++++++++++++-
 doc/media-api.txt |    8 ++++++++
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 5528ada..cf157d7 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -870,11 +870,33 @@ static struct media_player *media_adapter_find_player(
 	return NULL;
 }
 
+static void release_player(struct media_player *mp)
+{
+	DBusMessage *msg;
+
+	DBG("sender=%s path=%s", mp->sender, mp->path);
+
+	msg = dbus_message_new_method_call(mp->sender, mp->path,
+						MEDIA_PLAYER_INTERFACE,
+						"Release");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
+	g_dbus_send_message(mp->adapter->conn, msg);
+}
+
 static void media_player_free(gpointer data)
 {
 	struct media_player *mp = data;
 	struct media_adapter *adapter = mp->adapter;
 
+	if (mp->player) {
+		adapter->players = g_slist_remove(adapter->players, mp);
+		release_player(mp);
+	}
+
 	g_dbus_remove_watch(adapter->conn, mp->watch);
 	g_dbus_remove_watch(adapter->conn, mp->property_watch);
 	g_dbus_remove_watch(adapter->conn, mp->track_watch);
@@ -898,8 +920,10 @@ static void media_player_destroy(struct media_player *mp)
 	DBG("sender=%s path=%s", mp->sender, mp->path);
 
 	if (mp->player) {
+		struct avrcp_player *player = mp->player;
+		mp->player = NULL;
 		adapter->players = g_slist_remove(adapter->players, mp);
-		avrcp_unregister_player(mp->player);
+		avrcp_unregister_player(player);
 		return;
 	}
 
diff --git a/doc/media-api.txt b/doc/media-api.txt
index 5a3aa3e..f10afe1 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -137,6 +137,14 @@ Methods		void SetProperty(string property, variant value)
 
 			On success this will emit a PropertyChanged signal.
 
+		void Release()
+
+			This method gets called when the service daemon
+			unregisters the player which can then perform
+			cleanup tasks. There is no need to unregister the
+			player, because when this method gets called it has
+			already been unregistered.
+
 Signals		PropertyChanged(string setting, variant value)
 
 			This signal indicates a changed value of the given
-- 
1.7.6.4

