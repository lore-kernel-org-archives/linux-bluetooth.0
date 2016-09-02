Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] core/device: Fix attempting to connect to random address over BR/EDR
Date: Fri,  2 Sep 2016 15:49:08 +0300
Message-Id: <1472820549-1976-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BR/EDR don't have the concept of random addresses so the only option is
to over LE in that case.
---
 src/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/device.c b/src/device.c
index fb766d1..b8556f1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1748,6 +1748,10 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	else if (!dev->bredr_state.bonded && dev->le_state.bonded)
 		return dev->bdaddr_type;
 
+	/* If the address is private it can only be connected over LE */
+	if (device_address_is_private(dev))
+		return dev->bdaddr_type;
+
 	if (dev->bredr_seen) {
 		bredr_last = current - dev->bredr_seen;
 		if (bredr_last > SEEN_TRESHHOLD)
-- 
2.7.4

