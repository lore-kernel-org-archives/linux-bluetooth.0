Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/bluetooth: Add bonded information to found device callback
Date: Tue, 20 May 2014 17:37:34 +0200
Message-Id: <1400600254-19736-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device is bonded then discoverable flag is not set. This cause that
gatt application will not get scan callback with advertising bonded
device.

---

Not sure if it should work like that but lets do it for now. It is
useful for testing at least.

 android/bluetooth.c | 3 ++-
 android/bluetooth.h | 3 ++-
 android/gatt.c      | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 379d8ea..93b9cd7 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1503,7 +1503,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		discoverable = eir.flags & (EIR_LIM_DISC | EIR_GEN_DISC);
 
 		gatt_device_found_cb(bdaddr, bdaddr_type, rssi, data_len, data,
-								discoverable);
+								discoverable,
+								dev->le_bonded);
 	}
 
 	if (!dev->bredr_paired && !dev->le_paired)
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 6a3e766..a0b81a6 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -37,7 +37,8 @@ void bt_adapter_remove_record(uint32_t handle);
 
 typedef void (*bt_le_device_found)(const bdaddr_t *addr, uint8_t addr_type,
 					int rssi, uint16_t eir_len,
-					const void *eir, bool discoverable);
+					const void *eir, bool discoverable,
+					bool bonded);
 bool bt_le_discovery_start(bt_le_device_found cb);
 
 typedef void (*bt_le_discovery_stopped)(void);
diff --git a/android/gatt.c b/android/gatt.c
index 8e0d72a..e1deda7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -906,15 +906,15 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 
 static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 						int rssi, uint16_t eir_len,
-							const void *eir,
-							bool discoverable)
+						const void *eir,
+						bool discoverable, bool bonded)
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
 	struct gatt_device *dev;
 	char bda[18];
 
-	if (!scanning || !discoverable)
+	if (!scanning || (!discoverable && !bonded))
 		goto connect;
 
 	ba2str(addr, bda);
-- 
1.8.4

