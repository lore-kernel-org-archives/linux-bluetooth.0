Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 12/25] alert: Automatically unregister alert when agent leaves D-Bus
Date: Mon, 24 Sep 2012 14:00:48 -0400
Message-Id: <1348509661-15967-13-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 profiles/alert/server.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 8630931..e6402b7 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -84,6 +84,7 @@ struct alert_data {
 	const char *category;
 	char *srv;
 	char *path;
+	guint watcher;
 };
 
 static GSList *registered_alerts = NULL;
@@ -113,6 +114,9 @@ static void alert_data_destroy(gpointer user_data)
 {
 	struct alert_data *alert = user_data;
 
+	if (alert->watcher)
+		g_dbus_remove_watch(btd_get_dbus_connection(), alert->watcher);
+
 	g_free(alert->srv);
 	g_free(alert->path);
 	g_free(alert);
@@ -210,6 +214,16 @@ static gboolean valid_count(const char *category, uint16_t count)
 	return FALSE;
 }
 
+static void watcher_disconnect(DBusConnection *conn, void *user_data)
+{
+	struct alert_data *alert = user_data;
+
+	DBG("Category %s was disconnected", alert->category);
+
+	registered_alerts = g_slist_remove(registered_alerts, alert);
+	alert_data_destroy(alert);
+}
+
 static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -238,6 +252,15 @@ static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 	alert->srv = g_strdup(sender);
 	alert->path = g_strdup(path);
 	alert->category = category;
+	alert->watcher = g_dbus_add_disconnect_watch(conn, alert->srv,
+					watcher_disconnect, alert, NULL);
+
+	if (alert->watcher == 0) {
+		alert_data_destroy(alert);
+		DBG("Could not register disconnect watcher");
+		return btd_error_failed(msg,
+				"Could not register disconnect watcher");
+	}
 
 	registered_alerts = g_slist_append(registered_alerts, alert);
 
-- 
1.7.9.5

