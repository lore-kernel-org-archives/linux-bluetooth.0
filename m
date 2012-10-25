Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 03/18] cyclingspeed: Discover CSCS characteristics
Date: Thu, 25 Oct 2012 16:43:33 +0200
Message-ID: <1351176228-5789-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/uuid.h                           |  4 ++++
 profiles/cyclingspeed/cyclingspeed.c | 43 +++++++++++++++++++++++++++++++++++-
 profiles/cyclingspeed/cyclingspeed.h |  2 +-
 profiles/cyclingspeed/manager.c      | 19 +++++++++++++++-
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index ebc6d27..def4fea 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -75,6 +75,10 @@ extern "C" {
 #define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
 
 #define CYCLING_SC_UUID		"00001816-0000-1000-8000-00805f9b34fb"
+#define CSC_MEASUREMENT_UUID	"00002a5b-0000-1000-8000-00805f9b34fb"
+#define CSC_FEATURE_UUID	"00002a5c-0000-1000-8000-00805f9b34fb"
+#define SENSOR_LOCATION_UUID	"00002a5d-0000-1000-8000-00805f9b34fb"
+#define SC_CONTROL_POINT_UUID	"00002a55-0000-1000-8000-00805f9b34fb"
 
 #define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805f9b34fb"
 
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 4d98810..5744891 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -49,6 +49,10 @@ struct csc {
 
 	GAttrib			*attrib;
 	guint			attioid;
+
+	struct att_range	*svc_range;
+
+	uint16_t		controlpoint_val_handle;
 };
 
 static GSList *csc_adapters = NULL;
@@ -103,9 +107,38 @@ static void destroy_csc(gpointer user_data)
 		g_attrib_unref(csc->attrib);
 
 	btd_device_unref(csc->dev);
+	g_free(csc->svc_range);
 	g_free(csc);
 }
 
+static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
+{
+	struct csc *csc = user_data;
+
+	if (status) {
+		error("Discover CSCS characteristics: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	for (; chars; chars = chars->next) {
+		struct gatt_char *c = chars->data;
+
+		if (g_strcmp0(c->uuid, CSC_MEASUREMENT_UUID) == 0) {
+			/* TODO: discover CCC handle */
+		} else if (g_strcmp0(c->uuid, CSC_FEATURE_UUID) == 0) {
+			/* TODO: read characterictic value */
+		} else if (g_strcmp0(c->uuid, SENSOR_LOCATION_UUID) == 0) {
+			DBG("Sensor Location supported");
+			/* TODO: read characterictic value */
+		} else if (g_strcmp0(c->uuid, SC_CONTROL_POINT_UUID) == 0) {
+			DBG("SC Control Point supported");
+			csc->controlpoint_val_handle = c->value_handle;
+			/* TODO: discover CCC handle */
+		}
+	}
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct csc *csc = user_data;
@@ -113,6 +146,10 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	DBG("");
 
 	csc->attrib = g_attrib_ref(attrib);
+
+	gatt_discover_char(csc->attrib, csc->svc_range->start,
+				csc->svc_range->end, NULL,
+				discover_char_cb, csc);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -150,7 +187,7 @@ void csc_adapter_unregister(struct btd_adapter *adapter)
 	destroy_csc_adapter(cadapter);
 }
 
-int csc_device_register(struct btd_device *device)
+int csc_device_register(struct btd_device *device, struct gatt_primary *prim)
 {
 	struct btd_adapter *adapter;
 	struct csc_adapter *cadapter;
@@ -166,6 +203,10 @@ int csc_device_register(struct btd_device *device)
 	csc->dev = btd_device_ref(device);
 	csc->cadapter = cadapter;
 
+	csc->svc_range = g_new0(struct att_range, 1);
+	csc->svc_range->start = prim->range.start;
+	csc->svc_range->end = prim->range.end;
+
 	cadapter->devices = g_slist_prepend(cadapter->devices, csc);
 
 	csc->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
diff --git a/profiles/cyclingspeed/cyclingspeed.h b/profiles/cyclingspeed/cyclingspeed.h
index b83fa9e..3400d5f 100644
--- a/profiles/cyclingspeed/cyclingspeed.h
+++ b/profiles/cyclingspeed/cyclingspeed.h
@@ -22,5 +22,5 @@
 
 int csc_adapter_register(struct btd_adapter *adapter);
 void csc_adapter_unregister(struct btd_adapter *adapter);
-int csc_device_register(struct btd_device *device);
+int csc_device_register(struct btd_device *device, struct gatt_primary *prim);
 void csc_device_unregister(struct btd_device *device);
diff --git a/profiles/cyclingspeed/manager.c b/profiles/cyclingspeed/manager.c
index e5f7553..c147af2 100644
--- a/profiles/cyclingspeed/manager.c
+++ b/profiles/cyclingspeed/manager.c
@@ -34,6 +34,14 @@
 #include "cyclingspeed.h"
 #include "manager.h"
 
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
 static int csc_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	return csc_adapter_register(adapter);
@@ -48,7 +56,16 @@ static void csc_adapter_remove(struct btd_profile *p,
 static int csc_device_probe(struct btd_profile *p,
 				struct btd_device *device, GSList *uuids)
 {
-	return csc_device_register(device);
+	GSList *primaries;
+	GSList *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, CYCLING_SC_UUID, primary_uuid_cmp);
+	if (l == NULL)
+		return -EINVAL;
+
+	return csc_device_register(device, l->data);
 }
 
 static void csc_device_remove(struct btd_profile *p,
-- 
1.8.0

