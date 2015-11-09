Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Fix not responding to Connect
Date: Mon,  9 Nov 2015 14:57:02 +0200
Message-Id: <1447073822-4624-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If profile is removed while its connection is pending it shall not be
removed directly from pending list since service_remove should first
notify the error which will end up in device_profile_connected that
will take care of cleaning up properly and respond to Connect if
necessary.
---
 src/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6722976..16cbdcf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3320,7 +3320,6 @@ static void device_remove_gatt_service(struct btd_device *device,
 
 	service = l->data;
 	device->services = g_slist_delete_link(device->services, l);
-	device->pending = g_slist_remove(device->pending, service);
 	service_remove(service);
 }
 
@@ -4045,7 +4044,6 @@ void device_remove_profile(gpointer a, gpointer b)
 
 	service = l->data;
 	device->services = g_slist_delete_link(device->services, l);
-	device->pending = g_slist_remove(device->pending, service);
 	service_remove(service);
 }
 
-- 
2.4.3

