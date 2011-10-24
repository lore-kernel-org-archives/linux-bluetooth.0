Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/8] Implement D-Bus unregister watcher function
Date: Mon, 24 Oct 2011 19:04:04 +0200
Message-Id: <1319475848-4171-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1319475848-4171-4-git-send-email-sancane@gmail.com>
References: <1319475848-4171-1-git-send-email-sancane@gmail.com>
 <1319475848-4171-2-git-send-email-sancane@gmail.com>
 <1319475848-4171-3-git-send-email-sancane@gmail.com>
 <1319475848-4171-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 155b84a..6ff5da3 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -451,6 +451,11 @@ static void enable_final_measurement(struct thermometer *t)
 	/* TODO: enable final measurements */
 }
 
+static void disable_final_measurement(struct thermometer *t)
+{
+	/* TODO: disable final measurements */
+}
+
 static void watcher_exit(DBusConnection *conn, void *user_data)
 {
 	/* TODO: Watcher disconnected */
@@ -511,9 +516,28 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	/* TODO: */
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
-						"Function not implemented.");
+	const gchar *sender = dbus_message_get_sender(msg);
+	struct thermometer *t = data;
+	struct watcher *watcher;
+	gchar *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(t, sender, path);
+	if (watcher == NULL)
+		return btd_error_does_not_exist(msg);
+
+	DBG("Thermometer watcher %s unregistered", path);
+
+	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
+	destroy_watcher(watcher);
+
+	if (g_slist_length(t->fwatchers) == 0)
+		disable_final_measurement(t);
+
+	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *enable_intermediate(DBusConnection *conn, DBusMessage *msg,
-- 
1.7.6.1

