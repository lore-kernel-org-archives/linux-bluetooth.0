Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 1/4] Move get_eir_uuids() from src/adapter.c to src/event.c
Date: Fri, 17 Dec 2010 10:57:21 -0400
Message-Id: <1292597844-17135-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo@openbossa.org>

Moving get_eir_uuids() to src/event.c removes the need to pass the raw
EIR data to higher layers. Now it is not necessary to pass the original
GSList of service UUIDs, because the list is concatenated (with
verification of duplicate entries) on adapter_update_device_from_info()
(for LE) and adapter_update_found_devices() (for BR/EDR).
---
 src/adapter.c |  145 +++++++++++---------------------------------------------
 src/adapter.h |    7 +--
 src/event.c   |  114 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 142 insertions(+), 124 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5118306..34bf24a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2696,117 +2696,8 @@ static char **strlist2array(GSList *list)
 	return array;
 }
 
-static GSList *get_eir_uuids(uint8_t *eir_data, size_t eir_length, GSList *list)
-{
-	uint16_t len = 0;
-	size_t total;
-	size_t uuid16_count = 0;
-	size_t uuid32_count = 0;
-	size_t uuid128_count = 0;
-	uint8_t *uuid16;
-	uint8_t *uuid32;
-	uint8_t *uuid128;
-	uuid_t service;
-	char *uuid_str;
-	unsigned int i;
-
-	if (eir_data == NULL || eir_length == 0)
-		return list;
-
-	while (len < eir_length - 1) {
-		uint8_t field_len = eir_data[0];
-
-		/* Check for the end of EIR */
-		if (field_len == 0)
-			break;
-
-		switch (eir_data[1]) {
-		case EIR_UUID16_SOME:
-		case EIR_UUID16_ALL:
-			uuid16_count = field_len / 2;
-			uuid16 = &eir_data[2];
-			break;
-		case EIR_UUID32_SOME:
-		case EIR_UUID32_ALL:
-			uuid32_count = field_len / 4;
-			uuid32 = &eir_data[2];
-			break;
-		case EIR_UUID128_SOME:
-		case EIR_UUID128_ALL:
-			uuid128_count = field_len / 16;
-			uuid128 = &eir_data[2];
-			break;
-		}
-
-		len += field_len + 1;
-		eir_data += field_len + 1;
-	}
-
-	/* Bail out if got incorrect length */
-	if (len > eir_length)
-		return list;
-
-	total = uuid16_count + uuid32_count + uuid128_count;
-
-	if (!total)
-		return list;
-
-	/* Generate uuids in SDP format (EIR data is Little Endian) */
-	service.type = SDP_UUID16;
-	for (i = 0; i < uuid16_count; i++) {
-		uint16_t val16 = uuid16[1];
-
-		val16 = (val16 << 8) + uuid16[0];
-		service.value.uuid16 = val16;
-		uuid_str = bt_uuid2string(&service);
-		if (g_slist_find_custom(list, uuid_str,
-						(GCompareFunc) strcmp) == NULL)
-			list = g_slist_append(list, uuid_str);
-		else
-			g_free(uuid_str);
-		uuid16 += 2;
-	}
-
-	service.type = SDP_UUID32;
-	for (i = uuid16_count; i < uuid32_count + uuid16_count; i++) {
-		uint32_t val32 = uuid32[3];
-		int k;
-
-		for (k = 2; k >= 0; k--)
-			val32 = (val32 << 8) + uuid32[k];
-
-		service.value.uuid32 = val32;
-		uuid_str = bt_uuid2string(&service);
-		if (g_slist_find_custom(list, uuid_str,
-						(GCompareFunc) strcmp) == NULL)
-			list = g_slist_append(list, uuid_str);
-		else
-			g_free(uuid_str);
-		uuid32 += 4;
-	}
-
-	service.type = SDP_UUID128;
-	for (i = uuid32_count + uuid16_count; i < total; i++) {
-		int k;
-
-		for (k = 0; k < 16; k++)
-			service.value.uuid128.data[k] = uuid128[16 - k - 1];
-
-		uuid_str = bt_uuid2string(&service);
-		if (g_slist_find_custom(list, uuid_str,
-						(GCompareFunc) strcmp) == NULL)
-			list = g_slist_append(list, uuid_str);
-		else
-			g_free(uuid_str);
-		uuid128 += 16;
-	}
-
-	return list;
-}
-
 void adapter_emit_device_found(struct btd_adapter *adapter,
-				struct remote_dev_info *dev,
-				uint8_t *eir_data, size_t eir_length)
+						struct remote_dev_info *dev)
 {
 	struct btd_device *device;
 	char peer_addr[18], local_addr[18];
@@ -2823,8 +2714,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	if (device)
 		paired = device_is_paired(device);
 
-	/* Extract UUIDs from extended inquiry response if any */
-	dev->services = get_eir_uuids(eir_data, eir_length, dev->services);
+	/* The uuids string array is updated only if necessary */
 	uuid_count = g_slist_length(dev->services);
 	if (dev->services && dev->uuid_count != uuid_count) {
 		g_strfreev(dev->uuids);
@@ -2911,8 +2801,25 @@ static gboolean extract_eir_flags(uint8_t *flags, uint8_t *eir_data)
 	return TRUE;
 }
 
+static void remove_same_uuid(gpointer data, gpointer user_data)
+{
+	struct remote_dev_info *dev = user_data;
+	GSList *l;
+
+	for (l = dev->services; l; l = l->next) {
+		char *current_uuid = l->data;
+		char *new_uuid = data;
+
+		if (strcmp(current_uuid, new_uuid) == 0) {
+			g_free(current_uuid);
+			dev->services = g_slist_delete_link(dev->services, l);
+			break;
+		}
+	}
+}
+
 void adapter_update_device_from_info(struct btd_adapter *adapter,
-						le_advertising_info *info)
+				le_advertising_info *info, GSList *services)
 {
 	struct remote_dev_info *dev;
 	bdaddr_t bdaddr;
@@ -2935,6 +2842,9 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
 						(GCompareFunc) dev_rssi_cmp);
 
+	g_slist_foreach(services, remove_same_uuid, dev);
+	dev->services = g_slist_concat(dev->services, services);
+
 	if (info->length) {
 		char *tmp_name = bt_extract_eir_name(info->data, NULL);
 		if (tmp_name) {
@@ -2947,13 +2857,13 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 
 	/* FIXME: check if other information was changed before emitting the
 	 * signal */
-	adapter_emit_device_found(adapter, dev, info->data, info->length);
+	adapter_emit_device_found(adapter, dev);
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
-				name_status_t name_status, uint8_t *eir_data)
+				GSList *services, name_status_t name_status)
 {
 	struct remote_dev_info *dev;
 	gboolean new_dev;
@@ -2979,7 +2889,10 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
 						(GCompareFunc) dev_rssi_cmp);
 
-	adapter_emit_device_found(adapter, dev, eir_data, EIR_DATA_LENGTH);
+	g_slist_foreach(services, remove_same_uuid, dev);
+	dev->services = g_slist_concat(dev->services, services);
+
+	adapter_emit_device_found(adapter, dev);
 }
 
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
diff --git a/src/adapter.h b/src/adapter.h
index a02f61c..efcf5b8 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -124,15 +124,14 @@ gboolean adapter_is_ready(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
 void adapter_update_device_from_info(struct btd_adapter *adapter,
-						le_advertising_info *info);
+				le_advertising_info *info, GSList *services);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
-				name_status_t name_status, uint8_t *eir_data);
+				GSList *services, name_status_t name_status);
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
-				struct remote_dev_info *dev,
-				uint8_t *eir_data, size_t eir_length);
+						struct remote_dev_info *dev);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
 void adapter_update_local_name(struct btd_adapter *adapter, const char *name);
 void adapter_service_insert(const bdaddr_t *bdaddr, void *rec);
diff --git a/src/event.c b/src/event.c
index 47b50c4..0e6c86f 100644
--- a/src/event.c
+++ b/src/event.c
@@ -56,6 +56,7 @@
 #include "agent.h"
 #include "storage.h"
 #include "event.h"
+#include "sdpd.h"
 
 static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
 					struct btd_adapter **adapter,
@@ -299,9 +300,107 @@ void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
+static GSList *get_eir_uuids(uint8_t *eir_data, size_t eir_length)
+{
+	uint16_t len = 0;
+	size_t total;
+	size_t uuid16_count = 0;
+	size_t uuid32_count = 0;
+	size_t uuid128_count = 0;
+	GSList *list = NULL;
+	uint8_t *uuid16 = NULL;
+	uint8_t *uuid32 = NULL;
+	uint8_t *uuid128 = NULL;
+	uuid_t service;
+	char *uuid_str;
+	unsigned int i;
+
+	if (eir_data == NULL || eir_length == 0)
+		return list;
+
+	while (len < eir_length - 1) {
+		uint8_t field_len = eir_data[0];
+
+		/* Check for the end of EIR */
+		if (field_len == 0)
+			break;
+
+		switch (eir_data[1]) {
+		case EIR_UUID16_SOME:
+		case EIR_UUID16_ALL:
+			uuid16_count = field_len / 2;
+			uuid16 = &eir_data[2];
+			break;
+		case EIR_UUID32_SOME:
+		case EIR_UUID32_ALL:
+			uuid32_count = field_len / 4;
+			uuid32 = &eir_data[2];
+			break;
+		case EIR_UUID128_SOME:
+		case EIR_UUID128_ALL:
+			uuid128_count = field_len / 16;
+			uuid128 = &eir_data[2];
+			break;
+		}
+
+		len += field_len + 1;
+		eir_data += field_len + 1;
+	}
+
+	/* Bail out if got incorrect length */
+	if (len > eir_length)
+		return list;
+
+	total = uuid16_count + uuid32_count + uuid128_count;
+
+	if (!total)
+		return list;
+
+	/* Generate uuids in SDP format (EIR data is Little Endian) */
+	service.type = SDP_UUID16;
+	for (i = 0; i < uuid16_count; i++) {
+		uint16_t val16 = uuid16[1];
+
+		val16 = (val16 << 8) + uuid16[0];
+		service.value.uuid16 = val16;
+		uuid_str = bt_uuid2string(&service);
+		list = g_slist_append(list, uuid_str);
+		uuid16 += 2;
+	}
+
+	service.type = SDP_UUID32;
+	for (i = uuid16_count; i < uuid32_count + uuid16_count; i++) {
+		uint32_t val32 = uuid32[3];
+		int k;
+
+		for (k = 2; k >= 0; k--)
+			val32 = (val32 << 8) + uuid32[k];
+
+		service.value.uuid32 = val32;
+		uuid_str = bt_uuid2string(&service);
+		list = g_slist_append(list, uuid_str);
+		uuid32 += 4;
+	}
+
+	service.type = SDP_UUID128;
+	for (i = uuid32_count + uuid16_count; i < total; i++) {
+		int k;
+
+		for (k = 0; k < 16; k++)
+			service.value.uuid128.data[k] = uuid128[16 - k - 1];
+
+		uuid_str = bt_uuid2string(&service);
+		list = g_slist_append(list, uuid_str);
+		uuid128 += 16;
+	}
+
+	return list;
+}
+
 void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 {
 	struct btd_adapter *adapter;
+	GSList *services = NULL;
 
 	adapter = manager_find_adapter(local);
 	if (adapter == NULL) {
@@ -309,7 +408,10 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 		return;
 	}
 
-	adapter_update_device_from_info(adapter, info);
+	/* Extract UUIDs from advertising data if any */
+	services = get_eir_uuids(info->data, info->length);
+
+	adapter_update_device_from_info(adapter, info, services);
 }
 
 void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
@@ -322,6 +424,7 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	struct remote_dev_info *dev, match;
 	uint8_t name_type = 0x00;
 	name_status_t name_status;
+	GSList *services = NULL;
 	int state;
 	dbus_bool_t legacy;
 	unsigned char features[8];
@@ -350,6 +453,9 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 		adapter_set_state(adapter, state);
 	}
 
+	/* Extract UUIDs from extended inquiry response if any */
+	services = get_eir_uuids(data, EIR_DATA_LENGTH);
+
 	memset(&match, 0, sizeof(struct remote_dev_info));
 	bacpy(&match.bdaddr, peer);
 	match.name_status = NAME_SENT;
@@ -358,7 +464,7 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	if (dev) {
 		adapter_update_found_devices(adapter, peer, rssi, class,
 						NULL, NULL, dev->legacy,
-						NAME_NOT_REQUIRED, data);
+						services, NAME_NOT_REQUIRED);
 		return;
 	}
 
@@ -410,7 +516,7 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 
 	/* add in the list to track name sent/pending */
 	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
-					legacy, name_status, data);
+						legacy, services, name_status);
 
 	g_free(name);
 	g_free(alias);
@@ -500,7 +606,7 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status,
 	if (dev_info) {
 		g_free(dev_info->name);
 		dev_info->name = g_strdup(name);
-		adapter_emit_device_found(adapter, dev_info, NULL, 0);
+		adapter_emit_device_found(adapter, dev_info);
 	}
 
 	if (device)
-- 
1.7.0.4

