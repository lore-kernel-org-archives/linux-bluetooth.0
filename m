Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 3/7] proximity: Split internal monitor registration API
Date: Wed,  6 Feb 2013 10:16:23 +0100
Message-Id: <1360142187-15347-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Split the monitor registration API into three independent registrations
each of them taking one specific GATT primary.
---
 profiles/proximity/manager.c |  16 +++-
 profiles/proximity/monitor.c | 220 ++++++++++++++++++++++++++++++++++---------
 profiles/proximity/monitor.h |  17 +++-
 3 files changed, 204 insertions(+), 49 deletions(-)

diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index b405f15..1c07267 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -52,18 +52,30 @@ static int monitor_device_probe(struct btd_profile *p,
 				struct btd_device *device, GSList *uuids)
 {
 	struct gatt_primary *linkloss, *txpower, *immediate;
+	int err = 0;
 
 	immediate = btd_device_get_primary(device, IMMEDIATE_ALERT_UUID);
 	txpower = btd_device_get_primary(device, TX_POWER_UUID);
 	linkloss = btd_device_get_primary(device, LINK_LOSS_UUID);
 
-	return monitor_register(device, linkloss, txpower, immediate, &enabled);
+	if (linkloss)
+		err = monitor_register_linkloss(device, &enabled, linkloss);
+
+	if (err >= 0 && txpower)
+		err = monitor_register_txpower(device, &enabled, txpower);
+
+	if (err >= 0 && immediate)
+		err = monitor_register_immediate(device, &enabled, immediate);
+
+	return err;
 }
 
 static void monitor_device_remove(struct btd_profile *p,
 						struct btd_device *device)
 {
-	monitor_unregister(device);
+	monitor_unregister_immediate(device);
+	monitor_unregister_txpower(device);
+	monitor_unregister_linkloss(device);
 }
 
 static struct btd_profile pxp_monitor_profile = {
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 597f161..489ccdd 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -34,6 +34,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/stat.h>
+#include <glib.h>
 
 #include <bluetooth/bluetooth.h>
 
@@ -83,6 +84,22 @@ struct monitor {
 	guint attioid;
 };
 
+static GSList *monitors = NULL;
+
+static struct monitor *find_monitor(struct btd_device *device)
+{
+	GSList *l;
+
+	for (l = monitors; l; l = l->next) {
+		struct monitor *monitor = l->data;
+
+		if (monitor->device == device)
+			return monitor;
+	}
+
+	return NULL;
+}
+
 static void write_proximity_config(struct btd_device *device, const char *alert,
 					const char *level)
 {
@@ -580,33 +597,25 @@ static void monitor_destroy(gpointer user_data)
 {
 	struct monitor *monitor = user_data;
 
-	if (monitor->immediateto)
-		g_source_remove(monitor->immediateto);
-
-	if (monitor->attioid)
-		btd_device_remove_attio_callback(monitor->device,
-						monitor->attioid);
-	if (monitor->attrib)
-		g_attrib_unref(monitor->attrib);
-
 	btd_device_unref(monitor->device);
-	g_free(monitor->linkloss);
-	g_free(monitor->immediate);
-	g_free(monitor->txpower);
 	g_free(monitor->linklosslevel);
 	g_free(monitor->immediatelevel);
 	g_free(monitor->signallevel);
 	g_free(monitor);
+
+	monitors = g_slist_remove(monitors, monitor);
 }
 
-int monitor_register(struct btd_device *device,
-		struct gatt_primary *linkloss, struct gatt_primary *txpower,
-		struct gatt_primary *immediate, struct enabled *enabled)
+static struct monitor *register_monitor(struct btd_device *device)
 {
 	const char *path = device_get_path(device);
 	struct monitor *monitor;
 	char *level;
 
+	monitor = find_monitor(device);
+	if (monitor != NULL)
+		return monitor;
+
 	level = read_proximity_config(device, "LinkLossAlertLevel");
 
 	monitor = g_new0(struct monitor, 1);
@@ -615,6 +624,8 @@ int monitor_register(struct btd_device *device,
 	monitor->signallevel = g_strdup("unknown");
 	monitor->immediatelevel = g_strdup("none");
 
+	monitors = g_slist_append(monitors, monitor);
+
 	if (g_dbus_register_interface(btd_get_dbus_connection(), path,
 				PROXIMITY_INTERFACE,
 				NULL, NULL, monitor_device_properties,
@@ -622,55 +633,178 @@ int monitor_register(struct btd_device *device,
 		error("D-Bus failed to register %s interface",
 						PROXIMITY_INTERFACE);
 		monitor_destroy(monitor);
-		return -1;
+		return NULL;
 	}
 
 	DBG("Registered interface %s on path %s", PROXIMITY_INTERFACE, path);
 
-	if (linkloss && enabled->linkloss) {
-		monitor->linkloss = g_new0(struct att_range, 1);
-		monitor->linkloss->start = linkloss->range.start;
-		monitor->linkloss->end = linkloss->range.end;
-
-		monitor->enabled.linkloss = TRUE;
-	}
-
-	if (immediate) {
-		if (txpower && enabled->pathloss) {
-			monitor->txpower = g_new0(struct att_range, 1);
-			monitor->txpower->start = txpower->range.start;
-			monitor->txpower->end = txpower->range.end;
-
-			monitor->enabled.pathloss = TRUE;
-		}
-
-		if (enabled->pathloss || enabled->findme) {
-			monitor->immediate = g_new0(struct att_range, 1);
-			monitor->immediate->start = immediate->range.start;
-			monitor->immediate->end = immediate->range.end;
-		}
+	return monitor;
+}
 
-		monitor->enabled.findme = enabled->findme;
-	}
+static void update_monitor(struct monitor *monitor)
+{
+	if (monitor->txpower != NULL && monitor->immediate != NULL)
+		monitor->enabled.pathloss = TRUE;
+	else
+		monitor->enabled.pathloss = FALSE;
 
 	DBG("Link Loss: %s, Path Loss: %s, FindMe: %s",
 				monitor->enabled.linkloss ? "TRUE" : "FALSE",
 				monitor->enabled.pathloss ? "TRUE" : "FALSE",
 				monitor->enabled.findme ? "TRUE" : "FALSE");
 
-	if (monitor->enabled.linkloss || monitor->enabled.pathloss)
-		monitor->attioid = btd_device_add_attio_callback(device,
+	if (!monitor->enabled.linkloss && !monitor->enabled.pathloss)
+		return;
+
+	if (monitor->attioid != 0)
+		return;
+
+	monitor->attioid = btd_device_add_attio_callback(monitor->device,
 							attio_connected_cb,
 							attio_disconnected_cb,
 							monitor);
+}
+
+int monitor_register_linkloss(struct btd_device *device,
+						struct enabled *enabled,
+						struct gatt_primary *linkloss)
+{
+	struct monitor *monitor;
+
+	if (!enabled->linkloss)
+		return 0;
+
+	monitor = register_monitor(device);
+	if (monitor == NULL)
+		return -1;
+
+	monitor->linkloss = g_new0(struct att_range, 1);
+	monitor->linkloss->start = linkloss->range.start;
+	monitor->linkloss->end = linkloss->range.end;
+	monitor->enabled.linkloss = TRUE;
+
+	update_monitor(monitor);
 
 	return 0;
 }
 
-void monitor_unregister(struct btd_device *device)
+int monitor_register_txpower(struct btd_device *device,
+						struct enabled *enabled,
+						struct gatt_primary *txpower)
 {
+	struct monitor *monitor;
+
+	if (!enabled->pathloss)
+		return 0;
+
+	monitor = register_monitor(device);
+	if (monitor == NULL)
+		return -1;
+
+	monitor->txpower = g_new0(struct att_range, 1);
+	monitor->txpower->start = txpower->range.start;
+	monitor->txpower->end = txpower->range.end;
+
+	update_monitor(monitor);
+
+	return 0;
+}
+
+int monitor_register_immediate(struct btd_device *device,
+						struct enabled *enabled,
+						struct gatt_primary *immediate)
+{
+	struct monitor *monitor;
+
+	if (!enabled->pathloss && !enabled->findme)
+		return 0;
+
+	monitor = register_monitor(device);
+	if (monitor == NULL)
+		return -1;
+
+	monitor->immediate = g_new0(struct att_range, 1);
+	monitor->immediate->start = immediate->range.start;
+	monitor->immediate->end = immediate->range.end;
+	monitor->enabled.findme = enabled->findme;
+
+	update_monitor(monitor);
+
+	return 0;
+}
+
+static void cleanup_monitor(struct monitor *monitor)
+{
+	struct btd_device *device = monitor->device;
 	const char *path = device_get_path(device);
 
+	if (monitor->immediate != NULL || monitor->txpower != NULL)
+		return;
+
+	if (monitor->immediateto != 0) {
+		g_source_remove(monitor->immediateto);
+		monitor->immediateto = 0;
+	}
+
+	if (monitor->attioid != 0) {
+		btd_device_remove_attio_callback(device, monitor->attioid);
+		monitor->attioid = 0;
+	}
+
+	if (monitor->attrib != NULL) {
+		g_attrib_unref(monitor->attrib);
+		monitor->attrib = NULL;
+	}
+
+	if (monitor->linkloss != NULL)
+		return;
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 							PROXIMITY_INTERFACE);
 }
+
+void monitor_unregister_linkloss(struct btd_device *device)
+{
+	struct monitor *monitor;
+
+	monitor = find_monitor(device);
+	if (monitor == NULL)
+		return;
+
+	g_free(monitor->linkloss);
+	monitor->linkloss = NULL;
+	monitor->enabled.linkloss = TRUE;
+
+	cleanup_monitor(monitor);
+}
+
+void monitor_unregister_txpower(struct btd_device *device)
+{
+	struct monitor *monitor;
+
+	monitor = find_monitor(device);
+	if (monitor == NULL)
+		return;
+
+	g_free(monitor->txpower);
+	monitor->txpower = NULL;
+	monitor->enabled.pathloss = FALSE;
+
+	cleanup_monitor(monitor);
+}
+
+void monitor_unregister_immediate(struct btd_device *device)
+{
+	struct monitor *monitor;
+
+	monitor = find_monitor(device);
+	if (monitor == NULL)
+		return;
+
+	g_free(monitor->immediate);
+	monitor->immediate = NULL;
+	monitor->enabled.findme = FALSE;
+	monitor->enabled.pathloss = FALSE;
+
+	cleanup_monitor(monitor);
+}
diff --git a/profiles/proximity/monitor.h b/profiles/proximity/monitor.h
index 191b562..d9a40c6 100644
--- a/profiles/proximity/monitor.h
+++ b/profiles/proximity/monitor.h
@@ -28,7 +28,16 @@ struct enabled {
 	gboolean findme;
 };
 
-int monitor_register(struct btd_device *device, struct gatt_primary *linkloss,
-		struct gatt_primary *txpower, struct gatt_primary *immediate,
-		struct enabled *enabled);
-void monitor_unregister(struct btd_device *device);
+int monitor_register_linkloss(struct btd_device *device,
+						struct enabled *enabled,
+						struct gatt_primary *linkloss);
+int monitor_register_txpower(struct btd_device *device,
+						struct enabled *enabled,
+						struct gatt_primary *txpower);
+int monitor_register_immediate(struct btd_device *device,
+						struct enabled *enabled,
+						struct gatt_primary *immediate);
+
+void monitor_unregister_linkloss(struct btd_device *device);
+void monitor_unregister_txpower(struct btd_device *device);
+void monitor_unregister_immediate(struct btd_device *device);
-- 
1.8.1

