Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] Add Vendor, Product and Version properties to org.bluez.Device
Date: Thu, 22 Sep 2011 18:51:49 +0300
Message-Id: <1316706712-17611-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This identifiers can be used by applications to implements quirks which
seems to be very common in some profiles such as syncml and since this
information is already stored permanently we can quickly retrieve it
without having to connect or parse the records again.
---
 doc/device-api.txt |   12 +++++++
 src/device.c       |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |    3 ++
 3 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index d1feb18..e8fc314 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -125,6 +125,18 @@ Properties	string Address [readonly]
 			The Bluetooth remote name. This value can not be
 			changed. Use the Alias property instead.
 
+		uint16 Vendor [readonly]
+
+			Vendor unique numeric identifier.
+
+		uint16 Product [readonly]
+
+			Product unique numeric identifier.
+
+		uint16 Version [readonly]
+
+			Version unique numeric identifier.
+
 		string Icon [readonly]
 
 			Proposed icon name according to the freedesktop.org
diff --git a/src/device.c b/src/device.c
index 4372a8d..698b232 100644
--- a/src/device.c
+++ b/src/device.c
@@ -121,6 +121,9 @@ struct btd_device {
 	gchar		*path;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
+	uint16_t	vendor;
+	uint16_t	product;
+	uint16_t	version;
 	struct btd_adapter	*adapter;
 	GSList		*uuids;
 	GSList		*services;		/* Primary services path */
@@ -325,6 +328,21 @@ static DBusMessage *get_properties(DBusConnection *conn,
 						DBUS_TYPE_STRING, &icon);
 	}
 
+	/* Vendor */
+	if (device->vendor)
+		dict_append_entry(&dict, "Vendor", DBUS_TYPE_UINT16,
+							&device->vendor);
+
+	/* Product */
+	if (device->product)
+		dict_append_entry(&dict, "Product", DBUS_TYPE_UINT16,
+							&device->product);
+
+	/* Version */
+	if (device->product)
+		dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16,
+							&device->version);
+
 	/* Paired */
 	boolean = device_is_paired(device);
 	dict_append_entry(&dict, "Paired", DBUS_TYPE_BOOLEAN, &boolean);
@@ -905,6 +923,45 @@ void device_remove_disconnect_watch(struct btd_device *device, guint id)
 	}
 }
 
+static void device_set_vendor(struct btd_device *device, uint16_t value)
+{
+	DBusConnection *conn = get_dbus_connection();
+
+	if (device->vendor == value)
+		return;
+
+	device->vendor = value;
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Vendor",
+				DBUS_TYPE_UINT16, &value);
+}
+
+static void device_set_product(struct btd_device *device, uint16_t value)
+{
+	DBusConnection *conn = get_dbus_connection();
+
+	if (device->product == value)
+		return;
+
+	device->product = value;
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Product",
+				DBUS_TYPE_UINT16, &value);
+}
+
+static void device_set_version(struct btd_device *device, uint16_t value)
+{
+	DBusConnection *conn = get_dbus_connection();
+
+	if (device->version == value)
+		return;
+
+	device->version = value;
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Version",
+				DBUS_TYPE_UINT16, &value);
+}
+
 struct btd_device *device_create(DBusConnection *conn,
 				struct btd_adapter *adapter,
 				const gchar *address, device_type_t type)
@@ -914,6 +971,7 @@ struct btd_device *device_create(DBusConnection *conn,
 	const gchar *adapter_path = adapter_get_path(adapter);
 	bdaddr_t src;
 	char srcaddr[18], alias[MAX_NAME_LENGTH + 1];
+	uint16_t vendor, product, version;
 
 	device = g_try_malloc0(sizeof(struct btd_device));
 	if (device == NULL)
@@ -951,6 +1009,13 @@ struct btd_device *device_create(DBusConnection *conn,
 		device_set_bonded(device, TRUE);
 	}
 
+	if (read_device_id(srcaddr, address, NULL, &vendor, &product, &version)
+									== 0) {
+		device_set_vendor(device, vendor);
+		device_set_product(device, product);
+		device_set_version(device, version);
+	}
+
 	return btd_device_ref(device);
 }
 
@@ -985,6 +1050,21 @@ device_type_t device_get_type(struct btd_device *device)
 	return device->type;
 }
 
+uint16_t btd_device_get_vendor(struct btd_device *device)
+{
+	return device->vendor;
+}
+
+uint16_t btd_device_get_product(struct btd_device *device)
+{
+	return device->product;
+}
+
+uint16_t btd_device_get_version(struct btd_device *device)
+{
+	return device->version;
+}
+
 static void device_remove_stored(struct btd_device *device)
 {
 	bdaddr_t src;
@@ -1312,12 +1392,18 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 			pdlist = sdp_data_get(rec, SDP_ATTR_VENDOR_ID);
 			vendor = pdlist ? pdlist->val.uint16 : 0x0000;
 
+			device_set_vendor(device, vendor);
+
 			pdlist = sdp_data_get(rec, SDP_ATTR_PRODUCT_ID);
 			product = pdlist ? pdlist->val.uint16 : 0x0000;
 
+			device_set_product(device, product);
+
 			pdlist = sdp_data_get(rec, SDP_ATTR_VERSION);
 			version = pdlist ? pdlist->val.uint16 : 0x0000;
 
+			device_set_version(device, version);
+
 			if (source || vendor || product || version)
 				store_device_id(srcaddr, dstaddr, source,
 						vendor, product, version);
diff --git a/src/device.h b/src/device.h
index b6349bc..2e17a83 100644
--- a/src/device.h
+++ b/src/device.h
@@ -46,6 +46,9 @@ struct btd_device *device_create(DBusConnection *conn,
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 device_type_t device_get_type(struct btd_device *device);
+uint16_t btd_device_get_vendor(struct btd_device *device);
+uint16_t btd_device_get_product(struct btd_device *device);
+uint16_t btd_device_get_version(struct btd_device *device);
 void device_remove(struct btd_device *device, gboolean remove_stored);
 gint device_address_cmp(struct btd_device *device, const gchar *address);
 int device_browse_primary(struct btd_device *device, DBusConnection *conn,
-- 
1.7.6.2

