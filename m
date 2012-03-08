Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] attrib: Fix memory leak on watcher exit
Date: Thu,  8 Mar 2012 16:01:56 -0400
Message-Id: <1331236916-27596-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "destroy" callback of g_dbus_add_disconnect_watch() is actually
never called, therefore the watcher data should be freed on
watcher_exit().
---
 attrib/client.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 60cff01..e6cd3dc 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -212,6 +212,7 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 	DBG("%s watcher %s exited", gatt->path, watcher->name);
 
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
+	watcher_free(watcher);
 }
 
 static int characteristic_set_value(struct characteristic *chr,
@@ -355,7 +356,7 @@ static DBusMessage *register_watcher(DBusConnection *conn,
 	watcher->gatt = gatt;
 	watcher->path = g_strdup(path);
 	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
-							watcher, watcher_free);
+								watcher, NULL);
 
 	if (gatt->attioid == 0)
 		gatt->attioid = btd_device_add_attio_callback(gatt->dev,
-- 
1.7.5.4

