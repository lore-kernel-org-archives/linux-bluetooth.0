Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v7 04/13] heartrate: Discover HRS characteristics
Date: Fri, 21 Sep 2012 17:16:01 +0200
Message-ID: <1348240570-7532-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348240570-7532-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348240570-7532-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to discover known Heart Rate Service
characteristics.
---
 lib/uuid.h                     |  3 +++
 profiles/heartrate/heartrate.c | 43 +++++++++++++++++++++++++++++++++++++++++-
 profiles/heartrate/heartrate.h |  3 ++-
 profiles/heartrate/manager.c   | 19 ++++++++++++++++++-
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 3488e66..9da1b54 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -64,6 +64,9 @@ extern "C" {
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
 #define HEART_RATE_UUID			"0000180d-0000-1000-8000-00805f9b34fb"
+#define HEART_RATE_MEASUREMENT_UUID	"00002a37-0000-1000-8000-00805f9b34fb"
+#define BODY_SENSOR_LOCATION_UUID	"00002a38-0000-1000-8000-00805f9b34fb"
+#define HEART_RATE_CONTROL_POINT_UUID	"00002a39-0000-1000-8000-00805f9b34fb"
 
 #define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
 #define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index e057180..a6733d3 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -48,6 +48,11 @@ struct heartrate {
 	struct heartrate_adapter	*hradapter;
 	GAttrib				*attrib;
 	guint				attioid;
+
+	struct att_range		*svc_range;	/* primary svc range */
+
+	uint16_t			measurement_val_handle;
+	uint16_t			hrcp_val_handle;
 };
 
 static GSList *heartrate_adapters = NULL;
@@ -96,6 +101,7 @@ static void destroy_heartrate(gpointer user_data)
 		g_attrib_unref(hr->attrib);
 
 	btd_device_unref(hr->dev);
+	g_free(hr->svc_range);
 	g_free(hr);
 }
 
@@ -106,6 +112,33 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hradapter);
 }
 
+static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+
+	if (status) {
+		error("Discover HRS characteristics failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	for (; chars; chars = chars->next) {
+		struct gatt_char *c = chars->data;
+
+		if (g_strcmp0(c->uuid, HEART_RATE_MEASUREMENT_UUID) == 0) {
+			hr->measurement_val_handle = c->value_handle;
+			/* TODO: discover CCC handle */
+		} else if (g_strcmp0(c->uuid, BODY_SENSOR_LOCATION_UUID) == 0) {
+			DBG("Body Sensor Location supported");
+			/* TODO: read characterictic value */
+		} else if (g_strcmp0(c->uuid,
+					HEART_RATE_CONTROL_POINT_UUID) == 0) {
+			DBG("Heart Rate Control Point supported");
+			hr->hrcp_val_handle = c->value_handle;
+		}
+	}
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
@@ -113,6 +146,9 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	DBG("");
 
 	hr->attrib = g_attrib_ref(attrib);
+
+	gatt_discover_char(hr->attrib, hr->svc_range->start, hr->svc_range->end,
+						NULL, discover_char_cb, hr);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -150,7 +186,8 @@ void heartrate_adapter_unregister(struct btd_adapter *adapter)
 	destroy_heartrate_adapter(hradapter);
 }
 
-int heartrate_device_register(struct btd_device *device)
+int heartrate_device_register(struct btd_device *device,
+						struct gatt_primary *prim)
 {
 	struct btd_adapter *adapter;
 	struct heartrate_adapter *hradapter;
@@ -167,6 +204,10 @@ int heartrate_device_register(struct btd_device *device)
 	hr->dev = btd_device_ref(device);
 	hr->hradapter = hradapter;
 
+	hr->svc_range = g_new0(struct att_range, 1);
+	hr->svc_range->start = prim->range.start;
+	hr->svc_range->end = prim->range.end;
+
 	hradapter->devices = g_slist_prepend(hradapter->devices, hr);
 
 	hr->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
diff --git a/profiles/heartrate/heartrate.h b/profiles/heartrate/heartrate.h
index 486f5b3..064939d 100644
--- a/profiles/heartrate/heartrate.h
+++ b/profiles/heartrate/heartrate.h
@@ -22,5 +22,6 @@
 
 int heartrate_adapter_register(struct btd_adapter *adapter);
 void heartrate_adapter_unregister(struct btd_adapter *adapter);
-int heartrate_device_register(struct btd_device *device);
+int heartrate_device_register(struct btd_device *device,
+						struct gatt_primary *prim);
 void heartrate_device_unregister(struct btd_device *device);
diff --git a/profiles/heartrate/manager.c b/profiles/heartrate/manager.c
index 2a9326d..a0997bd 100644
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
@@ -46,7 +54,16 @@ static void heartrate_adapter_remove(struct btd_adapter *adapter)
 
 static int heartrate_device_probe(struct btd_device *device, GSList *uuids)
 {
-	return heartrate_device_register(device);
+	GSList *primaries;
+	GSList *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, HEART_RATE_UUID, primary_uuid_cmp);
+	if (l == NULL)
+		return -EINVAL;
+
+	return heartrate_device_register(device, l->data);
 }
 
 static void heartrate_device_remove(struct btd_device *device)
-- 
1.7.11.3

