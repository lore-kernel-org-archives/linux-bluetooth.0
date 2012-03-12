Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 2/3] DeviceInfo: Discover Characteristics
Date: Mon, 12 Mar 2012 16:54:27 +0200
Message-Id: <1331564068-2658-3-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1331564068-2658-1-git-send-email-chen.ganir@ti.com>
References: <1331564068-2658-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add logic to discover all characteristics and build a
characteristic list.
---
 deviceinfo/deviceinfo.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index 852878b..ab2e468 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -34,17 +34,33 @@
 #include "attio.h"
 #include "att.h"
 #include "gatt.h"
+#include "log.h"
 #include "deviceinfo.h"
 
+#define PNPID_UUID		                "00002a50-0000-1000-8000-00805f9b34fb"
 
 struct deviceinfo {
 	struct btd_device	*dev;		/* Device reference */
 	GAttrib			*attrib;		/* GATT connection */
+	struct att_range	*svc_range;	/* DeviceInfo range */
 	guint			attioid;		/* Att watcher id */
+	GSList			*chars;		/* Characteristics */
 };
 
 static GSList *deviceinfoservers = NULL;
 
+struct characteristic {
+	struct att_char		attr;	/* Characteristic */
+	struct deviceinfo	*d;	/* deviceinfo where the char belongs */
+};
+
+static void destroy_char(gpointer user_data)
+{
+	struct characteristic *c = user_data;
+
+	g_free(c);
+}
+
 static void destroy_deviceinfo(gpointer user_data)
 {
 	struct deviceinfo *d = user_data;
@@ -55,7 +71,11 @@ static void destroy_deviceinfo(gpointer user_data)
 	if (d->attrib != NULL)
 		g_attrib_unref(d->attrib);
 
+	if (d->chars != NULL)
+		g_slist_free_full(d->chars, destroy_char);
+
 	btd_device_unref(d->dev);
+	g_free(d->svc_range);
 	g_free(d);
 }
 
@@ -70,11 +90,53 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
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
+		struct att_char *c = l->data;
+		struct characteristic *ch;
+		uint16_t start, end;
+
+		ch = g_new0(struct characteristic, 1);
+		ch->attr.handle = c->handle;
+		ch->attr.properties = c->properties;
+		ch->attr.value_handle = c->value_handle;
+		memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
+		ch->d = d;
+
+		d->chars = g_slist_append(d->chars, ch);
+
+		start = c->value_handle + 1;
+
+		if (l->next != NULL) {
+			struct att_char *c = l->next->data;
+			if (start == c->handle)
+				continue;
+			end = c->handle - 1;
+		} else if (c->value_handle != d->svc_range->end)
+			end = d->svc_range->end;
+		else
+			continue;
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
@@ -91,6 +153,9 @@ int deviceinfo_register(struct btd_device *device, struct att_primary *dattr)
 
 	d = g_new0(struct deviceinfo, 1);
 	d->dev = btd_device_ref(device);
+	d->svc_range = g_new0(struct att_range, 1);
+	d->svc_range->start = dattr->start;
+	d->svc_range->end = dattr->end;
 
 	deviceinfoservers = g_slist_prepend(deviceinfoservers, d);
 
-- 
1.7.4.1

