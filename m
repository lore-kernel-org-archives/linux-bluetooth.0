Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 13/13] core/adapter: Create device even if not-connectable
Date: Thu, 16 Apr 2015 17:41:15 +0300
Message-Id: <1429195275-19635-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
References: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is in fact discoverable it should be no problem to create
a D-Bus object for it as the object is required in order to attach the
advertisement data in case a broadcaster/beacons come in range.
---
 src/adapter.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9de161b..5af8489 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5373,6 +5373,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
 					bool confirm, bool legacy,
+					bool not_connectable,
 					const uint8_t *data, uint8_t data_len)
 {
 	struct btd_device *dev;
@@ -5501,6 +5502,10 @@ static void update_found_devices(struct btd_adapter *adapter,
 	return;
 
 connect_le:
+	/* Ignore non-connectable events */
+	if (not_connectable)
+		return;
+
 	/*
 	 * If we're in the process of stopping passive scanning and
 	 * connecting another (or maybe even the same) LE device just
@@ -5563,15 +5568,12 @@ static void device_found_callback(uint16_t index, uint16_t length,
 	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u",
 			index, addr, ev->rssi, flags, eir_len);
 
-	/* Ignore non-connectable events for now */
-	if (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE)
-		return;
-
 	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
 	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
 
 	update_found_devices(adapter, &ev->addr.bdaddr, ev->addr.type,
 					ev->rssi, confirm_name, legacy,
+					flags & MGMT_DEV_FOUND_NOT_CONNECTABLE,
 					eir, eir_len);
 }
 
-- 
2.1.0

