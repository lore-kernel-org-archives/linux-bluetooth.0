Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 05/13] core: Add implementation of ManufacturerData
Date: Thu, 16 Apr 2015 17:41:07 +0300
Message-Id: <1429195275-19635-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
References: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds 'ManufacturerData' property to Device interface.
---
 src/adapter.c |  4 +++-
 src/device.c  | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |  1 +
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7ffd302..078a8d2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5470,8 +5470,10 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	device_add_eir_uuids(dev, eir_data.services);
 
-	if (eir_data.msd_list)
+	if (eir_data.msd_list) {
+		device_set_manufacturer_data(dev, eir_data.msd_list);
 		adapter_msd_notify(adapter, dev, eir_data.msd_list);
+	}
 
 	eir_data_free(&eir_data);
 
diff --git a/src/device.c b/src/device.c
index 7b4548e..9284b8f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -52,6 +52,7 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
+#include "src/shared/ad.h"
 #include "btio/btio.h"
 #include "lib/mgmt.h"
 #include "attrib/att.h"
@@ -73,6 +74,7 @@
 #include "textfile.h"
 #include "storage.h"
 #include "attrib-server.h"
+#include "eir.h"
 
 #define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
 
@@ -192,6 +194,7 @@ struct btd_device {
 	bool		svc_refreshed;
 	GSList		*svc_callbacks;
 	GSList		*eir_uuids;
+	struct bt_ad	*ad;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
 	uint32_t	class;
@@ -628,6 +631,8 @@ static void device_free(gpointer user_data)
 
 	gatt_db_unref(device->db);
 
+	bt_ad_unref(device->ad);
+
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
 					(sdp_free_func_t) sdp_record_free);
@@ -1088,6 +1093,46 @@ static gboolean dev_property_get_adapter(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void append_manufacturer_data(void *data, void *user_data)
+{
+	struct bt_ad_manufacturer_data *md = data;
+	DBusMessageIter *dict = user_data;
+
+	dict_append_basic_array(dict, DBUS_TYPE_UINT16, &md->manufacturer_id,
+				DBUS_TYPE_BYTE, &md->data, md->len);
+}
+
+static gboolean
+dev_property_get_manufacturer_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_UINT16_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	bt_ad_foreach_manufacturer_data(device->ad, append_manufacturer_data,
+									&dict);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
+static gboolean
+dev_property_manufacturer_data_exist(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	return bt_ad_has_manufacturer_data(device->ad, NULL);
+}
+
 static gboolean disconnect_all(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1418,6 +1463,24 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 						DEVICE_INTERFACE, "UUIDs");
 }
 
+static void add_manufacturer_data(void *data, void *user_data)
+{
+	struct eir_msd *msd = data;
+	struct btd_device *dev = user_data;
+
+	if (!bt_ad_add_manufacturer_data(dev->ad, msd->company, msd->data,
+								msd->data_len))
+		return;
+
+	g_dbus_emit_property_changed(dbus_conn, dev->path,
+					DEVICE_INTERFACE, "ManufacturerData");
+}
+
+void device_set_manufacturer_data(struct btd_device *dev, GSList *list)
+{
+	g_slist_foreach(list, add_manufacturer_data, dev);
+}
+
 static struct btd_service *find_connectable_service(struct btd_device *dev,
 							const char *uuid)
 {
@@ -2174,6 +2237,9 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
 						dev_property_exists_modalias },
 	{ "Adapter", "o", dev_property_get_adapter },
+	{ "ManufacturerData", "a{qv}", dev_property_get_manufacturer_data,
+				NULL, dev_property_manufacturer_data_exist,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -2921,6 +2987,12 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 		return NULL;
 	}
 
+	device->ad = bt_ad_new();
+	if (!device->ad) {
+		device_free(device);
+		return NULL;
+	}
+
 	address_up = g_ascii_strup(address, -1);
 	device->path = g_strdup_printf("%s/dev_%s", adapter_path, address_up);
 	g_strdelimit(device->path, ":", '_');
diff --git a/src/device.h b/src/device.h
index 9e86469..1378d0f 100644
--- a/src/device.h
+++ b/src/device.h
@@ -75,6 +75,7 @@ void btd_device_gatt_set_service_changed(struct btd_device *device,
 bool device_attach_att(struct btd_device *dev, GIOChannel *io);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
+void device_set_manufacturer_data(struct btd_device *dev, GSList *list);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
-- 
2.1.0

