Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	marcel@holtmann.org,
	rshaffer@codeaurora.org,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 7/7] Add service UUIDs from EIR to device properties in "Device Found" signal.
Date: Fri,  6 Aug 2010 11:35:24 -0700
Message-Id: <1281119724-28882-1-git-send-email-ingas@codeaurora.org>
In-Reply-To: <20100806173042.GA28198@jh-x301>
References: <20100806173042.GA28198@jh-x301>
List-ID: <linux-bluetooth.vger.kernel.org>

If service UUIDs are present in EIR, they are written to
"device properties" dictionary  when emitting "Device Found" signal.
This allows peek at available services offered by a remote device
without establishing SDP connection.
---
 src/adapter.c  |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/adapter.h  |    4 +-
 src/dbus-hci.c |    6 ++--
 3 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c142a4a..5746cbc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2749,8 +2749,102 @@ static void emit_device_found(const char *path, const char *address,
 	g_dbus_send_message(connection, signal);
 }
 
+static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
+{
+	uint16_t len = 0;
+	char **uuids;
+	size_t total;
+	size_t uuid16_count = 0;
+	size_t uuid32_count = 0;
+	size_t uuid128_count = 0;
+	uint8_t *uuid16;
+	uint8_t *uuid32;
+	uint8_t *uuid128;
+	uuid_t service;
+	unsigned int i;
+
+	while (len < EIR_DATA_LENGTH - 1) {
+		uint8_t type = eir_data[1];
+		uint8_t field_len = eir_data[0];
+
+		/* Check for the end of EIR */
+		if (field_len == 0)
+			break;
+
+		switch (type) {
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
+	if (len > EIR_DATA_LENGTH)
+		return NULL;
+
+	total = uuid16_count + uuid32_count + uuid128_count;
+	*uuid_count = total;
+
+	if (!total)
+		return NULL;
+
+	uuids = g_new0(char *, total + 1);
+
+	/* Generate uuids in SDP format (EIR data is Little Endian) */
+	service.type = SDP_UUID16;
+	for (i = 0; i < uuid16_count; i++) {
+		uint16_t val16 = uuid16[1];
+
+		val16 = (val16 << 8) + uuid16[0];
+		service.value.uuid16 = val16;
+		uuids[i] = bt_uuid2string(&service);
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
+		uuids[i] = bt_uuid2string(&service);
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
+		uuids[i] = bt_uuid2string(&service);
+		uuid128 += 16;
+	}
+
+	return uuids;
+}
+
 void adapter_emit_device_found(struct btd_adapter *adapter,
-				struct remote_dev_info *dev)
+				struct remote_dev_info *dev, uint8_t *eir_data)
 {
 	struct btd_device *device;
 	char peer_addr[18], local_addr[18];
@@ -2758,6 +2852,8 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	dbus_bool_t paired = FALSE;
 	dbus_int16_t rssi = dev->rssi;
 	char *alias;
+	char **uuids = NULL;
+	size_t uuid_count = 0;
 
 	ba2str(&dev->bdaddr, peer_addr);
 	ba2str(&adapter->bdaddr, local_addr);
@@ -2777,6 +2873,10 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	} else
 		alias = g_strdup(dev->alias);
 
+	/* Extract UUIDs from extended inquiry response if any*/
+	if (eir_data != NULL)
+		uuids = get_eir_uuids(eir_data, &uuid_count);
+
 	emit_device_found(adapter->path, paddr,
 			"Address", DBUS_TYPE_STRING, &paddr,
 			"Class", DBUS_TYPE_UINT32, &dev->class,
@@ -2786,15 +2886,17 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 			"Alias", DBUS_TYPE_STRING, &alias,
 			"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
 			"Paired", DBUS_TYPE_BOOLEAN, &paired,
+			"UUIDs", DBUS_TYPE_ARRAY, &uuids, uuid_count,
 			NULL);
 
 	g_free(alias);
+	g_strfreev(uuids);
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
-				name_status_t name_status)
+				name_status_t name_status, uint8_t *eir_data)
 {
 	struct remote_dev_info *dev, match;
 
@@ -2833,7 +2935,7 @@ done:
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
 						(GCompareFunc) dev_rssi_cmp);
 
-	adapter_emit_device_found(adapter, dev);
+	adapter_emit_device_found(adapter, dev, eir_data);
 }
 
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
diff --git a/src/adapter.h b/src/adapter.h
index 8226514..a7eca0e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -113,10 +113,10 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
-				name_status_t name_status);
+				name_status_t name_status, uint8_t *eir_data);
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
-				struct remote_dev_info *dev);
+				struct remote_dev_info *dev, uint8_t *eir_data);
 void adapter_update_oor_devices(struct btd_adapter *adapter);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
 void adapter_setname_complete(bdaddr_t *local, uint8_t status);
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index b83506f..6d27caa 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -515,7 +515,7 @@ void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	if (dev) {
 		adapter_update_found_devices(adapter, peer, rssi, class,
 						NULL, NULL, dev->legacy,
-						NAME_NOT_REQUIRED);
+						NAME_NOT_REQUIRED, data);
 		return;
 	}
 
@@ -566,7 +566,7 @@ void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 
 	/* add in the list to track name sent/pending */
 	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
-					legacy, name_status);
+					legacy, name_status, data);
 
 	g_free(name);
 	g_free(alias);
@@ -642,7 +642,7 @@ void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status,
 	if (dev_info) {
 		g_free(dev_info->name);
 		dev_info->name = g_strdup(name);
-		adapter_emit_device_found(adapter, dev_info);
+		adapter_emit_device_found(adapter, dev_info, NULL);
 	}
 
 	if (device)
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
