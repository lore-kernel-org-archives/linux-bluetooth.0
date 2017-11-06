Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] profiles/battery: Fix crash on disconnect
Date: Mon,  6 Nov 2017 18:26:56 +0100
Message-Id: <20171106172656.28718-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cancelling all the pending requests on the device is not needed as
bt_gatt_client_free() already does this for us.

There's also no need to explicitly unregister our notification, as this
will be done once the device has been disconnected, or not setup for
notifications yet.

==14797== Invalid read of size 1
==14797==    at 0x1825E7: ba2str (bluetooth.c:79)
==14797==    by 0x173DF4: change_state (service.c:101)
==14797==    by 0x148ECA: batt_disconnect (battery.c:348)
==14797==    by 0x174564: btd_service_disconnect (service.c:293)
==14797==    by 0x4EA551C: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x17AC71: att_disconnected_cb (device.c:4661)
==14797==    by 0x1972D7: queue_foreach (queue.c:220)
==14797==    by 0x19B831: disconnect_cb (att.c:590)
==14797==    by 0x1A4482: watch_callback (io-glib.c:170)
==14797==    by 0x4E86BB6: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x4E86F5F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x4E87271: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x121604: main (main.c:770)
==14797==  Address 0x74ad69b is 11 bytes inside a block of size 624 free'd
==14797==    at 0x4C30D18: free (vg_replace_malloc.c:530)
==14797==    by 0x4E8C4AD: g_free (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x1935CD: remove_interface (object.c:667)
==14797==    by 0x193AC9: g_dbus_unregister_interface (object.c:1391)
==14797==    by 0x148EC0: batt_disconnect (battery.c:346)
==14797==    by 0x174564: btd_service_disconnect (service.c:293)
==14797==    by 0x4EA551C: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x17AC71: att_disconnected_cb (device.c:4661)
==14797==    by 0x1972D7: queue_foreach (queue.c:220)
==14797==    by 0x19B831: disconnect_cb (att.c:590)
==14797==    by 0x1A4482: watch_callback (io-glib.c:170)
==14797==    by 0x4E86BB6: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x4E86F5F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x4E87271: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x121604: main (main.c:770)
==14797==  Block was alloc'd at
==14797==    at 0x4C31A1E: calloc (vg_replace_malloc.c:711)
==14797==    by 0x17FF6C: device_new (device.c:3648)
==14797==    by 0x180FDE: device_create_from_storage (device.c:3712)
==14797==    by 0x169495: load_devices (adapter.c:3826)
==14797==    by 0x16FF6B: adapter_register (adapter.c:7742)
==14797==    by 0x16FF6B: read_info_complete (adapter.c:8285)
==14797==    by 0x197D57: request_complete (mgmt.c:261)
==14797==    by 0x198824: can_read_data (mgmt.c:353)
==14797==    by 0x1A4482: watch_callback (io-glib.c:170)
==14797==    by 0x4E86BB6: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x4E86F5F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x4E87271: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.1)
==14797==    by 0x121604: main (main.c:770)
---
 profiles/battery/battery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 8cedfa250..ec28a0d5e 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -85,8 +85,6 @@ static void batt_reset(struct batt *batt)
 	batt->attr = NULL;
 	gatt_db_unref(batt->db);
 	batt->db = NULL;
-	bt_gatt_client_unregister_notify(batt->client, batt->batt_level_cb_id);
-	bt_gatt_client_cancel_all(batt->client);
 	bt_gatt_client_unref(batt->client);
 	batt->client = NULL;
 	g_free (batt->initial_value);
-- 
2.14.3

