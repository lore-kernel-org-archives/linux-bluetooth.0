Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] input: Disconnect SDP before connecting HID if HIDSDPDisable is set
Date: Fri, 13 Apr 2012 11:34:19 +0200
Message-ID: <1334309659-2046-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1334309659-2046-1-git-send-email-szymon.janc@tieto.com>
References: <1334309659-2046-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If remote HID device has HIDSDPDisable attribute present and set to
true host should disconnect SDP channel before connecting HID control
channel. Such devices multiplex resources between SDP and HID L2CAP
channels and will reject connection to HID control channel if SDP
channel is already connected.
---
 input/device.c  |   25 +++++++++++++++++++++----
 input/device.h  |    2 +-
 input/manager.c |    4 ++--
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/input/device.c b/input/device.c
index 743699f..59388d8 100644
--- a/input/device.c
+++ b/input/device.c
@@ -56,6 +56,8 @@
 #include "fakehid.h"
 #include "btio.h"
 
+#include "sdp-client.h"
+
 #define INPUT_DEVICE_INTERFACE "org.bluez.Input"
 
 #define BUF_SIZE		16
@@ -83,6 +85,7 @@ struct input_device {
 	bdaddr_t		dst;
 	uint32_t		handle;
 	guint			dc_id;
+	gboolean		disable_sdp;
 	char			*name;
 	struct btd_device	*device;
 	GSList			*connections;
@@ -931,6 +934,9 @@ static DBusMessage *input_device_connect(DBusConnection *conn,
 		/* HID devices */
 		GIOChannel *io;
 
+		if (idev->disable_sdp)
+			bt_clear_cached_session(&idev->src, &idev->dst);
+
 		io = bt_io_connect(BT_IO_L2CAP, control_connect_cb, iconn,
 					NULL, &err,
 					BT_IO_OPT_SOURCE_BDADDR, &idev->src,
@@ -1028,7 +1034,7 @@ static GDBusSignalTable device_signals[] = {
 
 static struct input_device *input_device_new(DBusConnection *conn,
 				struct btd_device *device, const char *path,
-				const uint32_t handle)
+				const uint32_t handle, gboolean disable_sdp)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
@@ -1041,6 +1047,7 @@ static struct input_device *input_device_new(DBusConnection *conn,
 	idev->path = g_strdup(path);
 	idev->conn = dbus_connection_ref(conn);
 	idev->handle = handle;
+	idev->disable_sdp = disable_sdp;
 
 	ba2str(&idev->src, src_addr);
 	ba2str(&idev->dst, dst_addr);
@@ -1075,16 +1082,26 @@ static struct input_conn *input_conn_new(struct input_device *idev,
 	return iconn;
 }
 
+static gboolean is_device_sdp_disable(const sdp_record_t *rec)
+{
+	sdp_data_t *data;
+
+	data = sdp_data_get(rec, SDP_ATTR_HID_SDP_DISABLE);
+
+	return data && data->val.uint8;
+}
+
 int input_device_register(DBusConnection *conn, struct btd_device *device,
 					const char *path, const char *uuid,
-					uint32_t handle, int timeout)
+					const sdp_record_t *rec, int timeout)
 {
 	struct input_device *idev;
 	struct input_conn *iconn;
 
 	idev = find_device_by_path(devices, path);
 	if (!idev) {
-		idev = input_device_new(conn, device, path, handle);
+		idev = input_device_new(conn, device, path, rec->handle,
+					is_device_sdp_disable(rec));
 		if (!idev)
 			return -EINVAL;
 		devices = g_slist_append(devices, idev);
@@ -1107,7 +1124,7 @@ int fake_input_register(DBusConnection *conn, struct btd_device *device,
 
 	idev = find_device_by_path(devices, path);
 	if (!idev) {
-		idev = input_device_new(conn, device, path, 0);
+		idev = input_device_new(conn, device, path, 0, FALSE);
 		if (!idev)
 			return -EINVAL;
 		devices = g_slist_append(devices, idev);
diff --git a/input/device.h b/input/device.h
index 356d9ed..c14b81a 100644
--- a/input/device.h
+++ b/input/device.h
@@ -46,7 +46,7 @@ int fake_input_register(DBusConnection *conn, struct btd_device *device,
 			const char *path, const char *uuid, uint8_t channel);
 int input_device_register(DBusConnection *conn, struct btd_device *device,
 					const char *path, const char *uuid,
-					uint32_t handle, int timeout);
+					const sdp_record_t *rec, int timeout);
 int input_device_unregister(const char *path, const char *uuid);
 
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
diff --git a/input/manager.c b/input/manager.c
index 9bcab10..4ac5686 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -66,8 +66,8 @@ static int hid_device_probe(struct btd_device *device, GSList *uuids)
 	if (!rec)
 		return -1;
 
-	return input_device_register(connection, device, path, HID_UUID,
-						rec->handle, idle_timeout * 60);
+	return input_device_register(connection, device, path, HID_UUID, rec,
+							idle_timeout * 60);
 }
 
 static void hid_device_remove(struct btd_device *device)
-- 
on behalf of ST-Ericsson

