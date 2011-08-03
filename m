Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/7] Request connection if Link or Path Loss is enabled
Date: Wed,  3 Aug 2011 15:41:42 -0300
Message-Id: <1312396907-14524-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Proximity Monitor needs to keep the link up if Link Loss and/or Path
Loss service is enabled.
---
 proximity/monitor.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 3e4f353..ba1982e 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -63,6 +63,7 @@ struct monitor {
 	char *linklosslevel;		/* Link Loss Alert Level */
 	char *immediatelevel;		/* Immediate Alert Level */
 	char *signallevel;		/* Path Loss RSSI level */
+	guint attioid;
 };
 
 static inline int create_filename(char *buf, size_t size,
@@ -318,6 +319,12 @@ static void monitor_destroy(gpointer user_data)
 {
 	struct monitor *monitor = user_data;
 
+	if (monitor->attioid)
+		btd_device_remove_attio_callback(monitor->device,
+						monitor->attioid);
+	if (monitor->attrib)
+		g_attrib_unref(monitor->attrib);
+
 	btd_device_unref(monitor->device);
 	g_free(monitor->linkloss);
 	g_free(monitor->immediate);
@@ -390,8 +397,11 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 				monitor->enabled.pathloss ? "TRUE" : "FALSE",
 				monitor->enabled.findme ? "TRUE" : "FALSE");
 
-	btd_device_add_attio_callback(device, attio_connected_cb,
-					attio_disconnected_cb, monitor);
+	if (monitor->enabled.linkloss || monitor->enabled.pathloss)
+		monitor->attioid = btd_device_add_attio_callback(device,
+							attio_connected_cb,
+							attio_disconnected_cb,
+							monitor);
 
 	return 0;
 }
-- 
1.7.6

