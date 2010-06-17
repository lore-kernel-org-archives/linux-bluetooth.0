Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, marcel@holtmann.org,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 2/2] Added support for updating EIR whenever record is added or removed
Date: Thu, 17 Jun 2010 10:24:50 -0700
Message-Id: <1276795490-17262-3-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1276795490-17262-1-git-send-email-ingas@codeaurora.org>
References: <1276795490-17262-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/service.c  |   18 ++++++
 src/adapter.c      |  148 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/adapter.h      |    5 +-
 src/dbus-hci.c     |    6 +-
 src/sdpd-service.c |  106 +++++++++++++++++++++++++++++++------
 src/sdpd.h         |   20 +++++++
 6 files changed, 277 insertions(+), 26 deletions(-)

diff --git a/plugins/service.c b/plugins/service.c
index 33cb27d..8ec4df4 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -446,6 +446,8 @@ static DBusMessage *update_record(DBusConnection *conn, DBusMessage *msg,
 				strerror(EIO));
 	}
 
+	adapter_update_ext_inquiry_response(&src);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -517,6 +519,7 @@ static DBusMessage *add_service_record(DBusConnection *conn,
 	const char *sender, *record;
 	dbus_uint32_t handle;
 	int err;
+	bdaddr_t addr;
 
 	if (dbus_message_get_args(msg, NULL,
 			DBUS_TYPE_STRING, &record, DBUS_TYPE_INVALID) == FALSE)
@@ -527,6 +530,13 @@ static DBusMessage *add_service_record(DBusConnection *conn,
 	if (err < 0)
 		return failed_strerror(msg, err);
 
+	if (serv_adapter->adapter)
+		adapter_get_address(serv_adapter->adapter, &addr);
+	else
+		bacpy(&addr, BDADDR_ANY);
+
+	adapter_update_ext_inquiry_response(&addr);
+
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
@@ -551,6 +561,7 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
 	struct service_adapter *serv_adapter = data;
 	dbus_uint32_t handle;
 	const char *sender;
+	bdaddr_t addr;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &handle,
 						DBUS_TYPE_INVALID) == FALSE)
@@ -561,6 +572,13 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
 	if (remove_record(conn, sender, serv_adapter, handle) < 0)
 		return not_available(msg);
 
+	if (serv_adapter->adapter)
+		adapter_get_address(serv_adapter->adapter, &addr);
+	else
+		bacpy(&addr, BDADDR_ANY);
+
+	adapter_update_ext_inquiry_response(&addr);
+
 	return dbus_message_new_method_return(msg);
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index ef41d83..e5330f0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -803,7 +803,7 @@ static DBusMessage *set_pairable_timeout(DBusConnection *conn,
 
 static void update_ext_inquiry_response(struct btd_adapter *adapter)
 {
-	uint8_t fec = 0, data[240];
+	uint8_t fec = 0, data[EIR_DATA_LENGTH];
 	struct hci_dev *dev = &adapter->dev;
 	int dd;
 
@@ -829,6 +829,27 @@ static void update_ext_inquiry_response(struct btd_adapter *adapter)
 	hci_close_dev(dd);
 }
 
+void adapter_update_ext_inquiry_response(const bdaddr_t *src)
+{
+	struct btd_adapter *adapter;
+	GSList *adapters;
+
+	if (bacmp(src, BDADDR_ANY) != 0) {
+		adapter = manager_find_adapter(src);
+		if (adapter)
+			update_ext_inquiry_response(adapter);
+		else
+			error("Updating EIR failed: device not found");
+	} else {
+
+		/* Update extended inquiry reponse for ANY adapter */
+		for (adapters = manager_get_adapters(); adapters; adapters = adapters->next) {
+			adapter = adapters->data;
+			update_ext_inquiry_response(adapter);
+		}
+	}
+}
+
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status)
 {
 	uint8_t class[3];
@@ -2677,6 +2698,7 @@ static void append_dict_valist(DBusMessageIter *iter,
 	DBusMessageIter dict;
 	const char *key;
 	int type;
+	int n_elements;
 	void *val;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
@@ -2688,7 +2710,12 @@ static void append_dict_valist(DBusMessageIter *iter,
 	while (key) {
 		type = va_arg(var_args, int);
 		val = va_arg(var_args, void *);
-		dict_append_entry(&dict, key, type, val);
+		if (type == DBUS_TYPE_ARRAY) {
+			n_elements = va_arg(var_args, int);
+			if (n_elements > 0)
+				dict_append_array(&dict, key, DBUS_TYPE_STRING, val, n_elements);
+		} else
+			dict_append_entry(&dict, key, type, val);
 		key = va_arg(var_args, char *);
 	}
 
@@ -2719,8 +2746,106 @@ static void emit_device_found(const char *path, const char *address,
 	g_dbus_send_message(connection, signal);
 }
 
+
+static int get_uuid_count_eir (uint8_t *eir_data)
+{
+	uint8_t type;
+	uint8_t len = 0;
+	uint8_t field_len;
+	int count = 0;
+
+	while (len < EIR_DATA_LENGTH) {
+		type = eir_data[1];
+		field_len = eir_data[0];
+		if ((type == EIR_UUID16_SOME) || (type == EIR_UUID16_ALL))
+			count += field_len/2;
+		else if ((type == EIR_UUID32_SOME) || (type == EIR_UUID32_ALL))
+			count += field_len/4;
+		else if ((type == EIR_UUID128_SOME) || (type == EIR_UUID128_ALL))
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
+	uint8_t type;
+	uint8_t len = 0;
+	uint8_t field_len = 0;
+	int count = 0;
+	int size;
+	uuid_t service;
+	gboolean service_found;
+
+	/* Count UUID16, UUID32 and UUID128 */
+	while (len < EIR_DATA_LENGTH) {
+		type = eir_data[1];
+		field_len =  eir_data[0];
+		service_found = FALSE;
+		if ((type == EIR_UUID16_SOME) || (type == EIR_UUID16_ALL)) {
+			size = 2;
+			service.type = SDP_UUID16;
+			service_found = TRUE;
+		} else if ((type == EIR_UUID32_SOME) || (type == EIR_UUID32_ALL)) {
+			size = 4;
+			service.type = SDP_UUID32;
+			service_found = TRUE;
+		} else if ((type == EIR_UUID128_SOME) || (type == EIR_UUID128_ALL)) {
+			size = 16;
+			service.type = SDP_UUID128;
+			service_found = TRUE;
+		}
+
+		if (service_found) {
+			uint8_t *data = &eir_data[2];
+			uint16_t val16;
+			uint32_t val32;
+			int i, k;
+
+			count = field_len/size;
+
+			/* Generate uuids in SDP format (EIR data is Little Endian) */
+			switch (service.type) {
+			case SDP_UUID16:
+				for (i = 0; i < count; i++) {
+					val16 = data[1];
+					val16 = (val16<<8) + data[0];
+					service.value.uuid16 = val16;
+					*uuids++ = bt_uuid2string(&service);
+					data += size;
+				}
+				break;
+			case SDP_UUID32:
+				for (i = 0; i < count; i++) {
+					val32 = data[3];
+					for (k = size-2 ; k >= 0; k--)
+						val32 = (val32<<8) + data[k];
+					service.value.uuid32 = val32;
+					*uuids++ = bt_uuid2string(&service);
+					data += size;
+				}
+				break;
+			case SDP_UUID128:
+				for (i = 0; i < count; i++) {
+					for (k = 0; k < size; k++)
+						service.value.uuid128.data[k] = data[size-k-1];
+					*uuids++ = bt_uuid2string(&service);
+					data += size;
+				}
+				break;
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
+			  struct remote_dev_info *dev, uint8_t *eir_data)
 {
 	struct btd_device *device;
 	char peer_addr[18], local_addr[18];
@@ -2728,6 +2853,8 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	dbus_bool_t paired = FALSE;
 	dbus_int16_t rssi = dev->rssi;
 	char *alias;
+	char **uuids = NULL;
+	int uuid_count = 0;
 
 	ba2str(&dev->bdaddr, peer_addr);
 	ba2str(&adapter->bdaddr, local_addr);
@@ -2747,6 +2874,15 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
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
@@ -2756,15 +2892,17 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
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
 
@@ -2803,7 +2941,7 @@ done:
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
 						(GCompareFunc) dev_rssi_cmp);
 
-	adapter_emit_device_found(adapter, dev);
+	adapter_emit_device_found(adapter, dev, eir_data);
 }
 
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
diff --git a/src/adapter.h b/src/adapter.h
index d141e32..891a133 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -114,10 +114,10 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
-				name_status_t name_status);
+				name_status_t name_status, uint8_t *eir_data);
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
-				struct remote_dev_info *dev);
+                               struct remote_dev_info *dev, uint8_t *eir_data);
 void adapter_update_oor_devices(struct btd_adapter *adapter);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
 void adapter_setname_complete(bdaddr_t *local, uint8_t status);
@@ -127,6 +127,7 @@ void adapter_service_insert(const bdaddr_t *bdaddr, void *rec);
 void adapter_service_remove(const bdaddr_t *bdaddr, void *rec);
 sdp_list_t *adapter_get_services(struct btd_adapter *adapter);
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status);
+void adapter_update_ext_inquiry_response(const bdaddr_t *src);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 void adapter_add_connection(struct btd_adapter *adapter,
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index daec192..64f8186 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -516,7 +516,7 @@ void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	if (dev) {
 		adapter_update_found_devices(adapter, peer, rssi, class,
 						NULL, NULL, dev->legacy,
-						NAME_NOT_REQUIRED);
+						NAME_NOT_REQUIRED, data);
 		return;
 	}
 
@@ -567,7 +567,7 @@ void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 
 	/* add in the list to track name sent/pending */
 	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
-					legacy, name_status);
+					legacy, name_status, data);
 
 	g_free(name);
 	g_free(alias);
@@ -643,7 +643,7 @@ void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status,
 	if (dev_info) {
 		g_free(dev_info->name);
 		dev_info->name = g_strdup(name);
-		adapter_emit_device_found(adapter, dev_info);
+		adapter_emit_device_found(adapter, dev_info, NULL);
 	}
 
 	if (device)
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 798e49d..5aa00f1 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -181,23 +181,30 @@ void create_ext_inquiry_response(const char *name,
 {
 	sdp_list_t *list = services;
 	uint8_t *ptr = data;
-	uint16_t uuid[24];
-	int i, index = 0;
+	uint16_t eir_len = 0;
+	int len;
+	uint16_t uuid16[EIR_DATA_LENGTH/2];
+	uint8_t *uuid128;
+	int i, k, index = 0;
+	gboolean truncated = FALSE;
 
 	if (name) {
-		int len = strlen(name);
+		len = strlen(name);
 
+		/* EIR Data type */
 		if (len > 48) {
 			len = 48;
-			ptr[1] = 0x08;
+			ptr[1] = EIR_NAME_SHORT;
 		} else
-			ptr[1] = 0x09;
+			ptr[1] = EIR_NAME_COMPLETE;
 
+		/* EIR Data length */
 		ptr[0] = len + 1;
 
 		memcpy(ptr + 2, name, len);
 
-		ptr += len + 2;
+		eir_len	 += (len + 2);
+		ptr += (len + 2);
 	}
 
 	if (tx_power != 0) {
@@ -209,7 +216,7 @@ void create_ext_inquiry_response(const char *name,
 	if (did_vendor != 0x0000) {
 		uint16_t source = 0x0002;
 		*ptr++ = 9;
-		*ptr++ = 0x10;
+		*ptr++ = EIR_DEVICE_ID;
 		*ptr++ = (source & 0x00ff);
 		*ptr++ = (source & 0xff00) >> 8;
 		*ptr++ = (did_vendor & 0x00ff);
@@ -218,9 +225,11 @@ void create_ext_inquiry_response(const char *name,
 		*ptr++ = (did_product & 0xff00) >> 8;
 		*ptr++ = (did_version & 0x00ff);
 		*ptr++ = (did_version & 0xff00) >> 8;
+		eir_len	 += 10;
 	}
 
-	ptr[1] = 0x03;
+
+	/* Group all UUID16 types */
 
 	for (; list; list = list->next) {
 		sdp_record_t *rec = (sdp_record_t *) list->data;
@@ -234,28 +243,93 @@ void create_ext_inquiry_response(const char *name,
 		if (rec->svclass.value.uuid16 == PNP_INFO_SVCLASS_ID)
 			continue;
 
-		if (index > 23) {
-			ptr[1] = 0x02;
+		/* Stop if not enough space to put next UUID16 */
+		if ((eir_len + 2 + sizeof(uint16_t)) > EIR_DATA_LENGTH) {
+			truncated = TRUE;
 			break;
 		}
 
+		/* Check for duplicates */
 		for (i = 0; i < index; i++)
-			if (uuid[i] == rec->svclass.value.uuid16)
+			if (uuid16[i] == rec->svclass.value.uuid16)
 				break;
 
-		if (i == index - 1)
+		if (i < index)
 			continue;
 
-		uuid[index++] = rec->svclass.value.uuid16;
+		uuid16[index++] = rec->svclass.value.uuid16;
+		eir_len += sizeof(uint16_t);
 	}
 
 	if (index > 0) {
-		ptr[0] = (index * 2) + 1;
+		/* EIR Data length */
+		ptr[0] = (index * sizeof(uint16_t)) + 1;
+		/* EIR Data type */
+		ptr[1] = (truncated) ? EIR_UUID16_SOME : EIR_UUID16_ALL;
+
 		ptr += 2;
 
+		eir_len += 2;
+
 		for (i = 0; i < index; i++) {
-			*ptr++ = (uuid[i] & 0x00ff);
-			*ptr++ = (uuid[i] & 0xff00) >> 8;
+			*ptr++ = (uuid16[i] & 0x00ff);
+			*ptr++ = (uuid16[i] & 0xff00) >> 8;
+		}
+	}
+
+	/* Group all UUID128 types */
+	if (!truncated && (eir_len <= EIR_DATA_LENGTH - 2 )) {
+
+		list = services;
+		index = 0;
+
+		/* Store UUID128 in place, skipping first 2 bytes to insert type and length later */
+		uuid128 = ptr + 2;
+
+		for (; list; list = list->next) {
+			sdp_record_t *rec = (sdp_record_t *) list->data;
+
+			if (rec->svclass.type != SDP_UUID128)
+				continue;
+
+			/* Stop if not enough space to put next UUID128 */
+			if ((eir_len + 2 + SIZEOF_UUID128) > EIR_DATA_LENGTH) {
+				truncated = TRUE;
+				break;
+			}
+
+			/* Check for duplicates, EIR data is Little Endian	*/
+			for (i = 0; i < index; i++) {
+				for (k = 0; k < SIZEOF_UUID128; k++) {
+					if (uuid128[i*SIZEOF_UUID128 + k] !=
+						rec->svclass.value.uuid128.data[SIZEOF_UUID128 - k])
+						break;
+				}
+				if (k == SIZEOF_UUID128)
+					break;
+			}
+
+			if (i < index)
+				continue;
+
+			/* EIR data is Little Endian */
+			for (k = 0; k < SIZEOF_UUID128; k++)
+				uuid128[index*SIZEOF_UUID128 + k] =
+				rec->svclass.value.uuid128.data[SIZEOF_UUID128 - 1 - k];
+
+			eir_len += SIZEOF_UUID128;
+			index++;
+		}
+
+		if (index > 0 || truncated) {
+			/* EIR Data length */
+			ptr[0] = (index * SIZEOF_UUID128) + 1;
+			/* EIR Data type */
+			ptr[1] = (truncated) ? EIR_UUID128_SOME : EIR_UUID128_ALL;
+
+			eir_len += 2;
+
+			ptr	 = data + eir_len;
 		}
 	}
 }
diff --git a/src/sdpd.h b/src/sdpd.h
index 1d2e169..1425c64 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -35,6 +35,26 @@
 #define SDPDBG(fmt...)
 #endif
 
+#define EIR_DATA_LENGTH  240
+
+#define EIR_FLAGS                   0x01  /* Flags */
+#define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
+#define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
+#define EIR_UUID32_SOME             0x04  /* 32-bit UUID, more available */
+#define EIR_UUID32_ALL              0x05  /* 32-bit UUID, all listed */
+#define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more available */
+#define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed */
+#define EIR_NAME_SHORT              0x08  /* shortened local name */
+#define EIR_NAME_COMPLETE           0x09  /* complete local name */
+#define EIR_TX_POWER                0x0A  /* Transmit power level */
+#define OOB_CLASS_OF_DEVICE         0x0D  /* Class of Device (OOB only) */
+#define OOB_SIMPLE_PAIRING_HASH_C   0x0E  /* Simple Pairing HashC (OOB only) */
+#define OOB_SIMPLE_PAIRING_RAND_R   0x0F  /* Simple Pairing RandR (OOB only) */
+#define EIR_DEVICE_ID               0x10  /* Device ID */
+#define EIR_MANF_DATA               0xFF  /* Manufacturer Specific Data */
+
+#define SIZEOF_UUID128 16
+
 typedef struct request {
 	bdaddr_t device;
 	bdaddr_t bdaddr;
-- 
1.7.1

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
