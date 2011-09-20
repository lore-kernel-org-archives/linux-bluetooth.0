Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ v2] Fix remove emitting Paired=false when deleting device
Date: Tue, 20 Sep 2011 22:09:50 +0300
Message-Id: <1316545790-3065-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adapter is requested to remove device, device's property
Paired=false is emitted after the adapter notifies clients that
list Devices is empty. Some clients get confused.

Emitting property was introduced in clean-up patch
c92a4af85f480c16f3ff017783c821304c899ce5. Since such notification
does not have practical meaning, it is better to remove it.
---
 src/device.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 96e798f..3a2d88f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -992,7 +992,8 @@ static void device_remove_stored(struct btd_device *device)
 		delete_entry(&src, "linkkeys", addr);
 		delete_entry(&src, "aliases", addr);
 		device_set_bonded(device, FALSE);
-		device_set_paired(device, FALSE);
+		device->paired = FALSE;
+		btd_adapter_remove_bonding(device->adapter, &device->bdaddr);
 	}
 	delete_entry(&src, "profiles", addr);
 	delete_entry(&src, "trusts", addr);
-- 
1.7.4.1

