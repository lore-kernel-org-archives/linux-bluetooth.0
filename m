Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 2/7] Refactor get_eir_uuids() to get EIR data length parameter
Date: Thu, 11 Nov 2010 15:51:56 -0300
Message-Id: <1289501521-21825-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo@openbossa.org>

get_eir_uuids() will be reused to parse LE advertising data as well, as
they share the same format. But for Advertising, maximum data length is
different (31 bytes vs. 240 bytes for EIR), and the radio is not
required to send the non-significant (zero-filled) bytes.

adapter_emit_device_found() now also accepts a EIR data length
parameter, so it can be reused for LE and can propagate the exact data
length.
---
 src/adapter.c |   17 ++++++++++-------
 src/adapter.h |    2 +-
 src/event.c   |    2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8b742b7..363ee94 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2962,7 +2962,8 @@ static void emit_device_found(const char *path, const char *address,
 	g_dbus_send_message(connection, signal);
 }
 
-static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
+static char **get_eir_uuids(uint8_t *eir_data, size_t eir_length,
+							size_t *uuid_count)
 {
 	uint16_t len = 0;
 	char **uuids;
@@ -2976,7 +2977,10 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
 	uuid_t service;
 	unsigned int i;
 
-	while (len < EIR_DATA_LENGTH - 1) {
+	if (eir_data == NULL || eir_length == 0)
+		return NULL;
+
+	while (len < eir_length - 1) {
 		uint8_t field_len = eir_data[0];
 
 		/* Check for the end of EIR */
@@ -3006,7 +3010,7 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
 	}
 
 	/* Bail out if got incorrect length */
-	if (len > EIR_DATA_LENGTH)
+	if (len > eir_length)
 		return NULL;
 
 	total = uuid16_count + uuid32_count + uuid128_count;
@@ -3056,7 +3060,7 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
 }
 
 void adapter_emit_device_found(struct btd_adapter *adapter,
-				struct remote_dev_info *dev, uint8_t *eir_data)
+	struct remote_dev_info *dev, uint8_t *eir_data, size_t eir_length)
 {
 	struct btd_device *device;
 	char peer_addr[18], local_addr[18];
@@ -3086,8 +3090,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 		alias = g_strdup(dev->alias);
 
 	/* Extract UUIDs from extended inquiry response if any*/
-	if (eir_data != NULL)
-		uuids = get_eir_uuids(eir_data, &uuid_count);
+	uuids = get_eir_uuids(eir_data, eir_length, &uuid_count);
 
 	emit_device_found(adapter->path, paddr,
 			"Address", DBUS_TYPE_STRING, &paddr,
@@ -3147,7 +3150,7 @@ done:
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
 						(GCompareFunc) dev_rssi_cmp);
 
-	adapter_emit_device_found(adapter, dev, eir_data);
+	adapter_emit_device_found(adapter, dev, eir_data, EIR_DATA_LENGTH);
 }
 
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
diff --git a/src/adapter.h b/src/adapter.h
index 8019cfc..89b07d7 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -124,7 +124,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				name_status_t name_status, uint8_t *eir_data);
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
-				struct remote_dev_info *dev, uint8_t *eir_data);
+	struct remote_dev_info *dev, uint8_t *eir_data, size_t eir_length);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
 void adapter_setname_complete(bdaddr_t *local, uint8_t status);
 void adapter_update_tx_power(bdaddr_t *bdaddr, uint8_t status, void *ptr);
diff --git a/src/event.c b/src/event.c
index 971bb35..a057306 100644
--- a/src/event.c
+++ b/src/event.c
@@ -510,7 +510,7 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status,
 	if (dev_info) {
 		g_free(dev_info->name);
 		dev_info->name = g_strdup(name);
-		adapter_emit_device_found(adapter, dev_info, NULL);
+		adapter_emit_device_found(adapter, dev_info, NULL, 0);
 	}
 
 	if (device)
-- 
1.7.3.2

