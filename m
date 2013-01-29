Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] core: Fix g_source_remove() with zero ID while removing device
Date: Tue, 29 Jan 2013 14:52:26 -0400
Message-Id: <1359485546-28790-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

store_device_info_cb() is also used as callback for g_idle_add() and
therefore sets device->store_id to zero. During device removal it may be
called manually, which must be done only after the existing
device->store_id is removed from mainloop.

Fix this GLib error (and a bunch of invalid read/writes when
store_device_info_cb() was called after device removal due to this bug):

bluetoothd[1192]: src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_12_34_12_34_12_34

(bluetoothd:1192): GLib-CRITICAL **: g_source_remove: assertion `tag >
0' failed
bluetoothd[1192]: src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_12_34_12_34_12_34
bluetoothd[1192]: src/device.c:device_free() 0x463a2a0
---
 src/device.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 34902b3..adf405a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2187,11 +2187,11 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 		do_disconnect(device);
 
 	if (device->store_id > 0) {
-		if (!remove_stored)
-			store_device_info_cb(device);
-
 		g_source_remove(device->store_id);
 		device->store_id = 0;
+
+		if (!remove_stored)
+			store_device_info_cb(device);
 	}
 
 	if (remove_stored)
-- 
1.7.9.5

