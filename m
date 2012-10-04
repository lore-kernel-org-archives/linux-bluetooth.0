Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 6/7] adapter: Constify use of bdaddr_t pointer parameters
Date: Thu, 4 Oct 2012 14:06:03 +0200
Message-ID: <1349352364-5491-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
References: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mark all input only bdaddr_t pointer parameters as const.

---
 src/adapter.c |   52 +++++++++++++++++++++++++++++-----------------------
 src/adapter.h |   51 +++++++++++++++++++++++++++++----------------------
 2 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 439046d..cc455a5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2037,14 +2037,14 @@ static void load_devices(struct btd_adapter *adapter)
 	textfile_foreach(filename, create_stored_device_from_blocked, adapter);
 }
 
-int btd_adapter_block_address(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							uint8_t bdaddr_type)
+int btd_adapter_block_address(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	return mgmt_block_device(adapter->dev_id, bdaddr, bdaddr_type);
 }
 
-int btd_adapter_unblock_address(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							uint8_t bdaddr_type)
+int btd_adapter_unblock_address(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	return mgmt_unblock_device(adapter->dev_id, bdaddr,
 								bdaddr_type);
@@ -2749,7 +2749,7 @@ static int found_device_cmp(gconstpointer a, gconstpointer b)
 }
 
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
-							bdaddr_t *bdaddr)
+							const bdaddr_t *bdaddr)
 {
 	GSList *l;
 
@@ -2976,7 +2976,7 @@ static void dev_prepend_uuid(gpointer data, gpointer user_data)
 	dev->services = g_slist_prepend(dev->services, g_strdup(new_uuid));
 }
 
-static gboolean pairing_is_legacy(bdaddr_t *local, bdaddr_t *peer,
+static gboolean pairing_is_legacy(const bdaddr_t *local, const bdaddr_t *peer,
 					const uint8_t *eir, const char *name)
 {
 	unsigned char features[8];
@@ -2996,7 +2996,7 @@ static gboolean pairing_is_legacy(bdaddr_t *local, bdaddr_t *peer,
 		return TRUE;
 }
 
-static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer,
+static char *read_stored_data(const bdaddr_t *local, const bdaddr_t *peer,
 			      uint8_t peer_type, const char *file)
 {
 	char local_addr[18], key[20], filename[PATH_MAX + 1], *str;
@@ -3065,9 +3065,10 @@ static gboolean connect_pending_cb(gpointer user_data)
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, uint8_t bdaddr_type,
-					int8_t rssi, uint8_t confirm_name,
-					uint8_t *data, uint8_t data_len)
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type, int8_t rssi,
+					uint8_t confirm_name, uint8_t *data,
+					uint8_t data_len)
 {
 	struct remote_dev_info *dev;
 	struct eir_data eir_data;
@@ -3650,7 +3651,7 @@ int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 	return mgmt_set_fast_connectable(adapter->dev_id, enable);
 }
 
-int btd_adapter_read_clock(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+int btd_adapter_read_clock(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 				int which, int timeout, uint32_t *clock,
 				uint16_t *accuracy)
 {
@@ -3662,33 +3663,37 @@ int btd_adapter_read_clock(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 }
 
 int btd_adapter_disconnect_device(struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, uint8_t bdaddr_type)
+						const bdaddr_t *bdaddr,
+						uint8_t bdaddr_type)
 
 {
 	return mgmt_disconnect(adapter->dev_id, bdaddr, bdaddr_type);
 }
 
-int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							uint8_t bdaddr_type)
+int btd_adapter_remove_bonding(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	return mgmt_unpair_device(adapter->dev_id, bdaddr, bdaddr_type);
 }
 
-int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+int btd_adapter_pincode_reply(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
 					const char *pin, size_t pin_len)
 {
 	return mgmt_pincode_reply(adapter->dev_id, bdaddr, pin, pin_len);
 }
 
-int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					uint8_t bdaddr_type, gboolean success)
+int btd_adapter_confirm_reply(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+				gboolean success)
 {
 	return mgmt_confirm_reply(adapter->dev_id, bdaddr, bdaddr_type,
 								success);
 }
 
-int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					uint8_t bdaddr_type, uint32_t passkey)
+int btd_adapter_passkey_reply(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+				uint32_t passkey)
 {
 	return mgmt_passkey_reply(adapter->dev_id, bdaddr, bdaddr_type,
 								passkey);
@@ -3701,14 +3706,14 @@ int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
 	return mgmt_set_did(adapter->dev_id, vendor, product, version, source);
 }
 
-int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 					uint8_t addr_type, uint8_t io_cap)
 {
 	suspend_discovery(adapter);
 	return mgmt_create_bonding(adapter->dev_id, bdaddr, addr_type, io_cap);
 }
 
-int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
+int adapter_cancel_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr)
 {
 	return mgmt_cancel_bonding(adapter->dev_id, bdaddr);
 }
@@ -3758,14 +3763,15 @@ int btd_adapter_read_local_oob_data(struct btd_adapter *adapter)
 }
 
 int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
-			bdaddr_t *bdaddr, uint8_t *hash, uint8_t *randomizer)
+					const bdaddr_t *bdaddr,
+					uint8_t *hash, uint8_t *randomizer)
 {
 	return mgmt_add_remote_oob_data(adapter->dev_id, bdaddr, hash,
 								randomizer);
 }
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
-							bdaddr_t *bdaddr)
+							const bdaddr_t *bdaddr)
 {
 	return mgmt_remove_remote_oob_data(adapter->dev_id, bdaddr);
 }
diff --git a/src/adapter.h b/src/adapter.h
index 07c0ad5..72a9988 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -124,11 +124,12 @@ uint16_t adapter_get_dev_id(struct btd_adapter *adapter);
 const gchar *adapter_get_path(struct btd_adapter *adapter);
 const bdaddr_t *adapter_get_address(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
-							bdaddr_t *bdaddr);
+							const bdaddr_t *bdaddr);
 void adapter_update_found_devices(struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, uint8_t bdaddr_type,
-					int8_t rssi, uint8_t confirm_name,
-					uint8_t *data, uint8_t data_len);
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type, int8_t rssi,
+					uint8_t confirm_name, uint8_t *data,
+					uint8_t data_len);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
@@ -205,36 +206,41 @@ void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 							gboolean enable);
 
-int btd_adapter_read_clock(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+int btd_adapter_read_clock(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 				int which, int timeout, uint32_t *clock,
 				uint16_t *accuracy);
 
-int btd_adapter_block_address(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							uint8_t bdaddr_type);
-int btd_adapter_unblock_address(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							uint8_t bdaddr_type);
+int btd_adapter_block_address(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type);
+int btd_adapter_unblock_address(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type);
 
 int btd_adapter_disconnect_device(struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, uint8_t bdaddr_type);
-
-int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+							const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type);
 
-int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+int btd_adapter_remove_bonding(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type);
+
+int btd_adapter_pincode_reply(struct btd_adapter *adapter,
+					const  bdaddr_t *bdaddr,
 					const char *pin, size_t pin_len);
-int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					uint8_t bdaddr_type, gboolean success);
-int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					uint8_t bdaddr_type, uint32_t passkey);
+int btd_adapter_confirm_reply(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+				gboolean success);
+int btd_adapter_passkey_reply(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+				uint32_t passkey);
 
 int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
 					uint16_t product, uint16_t version,
 					uint16_t source);
 
-int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				uint8_t bdaddr_type, uint8_t io_cap);
+int adapter_create_bonding(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+				uint8_t io_cap);
 
-int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr);
+int adapter_cancel_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr);
 
 void adapter_bonding_complete(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr, uint8_t status);
@@ -244,10 +250,11 @@ void adapter_read_local_oob_data_complete(struct btd_adapter *adapter,
 					uint8_t *hash, uint8_t *randomizer);
 
 int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
-			bdaddr_t *bdaddr, uint8_t *hash, uint8_t *randomizer);
+					const bdaddr_t *bdaddr,
+					uint8_t *hash, uint8_t *randomizer);
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
-							bdaddr_t *bdaddr);
+							const bdaddr_t *bdaddr);
 
 int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
 void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
-- 
1.7.9.5

