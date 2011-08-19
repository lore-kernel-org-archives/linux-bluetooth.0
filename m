Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Fix remove temporary link key for No Bonding
Date: Fri, 19 Aug 2011 18:24:11 +0300
Message-Id: <1313767451-26674-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes regression caused by 33cdfcb0fabcfb5260953a13ae277b5abe9a322d
in part. Temporary link key should be removed when device is disconnected
and bonding information is not stored in file system.

Otherwise, the key is deleted only when paired device is removed, or
adapter is powered off. In case of No Bonding authentication, device is
not paired after disconnection. As a result, link key is left in memory
after removing device.

On the other hand, device is not necessarily removed after disconnection
that also leaves unneeded temporary link key.
---
 src/device.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9dd657c..f323bf8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -855,8 +855,10 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
 		device->disconnects = g_slist_remove(device->disconnects, msg);
 	}
 
-	if (device_is_paired(device) && !device_is_bonded(device))
+	if (device_is_paired(device) && !device_is_bonded(device)) {
+		btd_adapter_remove_bonding(device->adapter, &device->bdaddr);
 		device_set_paired(device, FALSE);
+	}
 
 	emit_property_changed(conn, device->path,
 					DEVICE_INTERFACE, "Connected",
-- 
1.7.4.1

