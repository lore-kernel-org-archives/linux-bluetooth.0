Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 25/27] input: Hold a reference to btd_service
Date: Fri, 26 Apr 2013 08:17:21 +0200
Message-Id: <1366957043-2383-26-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Profile implementations are allowed to hold a reference to probed
services and make use of the service's userdata pointer, so update the
input profiles accordingly.
---
 profiles/input/device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index c9a3612..adbd114 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -65,6 +65,7 @@ enum reconnect_mode_t {
 };
 
 struct input_device {
+	struct btd_service	*service;
 	struct btd_device	*device;
 	char			*path;
 	bdaddr_t		src;
@@ -115,6 +116,7 @@ static void input_device_free(struct input_device *idev)
 	if (idev->dc_id)
 		device_remove_disconnect_watch(idev->device, idev->dc_id);
 
+	btd_service_unref(idev->service);
 	btd_device_unref(idev->device);
 	g_free(idev->name);
 	g_free(idev->path);
@@ -775,6 +777,7 @@ static struct input_device *input_device_new(struct btd_service *service)
 	idev = g_new0(struct input_device, 1);
 	bacpy(&idev->src, adapter_get_address(adapter));
 	bacpy(&idev->dst, device_get_address(device));
+	idev->service = btd_service_ref(service);
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
 	idev->handle = rec->handle;
@@ -887,6 +890,8 @@ int input_device_register(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	btd_service_set_user_data(service, idev);
+
 	devices = g_slist_append(devices, idev);
 
 	return 0;
@@ -911,14 +916,10 @@ void input_device_unregister(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
-	struct input_device *idev;
+	struct input_device *idev = btd_service_get_user_data(service);
 
 	DBG("%s", path);
 
-	idev = find_device_by_path(devices, path);
-	if (idev == NULL)
-		return;
-
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 						idev->path, INPUT_INTERFACE);
 
-- 
1.8.1.4

