Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH 03/13] heartrate: Add conn logic and attio callbacks
Date: Thu, 9 Aug 2012 09:20:06 +0200
Message-ID: <1344496816-4641-4-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
References: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle connection to the remote device when the
Heart Rate plugin is loaded.

---
 profiles/heartrate/heartrate.c |   86 +++++++++++++++++++++++++++++++++++++++-
 profiles/heartrate/heartrate.h |    2 +-
 profiles/heartrate/manager.c   |   22 +++++++++-
 3 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 9bd93c5..1114cff 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -30,10 +30,24 @@
 
 #include "adapter.h"
 #include "device.h"
+#include "gattrib.h"
+#include "attio.h"
+#include "att.h"
+#include "gatt.h"
 #include "heartrate.h"
+#include "log.h"
 
 struct heartrate {
 	struct btd_device	*dev;  /*Device reference*/
+	GAttrib			*attrib; /*GATT connection*/
+	guint			attioid; /*ATT watcher id*/
+	struct att_range	*svc_range; /*Heart Rate range*/
+	GSList			*chars; /*Characteristics*/
+};
+
+struct characteristic {
+	struct gatt_char	attr; /*Characteristic*/
+	struct heartrate	*hr; /*Parent Heart Rate Service*/
 };
 
 static GSList *hr_servers = NULL;
@@ -53,19 +67,89 @@ static void heartrate_destroy(gpointer user_data)
 {
 	struct heartrate *hr = user_data;
 
+	if (hr->chars != NULL)
+		g_slist_free_full(hr->chars, g_free);
+
+	if (hr->attioid > 0)
+		btd_device_remove_attio_callback(hr->dev, hr->attioid);
+
+	if (hr->attrib != NULL)
+		g_attrib_unref(hr->attrib);
+
 	btd_device_unref(hr->dev);
+	g_free(hr->svc_range);
 	g_free(hr);
+
+}
+
+static void configure_heartrate_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+	GSList *l;
+
+	if (status != 0) {
+		error("Discover heartrate characteristics: %s",
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
+		ch->hr = hr;
+
+		hr->chars = g_slist_append(hr->chars, ch);
+	}
+}
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	DBG("GATT Connected");
+
+	hr->attrib = g_attrib_ref(attrib);
+
+	if (hr->chars == NULL)
+		gatt_discover_char(hr->attrib, hr->svc_range->start,
+						hr->svc_range->end, NULL,
+						configure_heartrate_cb, hr);
 }
 
-int heartrate_register(struct btd_device *device)
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	DBG("GATT Disconnected");
+
+	g_attrib_unref(hr->attrib);
+	hr->attrib = NULL;
+}
+
+int heartrate_register(struct btd_device *device, struct gatt_primary *pattr)
 {
 	struct heartrate *hr;
 
 	hr = g_new0(struct heartrate, 1);
 	hr->dev = btd_device_ref(device);
 
+	hr->svc_range = g_new0(struct att_range, 1);
+	hr->svc_range->start = pattr->range.start;
+	hr->svc_range->end = pattr->range.end;
+
 	hr_servers = g_slist_prepend(hr_servers, hr);
 
+	hr->attioid = btd_device_add_attio_callback(device,
+						attio_connected_cb,
+						attio_disconnected_cb ,
+						hr);
 	return 0;
 }
 void heartrate_unregister(struct btd_device *device)
diff --git a/profiles/heartrate/heartrate.h b/profiles/heartrate/heartrate.h
index 8d4271c..1d2ba89 100644
--- a/profiles/heartrate/heartrate.h
+++ b/profiles/heartrate/heartrate.h
@@ -20,5 +20,5 @@
  *
  */
 
-int heartrate_register(struct btd_device *device);
+int heartrate_register(struct btd_device *device, struct gatt_primary *pattr);
 void heartrate_unregister(struct btd_device *device);
diff --git a/profiles/heartrate/manager.c b/profiles/heartrate/manager.c
index da6c7ef..6ba059d 100644
--- a/profiles/heartrate/manager.c
+++ b/profiles/heartrate/manager.c
@@ -32,9 +32,29 @@
 #include "heartrate.h"
 #include "manager.h"
 
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
 static int heartrate_driver_probe(struct btd_device *device, GSList *uuids)
 {
-	return heartrate_register(device);
+	struct gatt_primary *pattr;
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, HEART_RATE_UUID,
+							primary_uuid_cmp);
+	if (l == NULL)
+		return -EINVAL;
+
+	pattr = l->data;
+
+	return heartrate_register(device, pattr);
 }
 
 static void heartrate_driver_remove(struct btd_device *device)
-- 
1.7.9.5

