Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 10/20] cyclingspeed: Add DBus.Properties for org.bluez.CyclingSpeed interface
Date: Mon, 5 Nov 2012 09:54:55 +0100
Message-ID: <1352105705-13988-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 96 +++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index ae058f2..5a65507 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -103,6 +103,21 @@ struct characteristic {
 
 static GSList *csc_adapters = NULL;
 
+static const char * const location_enum[] = {
+	"other", "top-of-shoe", "in-shoe", "hip", "front-wheel", "left-crank",
+	"right-crank", "left-pedal", "right-pedal", "front-hub",
+	"rear-dropout", "chainstay", "rear-wheel", "rear-hub"
+};
+
+static const gchar *location2str(uint8_t value)
+{
+	if (value < G_N_ELEMENTS(location_enum))
+		return location_enum[value];
+
+	info("Body Sensor Location [%d] is RFU", value);
+	return location_enum[0];
+}
+
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
 {
 	const struct csc_adapter *cadapter = a;
@@ -692,6 +707,72 @@ void csc_adapter_unregister(struct btd_adapter *adapter)
 					CYCLINGSPEED_MANAGER_INTERFACE);
 }
 
+static gboolean property_get_location(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct csc *csc = data;
+	const char *loc;
+
+	if (!csc->has_location)
+		return FALSE;
+
+	loc = location2str(csc->location);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &loc);
+
+	return TRUE;
+}
+
+static gboolean property_exists_location(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct csc *csc = data;
+
+	return csc->has_location;
+}
+
+static gboolean property_exists_locations(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct csc *csc = data;
+
+	return !!(csc->feature & MULTI_SENSOR_LOC_SUPPORT);
+}
+
+static gboolean property_get_wheel_rev_sup(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct csc *csc = data;
+	dbus_bool_t val;
+
+	val = !!(csc->feature & WHEEL_REV_SUPPORT);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
+}
+
+static gboolean property_get_multi_loc_sup(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct csc *csc = data;
+	dbus_bool_t val;
+
+	val = !!(csc->feature & MULTI_SENSOR_LOC_SUPPORT);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable cyclingspeed_device_properties[] = {
+	{ "Location", "s", property_get_location, NULL,
+						property_exists_location },
+	{ "SupportedLocations", "as", NULL, NULL,
+						property_exists_locations },
+	{ "WheelRevolutionDataSupported", "b", property_get_wheel_rev_sup },
+	{ "MultipleLocationsSupported", "b", property_get_multi_loc_sup },
+	{ }
+};
+
 int csc_device_register(struct btd_device *device, struct gatt_primary *prim)
 {
 	struct btd_adapter *adapter;
@@ -708,6 +789,18 @@ int csc_device_register(struct btd_device *device, struct gatt_primary *prim)
 	csc->dev = btd_device_ref(device);
 	csc->cadapter = cadapter;
 
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+						device_get_path(device),
+						CYCLINGSPEED_INTERFACE,
+						NULL, NULL,
+						cyclingspeed_device_properties,
+						csc, destroy_csc)) {
+		error("D-Bus failed to register %s interface",
+						CYCLINGSPEED_INTERFACE);
+		destroy_csc(csc);
+		return -EIO;
+	}
+
 	csc->svc_range = g_new0(struct att_range, 1);
 	csc->svc_range->start = prim->range.start;
 	csc->svc_range->end = prim->range.end;
@@ -741,5 +834,6 @@ void csc_device_unregister(struct btd_device *device)
 
 	cadapter->devices = g_slist_remove(cadapter->devices, csc);
 
-	destroy_csc(csc);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+			device_get_path(device), CYCLINGSPEED_INTERFACE);
 }
-- 
1.8.0

