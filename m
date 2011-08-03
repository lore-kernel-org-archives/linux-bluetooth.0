Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/7] Parse handles when probing on Proximity
Date: Wed,  3 Aug 2011 15:41:41 -0300
Message-Id: <1312396907-14524-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Primary services start and end handles can now be obtained during
probing. This approach avoids primary service parsing on each
connection in the Proximity Monitor.
---
 proximity/manager.c |   36 ++++++++++++++++--------
 proximity/monitor.c |   74 +++++++++++++++++++++++++++++----------------------
 proximity/monitor.h |    3 +-
 3 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/proximity/manager.c b/proximity/manager.c
index 30384d1..a767554 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -28,9 +28,11 @@
 
 #include <glib.h>
 #include <gdbus.h>
+#include <bluetooth/uuid.h>
 
 #include "adapter.h"
 #include "device.h"
+#include "att.h"
 #include "monitor.h"
 #include "reporter.h"
 #include "manager.h"
@@ -47,23 +49,33 @@ static struct enabled enabled  = {
 	.findme = TRUE,
 };
 
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct att_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
 static int attio_device_probe(struct btd_device *device, GSList *uuids)
 {
-	gboolean linkloss = FALSE, pathloss = FALSE, findme = FALSE;
-
-	if (g_slist_find_custom(uuids, IMMEDIATE_ALERT_UUID,
-					(GCompareFunc) strcasecmp)) {
-		findme = enabled.findme;
-		if (g_slist_find_custom(uuids, TX_POWER_UUID,
-					(GCompareFunc) strcasecmp))
-			pathloss = enabled.pathloss;
-	}
+	struct att_primary *linkloss, *txpower, *immediate;
+	GSList *l, *primaries;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, IMMEDIATE_ALERT_UUID,
+			primary_uuid_cmp);
+	immediate = (l ? l->data : NULL);
+
+	l = g_slist_find_custom(primaries, TX_POWER_UUID, primary_uuid_cmp);
+	txpower = (l ? l->data : NULL);
 
-	if (g_slist_find_custom(uuids, LINK_LOSS_UUID,
-				(GCompareFunc) strcasecmp))
-		linkloss = enabled.linkloss;
+	l = g_slist_find_custom(primaries, LINK_LOSS_UUID, primary_uuid_cmp);
+	linkloss = (l ? l->data : NULL);
 
-	return monitor_register(connection, device, linkloss, pathloss, findme);
+	return monitor_register(connection, device, linkloss, txpower,
+							immediate, &enabled);
 }
 
 static void attio_device_remove(struct btd_device *device)
diff --git a/proximity/monitor.c b/proximity/monitor.c
index f4ea0df..3e4f353 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -51,12 +51,14 @@
 
 #define PROXIMITY_INTERFACE "org.bluez.Proximity"
 
-#define LINK_LOSS_UUID "00001803-0000-1000-8000-00805f9b34fb"
 #define ALERT_LEVEL_CHR_UUID 0x2A06
 
 struct monitor {
 	struct btd_device *device;
 	GAttrib *attrib;
+	struct att_range *linkloss;
+	struct att_range *txpower;
+	struct att_range *immediate;
 	struct enabled enabled;
 	char *linklosslevel;		/* Link Loss Alert Level */
 	char *immediatelevel;		/* Immediate Alert Level */
@@ -139,38 +141,14 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 static int write_alert_level(struct monitor *monitor)
 {
-	GSList *l, *primaries;
-	uint16_t start = 0, end = 0;
+	struct att_range *linkloss = monitor->linkloss;
 	bt_uuid_t uuid;
 
-	primaries = btd_device_get_primaries(monitor->device);
-	if (primaries == NULL) {
-		DBG("No primary services found");
-		return -1;
-	}
-
-	for (l = primaries; l; l = l->next) {
-		struct att_primary *primary = l->data;
-
-		if (strcmp(primary->uuid, LINK_LOSS_UUID) == 0) {
-			start = primary->start;
-			end = primary->end;
-			break;
-		}
-	}
-
-	if (!start) {
-		DBG("Link Loss service not found");
-		return -1;
-	}
-
-	DBG("Link Loss service found at range 0x%04x-0x%04x", start, end);
-
 	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
 
 	/* FIXME: use cache (requires service changed support) ? */
-	gatt_discover_char(monitor->attrib, start, end, &uuid, char_discovered_cb,
-								monitor);
+	gatt_discover_char(monitor->attrib, linkloss->start, linkloss->end,
+			&uuid, char_discovered_cb, monitor);
 
 	return 0;
 }
@@ -341,6 +319,9 @@ static void monitor_destroy(gpointer user_data)
 	struct monitor *monitor = user_data;
 
 	btd_device_unref(monitor->device);
+	g_free(monitor->linkloss);
+	g_free(monitor->immediate);
+	g_free(monitor->txpower);
 	g_free(monitor->linklosslevel);
 	g_free(monitor->immediatelevel);
 	g_free(monitor->signallevel);
@@ -348,7 +329,8 @@ static void monitor_destroy(gpointer user_data)
 }
 
 int monitor_register(DBusConnection *conn, struct btd_device *device,
-			gboolean linkloss, gboolean pathloss, gboolean findme)
+		struct att_primary *linkloss, struct att_primary *txpower,
+		struct att_primary *immediate, struct enabled *enabled)
 {
 	const char *path = device_get_path(device);
 	struct monitor *monitor;
@@ -364,9 +346,6 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 	monitor->device = btd_device_ref(device);
 	monitor->linklosslevel = (level ? : g_strdup("none"));
 	monitor->signallevel = g_strdup("unknown");
-	monitor->enabled.linkloss = linkloss;
-	monitor->enabled.pathloss = pathloss;
-	monitor->enabled.findme = findme;
 
 	if (g_dbus_register_interface(conn, path,
 				PROXIMITY_INTERFACE,
@@ -380,6 +359,37 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 
 	DBG("Registered interface %s on path %s", PROXIMITY_INTERFACE, path);
 
+	if (linkloss && enabled->linkloss) {
+		monitor->linkloss = g_new0(struct att_range, 1);
+		monitor->linkloss->start = linkloss->start;
+		monitor->linkloss->end = linkloss->end;
+
+		monitor->enabled.linkloss = TRUE;
+	}
+
+	if (immediate) {
+		if (txpower && enabled->pathloss) {
+			monitor->txpower = g_new0(struct att_range, 1);
+			monitor->txpower->start = txpower->start;
+			monitor->txpower->end = txpower->end;
+
+			monitor->enabled.pathloss = TRUE;
+		}
+
+		if (enabled->pathloss || enabled->findme) {
+			monitor->immediate = g_new0(struct att_range, 1);
+			monitor->immediate->start = immediate->start;
+			monitor->immediate->end = immediate->end;
+		}
+
+		monitor->enabled.findme = enabled->findme;
+	}
+
+	DBG("Link Loss: %s, Path Loss: %s, FindMe: %s",
+				monitor->enabled.linkloss ? "TRUE" : "FALSE",
+				monitor->enabled.pathloss ? "TRUE" : "FALSE",
+				monitor->enabled.findme ? "TRUE" : "FALSE");
+
 	btd_device_add_attio_callback(device, attio_connected_cb,
 					attio_disconnected_cb, monitor);
 
diff --git a/proximity/monitor.h b/proximity/monitor.h
index ef47ee1..fb79e26 100644
--- a/proximity/monitor.h
+++ b/proximity/monitor.h
@@ -29,5 +29,6 @@ struct enabled {
 };
 
 int monitor_register(DBusConnection *conn, struct btd_device *device,
-			gboolean linkloss, gboolean pathloss, gboolean findme);
+		struct att_primary *linkloss, struct att_primary *txpower,
+		struct att_primary *immediate, struct enabled *enabled);
 void monitor_unregister(DBusConnection *conn, struct btd_device *device);
-- 
1.7.6

