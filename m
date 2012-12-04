Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 03/20] cyclingspeed: Discover CSCS characteristics
Date: Tue, 4 Dec 2012 13:43:29 +0100
Message-ID: <1354625026-29358-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/uuid.h                           |  4 +++
 profiles/cyclingspeed/cyclingspeed.c | 60 ++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index a9a3b13..1e8188a 100644
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
index e0f458d..862383a 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -50,6 +50,10 @@ struct csc {
 
 	GAttrib			*attrib;
 	guint			attioid;
+
+	struct att_range	*svc_range;
+
+	uint16_t		controlpoint_val_handle;
 };
 
 static GSList *csc_adapters = NULL;
@@ -104,9 +108,38 @@ static void destroy_csc(gpointer user_data)
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
@@ -114,6 +147,10 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	DBG("");
 
 	csc->attrib = g_attrib_ref(attrib);
+
+	gatt_discover_char(csc->attrib, csc->svc_range->start,
+				csc->svc_range->end, NULL,
+				discover_char_cb, csc);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -152,12 +189,31 @@ static void csc_adapter_remove(struct btd_profile *p,
 	destroy_csc_adapter(cadapter);
 }
 
+static gint cmp_primary_uuid(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
 static int csc_device_probe(struct btd_profile *p,
 				struct btd_device *device, GSList *uuids)
 {
 	struct btd_adapter *adapter;
 	struct csc_adapter *cadapter;
 	struct csc *csc;
+	struct gatt_primary *prim;
+	GSList *primaries;
+	GSList *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, CYCLING_SC_UUID, cmp_primary_uuid);
+	if (l == NULL)
+		return -EINVAL;
+
+	prim = l->data;
 
 	adapter = device_get_adapter(device);
 
@@ -169,6 +225,10 @@ static int csc_device_probe(struct btd_profile *p,
 	csc->dev = btd_device_ref(device);
 	csc->cadapter = cadapter;
 
+	csc->svc_range = g_new0(struct att_range, 1);
+	csc->svc_range->start = prim->range.start;
+	csc->svc_range->end = prim->range.end;
+
 	cadapter->devices = g_slist_prepend(cadapter->devices, csc);
 
 	csc->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
-- 
1.8.0

