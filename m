Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/11] core: Add implementation of ServiceData
Date: Wed, 15 Apr 2015 14:44:27 +0300
Message-Id: <1429098268-9695-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
References: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds 'ServiceData' property to Device interface.
---
 src/device.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h |  1 +
 2 files changed, 66 insertions(+)

diff --git a/src/device.c b/src/device.c
index 9284b8f..3552999 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1133,6 +1133,47 @@ dev_property_manufacturer_data_exist(const GDBusPropertyTable *property,
 	return bt_ad_has_manufacturer_data(device->ad, NULL);
 }
 
+static void append_service_data(void *data, void *user_data)
+{
+	struct bt_ad_service_data *sd = data;
+	DBusMessageIter *dict = user_data;
+	char uuid_str[MAX_LEN_UUID_STR];
+
+	bt_uuid_to_string(&sd->uuid, uuid_str, sizeof(uuid_str));
+
+	dict_append_array(dict, uuid_str, DBUS_TYPE_BYTE, &sd->data, sd->len);
+}
+
+static gboolean
+dev_property_get_service_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	bt_ad_foreach_service_data(device->ad, append_service_data, &dict);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
+static gboolean
+dev_property_service_data_exist(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	return bt_ad_has_service_data(device->ad, NULL);
+}
+
 static gboolean disconnect_all(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1481,6 +1522,27 @@ void device_set_manufacturer_data(struct btd_device *dev, GSList *list)
 	g_slist_foreach(list, add_manufacturer_data, dev);
 }
 
+static void add_service_data(void *data, void *user_data)
+{
+	struct eir_sd *sd = data;
+	struct btd_device *dev = user_data;
+	bt_uuid_t uuid;
+
+	if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
+		return;
+
+	if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->data_len))
+		return;
+
+	g_dbus_emit_property_changed(dbus_conn, dev->path,
+					DEVICE_INTERFACE, "ServiceData");
+}
+
+void device_set_service_data(struct btd_device *dev, GSList *list)
+{
+	g_slist_foreach(list, add_service_data, dev);
+}
+
 static struct btd_service *find_connectable_service(struct btd_device *dev,
 							const char *uuid)
 {
@@ -2240,6 +2302,9 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "ManufacturerData", "a{qv}", dev_property_get_manufacturer_data,
 				NULL, dev_property_manufacturer_data_exist,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "ServiceData", "a{sv}", dev_property_get_service_data,
+				NULL, dev_property_service_data_exist,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
diff --git a/src/device.h b/src/device.h
index 1378d0f..b91916d 100644
--- a/src/device.h
+++ b/src/device.h
@@ -76,6 +76,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
 void device_set_manufacturer_data(struct btd_device *dev, GSList *list);
+void device_set_service_data(struct btd_device *dev, GSList *list);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
-- 
2.1.0

