Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] attrib: Fix D-Bus service disconnect watch removal
Date: Tue,  3 Apr 2012 12:15:00 -0400
Message-Id: <1333469700-29879-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1333469700-29879-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1333469700-29879-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

watcher_free() will be automatically called when removing the D-Bus
watch (it was set as the destroy callback when adding the watch),
therefore it is only necessary to remove the watch.
---
 attrib/client.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index f1c26c4..b5282c2 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -227,6 +227,7 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 	DBG("%s watcher %s exited", gatt->path, watcher->name);
 
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
+	g_dbus_remove_watch(gatt->conn, watcher->id);
 	remove_attio(gatt);
 }
 
@@ -429,10 +430,8 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 		return btd_error_not_authorized(msg);
 
 	watcher = l->data;
-	g_dbus_remove_watch(conn, watcher->id);
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
-	watcher_free(watcher);
-
+	g_dbus_remove_watch(conn, watcher->id);
 	remove_attio(gatt);
 
 	return dbus_message_new_method_return(msg);
-- 
1.7.5.4

