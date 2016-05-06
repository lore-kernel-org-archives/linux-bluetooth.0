Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ] device: Fix invalid memory access when removing a device
Date: Fri,  6 May 2016 17:16:54 -0300
Message-Id: <1462565814-19113-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current code uses disconnect_all() outside the disconnection timer
callback but doesn't remove the timer from the list of timeout sources,
making it possible (but tricky) to get into the situation that the
disconnect_all() callback gets called with a device that was already
removed/blocked.

Valgrind log:

bluetoothd[5207]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_00_1A_7D_DA_71_07
bluetoothd[5207]: src/service.c:change_state() 0x84f0d70: device 00:1A:7D:DA:71:07 profile gap-profile state changed: connecting -> disconnected (-103)
bluetoothd[5207]: src/device.c:device_profile_connected() gap-profile Software caused connection abort (103)
bluetoothd[5207]: src/service.c:change_state() 0x84f0d70: device 00:1A:7D:DA:71:07 profile gap-profile state changed: disconnected -> unavailable (0)
bluetoothd[5207]: profiles/gap/gas.c:gap_driver_remove() GAP profile remove (00:1A:7D:DA:71:07)
bluetoothd[5207]: src/service.c:btd_service_unref() 0x84f0d70: ref=0
bluetoothd[5207]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_00_1A_7D_DA_71_07
bluetoothd[5207]: src/gatt-client.c:unregister_service() Removing GATT service: /org/bluez/hci0/dev_00_1A_7D_DA_71_07/service0006
bluetoothd[5207]: src/gatt-client.c:unregister_characteristic() Removing GATT characteristic: /org/bluez/hci0/dev_00_1A_7D_DA_71_07/service0006/char0007
bluetoothd[5207]: src/gatt-client.c:unregister_descriptor() Removing GATT descriptor: /org/bluez/hci0/dev_00_1A_7D_DA_71_07/service0006/char0007/desc0009
bluetoothd[5207]: src/device.c:device_free() 0x8446200
bluetoothd[5207]: src/adapter.c:dev_disconnected() Device 00:1A:7D:DA:71:07 disconnected, reason 2
bluetoothd[5207]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1A:7D:DA:71:07 type 1 status 0xe
bluetoothd[5207]: src/adapter.c:resume_discovery()
bluetoothd[5207]: src/adapter.c:trigger_start_discovery()
bluetoothd[5207]: src/adapter.c:cancel_passive_scanning()
==5207== Invalid read of size 1
==5207==    at 0x49E87C: disconnect_all (device.c:1218)
==5207==    by 0x50C5FA2: g_timeout_dispatch (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4800.0)
==5207==    by 0x50C5569: g_main_context_dispatch (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4800.0)
==5207==    by 0x50C58E7: g_main_context_iterate.isra.29 (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4800.0)
==5207==    by 0x50C5C01: g_main_loop_run (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4800.0)
==5207==    by 0x40CA68: main (main.c:687)
==5207==  Address 0x8446412 is 530 bytes inside a block of size 616 free'd
==5207==    at 0x4C2AEA0: free (vg_replace_malloc.c:530)
==5207==    by 0x4A2EA5: device_free (device.c:670)
==5207==    by 0x4C7439: remove_interface (object.c:667)
==5207==    by 0x4C8051: g_dbus_unregister_interface (object.c:1391)
==5207==    by 0x4AAADC: btd_device_unref (device.c:5998)
==5207==    by 0x4AAC85: device_remove (device.c:3951)
==5207==    by 0x48F541: btd_adapter_remove_device (adapter.c:1180)
==5207==    by 0x49136A: connect_failed_callback (adapter.c:7707)
==5207==    by 0x4CE139: notify_handler (mgmt.c:292)
==5207==    by 0x4CD723: queue_foreach (queue.c:220)
==5207==    by 0x4CF568: process_notify (mgmt.c:304)
==5207==    by 0x4CF568: can_read_data (mgmt.c:370)
==5207==    by 0x4E01EA: watch_callback (io-glib.c:170)
==5207==  Block was alloc'd at
==5207==    at 0x4C2BD20: calloc (vg_replace_malloc.c:711)
==5207==    by 0x4A2F7C: device_new (device.c:3535)
==5207==    by 0x4A4F14: device_create (device.c:3623)
==5207==    by 0x484A08: adapter_create_device (adapter.c:1115)
==5207==    by 0x48EBE2: update_found_devices (adapter.c:5473)
==5207==    by 0x48EBE2: device_found_callback (adapter.c:5647)
==5207==    by 0x4CE139: notify_handler (mgmt.c:292)
==5207==    by 0x4CD723: queue_foreach (queue.c:220)
==5207==    by 0x4CF568: process_notify (mgmt.c:304)
==5207==    by 0x4CF568: can_read_data (mgmt.c:370)
==5207==    by 0x4E01EA: watch_callback (io-glib.c:170)
==5207==    by 0x50C5569: g_main_context_dispatch (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4800.0)
==5207==    by 0x50C58E7: g_main_context_iterate.isra.29 (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4800.0)
==5207==    by 0x50C5C01: g_main_loop_run (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4800.0)
==5207==
---
 src/device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index b004f43..83a794e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1233,6 +1233,9 @@ int device_block(struct btd_device *device, gboolean update_only)
 	if (device->blocked)
 		return 0;
 
+	if (device->disconn_timer > 0)
+		g_source_remove(device->disconn_timer);
+
 	disconnect_all(device);
 
 	while (device->services != NULL) {
@@ -3934,8 +3937,10 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	g_slist_free(device->pending);
 	device->pending = NULL;
 
-	if (btd_device_is_connected(device))
+	if (btd_device_is_connected(device)) {
+		g_source_remove(device->disconn_timer);
 		disconnect_all(device);
+	}
 
 	if (device->store_id > 0) {
 		g_source_remove(device->store_id);
-- 
2.8.1

