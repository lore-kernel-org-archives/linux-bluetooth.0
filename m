Return-Path: <cyrus@holtmann.org>
From: Biman Paul <biman.paul@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Biman Paul <biman.paul@samsung.com>
Subject: [PATCHv2] core: Store Device information immediately after saving
 LinkKey information
Date: Tue, 02 Dec 2014 11:34:18 +0530
Message-id: <1417500258-20694-1-git-send-email-biman.paul@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If bluetooth is turned off while pairing is in progress, sometimes
Linkey information is present but device (Class of Device) information is missing.

This patch stores the device information immediately after Linkkey
information is saved so that Class of Device information is stored.
---
 src/device.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index 025743f..e9630ed 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4031,6 +4031,7 @@ void btd_device_set_temporary(struct btd_device *device, gboolean temporary)
 	} else {
 		if (device->bredr)
 			adapter_whitelist_add(device->adapter, device);
+		store_device_info(device);
 	}
 
 	device->temporary = temporary;
-- 
1.7.9.5

