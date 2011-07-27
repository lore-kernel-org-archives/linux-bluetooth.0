Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 4/6] Match probed UUIDs and enabled services
Date: Wed, 27 Jul 2011 18:53:04 -0300
Message-Id: <1311803586-5405-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify if the service is enabled in the proximity configuration file
before to register the Proximity Monitor.
---
 proximity/manager.c |   22 ++++++++++++++++------
 proximity/monitor.c |    7 ++++++-
 proximity/monitor.h |    9 ++++++++-
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/proximity/manager.c b/proximity/manager.c
index e3e049d..a9526a1 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -41,11 +41,7 @@
 
 static DBusConnection *connection = NULL;
 
-static struct {
-	gboolean linkloss;
-	gboolean pathloss;
-	gboolean findme;
-} enabled  = {
+static struct enabled enabled  = {
 	.linkloss = TRUE,
 	.pathloss = TRUE,
 	.findme = TRUE,
@@ -53,7 +49,21 @@ static struct {
 
 static int attio_device_probe(struct btd_device *device, GSList *uuids)
 {
-	return monitor_register(connection, device);
+	gboolean linkloss = FALSE, pathloss = FALSE, findme = FALSE;
+
+	if (g_slist_find_custom(uuids, IMMEDIATE_ALERT_UUID,
+					(GCompareFunc) strcasecmp)) {
+		findme = enabled.findme;
+		if (g_slist_find_custom(uuids, TX_POWER_UUID,
+					(GCompareFunc) strcasecmp))
+			pathloss = enabled.pathloss;
+	}
+
+	if (g_slist_find_custom(uuids, LINK_LOSS_UUID,
+				(GCompareFunc) strcasecmp))
+		linkloss = enabled.linkloss;
+
+	return monitor_register(connection, device, linkloss, pathloss, findme);
 }
 
 static void attio_device_remove(struct btd_device *device)
diff --git a/proximity/monitor.c b/proximity/monitor.c
index f7995aa..6cea5df 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -57,6 +57,7 @@
 struct monitor {
 	struct btd_device *device;
 	GAttrib *attrib;
+	struct enabled enabled;
 	char *linklosslevel;		/* Link Loss Alert Level */
 };
 
@@ -290,7 +291,8 @@ static void monitor_destroy(gpointer user_data)
 	g_free(monitor);
 }
 
-int monitor_register(DBusConnection *conn, struct btd_device *device)
+int monitor_register(DBusConnection *conn, struct btd_device *device,
+			gboolean linkloss, gboolean pathloss, gboolean findme)
 {
 	const char *path = device_get_path(device);
 	struct monitor *monitor;
@@ -305,6 +307,9 @@ int monitor_register(DBusConnection *conn, struct btd_device *device)
 	monitor = g_new0(struct monitor, 1);
 	monitor->device = btd_device_ref(device);
 	monitor->linklosslevel = (level ? : g_strdup("none"));
+	monitor->enabled.linkloss = linkloss;
+	monitor->enabled.pathloss = pathloss;
+	monitor->enabled.findme = findme;
 
 	if (g_dbus_register_interface(conn, path,
 				PROXIMITY_INTERFACE,
diff --git a/proximity/monitor.h b/proximity/monitor.h
index 5c6ebf6..ef47ee1 100644
--- a/proximity/monitor.h
+++ b/proximity/monitor.h
@@ -22,5 +22,12 @@
  *
  */
 
-int monitor_register(DBusConnection *conn, struct btd_device *device);
+struct enabled {
+	gboolean linkloss;
+	gboolean pathloss;
+	gboolean findme;
+};
+
+int monitor_register(DBusConnection *conn, struct btd_device *device,
+			gboolean linkloss, gboolean pathloss, gboolean findme);
 void monitor_unregister(DBusConnection *conn, struct btd_device *device);
-- 
1.7.6

