Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Make it more clear random addresses can only be used with LE
Date: Tue,  6 Sep 2016 14:04:51 +0300
Message-Id: <1473159891-11621-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Any random address type can only be connected over LE as BR/EDR only
support public addresses.
---
 src/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index b8556f1..9586022 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1748,8 +1748,8 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	else if (!dev->bredr_state.bonded && dev->le_state.bonded)
 		return dev->bdaddr_type;
 
-	/* If the address is private it can only be connected over LE */
-	if (device_address_is_private(dev))
+	/* If the address is random it can only be connected over LE */
+	if (dev->bdaddr_type == BDADDR_LE_RANDOM)
 		return dev->bdaddr_type;
 
 	if (dev->bredr_seen) {
-- 
2.7.4

