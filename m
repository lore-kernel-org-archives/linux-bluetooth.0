Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCH] core: add D-Bus property for ManufacturerData
Date: Wed, 24 Sep 2014 15:57:41 -0700
Message-Id: <1411599462-8680-2-git-send-email-scott@netsplit.com>
In-Reply-To: <1411599462-8680-1-git-send-email-scott@netsplit.com>
References: <1411599462-8680-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/device-api.txt | 10 +++++++
 src/adapter.c      |  1 +
 src/device.c       | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |  2 ++
 src/eir.c          | 30 ++++++++++++++++++++
 src/eir.h          | 10 +++++++
 6 files changed, 135 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 68388e9..4df6ec9 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -134,6 +134,16 @@ Properties	string Address [readonly]
 			List of 128-bit UUIDs that represents the available
 			remote services.
 
+		array{struct of data} ManufacturerData [readonly, optional]
+
+			List of manufacturer-specific data obtained from the
+			device. Each array member is a struct of uint16
+			containing the vendor identifier and an array of bytes
+			containing the manufacturer data.
+
+			Duplicate entries for a single manufacturer are
+			permitted.
+
 		boolean Paired [readonly]
 
 			Indicates if the remote device is paired.
diff --git a/src/adapter.c b/src/adapter.c
index 1b44dc5..037a3c3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4739,6 +4739,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 							eir_data.did_version);
 
 	device_add_eir_uuids(dev, eir_data.services);
+	device_set_eir_manufacturer_data(dev, eir_data.manufacturer_data);
 
 	eir_data_free(&eir_data);
 
diff --git a/src/device.c b/src/device.c
index d4ebf4f..3e7a7b4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -66,6 +66,7 @@
 #include "textfile.h"
 #include "storage.h"
 #include "attrib-server.h"
+#include "eir.h"
 
 #define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
 
@@ -174,6 +175,7 @@ struct btd_device {
 	bool		svc_refreshed;
 	GSList		*svc_callbacks;
 	GSList		*eir_uuids;
+	GSList		*eir_manufacturer_data;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
 	uint32_t	class;
@@ -515,6 +517,8 @@ static void device_free(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
+	g_slist_free_full(device->eir_manufacturer_data,
+				(GDestroyNotify)eir_manufacturer_data_free);
 	g_slist_free_full(device->uuids, g_free);
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
@@ -970,6 +974,50 @@ static gboolean dev_property_get_uuids(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_exists_manufacturer_data(
+				const GDBusPropertyTable *property, void *data)
+{
+	struct btd_device *dev = data;
+
+	return dev->eir_manufacturer_data != NULL;
+}
+
+static gboolean dev_property_get_manufacturer_data(
+	const GDBusPropertyTable *property, DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+	DBusMessageIter entry;
+	GSList *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_UINT16_AS_STRING
+			DBUS_TYPE_ARRAY_AS_STRING DBUS_TYPE_BYTE_AS_STRING
+			DBUS_STRUCT_END_CHAR_AS_STRING, &entry);
+
+	for (l = dev->eir_manufacturer_data; l != NULL; l = l->next) {
+		struct eir_manufacturer_data *manufacturer_data = l->data;
+		DBusMessageIter member, array;
+
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_STRUCT,
+							NULL, &member);
+		dbus_message_iter_append_basic(&member, DBUS_TYPE_UINT16,
+						&manufacturer_data->vendor);
+
+		dbus_message_iter_open_container(&member, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+			&manufacturer_data->data, manufacturer_data->len);
+		dbus_message_iter_close_container(&member, &array);
+
+		dbus_message_iter_close_container(&entry, &member);
+	}
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static gboolean dev_property_get_modalias(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1333,6 +1381,38 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 						DEVICE_INTERFACE, "UUIDs");
 }
 
+void device_set_eir_manufacturer_data(struct btd_device *dev,
+						GSList *manufacturer_data)
+{
+	GSList *l;
+	bool changed = false;
+
+	if (dev->eir_service_data) {
+		g_slist_free_full(dev->eir_manufacturer_data,
+				(GDestroyNotify)eir_manufacturer_data_free);
+		dev->eir_manufacturer_data = NULL;
+		changed = true;
+	}
+
+	for (l = manufacturer_data; l != NULL; l = l->next) {
+		struct eir_manufacturer_data *data = l->data;
+		struct eir_manufacturer_data *new_data;
+
+		new_data = g_new0(struct eir_manufacturer_data, 1);
+		new_data->vendor = data->vendor;
+		new_data->data = g_memdup(data->data, data->len);
+		new_data->len = data->len;
+
+		dev->eir_manufacturer_data = g_slist_append(
+				dev->eir_manufacturer_data, new_data);
+		changed = true;
+	}
+
+	if (changed)
+		g_dbus_emit_property_changed(dbus_conn, dev->path,
+					DEVICE_INTERFACE, "ManufacturerData");
+}
+
 static struct btd_service *find_connectable_service(struct btd_device *dev,
 							const char *uuid)
 {
@@ -1984,6 +2064,8 @@ static const GDBusPropertyTable device_properties[] = {
 						dev_property_exists_tx_power },
 	{ "Connected", "b", dev_property_get_connected },
 	{ "UUIDs", "as", dev_property_get_uuids },
+	{ "ManufacturerData", "a(qay)", dev_property_get_manufacturer_data,
+				NULL, dev_property_exists_manufacturer_data },
 	{ "Modalias", "s", dev_property_get_modalias, NULL,
 						dev_property_exists_modalias },
 	{ "Adapter", "o", dev_property_get_adapter },
diff --git a/src/device.h b/src/device.h
index b568593..783833a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -72,6 +72,8 @@ void btd_device_gatt_set_service_changed(struct btd_device *device,
 bool device_attach_attrib(struct btd_device *dev, GIOChannel *io);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
+void device_set_eir_manufacturer_data(struct btd_device *dev,
+						GSList *manufacturer_data);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
diff --git a/src/eir.c b/src/eir.c
index d22ad91..d4594d6 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -43,10 +43,19 @@
 
 #define EIR_OOB_MIN (2 + 6)
 
+void eir_manufacturer_data_free(struct eir_manufacturer_data *manufacturer_data)
+{
+	g_free(manufacturer_data->data);
+	manufacturer_data->data = NULL;
+}
+
 void eir_data_free(struct eir_data *eir)
 {
 	g_slist_free_full(eir->services, free);
 	eir->services = NULL;
+	g_slist_free_full(eir->manufacturer_data,
+				(GDestroyNotify)eir_manufacturer_data_free);
+	eir->manufacturer_data = NULL;
 	g_free(eir->name);
 	eir->name = NULL;
 	g_free(eir->hash);
@@ -114,6 +123,23 @@ static void eir_parse_uuid128(struct eir_data *eir, const uint8_t *data,
 	}
 }
 
+static void eir_parse_manufacturer_data(struct eir_data *eir,
+					const uint8_t *data, uint8_t len)
+{
+	struct eir_manufacturer_data *manufacturer_data;
+
+	if (len < 2)
+		return;
+
+	manufacturer_data = g_new0(struct eir_manufacturer_data, 1);
+	manufacturer_data->vendor = get_le16(data);
+	manufacturer_data->data = g_memdup(data + 2, len - 2);
+	manufacturer_data->len = len - 2;
+
+	eir->manufacturer_data = g_slist_append(eir->manufacturer_data,
+							manufacturer_data);
+}
+
 static char *name2utf8(const uint8_t *name, uint8_t len)
 {
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
@@ -240,6 +266,10 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir->did_product = data[4] | (data[5] << 8);
 			eir->did_version = data[6] | (data[7] << 8);
 			break;
+
+		case EIR_MANUFACTURER_DATA:
+			eir_parse_manufacturer_data(eir, data, data_len);
+			break;
 		}
 
 		eir_data += field_len + 1;
diff --git a/src/eir.h b/src/eir.h
index e486fa2..65ba18a 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -37,6 +37,7 @@
 #define EIR_SSP_RANDOMIZER          0x0F  /* SSP Randomizer */
 #define EIR_DEVICE_ID               0x10  /* device ID */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
+#define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer-specific data */
 
 /* Flags Descriptions */
 #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
@@ -49,6 +50,7 @@
 
 struct eir_data {
 	GSList *services;
+	GSList *manufacturer_data;
 	unsigned int flags;
 	char *name;
 	uint32_t class;
@@ -64,6 +66,14 @@ struct eir_data {
 	uint16_t did_source;
 };
 
+struct eir_manufacturer_data {
+	uint16_t vendor;
+	uint8_t *data;
+	uint8_t len;
+};
+
+void eir_manufacturer_data_free(struct eir_manufacturer_data *
+							manufacturer_data);
 void eir_data_free(struct eir_data *eir);
 void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len);
 int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len);
-- 
2.1.0.rc2.206.gedb03e5

