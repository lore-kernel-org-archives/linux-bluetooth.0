Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix unpair device when disconnected for No Bonding
Date: Mon, 20 Jun 2011 12:23:57 +0300
Message-Id: <1308561837-11530-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix Paired property of device to be false if 'No Bonding' authentication
is used. This property is set to false when device is disconnected and
no link key is stored. Otherwise, there can be cases when device is still
valid and being claimed as paired without available bonding information.

For instanse, use of CreateDevice method call and obex client file
transfer is such use case.
---
 src/device.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index ae6a0d5..e886448 100644
--- a/src/device.c
+++ b/src/device.c
@@ -830,6 +830,14 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
 		device->disconnects = g_slist_remove(device->disconnects, msg);
 	}
 
+	if (device_is_paired(device)) {
+		bdaddr_t src;
+
+		adapter_get_address(device->adapter, &src);
+		if (read_link_key(&src, &device->bdaddr, NULL, NULL))
+			device_set_paired(device, FALSE);
+	}
+
 	emit_property_changed(conn, device->path,
 					DEVICE_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &device->connected);
-- 
1.7.4.1

