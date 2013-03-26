Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 09/11] input: Hold a reference to btd_service
Date: Tue, 26 Mar 2013 17:13:52 +0100
Message-Id: <1364314434-9796-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Profile implementations are expected to hold a reference to probed
services, so update the input profiles accordingly.
---
 profiles/input/device.c  | 74 +++++++++++++++++++++++++-----------------------
 profiles/input/device.h  |  8 +++---
 profiles/input/manager.c | 41 ++++-----------------------
 3 files changed, 48 insertions(+), 75 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 1da9d99..2115111 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -44,6 +44,7 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
+#include "../src/service.h"
 #include "../src/storage.h"
 #include "../src/dbus-common.h"
 
@@ -55,9 +56,9 @@
 #include "sdp-client.h"
 
 struct input_device {
+	struct btd_service	*service;
 	struct btd_device	*device;
 	char			*path;
-	char			*uuid;
 	bdaddr_t		src;
 	bdaddr_t		dst;
 	uint32_t		handle;
@@ -66,7 +67,6 @@ struct input_device {
 	guint			ctrl_watch;
 	guint			intr_watch;
 	guint			sec_watch;
-	int			timeout;
 	struct hidp_connadd_req *req;
 	guint			dc_id;
 	gboolean		disable_sdp;
@@ -74,6 +74,12 @@ struct input_device {
 };
 
 static GSList *devices = NULL;
+static int idle_timeout = 0;
+
+void input_set_idle_timeout(int timeout)
+{
+	idle_timeout = timeout;
+}
 
 static struct input_device *find_device_by_path(GSList *list, const char *path)
 {
@@ -92,6 +98,7 @@ static void input_device_free(struct input_device *idev)
 	if (idev->dc_id)
 		device_remove_disconnect_watch(idev->device, idev->dc_id);
 
+	btd_service_unref(idev->service);
 	btd_device_unref(idev->device);
 	g_free(idev->name);
 	g_free(idev->path);
@@ -111,8 +118,6 @@ static void input_device_free(struct input_device *idev)
 	if (idev->ctrl_io)
 		g_io_channel_unref(idev->ctrl_io);
 
-	g_free(idev->uuid);
-
 	g_free(idev);
 }
 
@@ -366,7 +371,7 @@ static int hidp_add_connection(struct input_device *idev)
 	req->ctrl_sock = g_io_channel_unix_get_fd(idev->ctrl_io);
 	req->intr_sock = g_io_channel_unix_get_fd(idev->intr_io);
 	req->flags     = 0;
-	req->idle_to   = idev->timeout;
+	req->idle_to   = idle_timeout;
 
 	ba2str(&idev->src, src_addr);
 	ba2str(&idev->dst, dst_addr);
@@ -674,10 +679,21 @@ int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile)
 	return 0;
 }
 
-static struct input_device *input_device_new(struct btd_device *device,
-				const char *path, const uint32_t handle,
-				gboolean disable_sdp)
+static gboolean is_device_sdp_disable(const sdp_record_t *rec)
 {
+	sdp_data_t *data;
+
+	data = sdp_data_get(rec, SDP_ATTR_HID_SDP_DISABLE);
+
+	return data && data->val.uint8;
+}
+
+static struct input_device *input_device_new(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+	struct btd_profile *p = btd_service_get_profile(service);
+	const sdp_record_t *rec = btd_device_get_record(device, p->remote_uuid);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
 	char name[HCI_MAX_NAME_LENGTH + 1];
@@ -685,10 +701,11 @@ static struct input_device *input_device_new(struct btd_device *device,
 	idev = g_new0(struct input_device, 1);
 	bacpy(&idev->src, adapter_get_address(adapter));
 	bacpy(&idev->dst, device_get_address(device));
+	idev->service = btd_service_ref(service);
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
-	idev->handle = handle;
-	idev->disable_sdp = disable_sdp;
+	idev->handle = rec->handle;
+	idev->disable_sdp = is_device_sdp_disable(rec);
 
 	device_get_name(device, name, HCI_MAX_NAME_LENGTH);
 	if (strlen(name) > 0)
@@ -697,19 +714,10 @@ static struct input_device *input_device_new(struct btd_device *device,
 	return idev;
 }
 
-static gboolean is_device_sdp_disable(const sdp_record_t *rec)
-{
-	sdp_data_t *data;
-
-	data = sdp_data_get(rec, SDP_ATTR_HID_SDP_DISABLE);
-
-	return data && data->val.uint8;
-}
-
-int input_device_register(struct btd_device *device,
-					const char *path, const char *uuid,
-					const sdp_record_t *rec, int timeout)
+int input_device_register(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
 	struct input_device *idev;
 
 	DBG("%s", path);
@@ -718,13 +726,11 @@ int input_device_register(struct btd_device *device,
 	if (idev)
 		return -EEXIST;
 
-	idev = input_device_new(device, path, rec->handle,
-			is_device_sdp_disable(rec));
+	idev = input_device_new(service);
 	if (!idev)
 		return -EINVAL;
 
-	idev->timeout = timeout;
-	idev->uuid = g_strdup(uuid);
+	btd_service_set_user_data(service, idev);
 
 	devices = g_slist_append(devices, idev);
 
@@ -746,25 +752,21 @@ static struct input_device *find_device(const bdaddr_t *src,
 	return NULL;
 }
 
-int input_device_unregister(const char *path, const char *uuid)
+void input_device_unregister(struct btd_service *service)
 {
-	struct input_device *idev;
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+	struct input_device *idev = btd_service_get_user_data(service);
 
 	DBG("%s", path);
 
-	idev = find_device_by_path(devices, path);
-	if (idev == NULL)
-		return -EINVAL;
-
 	if (idev->ctrl_io) {
-		/* Pending connection running */
-		return -EBUSY;
+		/* FIXME: pending connection running */
+		return;
 	}
 
 	devices = g_slist_remove(devices, idev);
 	input_device_free(idev);
-
-	return 0;
 }
 
 static int input_device_connadd(struct input_device *idev)
diff --git a/profiles/input/device.h b/profiles/input/device.h
index aabc79c..fd7f847 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -27,10 +27,10 @@
 struct input_device;
 struct input_conn;
 
-int input_device_register(struct btd_device *device, const char *path,
-				const char *uuid, const sdp_record_t *rec,
-				int timeout);
-int input_device_unregister(const char *path, const char *uuid);
+void input_set_idle_timeout(int timeout);
+
+int input_device_register(struct btd_service *service);
+void input_device_unregister(struct btd_service *service);
 
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 72a4e3b..dc771a6 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -45,39 +45,6 @@
 #include "server.h"
 #include "manager.h"
 
-static int idle_timeout = 0;
-
-static void input_remove(struct btd_device *device, const char *uuid)
-{
-	const char *path = device_get_path(device);
-
-	DBG("path %s", path);
-
-	input_device_unregister(path, uuid);
-}
-
-static int hid_device_probe(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	const char *path = device_get_path(device);
-	const sdp_record_t *rec = btd_device_get_record(device, HID_UUID);
-
-	DBG("path %s", path);
-
-	if (!rec)
-		return -1;
-
-	return input_device_register(device, path, HID_UUID, rec,
-							idle_timeout * 60);
-}
-
-static void hid_device_remove(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-
-	input_remove(device, HID_UUID);
-}
-
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	return server_start(adapter_get_address(adapter));
@@ -98,8 +65,8 @@ static struct btd_profile input_profile = {
 	.connect	= input_device_connect,
 	.disconnect	= input_device_disconnect,
 
-	.device_probe	= hid_device_probe,
-	.device_remove	= hid_device_remove,
+	.device_probe	= input_device_register,
+	.device_remove	= input_device_unregister,
 
 	.adapter_probe	= hid_server_probe,
 	.adapter_remove = hid_server_remove,
@@ -140,12 +107,16 @@ static int input_init(void)
 
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
+		int idle_timeout;
+
 		idle_timeout = g_key_file_get_integer(config, "General",
 						"IdleTimeout", &err);
 		if (err) {
 			DBG("input.conf: %s", err->message);
 			g_error_free(err);
 		}
+
+		input_set_idle_timeout(idle_timeout * 60);
 	}
 
 	btd_profile_register(&input_profile);
-- 
1.8.1.4

