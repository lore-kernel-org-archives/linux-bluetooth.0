Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 2/4] Modify get_eir_uuids() to parse other EIR data
Date: Fri, 17 Dec 2010 10:57:22 -0400
Message-Id: <1292597844-17135-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1292597844-17135-1-git-send-email-bruna.moreira@openbossa.org>
References: <1292597844-17135-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo@openbossa.org>

Currently, EIR parsing (name, UUIDs, flags etc.) is done in various
places. This leads to duplicated checks and does not support parsing
multiple AD/EIR structures on a single transfer.

These changes modify get_eir_uuids() to parse other EIR data types and
avoid passing raw EIR data to higher layers.

To accomplish this, get_eir_uuids() was renamed to parse_eir_data(), and
a new (internal) "struct eir_data" was introduced to store the parsed
data.

This first commit only handles the services UUIDs, following patches
will move other EIR parsing to it until everything is done inside
parse_eir_data().
---
 src/event.c |   49 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/src/event.c b/src/event.c
index 0e6c86f..3352717 100644
--- a/src/event.c
+++ b/src/event.c
@@ -58,6 +58,10 @@
 #include "event.h"
 #include "sdpd.h"
 
+struct eir_data {
+	GSList *services;
+};
+
 static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
 					struct btd_adapter **adapter,
 					struct btd_device **device,
@@ -300,14 +304,14 @@ void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-static GSList *get_eir_uuids(uint8_t *eir_data, size_t eir_length)
+static int parse_eir_data(struct eir_data *eir, uint8_t *eir_data,
+							size_t eir_length)
 {
 	uint16_t len = 0;
 	size_t total;
 	size_t uuid16_count = 0;
 	size_t uuid32_count = 0;
 	size_t uuid128_count = 0;
-	GSList *list = NULL;
 	uint8_t *uuid16 = NULL;
 	uint8_t *uuid32 = NULL;
 	uint8_t *uuid128 = NULL;
@@ -315,8 +319,9 @@ static GSList *get_eir_uuids(uint8_t *eir_data, size_t eir_length)
 	char *uuid_str;
 	unsigned int i;
 
+	/* No EIR data to parse */
 	if (eir_data == NULL || eir_length == 0)
-		return list;
+		return 0;
 
 	while (len < eir_length - 1) {
 		uint8_t field_len = eir_data[0];
@@ -349,12 +354,13 @@ static GSList *get_eir_uuids(uint8_t *eir_data, size_t eir_length)
 
 	/* Bail out if got incorrect length */
 	if (len > eir_length)
-		return list;
+		return -EINVAL;
 
 	total = uuid16_count + uuid32_count + uuid128_count;
 
+	/* No UUIDs were parsed, so skip code below */
 	if (!total)
-		return list;
+		return 0;
 
 	/* Generate uuids in SDP format (EIR data is Little Endian) */
 	service.type = SDP_UUID16;
@@ -364,7 +370,7 @@ static GSList *get_eir_uuids(uint8_t *eir_data, size_t eir_length)
 		val16 = (val16 << 8) + uuid16[0];
 		service.value.uuid16 = val16;
 		uuid_str = bt_uuid2string(&service);
-		list = g_slist_append(list, uuid_str);
+		eir->services = g_slist_append(eir->services, uuid_str);
 		uuid16 += 2;
 	}
 
@@ -378,7 +384,7 @@ static GSList *get_eir_uuids(uint8_t *eir_data, size_t eir_length)
 
 		service.value.uuid32 = val32;
 		uuid_str = bt_uuid2string(&service);
-		list = g_slist_append(list, uuid_str);
+		eir->services = g_slist_append(eir->services, uuid_str);
 		uuid32 += 4;
 	}
 
@@ -390,17 +396,18 @@ static GSList *get_eir_uuids(uint8_t *eir_data, size_t eir_length)
 			service.value.uuid128.data[k] = uuid128[16 - k - 1];
 
 		uuid_str = bt_uuid2string(&service);
-		list = g_slist_append(list, uuid_str);
+		eir->services = g_slist_append(eir->services, uuid_str);
 		uuid128 += 16;
 	}
 
-	return list;
+	return 0;
 }
 
 void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 {
 	struct btd_adapter *adapter;
-	GSList *services = NULL;
+	struct eir_data eir_data;
+	int err;
 
 	adapter = manager_find_adapter(local);
 	if (adapter == NULL) {
@@ -409,9 +416,13 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 	}
 
 	/* Extract UUIDs from advertising data if any */
-	services = get_eir_uuids(info->data, info->length);
+	memset(&eir_data, 0, sizeof(eir_data));
+	err = parse_eir_data(&eir_data, info->data, info->length);
+	if (err < 0)
+		error("Error parsing advertising data: %s (%d)",
+							strerror(-err), -err);
 
-	adapter_update_device_from_info(adapter, info, services);
+	adapter_update_device_from_info(adapter, info, eir_data.services);
 }
 
 void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
@@ -424,8 +435,8 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	struct remote_dev_info *dev, match;
 	uint8_t name_type = 0x00;
 	name_status_t name_status;
-	GSList *services = NULL;
-	int state;
+	struct eir_data eir_data;
+	int state, err;
 	dbus_bool_t legacy;
 	unsigned char features[8];
 
@@ -454,7 +465,10 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	}
 
 	/* Extract UUIDs from extended inquiry response if any */
-	services = get_eir_uuids(data, EIR_DATA_LENGTH);
+	memset(&eir_data, 0, sizeof(eir_data));
+	err = parse_eir_data(&eir_data, data, EIR_DATA_LENGTH);
+	if (err < 0)
+		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
 
 	memset(&match, 0, sizeof(struct remote_dev_info));
 	bacpy(&match.bdaddr, peer);
@@ -464,7 +478,8 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	if (dev) {
 		adapter_update_found_devices(adapter, peer, rssi, class,
 						NULL, NULL, dev->legacy,
-						services, NAME_NOT_REQUIRED);
+						eir_data.services,
+						NAME_NOT_REQUIRED);
 		return;
 	}
 
@@ -516,7 +531,7 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 
 	/* add in the list to track name sent/pending */
 	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
-						legacy, services, name_status);
+					legacy, eir_data.services, name_status);
 
 	g_free(name);
 	g_free(alias);
-- 
1.7.0.4

