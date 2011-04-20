Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Cleanup of device class update signal
Date: Wed, 20 Apr 2011 18:42:16 -0300
Message-Id: <1303335736-12150-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds a new device function to address the PropertyChanged
signal when the device's class changes. event.c file should
avoid sending signals that belongs to device objects.
---
 src/device.c |    8 ++++++++
 src/device.h |    1 +
 src/event.c  |    9 ++-------
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index e5451e8..bacd2c0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2445,3 +2445,11 @@ void btd_device_unref(struct btd_device *device)
 
 	g_free(path);
 }
+
+void device_set_class(struct btd_device *device, uint32_t value)
+{
+	DBusConnection *conn = get_dbus_connection();
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Class",
+				DBUS_TYPE_UINT32, &value);
+}
diff --git a/src/device.h b/src/device.h
index d59b8eb..ad7350a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -99,6 +99,7 @@ guint device_add_disconnect_watch(struct btd_device *device,
 				disconnect_watch watch, void *user_data,
 				GDestroyNotify destroy);
 void device_remove_disconnect_watch(struct btd_device *device, guint id);
+void device_set_class(struct btd_device *device, uint32_t value);
 
 #define BTD_UUIDS(args...) ((const char *[]) { args, NULL } )
 
diff --git a/src/event.c b/src/event.c
index d52edf3..587f16f 100644
--- a/src/event.c
+++ b/src/event.c
@@ -540,11 +540,9 @@ void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
 
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
 {
-	uint32_t old_class = 0;
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	const gchar *dev_path;
-	DBusConnection *conn = get_dbus_connection();
+	uint32_t old_class = 0;
 
 	read_remote_class(local, peer, &old_class);
 
@@ -559,10 +557,7 @@ void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
 	if (!device)
 		return;
 
-	dev_path = device_get_path(device);
-
-	emit_property_changed(conn, dev_path, DEVICE_INTERFACE, "Class",
-				DBUS_TYPE_UINT32, &class);
+	device_set_class(device, class);
 }
 
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status,
-- 
1.7.1

