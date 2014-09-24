Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCH] core: add D-Bus property for ServiceData
Date: Wed, 24 Sep 2014 15:57:42 -0700
Message-Id: <1411599462-8680-3-git-send-email-scott@netsplit.com>
In-Reply-To: <1411599462-8680-1-git-send-email-scott@netsplit.com>
References: <1411599462-8680-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the standard doesn't make any specific requirement that a UUID
present in a Service Data field be also present in a specific UUIDs
field, the UUIDs are also added to that list as well.
---
 doc/device-api.txt |  9 ++++++
 src/adapter.c      |  1 +
 src/device.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |  1 +
 src/eir.c          | 72 +++++++++++++++++++++++++++++++++++++++++++++
 src/eir.h          | 11 +++++++
 6 files changed, 179 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 4df6ec9..7d4813a 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -134,6 +134,15 @@ Properties	string Address [readonly]
 			List of 128-bit UUIDs that represents the available
 			remote services.
 
+		array{struct of data} ServiceData [readonly, optional]
+
+			List of service-specific data obtained from the device.
+			Each array member is a struct of string containing the
+			128-bit UUID of the service and an array of bytes
+			containing the service data.
+
+			Duplicate entries for a single service are permitted.
+
 		array{struct of data} ManufacturerData [readonly, optional]
 
 			List of manufacturer-specific data obtained from the
diff --git a/src/adapter.c b/src/adapter.c
index 037a3c3..15b4132 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4739,6 +4739,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 							eir_data.did_version);
 
 	device_add_eir_uuids(dev, eir_data.services);
+	device_set_eir_service_data(dev, eir_data.service_data);
 	device_set_eir_manufacturer_data(dev, eir_data.manufacturer_data);
 
 	eir_data_free(&eir_data);
diff --git a/src/device.c b/src/device.c
index 3e7a7b4..5df3117 100644
--- a/src/device.c
+++ b/src/device.c
@@ -175,6 +175,7 @@ struct btd_device {
 	bool		svc_refreshed;
 	GSList		*svc_callbacks;
 	GSList		*eir_uuids;
+	GSList		*eir_service_data;
 	GSList		*eir_manufacturer_data;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
@@ -517,6 +518,8 @@ static void device_free(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
+	g_slist_free_full(device->eir_service_data,
+				(GDestroyNotify)eir_service_data_free);
 	g_slist_free_full(device->eir_manufacturer_data,
 				(GDestroyNotify)eir_manufacturer_data_free);
 	g_slist_free_full(device->uuids, g_free);
@@ -974,6 +977,55 @@ static gboolean dev_property_get_uuids(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_exists_service_data(
+				const GDBusPropertyTable *property, void *data)
+{
+	struct btd_device *dev = data;
+
+	return dev->eir_service_data != NULL;
+}
+
+static gboolean dev_property_get_service_data(
+	const GDBusPropertyTable *property, DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+	DBusMessageIter entry;
+	GSList *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING
+			DBUS_TYPE_ARRAY_AS_STRING DBUS_TYPE_BYTE_AS_STRING
+			DBUS_STRUCT_END_CHAR_AS_STRING, &entry);
+
+	for (l = dev->eir_service_data; l != NULL; l = l->next) {
+		struct eir_service_data *service_data = l->data;
+		DBusMessageIter member, array;
+		char *uuid_str;
+
+		uuid_str = bt_uuid2string(&service_data->uuid);
+
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_STRUCT,
+							NULL, &member);
+		dbus_message_iter_append_basic(&member, DBUS_TYPE_STRING,
+								&uuid_str);
+
+		dbus_message_iter_open_container(&member, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+					&(service_data->data), service_data->len);
+		dbus_message_iter_close_container(&member, &array);
+
+		dbus_message_iter_close_container(&entry, &member);
+
+		g_free(uuid_str);
+	}
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static gboolean dev_property_exists_manufacturer_data(
 				const GDBusPropertyTable *property, void *data)
 {
@@ -1381,6 +1433,37 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 						DEVICE_INTERFACE, "UUIDs");
 }
 
+void device_set_eir_service_data(struct btd_device *dev, GSList *service_data)
+{
+	GSList *l;
+	bool changed = false;
+
+	if (dev->eir_service_data) {
+		g_slist_free_full(dev->eir_service_data,
+					(GDestroyNotify)eir_service_data_free);
+		dev->eir_service_data = NULL;
+		changed = true;
+	}
+
+	for (l = service_data; l != NULL; l = l->next) {
+		struct eir_service_data *data = l->data;
+		struct eir_service_data *new_data;
+
+		new_data = g_new0(struct eir_service_data, 1);
+		new_data->uuid = data->uuid;
+		new_data->data = g_memdup(data->data, data->len);
+		new_data->len = data->len;
+
+		dev->eir_service_data = g_slist_append(dev->eir_service_data,
+							       new_data);
+		changed = true;
+	}
+
+	if (changed)
+		g_dbus_emit_property_changed(dbus_conn, dev->path,
+					DEVICE_INTERFACE, "ServiceData");
+}
+
 void device_set_eir_manufacturer_data(struct btd_device *dev,
 						GSList *manufacturer_data)
 {
@@ -2064,6 +2147,8 @@ static const GDBusPropertyTable device_properties[] = {
 						dev_property_exists_tx_power },
 	{ "Connected", "b", dev_property_get_connected },
 	{ "UUIDs", "as", dev_property_get_uuids },
+	{ "ServiceData", "a(say)", dev_property_get_service_data, NULL,
+				       dev_property_exists_service_data },
 	{ "ManufacturerData", "a(qay)", dev_property_get_manufacturer_data,
 				NULL, dev_property_exists_manufacturer_data },
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
diff --git a/src/device.h b/src/device.h
index 783833a..e8bb7e8 100644
--- a/src/device.h
+++ b/src/device.h
@@ -72,6 +72,7 @@ void btd_device_gatt_set_service_changed(struct btd_device *device,
 bool device_attach_attrib(struct btd_device *dev, GIOChannel *io);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
+void device_set_eir_service_data(struct btd_device *dev, GSList *service_data);
 void device_set_eir_manufacturer_data(struct btd_device *dev,
 						GSList *manufacturer_data);
 void device_probe_profile(gpointer a, gpointer b);
diff --git a/src/eir.c b/src/eir.c
index d4594d6..d3e00ad 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -43,6 +43,12 @@
 
 #define EIR_OOB_MIN (2 + 6)
 
+void eir_service_data_free(struct eir_service_data *service_data)
+{
+	g_free(service_data->data);
+	service_data->data = NULL;
+}
+
 void eir_manufacturer_data_free(struct eir_manufacturer_data *manufacturer_data)
 {
 	g_free(manufacturer_data->data);
@@ -53,6 +59,9 @@ void eir_data_free(struct eir_data *eir)
 {
 	g_slist_free_full(eir->services, free);
 	eir->services = NULL;
+	g_slist_free_full(eir->service_data,
+				(GDestroyNotify)eir_service_data_free);
+	eir->service_data = NULL;
 	g_slist_free_full(eir->manufacturer_data,
 				(GDestroyNotify)eir_manufacturer_data_free);
 	eir->manufacturer_data = NULL;
@@ -123,6 +132,56 @@ static void eir_parse_uuid128(struct eir_data *eir, const uint8_t *data,
 	}
 }
 
+static void eir_parse_service_data(struct eir_data *eir, uint8_t type,
+					const uint8_t *data, uint8_t len)
+{
+	struct eir_service_data *service_data;
+	uuid_t service;
+	char *uuid_str;
+	int k;
+
+	service.type = type;
+	switch (service.type) {
+	case SDP_UUID16:
+		if (len < 2)
+			return;
+		service.value.uuid16 = get_le16(data);
+		data += 2;
+		len -= 2;
+		break;
+	case SDP_UUID32:
+		if (len < 4)
+			return;
+		service.value.uuid32 = get_le32(data);
+		data += 4;
+		len -= 4;
+		break;
+	case SDP_UUID128:
+		if (len < 16)
+			return;
+		for (k = 0; k < 16; k++)
+			service.value.uuid128.data[k] = data[16 - k - 1];
+		data += 16;
+		len -= 16;
+		break;
+	default:
+		/* Type of UUID unknown */
+		return;
+	}
+
+	uuid_str = bt_uuid2string(&service);
+	if (!uuid_str)
+		return;
+	eir->services = g_slist_append(eir->services, uuid_str);
+
+	service_data = g_new0(struct eir_service_data, 1);
+	service_data->uuid = service;
+	service_data->data = g_memdup(data, len);
+	service_data->len = len;
+
+	eir->service_data = g_slist_append(eir->service_data, service_data);
+}
+
 static void eir_parse_manufacturer_data(struct eir_data *eir,
 					const uint8_t *data, uint8_t len)
 {
@@ -267,6 +326,19 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir->did_version = data[6] | (data[7] << 8);
 			break;
 
+		case EIR_SERVICE_DATA_UUID16:
+			eir_parse_service_data(eir, SDP_UUID16, data, data_len);
+			break;
+
+		case EIR_SERVICE_DATA_UUID32:
+			eir_parse_service_data(eir, SDP_UUID32, data, data_len);
+			break;
+
+		case EIR_SERVICE_DATA_UUID128:
+			eir_parse_service_data(eir, SDP_UUID128,
+								data, data_len);
+			break;
+
 		case EIR_MANUFACTURER_DATA:
 			eir_parse_manufacturer_data(eir, data, data_len);
 			break;
diff --git a/src/eir.h b/src/eir.h
index 65ba18a..701f12d 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -36,6 +36,9 @@
 #define EIR_SSP_HASH                0x0E  /* SSP Hash */
 #define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
 #define EIR_DEVICE_ID               0x10  /* device ID */
+#define EIR_SERVICE_DATA_UUID16     0x16  /* 16-bit UUID with service data */
+#define EIR_SERVICE_DATA_UUID32     0x20  /* 32-bit UUID with service data */
+#define EIR_SERVICE_DATA_UUID128    0x21  /* 128-bit UUID with service data */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
 #define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer-specific data */
 
@@ -50,6 +53,7 @@
 
 struct eir_data {
 	GSList *services;
+	GSList *service_data;
 	GSList *manufacturer_data;
 	unsigned int flags;
 	char *name;
@@ -66,12 +70,19 @@ struct eir_data {
 	uint16_t did_source;
 };
 
+struct eir_service_data {
+	uuid_t uuid;
+	uint8_t *data;
+	uint8_t len;
+};
+
 struct eir_manufacturer_data {
 	uint16_t vendor;
 	uint8_t *data;
 	uint8_t len;
 };
 
+void eir_service_data_free(struct eir_service_data *service_data);
 void eir_manufacturer_data_free(struct eir_manufacturer_data *
 							manufacturer_data);
 void eir_data_free(struct eir_data *eir);
-- 
2.1.0.rc2.206.gedb03e5

