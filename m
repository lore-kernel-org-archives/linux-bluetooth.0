Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 12/17] input: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:14 +0200
Message-ID: <1348050139-27883-13-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes redundant references and function parameters for
DBusConnection object and uses btd_get_dbus_connection() call wherever
such object is needed instead.

Pointer returned by this call is guaranteed to be valid for entire
bluetoothd lifetime and thus do not need to be refcounted.
---
 profiles/input/device.c  | 25 +++++++++++++------------
 profiles/input/device.h  |  6 +++---
 profiles/input/main.c    | 12 +-----------
 profiles/input/manager.c | 10 ++--------
 profiles/input/manager.h |  2 +-
 5 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index dc3da80..73204e0 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -103,7 +103,6 @@ static void input_device_free(struct input_device *idev)
 	if (idev->dc_id)
 		device_remove_disconnect_watch(idev->device, idev->dc_id);
 
-	dbus_connection_unref(idev->conn);
 	btd_device_unref(idev->device);
 	g_free(idev->name);
 	g_free(idev->path);
@@ -506,6 +505,7 @@ static int input_device_connected(struct input_device *idev)
 static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct input_device *idev = user_data;
 	DBusMessage *reply;
 	int err;
@@ -523,7 +523,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 	}
 
 	/* Replying to the requestor */
-	g_dbus_send_reply(idev->conn, idev->pending_connect, DBUS_TYPE_INVALID);
+	g_dbus_send_reply(conn, idev->pending_connect, DBUS_TYPE_INVALID);
 
 	dbus_message_unref(idev->pending_connect);
 	idev->pending_connect = NULL;
@@ -537,7 +537,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 failed:
 	error("%s", err_msg);
 	reply = btd_error_failed(idev->pending_connect, err_msg);
-	g_dbus_send_message(idev->conn, reply);
+	g_dbus_send_message(conn, reply);
 
 	dbus_message_unref(idev->pending_connect);
 	idev->pending_connect = NULL;
@@ -599,7 +599,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 failed:
 	g_io_channel_unref(idev->ctrl_io);
 	idev->ctrl_io = NULL;
-	g_dbus_send_message(idev->conn, reply);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 	dbus_message_unref(idev->pending_connect);
 	idev->pending_connect = NULL;
 }
@@ -716,9 +716,9 @@ static const GDBusSignalTable device_signals[] = {
 	{ }
 };
 
-static struct input_device *input_device_new(DBusConnection *conn,
-				struct btd_device *device, const char *path,
-				const uint32_t handle, gboolean disable_sdp)
+static struct input_device *input_device_new(struct btd_device *device,
+				const char *path, const uint32_t handle,
+				gboolean disable_sdp)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
@@ -730,7 +730,6 @@ static struct input_device *input_device_new(DBusConnection *conn,
 	device_get_address(device, &idev->dst, &dst_type);
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
-	idev->conn = dbus_connection_ref(conn);
 	idev->handle = handle;
 	idev->disable_sdp = disable_sdp;
 
@@ -740,7 +739,8 @@ static struct input_device *input_device_new(DBusConnection *conn,
 	if (read_device_name(src_addr, dst_addr, dst_type, name) == 0)
 		idev->name = g_strdup(name);
 
-	if (g_dbus_register_interface(conn, idev->path, INPUT_DEVICE_INTERFACE,
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+					idev->path, INPUT_DEVICE_INTERFACE,
 					device_methods, device_signals, NULL,
 					idev, device_unregister) == FALSE) {
 		error("Failed to register interface %s on path %s",
@@ -764,7 +764,7 @@ static gboolean is_device_sdp_disable(const sdp_record_t *rec)
 	return data && data->val.uint8;
 }
 
-int input_device_register(DBusConnection *conn, struct btd_device *device,
+int input_device_register(struct btd_device *device,
 					const char *path, const char *uuid,
 					const sdp_record_t *rec, int timeout)
 {
@@ -774,7 +774,7 @@ int input_device_register(DBusConnection *conn, struct btd_device *device,
 	if (idev)
 		return -EEXIST;
 
-	idev = input_device_new(conn, device, path, rec->handle,
+	idev = input_device_new(device, path, rec->handle,
 			is_device_sdp_disable(rec));
 	if (!idev)
 		return -EINVAL;
@@ -815,7 +815,8 @@ int input_device_unregister(const char *path, const char *uuid)
 		return -EBUSY;
 	}
 
-	g_dbus_unregister_interface(idev->conn, path, INPUT_DEVICE_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						path, INPUT_DEVICE_INTERFACE);
 
 	return 0;
 }
diff --git a/profiles/input/device.h b/profiles/input/device.h
index 0632570..b26d617 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -27,9 +27,9 @@
 struct input_device;
 struct input_conn;
 
-int input_device_register(DBusConnection *conn, struct btd_device *device,
-					const char *path, const char *uuid,
-					const sdp_record_t *rec, int timeout);
+int input_device_register(struct btd_device *device, const char *path,
+				const char *uuid, const sdp_record_t *rec,
+				int timeout);
 int input_device_unregister(const char *path, const char *uuid);
 
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
diff --git a/profiles/input/main.c b/profiles/input/main.c
index 05469a1..4ddc511 100644
--- a/profiles/input/main.c
+++ b/profiles/input/main.c
@@ -53,22 +53,14 @@ static GKeyFile *load_config_file(const char *file)
 	return keyfile;
 }
 
-static DBusConnection *connection;
-
 static int input_init(void)
 {
 	GKeyFile *config;
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-
 	config = load_config_file(CONFIGDIR "/input.conf");
 
-	if (input_manager_init(connection, config) < 0) {
-		dbus_connection_unref(connection);
+	if (input_manager_init(config) < 0)
 		return -EIO;
-	}
 
 	if (config)
 		g_key_file_free(config);
@@ -79,8 +71,6 @@ static int input_init(void)
 static void input_exit(void)
 {
 	input_manager_exit();
-
-	dbus_connection_unref(connection);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(input, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 13096c7..c899b4e 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -45,7 +45,6 @@
 
 static int idle_timeout = 0;
 
-static DBusConnection *connection = NULL;
 static GSList *adapters = NULL;
 
 static void input_remove(struct btd_device *device, const char *uuid)
@@ -67,7 +66,7 @@ static int hid_device_probe(struct btd_device *device, GSList *uuids)
 	if (!rec)
 		return -1;
 
-	return input_device_register(connection, device, path, HID_UUID, rec,
+	return input_device_register(device, path, HID_UUID, rec,
 							idle_timeout * 60);
 }
 
@@ -115,7 +114,7 @@ static struct btd_profile input_profile = {
 	.adapter_remove = hid_server_remove,
 };
 
-int input_manager_init(DBusConnection *conn, GKeyFile *config)
+int input_manager_init(GKeyFile *config)
 {
 	GError *err = NULL;
 
@@ -128,8 +127,6 @@ int input_manager_init(DBusConnection *conn, GKeyFile *config)
 		}
 	}
 
-	connection = dbus_connection_ref(conn);
-
 	btd_profile_register(&input_profile);
 
 	return 0;
@@ -138,7 +135,4 @@ int input_manager_init(DBusConnection *conn, GKeyFile *config)
 void input_manager_exit(void)
 {
 	btd_profile_unregister(&input_profile);
-
-	dbus_connection_unref(connection);
-	connection = NULL;
 }
diff --git a/profiles/input/manager.h b/profiles/input/manager.h
index 7b93c5b..3f73253 100644
--- a/profiles/input/manager.h
+++ b/profiles/input/manager.h
@@ -21,5 +21,5 @@
  *
  */
 
-int input_manager_init(DBusConnection *conn, GKeyFile *config);
+int input_manager_init(GKeyFile *config);
 void input_manager_exit(void);
-- 
1.7.11.3

