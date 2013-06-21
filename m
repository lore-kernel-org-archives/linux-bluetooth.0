Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/5] adapter: Remove never used parameter
Date: Fri, 21 Jun 2013 11:17:33 -0300
Message-Id: <1371824255-3071-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

adapter_remove_device() is always called with remove_storage set to
TRUE, so remove it.
---
 src/adapter.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9e817f2..17f5508 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1019,8 +1019,7 @@ static void service_auth_cancel(struct service_auth *auth)
 }
 
 static void adapter_remove_device(struct btd_adapter *adapter,
-						struct btd_device *dev,
-						gboolean remove_storage)
+						struct btd_device *dev)
 {
 	GList *l;
 
@@ -1052,7 +1051,7 @@ static void adapter_remove_device(struct btd_adapter *adapter,
 		service_auth_cancel(auth);
 	}
 
-	device_remove(dev, remove_storage);
+	device_remove(dev, TRUE);
 }
 
 struct btd_device *adapter_get_device(struct btd_adapter *adapter,
@@ -1514,7 +1513,7 @@ static gboolean remove_temp_devices(gpointer user_data)
 		next = g_slist_next(l);
 
 		if (device_is_temporary(dev))
-			adapter_remove_device(adapter, dev, TRUE);
+			adapter_remove_device(adapter, dev);
 	}
 
 	return FALSE;
@@ -2141,7 +2140,7 @@ static DBusMessage *remove_device(DBusConnection *conn,
 	device_set_temporary(device, TRUE);
 
 	if (!device_is_connected(device)) {
-		adapter_remove_device(adapter, device, TRUE);
+		adapter_remove_device(adapter, device);
 		return dbus_message_new_method_return(msg);
 	}
 
@@ -4252,7 +4251,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 		const char *path = device_get_path(device);
 
 		DBG("Removing temporary device %s", path);
-		adapter_remove_device(adapter, device, TRUE);
+		adapter_remove_device(adapter, device);
 	}
 }
 
@@ -5808,7 +5807,7 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 	 * when it is temporary. */
 	if (device && !device_is_bonding(device, NULL)
 						&& device_is_temporary(device))
-		adapter_remove_device(adapter, device, TRUE);
+		adapter_remove_device(adapter, device);
 }
 
 static void unpaired_callback(uint16_t index, uint16_t length,
@@ -5839,7 +5838,7 @@ static void unpaired_callback(uint16_t index, uint16_t length,
 	if (device_is_connected(device))
 		device_request_disconnect(device, NULL);
 	else
-		adapter_remove_device(adapter, device, TRUE);
+		adapter_remove_device(adapter, device);
 }
 
 static void read_info_complete(uint8_t status, uint16_t length,
-- 
1.8.3.1

