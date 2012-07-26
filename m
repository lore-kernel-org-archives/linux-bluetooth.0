Return-Path: <cyrus@holtmann.org>
From: bruna.moreira@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 3/3] adapter: Remove Class property from LE devices
Date: Thu, 26 Jul 2012 13:37:28 -0400
Message-Id: <50117f09.0a4bec0a.04ec.ffffcfe7@mx.google.com>
In-Reply-To: <1343324248-19276-1-git-send-email-y>
References: <y>
 <1343324248-19276-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

For LE devices, the Class property is not applicable so it was replaced
by the correct one: Appearance property. If no appearance is supplied in
Adv Data, the Appearance property is set to zero and icon to null.
---
 doc/device-api.txt |    4 ++++
 src/adapter.c      |    6 ++++--
 src/device.c       |    5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 3b84033..1f0dc96 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -116,6 +116,10 @@ Properties	string Address [readonly]
 
 			The Bluetooth class of device of the remote device.
 
+		uint16 Appearance [readonly]
+
+			External appearance of device, as found on GAP service.
+
 		array{string} UUIDs [readonly]
 
 			List of 128-bit UUIDs that represents the available
diff --git a/src/adapter.c b/src/adapter.c
index d46f3c3..d471720 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2700,12 +2700,14 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 		if (read_remote_appearance(&adapter->bdaddr, &dev->bdaddr,
 						dev->bdaddr_type, &app) == 0)
 			icon = gap_appearance_to_icon(app);
-		else
+		else {
+			app = 0;
 			icon = NULL;
+		}
 
 		emit_device_found(adapter->path, paddr,
 				"Address", DBUS_TYPE_STRING, &paddr,
-				"Class", DBUS_TYPE_UINT32, &dev->class,
+				"Appearance", DBUS_TYPE_UINT16, &app,
 				"Icon", DBUS_TYPE_STRING, &icon,
 				"RSSI", DBUS_TYPE_INT16, &rssi,
 				"Name", DBUS_TYPE_STRING, &dev->name,
diff --git a/src/device.c b/src/device.c
index cd571f7..72d11f5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -373,10 +373,13 @@ static DBusMessage *get_properties(DBusConnection *conn,
 
 		dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
 	} else if (read_remote_appearance(&src, &device->bdaddr,
-						device->bdaddr_type, &app) == 0)
+					device->bdaddr_type, &app) == 0) {
 		/* Appearance */
 		icon = gap_appearance_to_icon(app);
 
+		dict_append_entry(&dict, "Appearance", DBUS_TYPE_UINT16, &app);
+	}
+
 	dict_append_entry(&dict, "Icon", DBUS_TYPE_STRING, &icon);
 
 	/* Vendor */
-- 
1.7.9.5

