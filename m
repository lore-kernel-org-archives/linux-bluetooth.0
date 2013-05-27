Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 6/6] input: Use btd_service userdata pointer
Date: Mon, 27 May 2013 14:04:09 +0200
Message-Id: <1369656249-27980-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Avoid maintaining an internal list of probed input_device instances by
making use of btd_service's userdata pointer.
---
 profiles/input/device.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 498c226..7c3130c 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -41,6 +41,7 @@
 
 #include "log.h"
 
+#include "lib/uuid.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
@@ -84,7 +85,6 @@ struct input_device {
 	uint32_t		reconnect_attempt;
 };
 
-static GSList *devices = NULL;
 static int idle_timeout = 0;
 
 void input_set_idle_timeout(int timeout)
@@ -94,18 +94,6 @@ void input_set_idle_timeout(int timeout)
 
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 
-static struct input_device *find_device_by_path(GSList *list, const char *path)
-{
-	for (; list; list = list->next) {
-		struct input_device *idev = list->data;
-
-		if (!strcmp(idev->path, path))
-			return idev;
-	}
-
-	return NULL;
-}
-
 static void input_device_free(struct input_device *idev)
 {
 	if (idev->dc_id)
@@ -863,10 +851,6 @@ int input_device_register(struct btd_service *service)
 
 	DBG("%s", path);
 
-	idev = find_device_by_path(devices, path);
-	if (idev)
-		return -EEXIST;
-
 	idev = input_device_new(service);
 	if (!idev)
 		return -EINVAL;
@@ -883,24 +867,24 @@ int input_device_register(struct btd_service *service)
 
 	btd_service_set_user_data(service, idev);
 
-	devices = g_slist_append(devices, idev);
-
 	return 0;
 }
 
 static struct input_device *find_device(const bdaddr_t *src,
 					const bdaddr_t *dst)
 {
-	GSList *list;
+	struct btd_device *device;
+	struct btd_service *service;
 
-	for (list = devices; list != NULL; list = list->next) {
-		struct input_device *idev = list->data;
+	device = adapter_find_device(adapter_find(src), dst);
+	if (device == NULL)
+		return NULL;
 
-		if (!bacmp(&idev->src, src) && !bacmp(&idev->dst, dst))
-			return idev;
-	}
+	service = btd_device_get_service(device, HID_UUID);
+	if (service == NULL)
+		return NULL;
 
-	return NULL;
+	return btd_service_get_user_data(service);
 }
 
 void input_device_unregister(struct btd_service *service)
@@ -914,7 +898,6 @@ void input_device_unregister(struct btd_service *service)
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 						idev->path, INPUT_INTERFACE);
 
-	devices = g_slist_remove(devices, idev);
 	input_device_free(idev);
 }
 
-- 
1.8.1.4

