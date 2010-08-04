Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 7/7] Add service UUIDs from EIR to device properties in "Device Found" signal.
Date: Tue,  3 Aug 2010 17:03:57 -0700
Message-Id: <1280880237-2296-8-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280880237-2296-1-git-send-email-ingas@codeaurora.org>
References: <1280880237-2296-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a2ef9aa..9603ba7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2750,8 +2750,100 @@ static void emit_device_found(const char *path, const char *address,
 	g_dbus_send_message(connection, signal);
 }
 
+static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
+{
+	uint8_t len = 0;
+	char **uuid_buf = NULL;
+	char **uuids;
+	size_t total = 0;
+	size_t uuid16_count = 0;
+	size_t uuid32_count = 0;
+	size_t uuid128_count = 0;
+	uint8_t *uuid16;
+	uint8_t *uuid32;
+	uint8_t *uuid128;
+	uuid_t service;
+	int i;
+
+	while (len < EIR_DATA_LENGTH) {
+		uint8_t type = eir_data[1];
+		uint8_t field_len = eir_data[0];
+
+		switch(type) {
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
+	total = uuid16_count + uuid32_count + uuid128_count;
+	*uuid_count = total;
+
+	if (!total)
+		return NULL;
+
+	uuid_buf = g_new0(char *, total + 1);
+
+	if (!uuid_buf)
+		return NULL;
+
+	uuids = uuid_buf;
+
+	/* Generate uuids in SDP format (EIR data is Little Endian) */
+	service.type = SDP_UUID16;
+	for (i = 0; i < uuid16_count; i++) {
+		uint16_t val16 = uuid16[1];
+
+		val16 = (val16<<8) + uuid16[0];
+		service.value.uuid16 = val16;
+		*uuids++ = bt_uuid2string(&service);
+		uuid16 += 2;
+	}
+
+	service.type = SDP_UUID32;
+	for (i = 0; i < uuid32_count; i++) {
+		uint32_t val32 = uuid32[3];
+		int k;
+
+		for (k = 2; k >= 0; k--)
+			val32 = (val32 << 8) + uuid32[k];
+
+		service.value.uuid32 = val32;
+		*uuids++ = bt_uuid2string(&service);
+		uuid32 += 4;
+	}
+
+	service.type = SDP_UUID128;
+	for (i = 0; i < uuid128_count; i++) {
+		int k;
+
+		for (k = 0; k < 16; k++)
+			service.value.uuid128.data[k] = uuid128[16 - k - 1];
+
+		*uuids++ = bt_uuid2string(&service);
+		uuid128 += 16;
+	}
+
+	return uuid_buf;
+}
+
 void adapter_emit_device_found(struct btd_adapter *adapter,
-				struct remote_dev_info *dev)
+				struct remote_dev_info *dev, uint8_t *eir_data)
 {
 	struct btd_device *device;
 	char peer_addr[18], local_addr[18];
@@ -2759,6 +2851,8 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	dbus_bool_t paired = FALSE;
 	dbus_int16_t rssi = dev->rssi;
 	char *alias;
+	char **uuids = NULL;
+	size_t uuid_count = 0;
 
 	ba2str(&dev->bdaddr, peer_addr);
 	ba2str(&adapter->bdaddr, local_addr);
@@ -2778,6 +2872,10 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	} else
 		alias = g_strdup(dev->alias);
 
+	/* Extract UUIDs from extended inquiry response if any*/
+	if (eir_data != NULL)
+		uuids = get_eir_uuids(eir_data, &uuid_count);
+
 	emit_device_found(adapter->path, paddr,
 			"Address", DBUS_TYPE_STRING, &paddr,
 			"Class", DBUS_TYPE_UINT32, &dev->class,
@@ -2787,15 +2885,17 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
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
 
@@ -2834,7 +2934,7 @@ done:
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
 						(GCompareFunc) dev_rssi_cmp);
 
-	adapter_emit_device_found(adapter, dev);
+	adapter_emit_device_found(adapter, dev, eir_data);
 }
 
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
