Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.dieb@signove.com
Subject: [RFC 1/2] Add Type property to Device
Date: Wed, 30 Mar 2011 15:33:55 -0300
Message-Id: <1301510036-17282-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/device-api.txt |    4 ++++
 src/device.c       |   18 ++++++++++++++++++
 src/device.h       |    2 ++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index d1feb18..a667296 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -130,6 +130,10 @@ Properties	string Address [readonly]
 			Proposed icon name according to the freedesktop.org
 			icon naming specification.
 
+		string Type [readonly]
+
+			Device type (BR/EDR, LE, BR/EDR/LE).
+
 		uint32 Class [readonly]
 
 			The Bluetooth class of device of the remote device.
diff --git a/src/device.c b/src/device.c
index d567952..96683de 100644
--- a/src/device.c
+++ b/src/device.c
@@ -228,6 +228,20 @@ static void device_free(gpointer user_data)
 	g_free(device);
 }
 
+const char *devtype2str(device_type_t type)
+{
+	switch (type) {
+	case DEVICE_TYPE_BREDR:
+		return "BR/EDR";
+	case DEVICE_TYPE_LE:
+		return "LE";
+	case DEVICE_TYPE_DUALMODE:
+		return "BR/EDR/LE";
+	default:
+		return "Unknown";
+	}
+}
+
 gboolean device_is_paired(struct btd_device *device)
 {
 	return device->paired;
@@ -302,6 +316,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 						DBUS_TYPE_STRING, &icon);
 	}
 
+	/* Type */
+	ptr = devtype2str(device->type);
+	dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &ptr);
+
 	/* Paired */
 	boolean = device_is_paired(device);
 	dict_append_entry(&dict, "Paired", DBUS_TYPE_BOOLEAN, &boolean);
diff --git a/src/device.h b/src/device.h
index 3ce212b..b385070 100644
--- a/src/device.h
+++ b/src/device.h
@@ -41,6 +41,8 @@ typedef enum {
 	DEVICE_TYPE_DUALMODE
 } device_type_t;
 
+const char *devtype2str(device_type_t type);
+
 struct btd_device *device_create(DBusConnection *conn,
 				struct btd_adapter *adapter,
 				const gchar *address, device_type_t type);
-- 
1.7.1

