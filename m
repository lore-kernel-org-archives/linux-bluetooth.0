Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 13/22] alert: Add support for automatic unregister when agent leave D-Bus
Date: Mon, 27 Aug 2012 13:11:57 -0400
Message-Id: <1346087526-15107-14-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 profiles/alert/server.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 8bc90f6..c77e1f1 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -81,6 +81,7 @@ struct alert_data {
 	const char *category;
 	char *srv;
 	char *path;
+	guint watcher;
 };
 
 static DBusConnection *connection = NULL;
@@ -111,6 +112,9 @@ static void alert_data_destroy(gpointer user_data)
 {
 	struct alert_data *alert = user_data;
 
+	if (alert->watcher)
+		g_dbus_remove_watch(connection, alert->watcher);
+
 	g_free(alert->srv);
 	g_free(alert->path);
 	g_free(alert);
@@ -208,6 +212,17 @@ static gboolean valid_count(const char *category, uint16_t count)
 	return FALSE;
 }
 
+static void watcher_disconnect(DBusConnection *conn, void *user_data)
+{
+	struct alert_data *alert = user_data;
+
+	DBG("Category %s was disconnected", alert->category);
+
+	registered_alerts = g_slist_remove(registered_alerts, alert);
+	g_dbus_remove_watch(connection, alert->watcher);
+	alert_data_destroy(alert);
+}
+
 static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -236,6 +251,15 @@ static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 	alert->srv = g_strdup(sender);
 	alert->path = g_strdup(path);
 	alert->category = category;
+	alert->watcher = g_dbus_add_disconnect_watch(connection, alert->srv,
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

