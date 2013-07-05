Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/device: Fix crash while freeing services list
Date: Fri,  5 Jul 2013 17:03:42 +0300
Message-Id: <1373033022-11180-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373033022-11180-1-git-send-email-luiz.dentz@gmail.com>
References: <1373033022-11180-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_service do alter its state on service_shutdown which can cause
plugins to attempt to access services list which may have freed some
services already.

To fix this the code now updates the list  in place so any service that
is gonna be shutdown is removed from the list so it no longer accessible
after freed.
---
 src/device.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index edd377c..300c358 100644
--- a/src/device.c
+++ b/src/device.c
@@ -994,8 +994,13 @@ int device_block(struct btd_device *device, gboolean update_only)
 	if (device->connected)
 		do_disconnect(device);
 
-	g_slist_free_full(device->services, remove_service);
-	device->services = NULL;
+	while (device->services != NULL) {
+		struct btd_service *service = device->services->data;
+
+		device->services = g_slist_remove(device->services, service);
+		service_shutdown(service);
+		btd_service_unref(service);
+	}
 
 	if (!update_only)
 		err = btd_adapter_block_address(device->adapter,
@@ -2362,7 +2367,6 @@ static void device_remove_stored(struct btd_device *device)
 
 void device_remove(struct btd_device *device, gboolean remove_stored)
 {
-
 	DBG("Removing device %s", device->path);
 
 	if (device->bonding) {
@@ -2379,7 +2383,13 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (device->browse)
 		browse_request_cancel(device->browse);
 
-	g_slist_foreach(device->services, dev_disconn_service, NULL);
+	while (device->services != NULL) {
+		struct btd_service *service = device->services->data;
+
+		device->services = g_slist_remove(device->services, service);
+		service_shutdown(service);
+		btd_service_unref(service);
+	}
 
 	g_slist_free(device->pending);
 	device->pending = NULL;
@@ -2398,9 +2408,6 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (remove_stored)
 		device_remove_stored(device);
 
-	g_slist_free_full(device->services, remove_service);
-	device->services = NULL;
-
 	btd_device_unref(device);
 }
 
-- 
1.8.1.4

