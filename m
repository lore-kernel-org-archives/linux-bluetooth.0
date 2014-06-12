Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/10] android/gatt: Fix not detecting device found by Bluetooth HAL
Date: Thu, 12 Jun 2014 15:33:23 +0300
Message-Id: <1402576409-9352-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402576409-9352-1-git-send-email-luiz.dentz@gmail.com>
References: <1402576409-9352-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is necessary so that devices found during regular discovery can be
handled by gatt HAL.
---
 android/bluetooth.c |  42 ++++++++++++++--------
 android/bluetooth.h |   5 ++-
 android/gatt.c      | 101 +++++++++++++++++++++++++++++-----------------------
 3 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index fac2637..4ec7c7a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -179,6 +179,7 @@ static struct {
 	uint32_t current_settings;
 	uint32_t supported_settings;
 
+	bool le_scanning;
 	uint8_t cur_discovery_type;
 	uint8_t exp_discovery_type;
 	uint32_t discoverable_timeout;
@@ -1301,10 +1302,8 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 	}
 
 	type = adapter.exp_discovery_type;
-	adapter.exp_discovery_type = SCAN_TYPE_NONE;
-
-	if (type == SCAN_TYPE_NONE && gatt_device_found_cb)
-		type = SCAN_TYPE_LE;
+	adapter.exp_discovery_type = adapter.le_scanning ? SCAN_TYPE_LE :
+								SCAN_TYPE_NONE;
 
 	if (type != SCAN_TYPE_NONE)
 		start_discovery(type);
@@ -3512,42 +3511,57 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 	return false;
 }
 
+bool bt_le_register(bt_le_device_found cb)
+{
+	if (gatt_device_found_cb)
+		return false;
+
+	gatt_device_found_cb = cb;
+
+	return true;
+}
+
+void bt_le_unregister(void)
+{
+	gatt_device_found_cb = NULL;
+}
+
 bool bt_le_discovery_stop(bt_le_discovery_stopped cb)
 {
+	if (!(adapter.current_settings & MGMT_SETTING_POWERED))
+		return false;
+
+	adapter.le_scanning = false;
+
 	if (adapter.cur_discovery_type != SCAN_TYPE_LE) {
 		if (cb)
 			cb();
 
-		gatt_device_found_cb = NULL;
-
 		return true;
 	}
 
 	if (!stop_discovery(SCAN_TYPE_LE))
 		return false;
 
-	gatt_device_found_cb = NULL;
 	gatt_discovery_stopped_cb = cb;
 	adapter.exp_discovery_type = SCAN_TYPE_NONE;
 
 	return true;
 }
 
-bool bt_le_discovery_start(bt_le_device_found cb)
+bool bt_le_discovery_start(void)
 {
 	if (!(adapter.current_settings & MGMT_SETTING_POWERED))
 		return false;
 
+	adapter.le_scanning = true;
+
 	/* If core is discovering, don't bother */
-	if (adapter.cur_discovery_type != SCAN_TYPE_NONE) {
-		gatt_device_found_cb = cb;
+	if (adapter.cur_discovery_type != SCAN_TYPE_NONE)
 		return true;
-	}
 
-	if (start_discovery(SCAN_TYPE_LE)) {
-		gatt_device_found_cb = cb;
+	if (start_discovery(SCAN_TYPE_LE))
 		return true;
-	}
 
 	return false;
 }
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 2409d46..7c64bab 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -44,7 +44,10 @@ typedef void (*bt_le_device_found)(const bdaddr_t *addr, uint8_t addr_type,
 					int rssi, uint16_t eir_len,
 					const void *eir, bool discoverable,
 					bool bonded);
-bool bt_le_discovery_start(bt_le_device_found cb);
+bool bt_le_register(bt_le_device_found cb);
+void bt_le_unregister(void);
+
+bool bt_le_discovery_start(void);
 
 typedef void (*bt_le_discovery_stopped)(void);
 bool bt_le_discovery_stop(bt_le_discovery_stopped cb);
diff --git a/android/gatt.c b/android/gatt.c
index a2314e0..13d03e8 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -627,6 +627,47 @@ static void destroy_gatt_app(void *data)
 	free(app);
 }
 
+static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
+						int rssi, uint16_t eir_len,
+						const void *eir,
+						bool discoverable, bool bonded)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
+	struct gatt_device *dev;
+	char bda[18];
+
+	if (!scanning || (!discoverable && !bonded))
+		goto connect;
+
+	ba2str(addr, bda);
+	DBG("LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi, !!eir);
+
+	bdaddr2android(addr, ev->bda);
+	ev->rssi = rssi;
+	ev->len = eir_len;
+
+	memcpy(ev->adv_data, eir, ev->len);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+						HAL_EV_GATT_CLIENT_SCAN_RESULT,
+						sizeof(*ev) + ev->len, ev);
+
+connect:
+	dev = find_device_by_addr(addr);
+	if (!dev || (dev->state != DEVICE_CONNECT_INIT))
+		return;
+
+	device_set_state(dev, DEVICE_CONNECT_READY);
+	dev->bdaddr_type = addr_type;
+
+	/*
+	 * We are ok to perform connect now. Stop discovery
+	 * and once it is stopped continue with creating ACL
+	 */
+	bt_le_discovery_stop(bt_le_discovery_stop_cb);
+}
+
 static struct gatt_app *register_app(const uint8_t *uuid, gatt_type_t type)
 {
 	static int32_t application_id = 1;
@@ -955,47 +996,6 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 	return s;
 }
 
-static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
-						int rssi, uint16_t eir_len,
-						const void *eir,
-						bool discoverable, bool bonded)
-{
-	uint8_t buf[IPC_MTU];
-	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
-	struct gatt_device *dev;
-	char bda[18];
-
-	if (!scanning || (!discoverable && !bonded))
-		goto connect;
-
-	ba2str(addr, bda);
-	DBG("LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi, !!eir);
-
-	bdaddr2android(addr, ev->bda);
-	ev->rssi = rssi;
-	ev->len = eir_len;
-
-	memcpy(ev->adv_data, eir, ev->len);
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-						HAL_EV_GATT_CLIENT_SCAN_RESULT,
-						sizeof(*ev) + ev->len, ev);
-
-connect:
-	dev = find_device_by_addr(addr);
-	if (!dev || (dev->state != DEVICE_CONNECT_INIT))
-		return;
-
-	device_set_state(dev, DEVICE_CONNECT_READY);
-	dev->bdaddr_type = addr_type;
-
-	/*
-	 * We are ok to perform connect now. Stop discovery
-	 * and once it is stopped continue with creating ACL
-	 */
-	bt_le_discovery_stop(bt_le_discovery_stop_cb);
-}
-
 static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1206,7 +1206,7 @@ reply:
 
 	/* Check if we should restart scan */
 	if (scanning)
-		bt_le_discovery_start(le_device_found_handler);
+		bt_le_discovery_start();
 
 	/* FIXME: What to do if discovery won't start here. */
 }
@@ -1292,7 +1292,7 @@ static void handle_client_scan(const void *buf, uint16_t len)
 	}
 
 	/* Turn on scan */
-	if (!bt_le_discovery_start(le_device_found_handler)) {
+	if (!bt_le_discovery_start()) {
 		error("gatt: LE scan switch failed");
 		status = HAL_STATUS_FAILED;
 		goto reply;
@@ -1324,7 +1324,7 @@ static void bt_le_discovery_stop_cb(void)
 
 	/* Check now if there is any device ready to connect */
 	if (connect_next_dev() < 0)
-		bt_le_discovery_start(le_device_found_handler);
+		bt_le_discovery_start();
 }
 
 static struct gatt_device *create_device(const bdaddr_t *addr)
@@ -1433,7 +1433,7 @@ static bool trigger_connection(struct app_connection *connection)
 
 	/* after state change trigger discovering */
 	if (!scanning && (connection->device->state == DEVICE_CONNECT_INIT))
-		if (!bt_le_discovery_start(le_device_found_handler)) {
+		if (!bt_le_discovery_start()) {
 			error("gatt: Could not start scan");
 
 			return false;
@@ -5901,6 +5901,15 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	if (!start_listening_io())
 		return false;
 
+	if (!bt_le_register(le_device_found_handler)) {
+		error("gatt: bt_le_register failed");
+
+		g_io_channel_unref(listening_io);
+		listening_io = NULL;
+
+		return false;
+	}
+
 	crypto = bt_crypto_new();
 	if (!crypto) {
 		error("gatt: Failed to setup crypto");
@@ -5985,6 +5994,8 @@ void bt_gatt_unregister(void)
 
 	bt_crypto_unref(crypto);
 	crypto = NULL;
+
+	bt_le_unregister();
 }
 
 
-- 
1.9.3

