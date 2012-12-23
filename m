Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] media: Enable RegisterPlayer and UnregisterPlayer methods as experimental
Date: Sun, 23 Dec 2012 17:24:54 +0200
Message-Id: <1356276298-13795-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
References: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/media.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index f728460..e4206e3 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -868,7 +868,6 @@ static DBusMessage *unregister_endpoint(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-#if 0
 static struct media_player *media_adapter_find_player(
 						struct media_adapter *adapter,
 						const char *sender,
@@ -1533,7 +1532,6 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
-#endif
 
 static const GDBusMethodTable media_methods[] = {
 	{ GDBUS_METHOD("RegisterEndpoint",
@@ -1541,14 +1539,12 @@ static const GDBusMethodTable media_methods[] = {
 		NULL, register_endpoint) },
 	{ GDBUS_METHOD("UnregisterEndpoint",
 		GDBUS_ARGS({ "endpoint", "o" }), NULL, unregister_endpoint) },
-#if 0
-	{ GDBUS_METHOD("RegisterPlayer",
+	{ GDBUS_EXPERIMENTAL_METHOD("RegisterPlayer",
 		GDBUS_ARGS({ "player", "o" }, { "properties", "a{sv}" },
 						{ "metadata", "a{sv}" }),
 		NULL, register_player) },
-	{ GDBUS_METHOD("UnregisterPlayer",
+	{ GDBUS_EXPERIMENTAL_METHOD("UnregisterPlayer",
 		GDBUS_ARGS({ "player", "o" }), NULL, unregister_player) },
-#endif
 	{ },
 };
 
@@ -1559,10 +1555,8 @@ static void path_free(void *data)
 	while (adapter->endpoints)
 		release_endpoint(adapter->endpoints->data);
 
-#if 0
 	while (adapter->players)
 		media_player_destroy(adapter->players->data);
-#endif
 
 	adapters = g_slist_remove(adapters, adapter);
 
-- 
1.7.11.7

