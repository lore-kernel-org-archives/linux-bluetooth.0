Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v4 04/10] battery: Add client connection logic
Date: Mon, 24 Sep 2012 09:15:13 +0200
Message-ID: <1348470919-25567-5-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1348470919-25567-1-git-send-email-chen.ganir@ti.com>
References: <1348470919-25567-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add connection logic to the Battery Plugin. When the driver is
loaded, it will request a connection to the remote device and
release the connection request when destroyed.
---
 profiles/battery/battery.c |   90 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 7702e39..5e52275 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -30,17 +30,28 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "gattrib.h"
+#include "attio.h"
 #include "att.h"
 #include "gattrib.h"
 #include "gatt.h"
 #include "battery.h"
+#include "log.h"
 
 struct battery {
 	struct btd_device	*dev;		/* Device reference */
+	GAttrib			*attrib;	/* GATT connection */
+	guint			attioid;	/* Att watcher id */
+	struct att_range	*svc_range;	/* Battery range */
+	GSList			*chars;		/* Characteristics */
 };
 
 static GSList *servers;
 
+struct characteristic {
+	struct gatt_char	attr;		/* Characteristic */
+	struct battery		*batt;		/* Parent Battery Service */
+};
 static gint cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct battery *batt = a;
@@ -56,20 +67,99 @@ static void battery_free(gpointer user_data)
 {
 	struct battery *batt = user_data;
 
+	if (batt->chars != NULL)
+		g_slist_free_full(batt->chars, g_free);
+
+	if (batt->attioid > 0)
+		btd_device_remove_attio_callback(batt->dev, batt->attioid);
+
+	if (batt->attrib != NULL)
+		g_attrib_unref(batt->attrib);
+
 	btd_device_unref(batt->dev);
 	g_free(batt);
 }
 
+static void configure_battery_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct battery *batt = user_data;
+	GSList *l;
+
+	if (status != 0) {
+		error("Discover Battery characteristics: %s",
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
+		ch->batt = batt;
+
+		batt->chars = g_slist_append(batt->chars, ch);
+	}
+}
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct battery *batt = user_data;
+
+	batt->attrib = g_attrib_ref(attrib);
+
+	if (batt->chars == NULL) {
+		gatt_discover_char(batt->attrib, batt->svc_range->start,
+					batt->svc_range->end, NULL,
+					configure_battery_cb, batt);
+	}
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct battery *batt = user_data;
+
+	g_attrib_unref(batt->attrib);
+	batt->attrib = NULL;
+}
+
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
 
 int battery_register(struct btd_device *device)
 {
 	struct battery *batt;
+	struct gatt_primary *prim;
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, BATTERY_SERVICE_UUID,
+							primary_uuid_cmp);
+	prim = l->data;
 
 	batt = g_new0(struct battery, 1);
 	batt->dev = btd_device_ref(device);
 
+	batt->svc_range = g_new0(struct att_range, 1);
+	batt->svc_range->start = prim->range.start;
+	batt->svc_range->end = prim->range.end;
+
 	servers = g_slist_prepend(servers, batt);
 
+	batt->attioid = btd_device_add_attio_callback(device,
+				attio_connected_cb, attio_disconnected_cb,
+				batt);
 	return 0;
 }
 
-- 
1.7.9.5

