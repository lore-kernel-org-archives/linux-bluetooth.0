Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/bluetooth: Remove address type from BT callbacks
Date: Thu,  5 Mar 2015 12:57:45 +0100
Message-Id: <1425556666-9868-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1425556666-9868-1-git-send-email-szymon.janc@tieto.com>
References: <1425556666-9868-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT code should always use bt_get_id_addr() when directly dealing with
remote address. This is to make sure that proper address and type is
used.
---
 android/bluetooth.c | 22 +++++++++----------
 android/bluetooth.h | 11 +++++-----
 android/gatt.c      | 61 ++++++++---------------------------------------------
 android/hidhost.c   |  2 +-
 4 files changed, 25 insertions(+), 71 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index e684d31..4d0cd48 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -887,7 +887,7 @@ static void send_paired_notification(void *data, void *user_data)
 	bt_paired_device_cb cb = data;
 	struct device *dev = user_data;
 
-	cb(&dev->bdaddr, dev->bdaddr_type);
+	cb(&dev->bdaddr);
 }
 
 static void update_device_state(struct device *dev, uint8_t addr_type,
@@ -1946,8 +1946,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 	/* Notify Gatt if its registered for LE events */
 	if (bdaddr_type != BDADDR_BREDR && gatt_device_found_cb) {
-		bdaddr_t *addr;
-		uint8_t addr_type;
+		const bdaddr_t *addr;
 
 		/*
 		 * If RPA is set it means that IRK was received and ID address
@@ -1955,16 +1954,13 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		 * it needs to be used also in GATT notifications. Also GATT
 		 * HAL implementation is using RPA for devices matching.
 		 */
-		if (bacmp(&dev->rpa, BDADDR_ANY)) {
+		if (bacmp(&dev->rpa, BDADDR_ANY))
 			addr = &dev->rpa;
-			addr_type = dev->rpa_type;
-		} else {
+		else
 			addr = &dev->bdaddr;
-			addr_type = dev->bdaddr_type;
-		}
 
-		gatt_device_found_cb(addr, addr_type, rssi, data_len, data,
-						connectable, dev->le_bonded);
+		gatt_device_found_cb(addr, rssi, data_len, data, connectable,
+								dev->le_bonded);
 	}
 
 	if (!dev->bredr_paired && !dev->le_paired)
@@ -4403,7 +4399,7 @@ static void send_unpaired_notification(void *data, void *user_data)
 	bt_unpaired_device_cb cb = data;
 	struct mgmt_addr_info *addr = user_data;
 
-	cb(&addr->bdaddr, addr->type);
+	cb(&addr->bdaddr);
 }
 
 static void unpair_device_complete(uint8_t status, uint16_t length,
@@ -4425,7 +4421,9 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 								false, false);
 
 	/* Cast rp->addr to (void *) since queue_foreach don't take const */
-	queue_foreach(unpaired_cb_list, send_unpaired_notification,
+
+	if (!dev->le_paired && !dev->bredr_paired)
+		queue_foreach(unpaired_cb_list, send_unpaired_notification,
 							(void *)&rp->addr);
 }
 
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 8b8a1f0..4b17209 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -35,10 +35,9 @@ void bt_bluetooth_unregister(void);
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
 void bt_adapter_remove_record(uint32_t handle);
 
-typedef void (*bt_le_device_found)(const bdaddr_t *addr, uint8_t addr_type,
-					int rssi, uint16_t eir_len,
-					const void *eir, bool connectable,
-					bool bonded);
+typedef void (*bt_le_device_found)(const bdaddr_t *addr, int rssi,
+					uint16_t eir_len, const void *eir,
+					bool connectable, bool bonded);
 bool bt_le_register(bt_le_device_found cb);
 void bt_le_unregister(void);
 
@@ -81,11 +80,11 @@ bool bt_auto_connect_add(const bdaddr_t *addr);
 
 void bt_auto_connect_remove(const bdaddr_t *addr);
 
-typedef void (*bt_unpaired_device_cb)(const bdaddr_t *addr, uint8_t type);
+typedef void (*bt_unpaired_device_cb)(const bdaddr_t *addr);
 bool bt_unpaired_register(bt_unpaired_device_cb cb);
 void bt_unpaired_unregister(bt_unpaired_device_cb cb);
 
-typedef void (*bt_paired_device_cb)(const bdaddr_t *addr, uint8_t type);
+typedef void (*bt_paired_device_cb)(const bdaddr_t *addr);
 bool bt_paired_register(bt_paired_device_cb cb);
 void bt_paired_unregister(bt_paired_device_cb cb);
 bool bt_is_pairing(const bdaddr_t *addr);
diff --git a/android/gatt.c b/android/gatt.c
index 638786d..7263e31 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -153,7 +153,6 @@ struct notification_data {
 
 struct gatt_device {
 	bdaddr_t bdaddr;
-	uint8_t bdaddr_type;
 
 	gatt_device_state_t state;
 
@@ -584,24 +583,8 @@ static void device_set_state(struct gatt_device *dev, uint32_t state)
 static bool auto_connect_le(struct gatt_device *dev)
 {
 	/*  For LE devices use auto connect feature if possible */
-	if (bt_kernel_conn_control()) {
-		const bdaddr_t *bdaddr;
-
-		/*
-		 * If address type is random it might be that IRK was received
-		 * and random is just for faking Android Framework. ID address
-		 * should be used for connection if present.
-		 */
-		if (dev->bdaddr_type == BDADDR_LE_RANDOM) {
-			bdaddr = bt_get_id_addr(&dev->bdaddr, NULL);
-			if (!bdaddr)
-				return -EINVAL;
-		} else {
-			bdaddr = &dev->bdaddr;
-		}
-
-		return bt_auto_connect_add(bdaddr);
-	}
+	if (bt_kernel_conn_control())
+		return bt_auto_connect_add(bt_get_id_addr(&dev->bdaddr, NULL));
 
 	/* Trigger discovery if not already started */
 	if (!scanning) {
@@ -1642,19 +1625,7 @@ static int connect_le(struct gatt_device *dev)
 
 	DBG("Connection attempt to: %s", addr);
 
-	/*
-	 * If address type is random it might be that IRK was received and
-	 * random is just for faking Android Framework. ID address should be
-	 * used for connection if present.
-	 */
-	if (dev->bdaddr_type == BDADDR_LE_RANDOM) {
-		bdaddr = bt_get_id_addr(&dev->bdaddr, &bdaddr_type);
-		if (!bdaddr)
-			return -EINVAL;
-	} else {
-		bdaddr = &dev->bdaddr;
-		bdaddr_type = dev->bdaddr_type;
-	}
+	bdaddr = bt_get_id_addr(&dev->bdaddr, &bdaddr_type);
 
 	/*
 	 * This connection will help us catch any PDUs that comes before
@@ -1703,10 +1674,9 @@ static void bt_le_discovery_stop_cb(void)
 		bt_le_discovery_start();
 }
 
-static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
-						int rssi, uint16_t eir_len,
-						const void *eir,
-						bool connectable, bool bonded)
+static void le_device_found_handler(const bdaddr_t *addr, int rssi,
+					uint16_t eir_len, const void *eir,
+					bool connectable, bool bonded)
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
@@ -1749,7 +1719,6 @@ done:
 		return;
 
 	device_set_state(dev, DEVICE_CONNECT_READY);
-	dev->bdaddr_type = addr_type;
 
 	/*
 	 * We are ok to perform connect now. Stop discovery
@@ -6717,16 +6686,12 @@ done:
 static void connect_confirm(GIOChannel *io, void *user_data)
 {
 	struct gatt_device *dev;
-	uint8_t dst_type;
 	bdaddr_t dst;
 	GError *gerr = NULL;
 
 	DBG("");
 
-	bt_io_get(io, &gerr,
-			BT_IO_OPT_DEST_BDADDR, &dst,
-			BT_IO_OPT_DEST_TYPE, &dst_type,
-			BT_IO_OPT_INVALID);
+	bt_io_get(io, &gerr, BT_IO_OPT_DEST_BDADDR, &dst, BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("gatt: bt_io_get: %s", gerr->message);
 		g_error_free(gerr);
@@ -6754,8 +6719,6 @@ static void connect_confirm(GIOChannel *io, void *user_data)
 		}
 	}
 
-	dev->bdaddr_type = dst_type;
-
 	if (!bt_io_accept(io, connect_cb, device_ref(dev), NULL, NULL)) {
 		error("gatt: failed to accept connection");
 		device_unref(dev);
@@ -7120,7 +7083,7 @@ static bool start_listening(void)
 	return true;
 }
 
-static void gatt_paired_cb(const bdaddr_t *addr, uint8_t type)
+static void gatt_paired_cb(const bdaddr_t *addr)
 {
 	struct gatt_device *dev;
 	char address[18];
@@ -7130,9 +7093,6 @@ static void gatt_paired_cb(const bdaddr_t *addr, uint8_t type)
 	if (!dev)
 		return;
 
-	if (dev->bdaddr_type != type)
-		return;
-
 	ba2str(addr, address);
 	DBG("Paired device %s", address);
 
@@ -7149,7 +7109,7 @@ static void gatt_paired_cb(const bdaddr_t *addr, uint8_t type)
 	search_dev_for_srvc(conn, NULL);
 }
 
-static void gatt_unpaired_cb(const bdaddr_t *addr, uint8_t type)
+static void gatt_unpaired_cb(const bdaddr_t *addr)
 {
 	struct gatt_device *dev;
 	char address[18];
@@ -7158,9 +7118,6 @@ static void gatt_unpaired_cb(const bdaddr_t *addr, uint8_t type)
 	if (!dev)
 		return;
 
-	if (dev->bdaddr_type != type)
-		return;
-
 	ba2str(addr, address);
 	DBG("Unpaired device %s", address);
 
diff --git a/android/hidhost.c b/android/hidhost.c
index b696563..2e589f4 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1495,7 +1495,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 }
 
-static void hid_unpaired_cb(const bdaddr_t *addr, uint8_t type)
+static void hid_unpaired_cb(const bdaddr_t *addr)
 {
 	GSList *l;
 	struct hid_device *dev;
-- 
1.9.3

