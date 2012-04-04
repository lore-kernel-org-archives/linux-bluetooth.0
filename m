Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v6 2/4] DeviceInfo: Add connection logic
Date: Wed,  4 Apr 2012 11:28:55 +0300
Message-Id: <1333528137-9305-3-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1333528137-9305-1-git-send-email-chen.ganir@ti.com>
References: <1333528137-9305-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add connection logic to the Device Information Plugin. When the
driver is loaded, it will request a connection to the remote device
and release the connection request when destroyed.
---
 deviceinfo/deviceinfo.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index fed0cc8..150b061 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -28,6 +28,8 @@
 #include <bluetooth/uuid.h>
 #include "adapter.h"
 #include "device.h"
+#include "gattrib.h"
+#include "attio.h"
 #include "att.h"
 #include "gattrib.h"
 #include "gatt.h"
@@ -35,6 +37,8 @@
 
 struct deviceinfo {
 	struct btd_device	*dev;		/* Device reference */
+	GAttrib			*attrib;	/* GATT connection */
+	guint			attioid;	/* Att watcher id */
 };
 
 static GSList *servers = NULL;
@@ -43,6 +47,12 @@ static void deviceinfo_free(gpointer user_data)
 {
 	struct deviceinfo *d = user_data;
 
+	if (d->attioid > 0)
+		btd_device_remove_attio_callback(d->dev, d->attioid);
+
+	if (d->attrib != NULL)
+		g_attrib_unref(d->attrib);
+
 	btd_device_unref(d->dev);
 	g_free(d);
 }
@@ -58,6 +68,21 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct deviceinfo *d = user_data;
+
+	d->attrib = g_attrib_ref(attrib);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct deviceinfo *d = user_data;
+
+	g_attrib_unref(d->attrib);
+	d->attrib = NULL;
+}
+
 int deviceinfo_register(struct btd_device *device)
 {
 	struct deviceinfo *d;
@@ -67,6 +92,8 @@ int deviceinfo_register(struct btd_device *device)
 
 	servers = g_slist_prepend(servers, d);
 
+	d->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
+						attio_disconnected_cb, d);
 	return 0;
 }
 
-- 
1.7.4.1

