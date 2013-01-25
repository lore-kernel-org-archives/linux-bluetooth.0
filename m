Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 5/6] core: Add a way to connect to LE devices
Date: Fri, 25 Jan 2013 00:07:06 -0300
Message-Id: <1359083227-13122-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

adapter_create_le_connection() implements the Direct Connection
Procedure, we will use it when the device is in range, and we want to
re-connect to it and also when we want to pair to devices.

When pairing and the device is out of range, any attempt of connection will
fail until the connection times out (the controller sends the Connection
Complete event with an error).
---
 src/adapter.c | 22 ++++++++++++++++++++--
 src/adapter.h |  3 +++
 src/device.c  | 10 ++++------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5fd5062..e5bcb15 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4054,8 +4054,8 @@ static void update_found_devices(struct btd_adapter *adapter,
 									dev);
 
 done:
-	if (device_is_le(dev) && g_slist_find(adapter->connect_list, dev)) {
-	}
+	if (device_is_le(dev) && g_slist_find(adapter->connect_list, dev))
+		adapter_create_le_connection(adapter, dev);
 }
 
 static void device_found_callback(uint16_t index, uint16_t length,
@@ -4710,6 +4710,24 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	}
 }
 
+int adapter_create_le_connection(struct btd_adapter *adapter,
+						struct btd_device *dev)
+{
+	GIOChannel *io;
+
+	DBG("");
+
+	io = device_connect_le(dev);
+	if (io == NULL)
+		return -EBUSY;
+
+	g_io_channel_unref(io);
+
+	adapter_connect_list_remove(adapter, dev);
+
+	return 0;
+}
+
 int adapter_cancel_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 							 uint8_t addr_type)
 {
diff --git a/src/adapter.h b/src/adapter.h
index 6e1ba9d..155e3f0 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -166,6 +166,9 @@ int btd_adapter_passkey_reply(struct btd_adapter *adapter,
 				const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 				uint32_t passkey);
 
+int adapter_create_le_connection(struct btd_adapter *adapter,
+						struct btd_device *dev);
+
 int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 					uint8_t addr_type, uint8_t io_cap);
 
diff --git a/src/device.c b/src/device.c
index c76fb2b..2bf1ad9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1411,12 +1411,10 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	device->bonding = bonding;
 	bonding->device = device;
 
-	if (device_is_le(device) && !device_is_connected(device)) {
-		adapter_connect_list_add(adapter, device);
-		return NULL;
-	}
-
-	err = adapter_create_bonding(adapter, &device->bdaddr,
+	if (device_is_le(device) && !device_is_connected(device))
+		err = adapter_create_le_connection(adapter, device);
+	else
+		err = adapter_create_bonding(adapter, &device->bdaddr,
 					device->bdaddr_type, io_cap);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
-- 
1.8.1.1

