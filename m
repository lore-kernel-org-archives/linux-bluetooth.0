Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] core: Fix crash if adapter register failed
Date: Mon,  2 Mar 2015 22:02:30 +0100
Message-Id: <1425330150-2448-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If btd_gatt_database_new() failed adapter was unreferenced without
being removed from adapters list.

bluetoothd[2234]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[2234]: src/adapter.c:clear_uuids() sending clear uuids command for index 0
bluetoothd[2234]: src/adapter.c:clear_devices() sending clear devices command for index 0
bluetoothd[2234]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[2234]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[2234]: Failed to register org.bluez.GattManager1
bluetoothd[2234]: Failed to create GATT database for adapter
bluetoothd[2234]: Unable to register new adapter
bluetoothd[2234]: src/adapter.c:btd_adapter_unref() Freeing adapter /org/bluez/hci0
bluetoothd[2234]: src/adapter.c:adapter_free() 0x44e1c98
bluetoothd[2234]: plugins/neard.c:neard_appeared()
bluetoothd[2234]: plugins/hostname.c:property_changed() static hostname: athlon
bluetoothd[2234]: plugins/hostname.c:property_changed() pretty hostname:
==2234== Invalid read of size 1
==2234==    at 0x80A3F98: btd_adapter_is_default (adapter.c:273)
==2234==    by 0x8050E71: update_name (hostname.c:88)
==2234==    by 0x40BF252: g_slist_foreach (in /lib/i386-linux-gnu/libglib-2.0.so.0.4200.1)
==2234==    by 0x80A9485: adapter_foreach (adapter.c:6595)
==2234==    by 0x805107C: property_changed (hostname.c:167)
==2234==    by 0x80CA7EC: add_property (client.c:243)
==2234==    by 0x80CA9A4: update_properties (client.c:275)
==2234==    by 0x80CBD45: get_all_properties_reply (client.c:298)
==2234==    by 0x41A2184: ??? (in /lib/i386-linux-gnu/libdbus-1.so.3.8.11)
==2234==    by 0x418E197: ??? (in /lib/i386-linux-gnu/libdbus-1.so.3.8.11)
==2234==    by 0x4191C72: dbus_connection_dispatch (in /lib/i386-linux-gnu/libdbus-1.so.3.8.11)
==2234==    by 0x80C63A0: message_dispatch (mainloop.c:72)
==2234==  Address 0x44e1d58 is 192 bytes inside a block of size 196 free'd
==2234==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==2234==    by 0x40A6810: g_free (in /lib/i386-linux-gnu/libglib-2.0.so.0.4200.1)
==2234==    by 0x80C8BCB: remove_interface (object.c:658)
==2234==    by 0x80C90E8: g_dbus_unregister_interface (object.c:1382)
==2234==    by 0x80A7261: btd_adapter_unref (adapter.c:3642)
==2234==    by 0x80A8597: read_info_complete (adapter.c:7239)
==2234==    by 0x80CD486: request_complete (mgmt.c:242)
==2234==    by 0x80CDEBD: can_read_data (mgmt.c:321)
==2234==    by 0x80D86F9: watch_callback (io-glib.c:170)
==2234==    by 0x40E7C5D: ??? (in /lib/i386-linux-gnu/libglib-2.0.so.0.4200.1)
==2234==    by 0x40A0CB2: g_main_context_dispatch (in /lib/i386-linux-gnu/libglib-2.0.so.0.4200.1)
==2234==    by 0x40A10C8: ??? (in /lib/i386-linux-gnu/libglib-2.0.so.0.4200.1)
==2234==
---
 src/adapter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/adapter.c b/src/adapter.c
index 5b6ab5c..c12f557 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6663,6 +6663,7 @@ static int adapter_register(struct btd_adapter *adapter)
 	adapter->database = btd_gatt_database_new(adapter);
 	if (!adapter->database) {
 		error("Failed to create GATT database for adapter");
+		adapters = g_slist_remove(adapters, adapter);
 		return -EINVAL;
 	}
 
-- 
2.1.4

