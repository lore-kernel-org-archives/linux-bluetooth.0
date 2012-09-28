Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 2/4] proximity: Remove alert level storage
Date: Fri, 28 Sep 2012 17:01:32 -0300
Message-Id: <1348862494-16911-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix leftover LinkLossAlertLevel store value when the device
is removed from the system.
---
 profiles/proximity/manager.c |  2 +-
 profiles/proximity/monitor.c | 15 +++++++++++++--
 profiles/proximity/monitor.h |  2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index 93dc33e..afc2569 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -80,7 +80,7 @@ static int monitor_device_probe(struct btd_profile *p,
 static void monitor_device_remove(struct btd_profile *p,
 				struct btd_device *device, gboolean purge)
 {
-	monitor_unregister(device);
+	monitor_unregister(device, purge);
 }
 
 static struct btd_profile pxp_monitor_profile = {
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index a791916..4745791 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -106,7 +106,10 @@ static int write_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
 
 	snprintf(key, sizeof(key), "%17s#%s", addr, alert);
 
-	return textfile_put(filename, key, level);
+	if (level)
+		return textfile_put(filename, key, level);
+	else
+		return textfile_del(filename, key);
 }
 
 static char *read_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
@@ -659,10 +662,18 @@ int monitor_register(struct btd_device *device,
 	return 0;
 }
 
-void monitor_unregister(struct btd_device *device)
+void monitor_unregister(struct btd_device *device, gboolean purge)
 {
 	const char *path = device_get_path(device);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 							PROXIMITY_INTERFACE);
+	if (purge) {
+		bdaddr_t sba, dba;
+
+		adapter_get_address(device_get_adapter(device), &sba);
+		device_get_address(device, &dba, NULL);
+
+		write_proximity_config(&sba, &dba, "LinkLossAlertLevel", NULL);
+	}
 }
diff --git a/profiles/proximity/monitor.h b/profiles/proximity/monitor.h
index 191b562..bffc8af 100644
--- a/profiles/proximity/monitor.h
+++ b/profiles/proximity/monitor.h
@@ -31,4 +31,4 @@ struct enabled {
 int monitor_register(struct btd_device *device, struct gatt_primary *linkloss,
 		struct gatt_primary *txpower, struct gatt_primary *immediate,
 		struct enabled *enabled);
-void monitor_unregister(struct btd_device *device);
+void monitor_unregister(struct btd_device *device, gboolean purge);
-- 
1.7.12

