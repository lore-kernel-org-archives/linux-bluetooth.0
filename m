Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/gatt: Add connectable flag to device found callback
Date: Mon,  1 Dec 2014 15:10:13 +0100
Message-Id: <1417443013-32230-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417443013-32230-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417443013-32230-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT is interested in advertising event type. i.e if it is connectable
or not. It is because GATT does not want to triggers connection to
devices doing non-connectable advertising.
This patch add such support.
---
 android/bluetooth.c | 9 ++++++---
 android/bluetooth.h | 3 ++-
 android/gatt.c      | 6 +++++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d6cfc55..f79ca37 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1904,6 +1904,7 @@ static bool is_new_device(const struct device *dev, unsigned int flags,
 
 static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
+					bool connectable,
 					const uint8_t *data, uint8_t data_len)
 {
 	struct eir_data eir;
@@ -1951,7 +1952,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		}
 
 		gatt_device_found_cb(addr, addr_type, rssi, data_len, data,
-								dev->le_bonded);
+						connectable, dev->le_bonded);
 	}
 
 	if (!dev->bredr_paired && !dev->le_paired)
@@ -1987,6 +1988,7 @@ static void mgmt_device_found_event(uint16_t index, uint16_t length,
 	uint16_t eir_len;
 	uint32_t flags;
 	bool confirm_name;
+	bool connectable;
 	char addr[18];
 
 	if (length < sizeof(*ev)) {
@@ -2013,9 +2015,10 @@ static void mgmt_device_found_event(uint16_t index, uint16_t length,
 				index, addr, ev->rssi, flags, eir_len);
 
 	confirm_name = flags & MGMT_DEV_FOUND_CONFIRM_NAME;
+	connectable = !(flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
 
 	update_found_device(&ev->addr.bdaddr, ev->addr.type, ev->rssi,
-						confirm_name, eir, eir_len);
+				confirm_name, connectable, eir, eir_len);
 }
 
 static void mgmt_device_connected_event(uint16_t index, uint16_t length,
@@ -2030,7 +2033,7 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 		return;
 	}
 
-	update_found_device(&ev->addr.bdaddr, ev->addr.type, 0, false,
+	update_found_device(&ev->addr.bdaddr, ev->addr.type, 0, false, false,
 					&ev->eir[0], btohs(ev->eir_len));
 
 	hal_ev.status = HAL_STATUS_SUCCESS;
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 4b7a70d..d09b6f2 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -42,7 +42,8 @@ void bt_adapter_remove_record(uint32_t handle);
 
 typedef void (*bt_le_device_found)(const bdaddr_t *addr, uint8_t addr_type,
 					int rssi, uint16_t eir_len,
-					const void *eir, bool bonded);
+					const void *eir, bool connectable,
+					bool bonded);
 bool bt_le_register(bt_le_device_found cb);
 void bt_le_unregister(void);
 
diff --git a/android/gatt.c b/android/gatt.c
index ce7dc62..a2cb632 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1619,7 +1619,8 @@ static void bt_le_discovery_stop_cb(void)
 
 static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 						int rssi, uint16_t eir_len,
-						const void *eir, bool bonded)
+						const void *eir,
+						bool connectable, bool bonded)
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
@@ -1643,6 +1644,9 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 						sizeof(*ev) + ev->len, ev);
 
 connect:
+	if (!connectable)
+		return;
+
 	/* We use auto connect feature from kernel if possible */
 	if (bt_kernel_conn_control())
 		return;
-- 
1.8.4

