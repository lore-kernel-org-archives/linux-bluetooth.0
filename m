Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Fix regression introduced by b278efa5
Date: Sun, 30 Mar 2014 08:04:31 +0200
Message-ID: <1396159471-1773-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Seems that GattService onScanResult is only looking into remote uuids in
adverisement data. No device object is created in the Android framework,
Therefore we need to send regular device found for BLE devices as well.
Otherwise the Android GATT application will not be aware of remote device
properties like name etc.
---
 android/bluetooth.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 690aaf6..734adeb 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1331,9 +1331,6 @@ static bool is_new_device(const struct device *dev)
 	if (dev->found)
 		return false;
 
-	if (adapter.cur_discovery_type != SCAN_TYPE_DUAL)
-		return false;
-
 	if (dev->bond_state == HAL_BOND_STATE_BONDED)
 		return false;
 
-- 
1.8.4

