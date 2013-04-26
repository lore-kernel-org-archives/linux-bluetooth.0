Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 09/27] input: Bypass manager during probe/remove
Date: Fri, 26 Apr 2013 08:17:05 +0200
Message-Id: <1366957043-2383-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use the internal device API to provide the btd_profile callback
functions, without boilerplate code in manager.c.
---
 profiles/input/device.c  | 29 ++++++++++++++++-------------
 profiles/input/device.h  |  5 ++---
 profiles/input/manager.c | 31 ++-----------------------------
 3 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 0688a02..b6f9028 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -92,6 +92,9 @@ void input_set_idle_timeout(int timeout)
 }
 
 static void input_device_enter_reconnect_mode(struct input_device *idev);
+static bool is_device_sdp_disable(const sdp_record_t *rec);
+static void extract_hid_props(struct input_device *idev,
+						const sdp_record_t *rec);
 static const char *reconnect_mode_to_string(const enum reconnect_mode_t mode);
 
 static struct input_device *find_device_by_path(GSList *list, const char *path)
@@ -759,9 +762,10 @@ int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile)
 }
 
 static struct input_device *input_device_new(struct btd_device *device,
-				const char *path, const uint32_t handle,
-				bool disable_sdp)
+							struct btd_profile *p)
 {
+	const char *path = device_get_path(device);
+	const sdp_record_t *rec = btd_device_get_record(device, p->remote_uuid);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
 	char name[HCI_MAX_NAME_LENGTH + 1];
@@ -771,13 +775,16 @@ static struct input_device *input_device_new(struct btd_device *device,
 	bacpy(&idev->dst, device_get_address(device));
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
-	idev->handle = handle;
-	idev->disable_sdp = disable_sdp;
+	idev->handle = rec->handle;
+	idev->disable_sdp = is_device_sdp_disable(rec);
 
 	device_get_name(device, name, HCI_MAX_NAME_LENGTH);
 	if (strlen(name) > 0)
 		idev->name = g_strdup(name);
 
+	/* Initialize device properties */
+	extract_hid_props(idev, rec);
+
 	return idev;
 }
 
@@ -852,10 +859,9 @@ static const GDBusPropertyTable input_properties[] = {
 	{ }
 };
 
-int input_device_register(struct btd_device *device,
-					const char *path, const char *uuid,
-					const sdp_record_t *rec)
+int input_device_register(struct btd_profile *p, struct btd_device *device)
 {
+	const char *path = device_get_path(device);
 	struct input_device *idev;
 
 	DBG("%s", path);
@@ -864,14 +870,10 @@ int input_device_register(struct btd_device *device,
 	if (idev)
 		return -EEXIST;
 
-	idev = input_device_new(device, path, rec->handle,
-			is_device_sdp_disable(rec));
+	idev = input_device_new(device, p);
 	if (!idev)
 		return -EINVAL;
 
-	/* Initialize device properties */
-	extract_hid_props(idev, rec);
-
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 					idev->path, INPUT_INTERFACE,
 					NULL, NULL,
@@ -902,8 +904,9 @@ static struct input_device *find_device(const bdaddr_t *src,
 	return NULL;
 }
 
-void input_device_unregister(const char *path, const char *uuid)
+void input_device_unregister(struct btd_profile *p, struct btd_device *device)
 {
+	const char *path = device_get_path(device);
 	struct input_device *idev;
 
 	DBG("%s", path);
diff --git a/profiles/input/device.h b/profiles/input/device.h
index 798b4b0..1c237fc 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -29,9 +29,8 @@ struct input_conn;
 
 void input_set_idle_timeout(int timeout);
 
-int input_device_register(struct btd_device *device, const char *path,
-				const char *uuid, const sdp_record_t *rec);
-void input_device_unregister(const char *path, const char *uuid);
+int input_device_register(struct btd_profile *p, struct btd_device *device);
+void input_device_unregister(struct btd_profile *p, struct btd_device *device);
 
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index cdcabfe..51cd4cf 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -44,33 +44,6 @@
 #include "server.h"
 #include "manager.h"
 
-static void input_remove(struct btd_device *device, const char *uuid)
-{
-	const char *path = device_get_path(device);
-
-	DBG("path %s", path);
-
-	input_device_unregister(path, uuid);
-}
-
-static int hid_device_probe(struct btd_profile *p, struct btd_device *device)
-{
-	const char *path = device_get_path(device);
-	const sdp_record_t *rec = btd_device_get_record(device, HID_UUID);
-
-	DBG("path %s", path);
-
-	if (!rec)
-		return -1;
-
-	return input_device_register(device, path, HID_UUID, rec);
-}
-
-static void hid_device_remove(struct btd_profile *p, struct btd_device *device)
-{
-	input_remove(device, HID_UUID);
-}
-
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	return server_start(adapter_get_address(adapter));
@@ -91,8 +64,8 @@ static struct btd_profile input_profile = {
 	.connect	= input_device_connect,
 	.disconnect	= input_device_disconnect,
 
-	.device_probe	= hid_device_probe,
-	.device_remove	= hid_device_remove,
+	.device_probe	= input_device_register,
+	.device_remove	= input_device_unregister,
 
 	.adapter_probe	= hid_server_probe,
 	.adapter_remove = hid_server_remove,
-- 
1.8.1.4

