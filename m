Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v4 04/17] heartrate: Discover characteristics
Date: Thu, 13 Sep 2012 14:13:08 +0200
Message-ID: <1347538401-6417-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

This patch adds support to discover Heart Rate Service characteristics when
connected to remote device.

Change-Id: Ibbae71a35b3d9c295106e12041d51c54e6928f08
---
 profiles/heartrate/heartrate.c | 49 +++++++++++++++++++++++++++++++++++++++++-
 profiles/heartrate/heartrate.h |  3 ++-
 profiles/heartrate/manager.c   | 22 ++++++++++++++++++-
 3 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 6b470e5..140a2fb 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -48,6 +48,13 @@ struct heartrate_device {
 	struct heartrate_adapter	*hr;
 	GAttrib				*attrib;
 	guint				attioid;
+	struct att_range		*svc_range;
+	GSList				*chars;
+};
+
+struct characteristic {
+	struct gatt_char	attr;
+	struct heartrate_device	*hrdev;
 };
 
 static GSList *heartrate_adapters = NULL;
@@ -95,7 +102,11 @@ static void destroy_heartrate_device(gpointer user_data)
 	if (hrdev->attrib != NULL)
 		g_attrib_unref(hrdev->attrib);
 
+	if (hrdev->chars != NULL)
+		g_slist_free_full(hrdev->chars, g_free);
+
 	btd_device_unref(hrdev->dev);
+	g_free(hrdev->svc_range);
 	g_free(hrdev);
 }
 
@@ -109,6 +120,33 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hr);
 }
 
+static void configure_heartrate_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct heartrate_device *hrdev = user_data;
+	GSList *l;
+
+	if (status != 0) {
+		error("Discover Heart Rate characteristics: %s",
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
+		ch->hrdev = hrdev;
+
+		hrdev->chars = g_slist_append(hrdev->chars, ch);
+	}
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct heartrate_device *hrdev = user_data;
@@ -116,6 +154,10 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	DBG("GATT Connected");
 
 	hrdev->attrib = g_attrib_ref(attrib);
+
+	gatt_discover_char(hrdev->attrib, hrdev->svc_range->start,
+					hrdev->svc_range->end, NULL,
+					configure_heartrate_cb, hrdev);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -152,7 +194,8 @@ void heartrate_adapter_unregister(struct btd_adapter *adapter)
 	destroy_heartrate_adapter(hr);
 }
 
-int heartrate_device_register(struct btd_device *device)
+int heartrate_device_register(struct btd_device *device,
+						struct gatt_primary *pattr)
 {
 	struct heartrate_adapter *hr;
 	struct btd_adapter *adapter;
@@ -171,6 +214,10 @@ int heartrate_device_register(struct btd_device *device)
 
 	hr->devices = g_slist_prepend(hr->devices, hrdev);
 
+	hrdev->svc_range = g_new0(struct att_range, 1);
+	hrdev->svc_range->start = pattr->range.start;
+	hrdev->svc_range->end = pattr->range.end;
+
 	hrdev->attioid = btd_device_add_attio_callback(device,
 						attio_connected_cb,
 						attio_disconnected_cb,
diff --git a/profiles/heartrate/heartrate.h b/profiles/heartrate/heartrate.h
index 486f5b3..ec3ed7a 100644
--- a/profiles/heartrate/heartrate.h
+++ b/profiles/heartrate/heartrate.h
@@ -22,5 +22,6 @@
 
 int heartrate_adapter_register(struct btd_adapter *adapter);
 void heartrate_adapter_unregister(struct btd_adapter *adapter);
-int heartrate_device_register(struct btd_device *device);
+int heartrate_device_register(struct btd_device *device,
+						struct gatt_primary *pattr);
 void heartrate_device_unregister(struct btd_device *device);
diff --git a/profiles/heartrate/manager.c b/profiles/heartrate/manager.c
index 2a9326d..d7d7ae4 100644
--- a/profiles/heartrate/manager.c
+++ b/profiles/heartrate/manager.c
@@ -34,6 +34,14 @@
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
 static int heartrate_adapter_probe(struct btd_adapter *adapter)
 {
 	return heartrate_adapter_register(adapter);
@@ -46,7 +54,19 @@ static void heartrate_adapter_remove(struct btd_adapter *adapter)
 
 static int heartrate_device_probe(struct btd_device *device, GSList *uuids)
 {
-	return heartrate_device_register(device);
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
+	return heartrate_device_register(device, pattr);
 }
 
 static void heartrate_device_remove(struct btd_device *device)
-- 
1.7.11.3

