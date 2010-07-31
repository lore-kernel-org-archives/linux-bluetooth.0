Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 6/6] Support for generating dictionary value of service UUIDs.
Date: Sat, 31 Jul 2010 04:45:12 -0700
Message-Id: <1280576713-1398-7-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
References: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add service UUIDs from EIR to device properties in "Device Found" signal.
---
 src/adapter.c  |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/adapter.h  |    4 +-
 src/dbus-hci.c |    6 ++--
 3 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2560440..b353fa6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2748,8 +2748,84 @@ static void emit_device_found(const char *path, const char *address,
 	g_dbus_send_message(connection, signal);
 }
 
+static int get_uuid_count_eir(uint8_t *eir_data)
+{
+	uint8_t len = 0;
+	int count = 0;
+
+	while (len < EIR_DATA_LENGTH) {
+		uint8_t type = eir_data[1];
+		uint8_t field_len = eir_data[0];
+		if (type == EIR_UUID16_SOME || type == EIR_UUID16_ALL)
+			count += field_len/2;
+		else if (type == EIR_UUID32_SOME || type == EIR_UUID32_ALL)
+			count += field_len/4;
+		else if (type == EIR_UUID128_SOME || type == EIR_UUID128_ALL)
+			count += field_len/16;
+		len += field_len + 1;
+		eir_data += field_len + 1;
+	}
+
+	return count;
+}
+
+static void get_uuids_eir(char **uuids, uint8_t *eir_data)
+{
+	uint8_t len = 0;
+
+	/* Count UUID16, UUID32 and UUID128 */
+	while (len < EIR_DATA_LENGTH) {
+		uint8_t field_len = eir_data[0];
+		uint8_t type = eir_data[1];
+		int count;
+		uuid_t service;
+		int size;
+		uint8_t *data = &eir_data[2];
+		int i, k;
+
+		/* Generate uuids in SDP format (EIR data is Little Endian) */
+		if (type == EIR_UUID16_SOME || type == EIR_UUID16_ALL) {
+			size = 2;
+			count = field_len/size;
+			service.type = SDP_UUID16;
+			for (i = 0; i < count; i++) {
+				uint16_t val16 = data[1];
+				val16 = (val16<<8) + data[0];
+				service.value.uuid16 = val16;
+				*uuids++ = bt_uuid2string(&service);
+				data += size;
+			}
+		} else if (type == EIR_UUID32_SOME || type == EIR_UUID32_ALL) {
+			size = 4;
+			count = field_len/size;
+			service.type = SDP_UUID32;
+			for (i = 0; i < count; i++) {
+				uint32_t val32 = data[3];
+				for (k = size-2; k >= 0; k--)
+					val32 = (val32<<8) + data[k];
+				service.value.uuid32 = val32;
+				*uuids++ = bt_uuid2string(&service);
+				data += size;
+			}
+		} else if (type == EIR_UUID128_SOME || type == EIR_UUID128_ALL) {
+			size = 16;
+			count = field_len/size;
+			service.type = SDP_UUID128;
+			for (i = 0; i < count; i++) {
+				for (k = 0; k < size; k++)
+					service.value.uuid128.data[k] = data[size-k-1];
+				*uuids++ = bt_uuid2string(&service);
+				data += size;
+			}
+		}
+
+		len += field_len + 1;
+		eir_data += field_len + 1;
+	}
+}
+
 void adapter_emit_device_found(struct btd_adapter *adapter,
-				struct remote_dev_info *dev)
+				struct remote_dev_info *dev, uint8_t *eir_data)
 {
 	struct btd_device *device;
 	char peer_addr[18], local_addr[18];
@@ -2757,6 +2833,8 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	dbus_bool_t paired = FALSE;
 	dbus_int16_t rssi = dev->rssi;
 	char *alias;
+	char **uuids = NULL;
+	int uuid_count = 0;
 
 	ba2str(&dev->bdaddr, peer_addr);
 	ba2str(&adapter->bdaddr, local_addr);
@@ -2776,6 +2854,15 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	} else
 		alias = g_strdup(dev->alias);
 
+	/* Extract UUIDs from extended inquiry response if any*/
+	if (eir_data != NULL)
+		uuid_count = get_uuid_count_eir(eir_data);
+
+	if (uuid_count > 0) {
+		uuids = g_new0(char *, uuid_count + 1);
+		get_uuids_eir(uuids, eir_data);
+	}
+
 	emit_device_found(adapter->path, paddr,
 			"Address", DBUS_TYPE_STRING, &paddr,
 			"Class", DBUS_TYPE_UINT32, &dev->class,
@@ -2785,15 +2872,17 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
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
 
@@ -2832,7 +2921,7 @@ done:
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
