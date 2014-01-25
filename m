Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Rename adapter_remove_device to btd_adapter_remove_device
Message-Id: <20140125005506.7AD85100900@puck.mtv.corp.google.com>
Date: Fri, 24 Jan 2014 16:55:06 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow this symbol to be exported and usable from external plugins.
---
 src/adapter.c | 14 +++++++-------
 src/adapter.h |  3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 570a5bf..649fc7a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1036,8 +1036,8 @@ static void service_auth_cancel(struct service_auth *auth)
 	g_free(auth);
 }
 
-static void adapter_remove_device(struct btd_adapter *adapter,
-						struct btd_device *dev)
+void btd_adapter_remove_device(struct btd_adapter *adapter,
+				struct btd_device *dev)
 {
 	GList *l;
 
@@ -1531,7 +1531,7 @@ static gboolean remove_temp_devices(gpointer user_data)
 		next = g_slist_next(l);
 
 		if (device_is_temporary(dev))
-			adapter_remove_device(adapter, dev);
+			btd_adapter_remove_device(adapter, dev);
 	}
 
 	return FALSE;
@@ -2159,7 +2159,7 @@ static DBusMessage *remove_device(DBusConnection *conn,
 	btd_device_set_temporary(device, TRUE);
 
 	if (!btd_device_is_connected(device)) {
-		adapter_remove_device(adapter, device);
+		btd_adapter_remove_device(adapter, device);
 		return dbus_message_new_method_return(msg);
 	}
 
@@ -4268,7 +4268,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 		const char *path = device_get_path(device);
 
 		DBG("Removing temporary device %s", path);
-		adapter_remove_device(adapter, device);
+		btd_adapter_remove_device(adapter, device);
 	}
 }
 
@@ -5834,7 +5834,7 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 	 * when it is temporary. */
 	if (device && !device_is_bonding(device, NULL)
 						&& device_is_temporary(device))
-		adapter_remove_device(adapter, device);
+		btd_adapter_remove_device(adapter, device);
 }
 
 static void unpaired_callback(uint16_t index, uint16_t length,
@@ -5865,7 +5865,7 @@ static void unpaired_callback(uint16_t index, uint16_t length,
 	if (btd_device_is_connected(device))
 		device_request_disconnect(device, NULL);
 	else
-		adapter_remove_device(adapter, device);
+		btd_adapter_remove_device(adapter, device);
 }
 
 static void read_info_complete(uint8_t status, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index de5b07d..e2e73dc 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -36,6 +36,7 @@
 #define INVALID_PASSKEY		0xffffffff
 
 struct btd_adapter;
+struct btd_device;
 
 struct btd_adapter *btd_adapter_get_default(void);
 bool btd_adapter_is_default(struct btd_adapter *adapter);
@@ -90,6 +91,8 @@ bool btd_adapter_get_connectable(struct btd_adapter *adapter);
 
 uint32_t btd_adapter_get_class(struct btd_adapter *adapter);
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
+void btd_adapter_remove_device(struct btd_adapter *adapter,
+				struct btd_device *dev);
 struct btd_device *btd_adapter_get_device(struct btd_adapter *adapter,
 					const bdaddr_t *addr,
 					uint8_t addr_type);
-- 
1.8.5.3

