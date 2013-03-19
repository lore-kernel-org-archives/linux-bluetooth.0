Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@intel.com,
	marcel@holtmann.org, keybuk@chromium.org
Cc: Alex Deymo <deymo@chromium.org>
Subject: [PATCH] Expose HIDNormallyConnectable and HIDReconnectInitiate properties
Date: Mon, 18 Mar 2013 18:05:44 -0700
Message-Id: <1363655144-9705-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "Connectability" of a HID device, as defined by the HID spec,
governs the way the host may and should connect to a HID device or
expect a connection from it. In the comon case of mice and keyboards
the HIDNormallyConnectable is FALSE and HIDReconnectInitiate is TRUE,
since those devices only attempt a connection to the host when they
have some data to transfer. A connection attempt initiated from the
host after the device drops the connection (while still paired) will
result in a Page timeout.

This patch exposes these two HID properties as Device properties, updates
them every time new SDP records are available and persists them in the
device's info file. This patch also shows this information in the
bluetoothctl "info <dev>" command.
For non-HID devices and when no information is available (i.e. a cached
device after upgrade from a version without this patch) both properties
are set to the comon case: HIDNormallyConnectable is FALSE and
HIDReconnectInitiate is TRUE.
---

This patch is a rework of a previous patch named "Add GetCachedServices
to device API". This new attempt exposes only these two properties 
related to the "Connectability" of the device. 

 client/main.c      |   2 +
 doc/device-api.txt |  22 +++++++++++
 src/device.c       | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |   2 +
 4 files changed, 138 insertions(+)

diff --git a/client/main.c b/client/main.c
index 9a927a8..bc4be62 100644
--- a/client/main.c
+++ b/client/main.c
@@ -707,6 +707,8 @@ static void cmd_info(const char *arg)
 	print_property(proxy, "LegacyPairing");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
+	print_property(proxy, "HIDNormallyConnectable");
+	print_property(proxy, "HIDReconnectInitiate");
 }
 
 static void pair_reply(DBusMessage *message, void *user_data)
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 0f916c7..795845c 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -185,3 +185,25 @@ Properties	string Address [readonly]
 
 			Received Signal Strength Indicator of the remote
 			device.
+
+		boolean HIDNormallyConnectable [readonly]
+
+			For HID devices exposes the value of
+			HIDNormallyConnectable as defined by the HID profile
+			specification. If this optional value is not specified
+			by the HID device, the value is asumend as FALSE.
+
+			For devices not supporting the HID profile or if it is
+			unknown if the device supports the HID profile, this
+			property is set to FALSE. You must check the UUIDs
+			property to know if the device supports the HID profile.
+
+		boolean HIDConnectInitiate [readonly]
+
+			For HID devices exposes the value of HIDConnectInitiate
+			as defined by the HID profile specification.
+
+			For devices not supporting the HID profile or if it is
+			unknown if the device supports the HID profile, this
+			property is set to TRUE. You must check the UUIDs
+			property to know if the device supports the HID profile.
diff --git a/src/device.c b/src/device.c
index 3cd7f10..3064b8f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -196,6 +196,8 @@ struct btd_device {
 	gboolean	auto_connect;
 	gboolean	disable_auto_connect;
 	gboolean	general_connect;
+	gboolean	hid_normally_connectable;
+	gboolean	hid_reconnect_initiate;
 
 	bool		legacy;
 	int8_t		rssi;
@@ -228,6 +230,8 @@ static gboolean store_device_info_cb(gpointer user_data)
 	char class[9];
 	char **uuids = NULL;
 	gsize length = 0;
+	gboolean has_hid_records;
+	GSList *l;
 
 	device->store_id = 0;
 
@@ -297,6 +301,23 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_set_boolean(key_file, "General", "Blocked",
 							device->blocked);
 
+	has_hid_records = FALSE;
+	for (l = device->uuids; l && !has_hid_records; l = g_slist_next(l))
+		has_hid_records = strcmp(l->data, HID_UUID);
+
+	if (has_hid_records) {
+		g_key_file_set_boolean(key_file, "General",
+						"HIDNormallyConnectable",
+					device->hid_normally_connectable);
+		g_key_file_set_boolean(key_file, "General",
+			"HIDReconnectInitiate", device->hid_reconnect_initiate);
+	} else {
+		g_key_file_remove_key(key_file, "General",
+						"HIDNormallyConnectable", NULL);
+		g_key_file_remove_key(key_file, "General",
+						"HIDReconnectInitiate", NULL);
+	}
+
 	if (device->uuids) {
 		GSList *l;
 		int i;
@@ -870,6 +891,31 @@ static gboolean dev_property_get_adapter(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_hid_normally_connectable(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+					&device->hid_normally_connectable);
+
+	return TRUE;
+}
+
+static gboolean dev_property_get_hid_reconnect_initiate(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+					&device->hid_reconnect_initiate);
+
+	return TRUE;
+}
+
+
 static void profile_remove(gpointer data, gpointer user_data)
 {
 	struct btd_profile *profile = data;
@@ -1615,6 +1661,10 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
 						dev_property_exists_modalias },
 	{ "Adapter", "o", dev_property_get_adapter },
+	{ "HIDNormallyConnectable", "b",
+				dev_property_get_hid_normally_connectable },
+	{ "HIDReconnectInitiate", "b",
+				dev_property_get_hid_reconnect_initiate },
 	{ }
 };
 
@@ -1748,6 +1798,7 @@ static void load_info(struct btd_device *device, const char *local,
 	char **techno, **t;
 	gboolean bredr = FALSE;
 	gboolean le = FALSE;
+	GError *err = NULL;
 
 	/* Load device name from storage info file, if that fails fall back to
 	 * the cache.
@@ -1830,6 +1881,23 @@ next:
 	if (blocked)
 		device_block(device, FALSE);
 
+	/* Load HID connectivity properties */
+	device->hid_normally_connectable = g_key_file_get_boolean(key_file,
+				"General", "HIDNormallyConnectable", &err);
+	if (err) {
+		device->hid_normally_connectable = FALSE;
+		g_error_free(err);
+		err = NULL;
+	}
+
+	device->hid_reconnect_initiate = g_key_file_get_boolean(key_file,
+				"General", "HIDReconnectInitiate", &err);
+	if (err) {
+		device->hid_reconnect_initiate = TRUE;
+		g_error_free(err);
+		err = NULL;
+	}
+
 	/* Load device profile list */
 	uuids = g_key_file_get_string_list(key_file, "General", "Services",
 						NULL, NULL);
@@ -2045,6 +2113,11 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 		g_free(str);
 	}
 
+	/* In absense of futher information we expose the comon values for HID
+	 * devices. */
+	device->hid_normally_connectable = FALSE;
+	device->hid_reconnect_initiate = TRUE;
+
 	return device;
 }
 
@@ -2611,6 +2684,24 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 							product, version);
 		}
 
+		/* Extract HID connectability */
+		if (bt_uuid_strcmp(profile_uuid, HID_UUID) == 0) {
+			bool hid_nc, hid_ri;
+			sdp_data_t *pdlist;
+
+			/* HIDNormallyConnectable is optional and assumed FALSE
+			 * if not present. */
+			pdlist = sdp_data_get(rec,
+					SDP_ATTR_HID_NORMALLY_CONNECTABLE);
+			hid_nc = pdlist ? pdlist->val.uint8 : FALSE;
+
+			pdlist = sdp_data_get(rec,
+					SDP_ATTR_HID_RECONNECT_INITIATE);
+			hid_ri = pdlist ? pdlist->val.uint8 : TRUE;
+
+			btd_device_set_hid_props(device, hid_nc, hid_ri);
+		}
+
 		/* Check for duplicates */
 		if (sdp_list_find(req->records, rec, rec_cmp)) {
 			g_free(profile_uuid);
@@ -4281,6 +4372,27 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 	store_device_info(device);
 }
 
+void btd_device_set_hid_props(struct btd_device *device,
+		gboolean normally_connectable, gboolean reconnect_initiate)
+{
+	gboolean update_nc, update_ri;
+
+	update_nc = device->hid_normally_connectable != normally_connectable;
+	device->hid_normally_connectable = normally_connectable;
+	if (update_nc)
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+				DEVICE_INTERFACE, "HIDNormallyConnectable");
+
+	update_ri = device->hid_reconnect_initiate != reconnect_initiate;
+	device->hid_reconnect_initiate = reconnect_initiate;
+	if (update_ri)
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+				DEVICE_INTERFACE, "HIDReconnectInitiate");
+
+	if (update_nc || update_ri)
+		store_device_info(device);
+}
+
 void btd_device_init(void)
 {
 	dbus_conn = btd_get_dbus_connection();
diff --git a/src/device.h b/src/device.h
index d072015..1442e0a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -108,6 +108,8 @@ int device_unblock(struct btd_device *device, gboolean silent,
 							gboolean update_only);
 void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 			uint16_t vendor, uint16_t product, uint16_t version);
+void btd_device_set_hid_props(struct btd_device *device,
+		gboolean normally_connectable, gboolean reconnect_initiate);
 
 int device_connect_le(struct btd_device *dev);
 
-- 
1.8.1.3

