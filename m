Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/2] device: Fix storing GATT attributes
Date: Fri, 23 Mar 2018 15:27:14 +0100
Message-Id: <20180323142714.30687-2-szymon.janc@codecoup.pl>
In-Reply-To: <20180323142714.30687-1-szymon.janc@codecoup.pl>
References: <20180323142714.30687-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix two issues:
 - not storing attributes after pairing if device is using RPA
 - storing attributes for temporary device if it is using static
   or public address
---
 src/device.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index f26d6e3d2..102e812e6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2333,11 +2333,12 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 		dev->pending_paired = false;
 	}
 
-	if (!dev->temporary)
+	if (!dev->temporary) {
 		store_device_info(dev);
 
-	if (bdaddr_type != BDADDR_BREDR && err == 0)
-		store_services(dev);
+		if (bdaddr_type != BDADDR_BREDR && err == 0)
+			store_services(dev);
+	}
 
 	if (req)
 		browse_request_complete(req, browse_type, bdaddr_type, err);
@@ -5278,6 +5279,12 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 		adapter_whitelist_add(device->adapter, device);
 
 	store_device_info(device);
+
+	/* attributes were not cached when resolved if device was temporary */
+	if (device->bdaddr_type != BDADDR_BREDR &&
+			device->le_state.svc_resolved &&
+			g_slist_length(device->primaries) != 0)
+		store_services(device);
 }
 
 void btd_device_set_trusted(struct btd_device *device, gboolean trusted)
-- 
2.14.3

