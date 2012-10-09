Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/9] Simplify checking if found device is legacy
Date: Tue, 9 Oct 2012 14:11:54 +0200
Message-ID: <1349784722-14578-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This simplify code by removing pairing_is_legacy() function which was
always returning FALSE due to EIR being always present with mgmt
interface (this also fix small issue when first DeviceFound signal
emitted for legacy device was having LegacyPairing set to false).

Instead of using btd_event_set_legacy_pairing to set legacy pairing in
remote_dev_info handle it in similar way to rssi.

---
 src/adapter.c |   52 ++++++++++++----------------------------------------
 src/adapter.h |    6 +++---
 src/event.c   |   22 +++-------------------
 src/event.h   |    4 ++--
 src/mgmt.c    |   11 +++--------
 5 files changed, 23 insertions(+), 72 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6b28651..abb9691 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2947,6 +2947,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	const char *icon, *paddr = peer_addr;
 	dbus_bool_t paired = FALSE, trusted = FALSE;
 	dbus_int16_t rssi = dev->rssi;
+	dbus_bool_t legacy = dev->legacy;
 	char *alias;
 	size_t uuid_count;
 
@@ -2985,8 +2986,6 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 			return;
 		}
 
-		dev->legacy = FALSE;
-
 		if (read_remote_appearance(&adapter->bdaddr, &dev->bdaddr,
 						dev->bdaddr_type, &app) == 0)
 			icon = gap_appearance_to_icon(app);
@@ -3002,7 +3001,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 				"RSSI", DBUS_TYPE_INT16, &rssi,
 				"Name", DBUS_TYPE_STRING, &dev->name,
 				"Alias", DBUS_TYPE_STRING, &alias,
-				"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
+				"LegacyPairing", DBUS_TYPE_BOOLEAN, &legacy,
 				"Paired", DBUS_TYPE_BOOLEAN, &paired,
 				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
 				NULL);
@@ -3016,7 +3015,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 				"RSSI", DBUS_TYPE_INT16, &rssi,
 				"Name", DBUS_TYPE_STRING, &dev->name,
 				"Alias", DBUS_TYPE_STRING, &alias,
-				"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
+				"LegacyPairing", DBUS_TYPE_BOOLEAN, &legacy,
 				"Paired", DBUS_TYPE_BOOLEAN, &paired,
 				"Trusted", DBUS_TYPE_BOOLEAN, &trusted,
 				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
@@ -3071,26 +3070,6 @@ static void dev_prepend_uuid(gpointer data, gpointer user_data)
 	dev->services = g_slist_prepend(dev->services, g_strdup(new_uuid));
 }
 
-static gboolean pairing_is_legacy(const bdaddr_t *local, const bdaddr_t *peer,
-					const uint8_t *eir, const char *name)
-{
-	unsigned char features[8];
-
-	if (eir)
-		return FALSE;
-
-	if (name == NULL)
-		return TRUE;
-
-	if (read_remote_features(local, peer, NULL, features) < 0)
-		return TRUE;
-
-	if (features[0] & 0x01)
-		return FALSE;
-	else
-		return TRUE;
-}
-
 static char *read_stored_data(const bdaddr_t *local, const bdaddr_t *peer,
 			      uint8_t peer_type, const char *file)
 {
@@ -3162,13 +3141,13 @@ static gboolean connect_pending_cb(gpointer user_data)
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					uint8_t confirm_name, uint8_t *data,
-					uint8_t data_len)
+					uint8_t confirm_name, gboolean legacy,
+					uint8_t *data, uint8_t data_len)
 {
 	struct remote_dev_info *dev;
 	struct eir_data eir_data;
 	char *alias, *name;
-	gboolean legacy, name_known;
+	gboolean name_known;
 	int err;
 	GSList *l;
 
@@ -3203,7 +3182,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 			goto done;
 		}
 
-		if (dev->rssi != rssi)
+		if (dev->rssi != rssi || dev->legacy != legacy)
 			goto done;
 
 		eir_data_free(&eir_data);
@@ -3215,19 +3194,11 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
 	name = read_stored_data(&adapter->bdaddr, bdaddr, bdaddr_type, "names");
 
-	if (bdaddr_type == BDADDR_BREDR) {
-		legacy = pairing_is_legacy(&adapter->bdaddr, bdaddr, data,
-									name);
-
-		if (!name && main_opts.name_resolv &&
-				adapter_has_discov_sessions(adapter))
-			name_known = FALSE;
-		else
-			name_known = TRUE;
-	} else {
-		legacy = FALSE;
+	if (bdaddr_type == BDADDR_BREDR && !name && main_opts.name_resolv &&
+			adapter_has_discov_sessions(adapter))
+		name_known = FALSE;
+	else
 		name_known = TRUE;
-	}
 
 	if (confirm_name)
 		mgmt_confirm_name(adapter->dev_id, bdaddr, bdaddr_type,
@@ -3262,6 +3233,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
 done:
 	dev->rssi = rssi;
+	dev->legacy = legacy;
 
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
 						(GCompareFunc) dev_rssi_cmp);
diff --git a/src/adapter.h b/src/adapter.h
index 72a9988..a089075 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -82,7 +82,7 @@ struct remote_dev_info {
 	uint32_t class;
 	char *name;
 	char *alias;
-	dbus_bool_t legacy;
+	gboolean legacy;
 	char **uuids;
 	size_t uuid_count;
 	GSList *services;
@@ -128,8 +128,8 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					uint8_t confirm_name, uint8_t *data,
-					uint8_t data_len);
+					uint8_t confirm_name, gboolean legacy,
+					uint8_t *data, uint8_t data_len);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
diff --git a/src/event.c b/src/event.c
index 0ebab19..d552a0f 100644
--- a/src/event.c
+++ b/src/event.c
@@ -244,7 +244,8 @@ static void update_lastused(bdaddr_t *sba, bdaddr_t *dba, uint8_t dba_type)
 
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					int8_t rssi, uint8_t confirm_name,
-					uint8_t *data, uint8_t data_len)
+					gboolean legacy, uint8_t *data,
+					uint8_t data_len)
 {
 	struct btd_adapter *adapter;
 
@@ -260,24 +261,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type
 		write_remote_eir(local, peer, bdaddr_type, data, data_len);
 
 	adapter_update_found_devices(adapter, peer, bdaddr_type, rssi,
-						confirm_name, data, data_len);
-}
-
-void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
-							gboolean legacy)
-{
-	struct btd_adapter *adapter;
-	struct remote_dev_info *dev;
-
-	adapter = manager_find_adapter(local);
-	if (!adapter) {
-		error("No matching adapter found");
-		return;
-	}
-
-	dev = adapter_search_found_devices(adapter, peer);
-	if (dev)
-		dev->legacy = legacy;
+					confirm_name, legacy, data, data_len);
 }
 
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
diff --git a/src/event.h b/src/event.h
index 6adf1f5..a9afa1e 100644
--- a/src/event.h
+++ b/src/event.h
@@ -25,8 +25,8 @@
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure);
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					int8_t rssi, uint8_t confirm_name,
-					uint8_t *data, uint8_t data_len);
-void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
+					gboolean legacy, uint8_t *data,
+					uint8_t data_len);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 						char *name, uint32_t class);
diff --git a/src/mgmt.c b/src/mgmt.c
index d3f7809..9353c7d 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1635,6 +1635,7 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 	uint16_t eir_len;
 	uint8_t *eir;
 	gboolean confirm_name;
+	gboolean legacy;
 
 	if (len < sizeof(*ev)) {
 		error("mgmt_device_found too short (%zu bytes)", len);
@@ -1666,19 +1667,13 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u",
 			index, addr, ev->rssi, flags, eir_len);
 
-	if (flags & MGMT_DEV_FOUND_LEGACY_PAIRING)
-		btd_event_set_legacy_pairing(&info->bdaddr, &ev->addr.bdaddr,
-									TRUE);
-	else
-		btd_event_set_legacy_pairing(&info->bdaddr, &ev->addr.bdaddr,
-									FALSE);
-
 	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
+	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING) ? TRUE : FALSE;
 
 	btd_event_device_found(&info->bdaddr, &ev->addr.bdaddr,
 						ev->addr.type,
 						ev->rssi, confirm_name,
-						eir, eir_len);
+						legacy, eir, eir_len);
 }
 
 static void mgmt_discovering(int sk, uint16_t index, void *buf, size_t len)
-- 
1.7.9.5

