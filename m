Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 4/5] Propagate disconnect reason to device
Date: Mon, 14 May 2012 17:33:03 +0200
Message-Id: <1337009584-17181-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Internally propagate disconnect reason in order to make it public in the
D-Bus API.
---
 src/adapter.c |    2 +-
 src/device.c  |    3 ++-
 src/device.h  |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b9a90dd..4ed32a7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3001,7 +3001,7 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 		return;
 	}
 
-	device_remove_connection(device, connection);
+	device_remove_connection(device, connection, reason);
 
 	adapter->connections = g_slist_remove(adapter->connections, device);
 
diff --git a/src/device.c b/src/device.c
index 82dc2ca..b2b9d54 100644
--- a/src/device.c
+++ b/src/device.c
@@ -915,7 +915,8 @@ void device_add_connection(struct btd_device *device, DBusConnection *conn)
 					DBUS_TYPE_BOOLEAN, &device->connected);
 }
 
-void device_remove_connection(struct btd_device *device, DBusConnection *conn)
+void device_remove_connection(struct btd_device *device, DBusConnection *conn,
+								uint8_t reason)
 {
 	if (!device->connected) {
 		char addr[18];
diff --git a/src/device.h b/src/device.h
index 51140c7..f77d3aa 100644
--- a/src/device.h
+++ b/src/device.h
@@ -91,7 +91,8 @@ gboolean device_is_authenticating(struct btd_device *device);
 gboolean device_is_authorizing(struct btd_device *device);
 void device_set_authorizing(struct btd_device *device, gboolean auth);
 void device_add_connection(struct btd_device *device, DBusConnection *conn);
-void device_remove_connection(struct btd_device *device, DBusConnection *conn);
+void device_remove_connection(struct btd_device *device, DBusConnection *conn,
+								uint8_t reason);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
-- 
1.7.7.6

