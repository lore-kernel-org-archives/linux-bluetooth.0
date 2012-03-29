Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v4 3/4] DeviceInfo: Discover Characteristics
Date: Thu, 29 Mar 2012 15:52:56 +0200
Message-Id: <1333029177-15204-4-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1333029177-15204-1-git-send-email-chen.ganir@ti.com>
References: <1333029177-15204-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add logic to discover all characteristics and build a
characteristic list.
---
 deviceinfo/deviceinfo.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 deviceinfo/deviceinfo.h |    2 +-
 deviceinfo/manager.c    |    5 ++++-
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index 51eaf1f..af99156 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -34,17 +34,26 @@
 #include "att.h"
 #include "gattrib.h"
 #include "gatt.h"
+#include "log.h"
 #include "deviceinfo.h"
 
+#define PNPID_UUID		"00002a50-0000-1000-8000-00805f9b34fb"
 
 struct deviceinfo {
 	struct btd_device	*dev;		/* Device reference */
 	GAttrib			*attrib;	/* GATT connection */
 	guint			attioid;	/* Att watcher id */
+	struct att_range	*svc_range;	/* DeviceInfo range */
+	GSList			*chars;		/* Characteristics */
 };
 
 static GSList *servers = NULL;
 
+struct characteristic {
+	struct gatt_char	attr;	/* Characteristic */
+	struct deviceinfo	*d;	/* deviceinfo where the char belongs */
+};
+
 static void deviceinfo_free(gpointer user_data)
 {
 	struct deviceinfo *d = user_data;
@@ -55,7 +64,10 @@ static void deviceinfo_free(gpointer user_data)
 	if (d->attrib != NULL)
 		g_attrib_unref(d->attrib);
 
+	g_slist_free_full(d->chars, g_free);
+
 	btd_device_unref(d->dev);
+	g_free(d->svc_range);
 	g_free(d);
 }
 
@@ -70,11 +82,40 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct deviceinfo *d = user_data;
+	GSList *l;
+
+	if (status != 0) {
+		error("Discover deviceinfo characteristics: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	for (l = characteristics; l; l = l->next) {
+		struct gatt_char *c = l->data;
+		struct characteristic *ch;
+
+		ch = g_new0(struct characteristic, 1);
+		ch->attr.handle = c->handle;
+		ch->attr.properties = c->properties;
+		ch->attr.value_handle = c->value_handle;
+		memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
+		ch->d = d;
+
+		d->chars = g_slist_append(d->chars, ch);
+	}
+}
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct deviceinfo *d = user_data;
 
 	d->attrib = g_attrib_ref(attrib);
+
+	gatt_discover_char(d->attrib, d->svc_range->start, d->svc_range->end,
+					NULL, configure_deviceinfo_cb, d);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -85,12 +126,15 @@ static void attio_disconnected_cb(gpointer user_data)
 	d->attrib = NULL;
 }
 
-int deviceinfo_register(struct btd_device *device)
+int deviceinfo_register(struct btd_device *device, struct gatt_primary *prim)
 {
 	struct deviceinfo *d;
 
 	d = g_new0(struct deviceinfo, 1);
 	d->dev = btd_device_ref(device);
+	d->svc_range = g_new0(struct att_range, 1);
+	d->svc_range->start = prim->range.start;
+	d->svc_range->end = prim->range.end;
 
 	servers = g_slist_prepend(servers, d);
 
diff --git a/deviceinfo/deviceinfo.h b/deviceinfo/deviceinfo.h
index 0ea6ff5..7a804a5 100644
--- a/deviceinfo/deviceinfo.h
+++ b/deviceinfo/deviceinfo.h
@@ -20,5 +20,5 @@
  *
  */
 
-int deviceinfo_register(struct btd_device *device);
+int deviceinfo_register(struct btd_device *device, struct gatt_primary *prim);
 void deviceinfo_unregister(struct btd_device *device);
diff --git a/deviceinfo/manager.c b/deviceinfo/manager.c
index 025a076..c2378c2 100644
--- a/deviceinfo/manager.c
+++ b/deviceinfo/manager.c
@@ -44,6 +44,7 @@ static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 
 static int deviceinfo_driver_probe(struct btd_device *device, GSList *uuids)
 {
+	struct gatt_primary *prim;
 	GSList *primaries, *l;
 
 	primaries = btd_device_get_primaries(device);
@@ -53,7 +54,9 @@ static int deviceinfo_driver_probe(struct btd_device *device, GSList *uuids)
 	if (l == NULL)
 		return -EINVAL;
 
-	return deviceinfo_register(device);
+	prim = l->data;
+
+	return deviceinfo_register(device, prim);
 }
 
 static void deviceinfo_driver_remove(struct btd_device *device)
-- 
1.7.4.1

