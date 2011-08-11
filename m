Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/3] Code clean-up: value is used in set paired and bonded
Date: Thu, 11 Aug 2011 17:59:47 +0300
Message-Id: <1313074788-16317-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1313074788-16317-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1313074788-16317-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Prototype for device_set_paired is updated accordingly to its function
definition.

In order to make code consistent, variable value is to be used in
device_set_paired and device_set_bonded instead of paired and bonded
respectively.
---
 src/device.c |    8 ++++----
 src/device.h |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7ff26c1..40d2cfd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1914,22 +1914,22 @@ void device_set_temporary(struct btd_device *device, gboolean temporary)
 	device->temporary = temporary;
 }
 
-void device_set_bonded(struct btd_device *device, gboolean bonded)
+void device_set_bonded(struct btd_device *device, gboolean value)
 {
 	DBusConnection *conn = get_dbus_connection();
 
 	if (device_is_bonded(device) == bonded)
 		return;
 
-	DBG("%s", bonded ? "TRUE" : "FALSE");
+	DBG("%s", value ? "TRUE" : "FALSE");
 
-	if (bonded)
+	if (value)
 		device->pairing_status = DEVICE_PAIRING_STATUS_BONDED;
 	else
 		device->pairing_status = DEVICE_PAIRING_STATUS_NONE;
 
 	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Paired",
-				DBUS_TYPE_BOOLEAN, &bonded);
+				DBUS_TYPE_BOOLEAN, &value);
 }
 
 void device_set_type(struct btd_device *device, device_type_t type)
diff --git a/src/device.h b/src/device.h
index 6efcf63..0f3e857 100644
--- a/src/device.h
+++ b/src/device.h
@@ -70,10 +70,10 @@ gboolean device_is_temporary(struct btd_device *device);
 gboolean device_is_paired(struct btd_device *device);
 gboolean device_is_bonded(struct btd_device *device);
 gboolean device_is_trusted(struct btd_device *device);
-void device_set_paired(struct btd_device *device, gboolean paired);
+void device_set_paired(struct btd_device *device, gboolean value);
 void device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_type(struct btd_device *device, device_type_t type);
-void device_set_bonded(struct btd_device *device, gboolean bonded);
+void device_set_bonded(struct btd_device *device, gboolean value);
 gboolean device_is_connected(struct btd_device *device);
 DBusMessage *device_create_bonding(struct btd_device *device,
 				DBusConnection *conn, DBusMessage *msg,
-- 
1.7.4.1

