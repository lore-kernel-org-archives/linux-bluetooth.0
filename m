Return-Path: <cyrus@holtmann.org>
Message-ID: <1386428014.32408.12.camel@nuvo>
Subject: [PATCH 1/2] device: When the Class changes, Icon might too
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 07 Dec 2013 15:53:34 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Send out a PropertyChanged signal when the Class changes for
Icon also changing, as it's likely that the Icon needs to be
refetched.

Tested with the PS3 Sixaxis controller connecting the first time
around, as it would not budge from not having any icons until the
client was restarted.
---
 src/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/device.c b/src/device.c
index 5380c1a..d7a00ec 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2285,6 +2285,8 @@ void device_set_class(struct btd_device *device, uint32_t class)
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Class");
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "Icon");
 }
 
 uint32_t btd_device_get_class(struct btd_device *device)
-- 
1.8.4.2


