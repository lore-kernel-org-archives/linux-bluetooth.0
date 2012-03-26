Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v2 5/5] DeviceInfo: Read PNP ID
Date: Mon, 26 Mar 2012 17:25:08 +0200
Message-Id: <1332775508-32693-6-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332775508-32693-1-git-send-email-chen.ganir@ti.com>
References: <1332775508-32693-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Read the PNP ID characteristic of the DeviceInfo Service, and
store it inside the btd_device, for use by other profiles.
---
 deviceinfo/deviceinfo.c |   38 ++++++++++++++++++++++++++++++++++++++
 src/device.c            |   33 +++++++++++++++++++++++++++++++++
 src/device.h            |    3 +++
 3 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index cc2b061..dffff60 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -90,6 +90,42 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
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
+		DBG("value read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, len, value, &vlen)) {
+		DBG("Protocol error\n");
+		return;
+	}
+
+	if (vlen < 7) {
+		DBG("Invalid deviceinfo received");
+		return;
+	}
+
+	device_set_pnpid(ch->d->dev,value[0],att_get_u16(&value[1]), att_get_u16(&value[3]),
+				att_get_u16(&value[5]));
+}
+
+static void process_deviceinfo_char(struct characteristic *ch)
+{
+	if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0) {
+		gatt_read_char(ch->d->attrib, ch->attr.value_handle, 0,
+							read_pnpid_cb, ch);
+		return;
+	}
+}
+
 static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
@@ -114,6 +150,8 @@ static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
 		ch->d = d;
 
 		d->chars = g_slist_append(d->chars, ch);
+
+		process_deviceinfo_char(ch);
 	}
 }
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
diff --git a/src/device.c b/src/device.c
index 3b772ee..dad8c26 100644
--- a/src/device.c
+++ b/src/device.c
@@ -131,6 +131,7 @@ struct btd_device {
 	gchar		*path;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
+	uint16_t	vendor_src;
 	uint16_t	vendor;
 	uint16_t	product;
 	uint16_t	version;
@@ -377,6 +378,11 @@ static DBusMessage *get_properties(DBusConnection *conn,
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
@@ -983,6 +989,19 @@ static void device_set_vendor(struct btd_device *device, uint16_t value)
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
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "VendorSource",
+				DBUS_TYPE_UINT16, &value);
+}
+
 static void device_set_product(struct btd_device *device, uint16_t value)
 {
 	DBusConnection *conn = get_dbus_connection();
@@ -1102,6 +1121,11 @@ uint16_t btd_device_get_vendor(struct btd_device *device)
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
@@ -2992,3 +3016,12 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	return TRUE;
 }
+
+void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
+					uint16_t vendor_id, uint16_t product_id, uint16_t product_ver)
+{
+	device_set_vendor(device, vendor_id);
+	device_set_vendor_src(device, vendor_id_src);
+	device_set_product(device, product_id);
+	device_set_version(device, product_ver);
+}
diff --git a/src/device.h b/src/device.h
index 7cb9bb2..c7973c5 100644
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
@@ -120,3 +121,5 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 						gboolean update_only);
 int device_unblock(DBusConnection *conn, struct btd_device *device,
 					gboolean silent, gboolean update_only);
+void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
+					uint16_t vendor_id, uint16_t product_id, uint16_t product_ver);
-- 
1.7.4.1

