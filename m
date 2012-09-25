Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 01/14] thermometer: Store thermometer devices per-adapter
Date: Tue, 25 Sep 2012 16:52:30 +0200
Message-ID: <1348584763-22824-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces global list of thermometer devices with per-adapter
lists.
---
 profiles/thermometer/manager.c     |  16 +++++-
 profiles/thermometer/thermometer.c | 114 ++++++++++++++++++++++++++++++-------
 profiles/thermometer/thermometer.h |   2 +
 3 files changed, 110 insertions(+), 22 deletions(-)

diff --git a/profiles/thermometer/manager.c b/profiles/thermometer/manager.c
index d965976..86e3a0f 100644
--- a/profiles/thermometer/manager.c
+++ b/profiles/thermometer/manager.c
@@ -66,11 +66,25 @@ static void thermometer_driver_remove(struct btd_profile *p,
 	thermometer_unregister(device);
 }
 
+static int thermometer_adapter_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	return thermometer_adapter_register(adapter);
+}
+
+static void thermometer_adapter_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	thermometer_adapter_unregister(adapter);
+}
+
 static struct btd_profile thermometer_profile = {
 	.name		= "thermometer-device-driver",
 	.remote_uuids	= BTD_UUIDS(HEALTH_THERMOMETER_UUID),
 	.device_probe	= thermometer_driver_probe,
-	.device_remove	= thermometer_driver_remove
+	.device_remove	= thermometer_driver_remove,
+	.adapter_probe	= thermometer_adapter_probe,
+	.adapter_remove	= thermometer_adapter_remove
 };
 
 int thermometer_manager_init(void)
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 77dcb26..c8a6826 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -55,23 +55,29 @@
 #define TEMPERATURE_TYPE_SIZE	1
 #define MEASUREMENT_INTERVAL_SIZE	2
 
+struct thermometer_adapter {
+	struct btd_adapter	*adapter;
+	GSList			*devices;
+};
+
 struct thermometer {
-	struct btd_device	*dev;		/* Device reference */
-	GAttrib			*attrib;	/* GATT connection */
-	struct att_range	*svc_range;	/* Thermometer range */
-	guint			attioid;	/* Att watcher id */
-	guint			attindid;	/* Att incications id */
-	guint			attnotid;	/* Att notifications id */
-	GSList			*chars;		/* Characteristics */
-	GSList			*fwatchers;     /* Final measurements */
-	GSList			*iwatchers;     /* Intermediate measurements */
-	gboolean		intermediate;
-	uint8_t			type;
-	uint16_t		interval;
-	uint16_t		max;
-	uint16_t		min;
-	gboolean		has_type;
-	gboolean		has_interval;
+	struct btd_device		*dev;		/* Device reference */
+	struct thermometer_adapter	*tadapter;
+	GAttrib				*attrib;	/* GATT connection */
+	struct att_range		*svc_range;	/* Thermometer range */
+	guint				attioid;	/* Att watcher id */
+	guint				attindid;	/* Att incications id */
+	guint				attnotid;	/* Att notif id */
+	GSList				*chars;		/* Characteristics */
+	GSList				*fwatchers;     /* Final measurements */
+	GSList				*iwatchers;     /* Intermediate meas  */
+	gboolean			intermediate;
+	uint8_t				type;
+	uint16_t			interval;
+	uint16_t			max;
+	uint16_t			min;
+	gboolean			has_type;
+	gboolean			has_interval;
 };
 
 struct characteristic {
@@ -108,7 +114,7 @@ struct tmp_interval_data {
 	uint16_t		interval;
 };
 
-static GSList *thermometers = NULL;
+static GSList *thermometer_adapters = NULL;
 
 const char *temp_type[] = {
 	"<reserved>",
@@ -183,6 +189,17 @@ static void destroy_thermometer(gpointer user_data)
 	g_free(t);
 }
 
+static gint cmp_adapter(gconstpointer a, gconstpointer b)
+{
+	const struct thermometer_adapter *tadapter = a;
+	const struct btd_adapter *adapter = b;
+
+	if (adapter == tadapter->adapter)
+		return 0;
+
+	return -1;
+}
+
 static gint cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct thermometer *t = a;
@@ -231,6 +248,17 @@ static gint cmp_descriptor(gconstpointer a, gconstpointer b)
 	return bt_uuid_cmp(&desc->uuid, uuid);
 }
 
+static struct thermometer_adapter *
+find_thermometer_adapter(struct btd_adapter *adapter)
+{
+	GSList *l = g_slist_find_custom(thermometer_adapters, adapter,
+								cmp_adapter);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
 static struct characteristic *get_characteristic(struct thermometer *t,
 							const char *uuid)
 {
@@ -1233,13 +1261,25 @@ int thermometer_register(struct btd_device *device, struct gatt_primary *tattr)
 {
 	const gchar *path = device_get_path(device);
 	struct thermometer *t;
+	struct btd_adapter *adapter;
+	struct thermometer_adapter *tadapter;
+
+	adapter = device_get_adapter(device);
+
+	tadapter = find_thermometer_adapter(adapter);
+
+	if (tadapter == NULL)
+		return -1;
 
 	t = g_new0(struct thermometer, 1);
 	t->dev = btd_device_ref(device);
+	t->tadapter = tadapter;
 	t->svc_range = g_new0(struct att_range, 1);
 	t->svc_range->start = tattr->range.start;
 	t->svc_range->end = tattr->range.end;
 
+	tadapter->devices = g_slist_prepend(tadapter->devices, t);
+
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 				path, THERMOMETER_INTERFACE,
 				thermometer_methods, thermometer_signals,
@@ -1250,8 +1290,6 @@ int thermometer_register(struct btd_device *device, struct gatt_primary *tattr)
 		return -EIO;
 	}
 
-	thermometers = g_slist_prepend(thermometers, t);
-
 	t->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
 						attio_disconnected_cb, t);
 	return 0;
@@ -1260,14 +1298,48 @@ int thermometer_register(struct btd_device *device, struct gatt_primary *tattr)
 void thermometer_unregister(struct btd_device *device)
 {
 	struct thermometer *t;
+	struct btd_adapter *adapter;
+	struct thermometer_adapter *tadapter;
 	GSList *l;
 
-	l = g_slist_find_custom(thermometers, device, cmp_device);
+	adapter = device_get_adapter(device);
+
+	tadapter = find_thermometer_adapter(adapter);
+
+	if (tadapter == NULL)
+		return;
+
+	l = g_slist_find_custom(tadapter->devices, device, cmp_device);
 	if (l == NULL)
 		return;
 
 	t = l->data;
-	thermometers = g_slist_remove(thermometers, t);
+
+	tadapter->devices = g_slist_remove(tadapter->devices, t);
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 				device_get_path(t->dev), THERMOMETER_INTERFACE);
 }
+
+int thermometer_adapter_register(struct btd_adapter *adapter)
+{
+	struct thermometer_adapter *tadapter;
+
+	tadapter = g_new0(struct thermometer_adapter, 1);
+	tadapter->adapter = adapter;
+
+	thermometer_adapters = g_slist_prepend(thermometer_adapters, tadapter);
+
+	return 0;
+}
+
+void thermometer_adapter_unregister(struct btd_adapter *adapter)
+{
+	struct thermometer_adapter *tadapter;
+
+	tadapter = find_thermometer_adapter(adapter);
+	if (tadapter == NULL)
+		return;
+
+	thermometer_adapters = g_slist_remove(thermometer_adapters, tadapter);
+}
diff --git a/profiles/thermometer/thermometer.h b/profiles/thermometer/thermometer.h
index 2744ed6..ca83c31 100644
--- a/profiles/thermometer/thermometer.h
+++ b/profiles/thermometer/thermometer.h
@@ -22,3 +22,5 @@
 
 int thermometer_register(struct btd_device *device, struct gatt_primary *tattr);
 void thermometer_unregister(struct btd_device *device);
+int thermometer_adapter_register(struct btd_adapter *adapter);
+void thermometer_adapter_unregister(struct btd_adapter *adapter);
-- 
1.7.11.3

