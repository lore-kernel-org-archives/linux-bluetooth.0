Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v3 2/5] DeviceInfo: Add connection logic
Date: Wed, 28 Mar 2012 17:26:42 +0200
Message-Id: <1332948405-1104-3-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332948405-1104-1-git-send-email-chen.ganir@ti.com>
References: <1332948405-1104-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add connection logic to the Device Information Plugin. When the
driver is loaded, it will request a connection to the remote device
and release the connection request when destroyed.
---
 deviceinfo/deviceinfo.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index 95e7f1d..8624a31 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -29,13 +29,18 @@
 #include <bluetooth/uuid.h>
 #include "adapter.h"
 #include "device.h"
+#include "gattrib.h"
+#include "attio.h"
 #include "att.h"
 #include "gattrib.h"
 #include "gatt.h"
 #include "deviceinfo.h"
 
+
 struct deviceinfo {
 	struct btd_device	*dev;		/* Device reference */
+	GAttrib			*attrib;		/* GATT connection */
+	guint			attioid;		/* Att watcher id */
 };
 
 static GSList *deviceinfoservers = NULL;
@@ -44,6 +49,12 @@ static void deviceinfo_free(gpointer user_data)
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
@@ -59,6 +70,21 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
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
@@ -68,6 +94,8 @@ int deviceinfo_register(struct btd_device *device)
 
 	deviceinfoservers = g_slist_prepend(deviceinfoservers, d);
 
+	d->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
+						attio_disconnected_cb, d);
 	return 0;
 }
 
-- 
1.7.4.1

