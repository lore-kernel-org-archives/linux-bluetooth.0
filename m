Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] thermometer: Fix D-Bus service disconnect watch removal
Date: Tue,  3 Apr 2012 12:14:59 -0400
Message-Id: <1333469700-29879-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1333469700-29879-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1333469700-29879-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

destroy_watcher() will be automatically called when removing the D-Bus
watch (it was set as the destroy callback when adding the watch),
therefore it is only necessary to remove the watch.
---
 thermometer/thermometer.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index a64ed54..9d23275 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -136,14 +136,18 @@ static void destroy_watcher(gpointer user_data)
 {
 	struct watcher *watcher = user_data;
 
-	if (watcher->id > 0)
-		g_dbus_remove_watch(watcher->t->conn, watcher->id);
-
 	g_free(watcher->path);
 	g_free(watcher->srv);
 	g_free(watcher);
 }
 
+static void remove_watcher(gpointer user_data)
+{
+	struct watcher *watcher = user_data;
+
+	g_dbus_remove_watch(watcher->t->conn, watcher->id);
+}
+
 static void destroy_char(gpointer user_data)
 {
 	struct characteristic *c = user_data;
@@ -172,7 +176,7 @@ static void destroy_thermometer(gpointer user_data)
 		g_slist_free_full(t->chars, destroy_char);
 
 	if (t->fwatchers != NULL)
-		g_slist_free_full(t->fwatchers, destroy_watcher);
+		g_slist_free_full(t->fwatchers, remove_watcher);
 
 	dbus_connection_unref(t->conn);
 	btd_device_unref(t->dev);
@@ -814,7 +818,7 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 	remove_int_watcher(t, watcher);
 
 	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
-	watcher->id = 0;
+	g_dbus_remove_watch(watcher->t->conn, watcher->id);
 
 	if (g_slist_length(t->fwatchers) == 0)
 		disable_final_measurement(t);
@@ -893,7 +897,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	remove_int_watcher(t, watcher);
 
 	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
-	destroy_watcher(watcher);
+	g_dbus_remove_watch(watcher->t->conn, watcher->id);
 
 	if (g_slist_length(t->fwatchers) == 0)
 		disable_final_measurement(t);
-- 
1.7.5.4

