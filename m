Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/9] device: Add implementation of AdvertisingData
Date: Wed,  2 May 2018 12:24:36 +0300
Message-Id: <20180502092442.10567-3-luiz.dentz@gmail.com>
In-Reply-To: <20180502092442.10567-1-luiz.dentz@gmail.com>
References: <20180502092442.10567-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the implementation of AdvertisingData property:

[CHG] Device 00:1B:DC:07:31:88 AdvertisingData Key: 0x26
[CHG] Device 00:1B:DC:07:31:88 AdvertisingData Value:
  01 01 00                                         ...
---
 src/adapter.c |  3 +++
 src/device.c  | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/device.h  |  2 ++
 src/eir.c     | 27 ++++++++++++++++++++++++
 src/eir.h     |  8 +++++++
 5 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 932b2a34d..c1c792aa3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6092,6 +6092,9 @@ static void update_found_devices(struct btd_adapter *adapter,
 	if (eir_data.sd_list)
 		device_set_service_data(dev, eir_data.sd_list, duplicate);
 
+	if (eir_data.data_list)
+		device_set_data(dev, eir_data.data_list, duplicate);
+
 	if (bdaddr_type != BDADDR_BREDR)
 		device_set_flags(dev, eir_data.flags);
 
diff --git a/src/device.c b/src/device.c
index f693b7023..38e23211f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1276,6 +1276,46 @@ dev_property_service_data_exist(const GDBusPropertyTable *property,
 	return bt_ad_has_service_data(device->ad, NULL);
 }
 
+static void append_advertising_data(void *data, void *user_data)
+{
+	struct bt_ad_data *ad = data;
+	DBusMessageIter *dict = user_data;
+
+	g_dbus_dict_append_basic_array(dict,
+				DBUS_TYPE_BYTE, &ad->type,
+				DBUS_TYPE_BYTE, &ad->data, ad->len);
+}
+
+static gboolean
+dev_property_get_advertising_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_BYTE_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	bt_ad_foreach_data(device->ad, append_advertising_data, &dict);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
+static gboolean
+dev_property_advertising_data_exist(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	return bt_ad_has_data(device->ad, NULL);
+}
+
 static gboolean disconnect_all(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1681,6 +1721,29 @@ void device_set_service_data(struct btd_device *dev, GSList *list,
 	g_slist_foreach(list, add_service_data, dev);
 }
 
+static void add_data(void *data, void *user_data)
+{
+	struct eir_ad *ad = data;
+	struct btd_device *dev = user_data;
+
+	if (!bt_ad_add_data(dev->ad, ad->type, ad->data, ad->len))
+		return;
+
+	if (ad->type == EIR_TRANSPORT_DISCOVERY)
+		g_dbus_emit_property_changed(dbus_conn, dev->path,
+						DEVICE_INTERFACE,
+						"AdvertisingData");
+}
+
+void device_set_data(struct btd_device *dev, GSList *list,
+							bool duplicate)
+{
+	if (duplicate)
+		bt_ad_clear_data(dev->ad);
+
+	g_slist_foreach(list, add_data, dev);
+}
+
 static struct btd_service *find_connectable_service(struct btd_device *dev,
 							const char *uuid)
 {
@@ -2673,7 +2736,9 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
 					dev_property_flags_exist,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
-
+	{ "AdvertisingData", "a{yv}", dev_property_get_advertising_data,
+				NULL, dev_property_advertising_data_exist,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
diff --git a/src/device.h b/src/device.h
index b90f9273a..06b100499 100644
--- a/src/device.h
+++ b/src/device.h
@@ -83,6 +83,8 @@ void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
 							bool duplicate);
 void device_set_service_data(struct btd_device *dev, GSList *list,
 							bool duplicate);
+void device_set_data(struct btd_device *dev, GSList *list,
+							bool duplicate);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
diff --git a/src/eir.c b/src/eir.c
index c984fa5a7..25d961dad 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -51,6 +51,14 @@ static void sd_free(void *data)
 	g_free(sd);
 }
 
+static void data_free(void *data)
+{
+	struct eir_ad *ad = data;
+
+	g_free(ad->data);
+	g_free(ad);
+}
+
 void eir_data_free(struct eir_data *eir)
 {
 	g_slist_free_full(eir->services, free);
@@ -65,6 +73,8 @@ void eir_data_free(struct eir_data *eir)
 	eir->msd_list = NULL;
 	g_slist_free_full(eir->sd_list, sd_free);
 	eir->sd_list = NULL;
+	g_slist_free_full(eir->data_list, data_free);
+	eir->data_list = NULL;
 }
 
 static void eir_parse_uuid16(struct eir_data *eir, const void *data,
@@ -226,6 +236,20 @@ static void eir_parse_uuid128_data(struct eir_data *eir, const uint8_t *data,
 	eir_parse_sd(eir, &service, data + 16, len - 16);
 }
 
+static void eir_parse_data(struct eir_data *eir, uint8_t type,
+					const uint8_t *data, uint8_t len)
+{
+	struct eir_ad *ad;
+
+	ad = g_malloc(sizeof(*ad));
+	ad->type = type;
+	ad->len = len;
+	ad->data = g_malloc(len);
+	memcpy(ad->data, data, len);
+
+	eir->data_list = g_slist_append(eir->data_list, ad);
+}
+
 void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 {
 	uint16_t len = 0;
@@ -346,6 +370,9 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir_parse_msd(eir, data, data_len);
 			break;
 
+		default:
+			eir_parse_data(eir, eir_data[1], data, data_len);
+			break;
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index 219ee794b..c868177a6 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -49,6 +49,7 @@
 #define EIR_SOLICIT32               0x1F  /* LE: Solicit UUIDs, 32-bit */
 #define EIR_SVC_DATA32              0x20  /* LE: Service data, 32-bit UUID */
 #define EIR_SVC_DATA128             0x21  /* LE: Service data, 128-bit UUID */
+#define EIR_TRANSPORT_DISCOVERY     0x26  /* Transport Discovery Service */
 #define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
 
 /* Flags Descriptions */
@@ -75,6 +76,12 @@ struct eir_sd {
 	uint8_t data_len;
 };
 
+struct eir_ad {
+	uint8_t type;
+	uint8_t len;
+	void *data;
+};
+
 struct eir_data {
 	GSList *services;
 	unsigned int flags;
@@ -92,6 +99,7 @@ struct eir_data {
 	uint16_t did_source;
 	GSList *msd_list;
 	GSList *sd_list;
+	GSList *data_list;
 };
 
 void eir_data_free(struct eir_data *eir);
-- 
2.14.3

