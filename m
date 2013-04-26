Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 07/27] input: Move timeout setting to device.c
Date: Fri, 26 Apr 2013 08:17:03 +0200
Message-Id: <1366957043-2383-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The timeout setting is global across devices and it's actually only used
inside device.c. Therefore, simplify the code by just passing it once.
---
 profiles/input/device.c  | 12 ++++++++----
 profiles/input/device.h  |  5 +++--
 profiles/input/manager.c |  9 +++++----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 161d8af..d191967 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -75,7 +75,6 @@ struct input_device {
 	guint			ctrl_watch;
 	guint			intr_watch;
 	guint			sec_watch;
-	int			timeout;
 	struct hidp_connadd_req *req;
 	guint			dc_id;
 	bool			disable_sdp;
@@ -86,6 +85,12 @@ struct input_device {
 };
 
 static GSList *devices = NULL;
+static int idle_timeout = 0;
+
+void input_set_idle_timeout(int timeout)
+{
+	idle_timeout = timeout;
+}
 
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static const char *reconnect_mode_to_string(const enum reconnect_mode_t mode);
@@ -392,7 +397,7 @@ static int hidp_add_connection(struct input_device *idev)
 	req->ctrl_sock = g_io_channel_unix_get_fd(idev->ctrl_io);
 	req->intr_sock = g_io_channel_unix_get_fd(idev->intr_io);
 	req->flags     = 0;
-	req->idle_to   = idev->timeout;
+	req->idle_to   = idle_timeout;
 
 	ba2str(&idev->src, src_addr);
 	ba2str(&idev->dst, dst_addr);
@@ -852,7 +857,7 @@ static const GDBusPropertyTable input_properties[] = {
 
 int input_device_register(struct btd_device *device,
 					const char *path, const char *uuid,
-					const sdp_record_t *rec, int timeout)
+					const sdp_record_t *rec)
 {
 	struct input_device *idev;
 
@@ -880,7 +885,6 @@ int input_device_register(struct btd_device *device,
 		return -EINVAL;
 	}
 
-	idev->timeout = timeout;
 	idev->uuid = g_strdup(uuid);
 
 	devices = g_slist_append(devices, idev);
diff --git a/profiles/input/device.h b/profiles/input/device.h
index db69053..798b4b0 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -27,9 +27,10 @@
 struct input_device;
 struct input_conn;
 
+void input_set_idle_timeout(int timeout);
+
 int input_device_register(struct btd_device *device, const char *path,
-				const char *uuid, const sdp_record_t *rec,
-				int timeout);
+				const char *uuid, const sdp_record_t *rec);
 void input_device_unregister(const char *path, const char *uuid);
 
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index d3d4cf3..cdcabfe 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -44,8 +44,6 @@
 #include "server.h"
 #include "manager.h"
 
-static int idle_timeout = 0;
-
 static void input_remove(struct btd_device *device, const char *uuid)
 {
 	const char *path = device_get_path(device);
@@ -65,8 +63,7 @@ static int hid_device_probe(struct btd_profile *p, struct btd_device *device)
 	if (!rec)
 		return -1;
 
-	return input_device_register(device, path, HID_UUID, rec,
-							idle_timeout * 60);
+	return input_device_register(device, path, HID_UUID, rec);
 }
 
 static void hid_device_remove(struct btd_profile *p, struct btd_device *device)
@@ -136,12 +133,16 @@ static int input_init(void)
 
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

