Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Mark AcquireWrite and AcquireNotify as stable
Date: Tue, 19 Dec 2017 15:06:01 -0200
Message-Id: <20171219170601.24722-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

AcquireWrite and AcquireNofify are required by meshctl.
---
 doc/gatt-api.txt  |  4 ++--
 src/gatt-client.c | 10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 8a367783c..ccf3a8b6d 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -91,7 +91,7 @@ Methods		array{byte} ReadValue(dict options)
 					 org.bluez.Error.NotAuthorized
 					 org.bluez.Error.NotSupported
 
-		fd, uint16 AcquireWrite(dict options) [experimental, optional]
+		fd, uint16 AcquireWrite(dict options) [optional]
 
 			Acquire file descriptor and MTU for writing. Usage of
 			WriteValue will be locked causing it to return
@@ -120,7 +120,7 @@ Methods		array{byte} ReadValue(dict options)
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.NotSupported
 
-		fd, uint16 AcquireNotify(dict options) [experimental, optional]
+		fd, uint16 AcquireNotify(dict options) [optional]
 
 			Acquire file descriptor and MTU for notify. Usage of
 			StartNotify will be locked causing it to return
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 6d5bbfa02..2f01867dc 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1612,11 +1612,9 @@ static const GDBusPropertyTable characteristic_properties[] = {
 					characteristic_notifying_exists },
 	{ "Flags", "as", characteristic_get_flags, NULL, NULL },
 	{ "WriteAcquired", "b", characteristic_get_write_acquired, NULL,
-				characteristic_write_acquired_exists,
-				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+				characteristic_write_acquired_exists },
 	{ "NotifyAcquired", "b", characteristic_get_notify_acquired, NULL,
-				characteristic_notify_acquired_exists,
-				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+				characteristic_notify_acquired_exists },
 	{ }
 };
 
@@ -1628,12 +1626,12 @@ static const GDBusMethodTable characteristic_methods[] = {
 						{ "options", "a{sv}" }),
 					NULL,
 					characteristic_write_value) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("AcquireWrite",
+	{ GDBUS_ASYNC_METHOD("AcquireWrite",
 					GDBUS_ARGS({ "options", "a{sv}" }),
 					GDBUS_ARGS({ "fd", "h" },
 						{ "mtu", "q" }),
 					characteristic_acquire_write) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("AcquireNotify",
+	{ GDBUS_ASYNC_METHOD("AcquireNotify",
 					GDBUS_ARGS({ "options", "a{sv}" }),
 					GDBUS_ARGS({ "fd", "h" },
 						{ "mtu", "q" }),
-- 
2.13.6

