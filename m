Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] input: Remove unneeded Bluetooth Address arguments
Date: Mon, 12 Mar 2012 17:05:26 -0300
Message-Id: <1331582727-924-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/device.c  |   26 ++++++++++++--------------
 input/device.h  |    8 +++-----
 input/manager.c |   17 +++--------------
 3 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/input/device.c b/input/device.c
index 0ab63c0..e4e0b21 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1032,23 +1032,23 @@ static GDBusSignalTable device_signals[] = {
 };
 
 static struct input_device *input_device_new(DBusConnection *conn,
-					struct btd_device *device, const char *path,
-					const bdaddr_t *src, const bdaddr_t *dst,
-					const uint32_t handle)
+				struct btd_device *device, const char *path,
+				const uint32_t handle)
 {
+	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
 	char name[249], src_addr[18], dst_addr[18];
 
 	idev = g_new0(struct input_device, 1);
-	bacpy(&idev->src, src);
-	bacpy(&idev->dst, dst);
+	adapter_get_address(adapter, &idev->src);
+	device_get_address(device, &idev->dst, NULL);
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
 	idev->conn = dbus_connection_ref(conn);
 	idev->handle = handle;
 
-	ba2str(src, src_addr);
-	ba2str(dst, dst_addr);
+	ba2str(&idev->src, src_addr);
+	ba2str(&idev->dst, dst_addr);
 	if (read_device_name(src_addr, dst_addr, name) == 0)
 		idev->name = g_strdup(name);
 
@@ -1083,16 +1083,15 @@ static struct input_conn *input_conn_new(struct input_device *idev,
 }
 
 int input_device_register(DBusConnection *conn, struct btd_device *device,
-			const char *path, const bdaddr_t *src,
-			const bdaddr_t *dst, const char *uuid,
-			uint32_t handle, int timeout)
+					const char *path, const char *uuid,
+					uint32_t handle, int timeout)
 {
 	struct input_device *idev;
 	struct input_conn *iconn;
 
 	idev = find_device_by_path(devices, path);
 	if (!idev) {
-		idev = input_device_new(conn, device, path, src, dst, handle);
+		idev = input_device_new(conn, device, path, handle);
 		if (!idev)
 			return -EINVAL;
 		devices = g_slist_append(devices, idev);
@@ -1108,15 +1107,14 @@ int input_device_register(DBusConnection *conn, struct btd_device *device,
 }
 
 int fake_input_register(DBusConnection *conn, struct btd_device *device,
-			const char *path, bdaddr_t *src, bdaddr_t *dst,
-			const char *uuid, uint8_t channel)
+			const char *path, const char *uuid, uint8_t channel)
 {
 	struct input_device *idev;
 	struct input_conn *iconn;
 
 	idev = find_device_by_path(devices, path);
 	if (!idev) {
-		idev = input_device_new(conn, device, path, src, dst, 0);
+		idev = input_device_new(conn, device, path, 0);
 		if (!idev)
 			return -EINVAL;
 		devices = g_slist_append(devices, idev);
diff --git a/input/device.h b/input/device.h
index 14c0f97..356d9ed 100644
--- a/input/device.h
+++ b/input/device.h
@@ -43,12 +43,10 @@ struct fake_input {
 };
 
 int fake_input_register(DBusConnection *conn, struct btd_device *device,
-			const char *path, bdaddr_t *src, bdaddr_t *dst,
-			const char *uuid, uint8_t channel);
+			const char *path, const char *uuid, uint8_t channel);
 int input_device_register(DBusConnection *conn, struct btd_device *device,
-			const char *path, const bdaddr_t *src,
-			const bdaddr_t *dst, const char *uuid,
-			uint32_t handle, int timeout);
+					const char *path, const char *uuid,
+					uint32_t handle, int timeout);
 int input_device_unregister(const char *path, const char *uuid);
 
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
diff --git a/input/manager.c b/input/manager.c
index ede06be..9bcab10 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -58,21 +58,16 @@ static void input_remove(struct btd_device *device, const char *uuid)
 
 static int hid_device_probe(struct btd_device *device, GSList *uuids)
 {
-	struct btd_adapter *adapter = device_get_adapter(device);
 	const gchar *path = device_get_path(device);
 	const sdp_record_t *rec = btd_device_get_record(device, uuids->data);
-	bdaddr_t src, dst;
 
 	DBG("path %s", path);
 
 	if (!rec)
 		return -1;
 
-	adapter_get_address(adapter, &src);
-	device_get_address(device, &dst, NULL);
-
-	return input_device_register(connection, device, path, &src, &dst,
-				HID_UUID, rec->handle, idle_timeout * 60);
+	return input_device_register(connection, device, path, HID_UUID,
+						rec->handle, idle_timeout * 60);
 }
 
 static void hid_device_remove(struct btd_device *device)
@@ -82,12 +77,10 @@ static void hid_device_remove(struct btd_device *device)
 
 static int headset_probe(struct btd_device *device, GSList *uuids)
 {
-	struct btd_adapter *adapter = device_get_adapter(device);
 	const gchar *path = device_get_path(device);
 	const sdp_record_t *record;
 	sdp_list_t *protos;
 	int ch;
-	bdaddr_t src, dst;
 
 	DBG("path %s", path);
 
@@ -111,11 +104,7 @@ static int headset_probe(struct btd_device *device, GSList *uuids)
 		return -EINVAL;
 	}
 
-	adapter_get_address(adapter, &src);
-	device_get_address(device, &dst, NULL);
-
-	return fake_input_register(connection, device, path, &src, &dst,
-				HSP_HS_UUID, ch);
+	return fake_input_register(connection, device, path, HSP_HS_UUID, ch);
 }
 
 static void headset_remove(struct btd_device *device)
-- 
1.7.8.5

