Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v6 4/4] DeviceInfo: Read PNP ID
Date: Wed,  4 Apr 2012 11:28:57 +0300
Message-Id: <1333528137-9305-5-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1333528137-9305-1-git-send-email-chen.ganir@ti.com>
References: <1333528137-9305-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Read the PNP ID characteristic of the DeviceInfo Service, and
store it inside the btd_device, for use by other profiles.
---
 deviceinfo/deviceinfo.c |   35 +++++++++++++++++++++++++++++++++++
 doc/device-api.txt      |    4 ++++
 src/device.c            |   34 ++++++++++++++++++++++++++++++++++
 src/device.h            |    4 ++++
 4 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index 8e4e8cb..e9fcd04 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -81,6 +81,39 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	uint8_t value[ATT_MAX_MTU];
+	int vlen;
+
+	if (status != 0) {
+		error("Error reading PNP_ID value: %s", att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, len, value, &vlen)) {
+		error("Error reading PNP_ID: Protocol error");
+		return;
+	}
+
+	if (vlen < 7) {
+		error("Error reading PNP_ID: Invalid pdu length received");
+		return;
+	}
+
+	device_set_pnpid(ch->d->dev,value[0],att_get_u16(&value[1]),
+				att_get_u16(&value[3]),	att_get_u16(&value[5]));
+}
+
+static void process_deviceinfo_char(struct characteristic *ch)
+{
+	if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0)
+		gatt_read_char(ch->d->attrib, ch->attr.value_handle, 0,
+							read_pnpid_cb, ch);
+}
+
 static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
@@ -105,6 +138,8 @@ static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
 		ch->d = d;
 
 		d->chars = g_slist_append(d->chars, ch);
+
+		process_deviceinfo_char(ch);
 	}
 }
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
diff --git a/doc/device-api.txt b/doc/device-api.txt
index e8fc314..6c1a3c7 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -129,6 +129,10 @@ Properties	string Address [readonly]
 
 			Vendor unique numeric identifier.
 
+	    uint16 VendorSource [readonly]
+
+	        Vendor source numeric identifier.
+
 		uint16 Product [readonly]
 
 			Product unique numeric identifier.
diff --git a/src/device.c b/src/device.c
index 48b693c..df3fbac 100644
--- a/src/device.c
+++ b/src/device.c
@@ -134,6 +134,7 @@ struct btd_device {
 	gchar		*path;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
+	uint16_t	vendor_src;
 	uint16_t	vendor;
 	uint16_t	product;
 	uint16_t	version;
@@ -381,6 +382,11 @@ static DBusMessage *get_properties(DBusConnection *conn,
 		dict_append_entry(&dict, "Vendor", DBUS_TYPE_UINT16,
 							&device->vendor);
 
+	/* Vendor Source*/
+	if (device->vendor_src)
+		dict_append_entry(&dict, "VendorSource", DBUS_TYPE_UINT16,
+							&device->vendor_src);
+
 	/* Product */
 	if (device->product)
 		dict_append_entry(&dict, "Product", DBUS_TYPE_UINT16,
@@ -987,6 +993,19 @@ static void device_set_vendor(struct btd_device *device, uint16_t value)
 				DBUS_TYPE_UINT16, &value);
 }
 
+static void device_set_vendor_src(struct btd_device *device, uint16_t value)
+{
+	DBusConnection *conn = get_dbus_connection();
+
+	if (device->vendor_src == value)
+		return;
+
+	device->vendor_src = value;
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE,
+				"VendorSource",	DBUS_TYPE_UINT16, &value);
+}
+
 static void device_set_product(struct btd_device *device, uint16_t value)
 {
 	DBusConnection *conn = get_dbus_connection();
@@ -1106,6 +1125,11 @@ uint16_t btd_device_get_vendor(struct btd_device *device)
 	return device->vendor;
 }
 
+uint16_t btd_device_get_vendor_src(struct btd_device *device)
+{
+	return device->vendor_src;
+}
+
 uint16_t btd_device_get_product(struct btd_device *device)
 {
 	return device->product;
@@ -3048,3 +3072,13 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	return TRUE;
 }
+
+void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
+			uint16_t vendor_id, uint16_t product_id,
+			uint16_t product_ver)
+{
+	device_set_vendor(device, vendor_id);
+	device_set_vendor_src(device, vendor_id_src);
+	device_set_product(device, product_id);
+	device_set_version(device, product_ver);
+}
diff --git a/src/device.h b/src/device.h
index 7cb9bb2..f3d6c70 100644
--- a/src/device.h
+++ b/src/device.h
@@ -39,6 +39,7 @@ struct btd_device *device_create(DBusConnection *conn,
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 uint16_t btd_device_get_vendor(struct btd_device *device);
+uint16_t btd_device_get_vendor_src(struct btd_device *device);
 uint16_t btd_device_get_product(struct btd_device *device);
 uint16_t btd_device_get_version(struct btd_device *device);
 void device_remove(struct btd_device *device, gboolean remove_stored);
@@ -120,3 +121,6 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 						gboolean update_only);
 int device_unblock(DBusConnection *conn, struct btd_device *device,
 					gboolean silent, gboolean update_only);
+void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
+			uint16_t vendor_id, uint16_t product_id,
+			uint16_t product_ver);
-- 
1.7.4.1

