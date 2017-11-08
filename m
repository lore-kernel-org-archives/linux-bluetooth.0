Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] plugins/sixaxis: Don't ignore previously setup devices
Date: Wed,  8 Nov 2017 12:24:52 +0100
Message-Id: <20171108112452.9703-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1. Setup PS3 controller through cable pairing
2. Remove device from BlueZ's database
3. Plug original PS3 controller back

As we don't change the master bdaddr on the device itself, the joypad
will likely be trying to connect to BlueZ, and fail to connect after a
small period of time. But the device will appear connected just long
enough for the cable pairing to say "hey, I already have this setup".

Ideally, we would test for whether the device is temporary, or already
trusted, but testing for whether we've setup its internal services *and*
it's connected, rather than *or*, is sufficient.
---
 plugins/sixaxis.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 4e714e72d..47750969b 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -561,16 +561,13 @@ static bool setup_device(int fd, const char *sysfs_path,
 	if (get_device_bdaddr(fd, &device_bdaddr, cp->type) < 0)
 		return false;
 
-	/* This can happen if controller was plugged while already connected
-	 * eg. to charge up battery. */
+	/* This can happen if controller was plugged while already setup and
+	 * connected eg. to charge up battery. */
 	device = btd_adapter_find_device(adapter, &device_bdaddr,
 							BDADDR_BREDR);
-	if (device && btd_device_is_connected(device))
-		return false;
-
-	device = btd_adapter_get_device(adapter, &device_bdaddr, BDADDR_BREDR);
-
-	if (g_slist_find_custom(btd_device_get_uuids(device), HID_UUID,
+	if (device != NULL &&
+		btd_device_is_connected(device) &&
+		g_slist_find_custom(btd_device_get_uuids(device), HID_UUID,
 						(GCompareFunc)strcasecmp)) {
 		char device_addr[18];
 		ba2str(&device_bdaddr, device_addr);
@@ -578,6 +575,8 @@ static bool setup_device(int fd, const char *sysfs_path,
 		return false;
 	}
 
+	device = btd_adapter_get_device(adapter, &device_bdaddr, BDADDR_BREDR);
+
 	info("sixaxis: setting up new device");
 
 	btd_device_device_set_name(device, cp->name);
-- 
2.14.3

