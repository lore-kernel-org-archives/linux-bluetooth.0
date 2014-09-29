Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ] core: Reduce RSSI delta threshold for RSSI property updates on Device1.
Date: Mon, 29 Sep 2014 15:16:04 -0700
Message-Id: <1412028964-5298-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently the daemon does not update the RSSI property of a device object unless
it sees a change of at least 8 dBm. This is too large for proximity use cases
involving changes in distance within 4-5 feet. This patch reduces the threshold
to 2 dBm to address this.
---
 src/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 875a5c5..821549e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4094,8 +4094,8 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
 		else
 			delta = rssi - device->rssi;
 
-		/* only report changes of 8 dBm or more */
-		if (delta < 8)
+		/* only report changes of 2 dBm or more */
+		if (delta < 2)
 			return;
 
 		DBG("rssi %d delta %d", rssi, delta);
-- 
2.1.0.rc2.206.gedb03e5

