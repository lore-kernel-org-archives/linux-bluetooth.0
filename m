Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Fix crash when disconnecting
Date: Thu, 15 Oct 2015 13:22:46 +0300
Message-Id: <1444904566-30314-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When device disconnect while GATT discovery is ongoing the following
crash can happen if the device is destroyed in case it is temporary:

Invalid read of size 4
   at 0x40A707C: g_slist_find_custom (in /usr/lib/libglib-2.0.so.0.4400.1)
   by 0x80B7382: gatt_service_removed (device.c:3422)
   by 0x80DF2FB: handle_notify (gatt-db.c:266)
   by 0x80D3B8E: queue_foreach (queue.c:251)
   by 0x80DF981: notify_service_changed (gatt-db.c:283)
   by 0x80DF981: gatt_db_service_destroy (gatt-db.c:294)
   by 0x80D3DFE: queue_remove_all (queue.c:387)
   by 0x80DFA4C: gatt_db_clear (gatt-db.c:438)
   by 0x80D908C: init_fail (gatt-client.c:1524)
   by 0x80D9A52: discovery_op_unref (gatt-client.c:419)
   by 0x80E18F2: destroy_mtu_op (gatt-helpers.c:495)
   by 0x80D7F6E: cancel_att_send_op (att.c:212)
   by 0x80D7F6E: bt_att_cancel (att.c:1238)
   by 0x80DB26A: bt_gatt_client_cancel_all (gatt-client.c:1962)
 Address 0x5536b58 is 0 bytes inside a block of size 8 free'd
   at 0x402B2C9: free (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
   by 0x408CE4F: g_free (in /usr/lib/libglib-2.0.so.0.4400.1)
   by 0x40A6772: g_slice_free_chain_with_offset (in /usr/lib/libglib-2.0.so.0.4400.1)
   by 0x40A6B6B: g_slist_free (in /usr/lib/libglib-2.0.so.0.4400.1)
   by 0x40A7374: g_slist_free_full (in /usr/lib/libglib-2.0.so.0.4400.1)
   by 0x80B6CE0: device_free (device.c:624)
   by 0x80CFCCB: remove_interface (object.c:658)
   by 0x80D0208: g_dbus_unregister_interface (object.c:1382)
   by 0x80BC281: btd_device_unref (device.c:5942)
   by 0x80A9ACA: btd_adapter_remove_device (adapter.c:1165)
   by 0x80A9C52: adapter_remove_connection (adapter.c:5624)
   by 0x80AA77F: dev_disconnected (adapter.c:6584)
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index fd177f4..0d3a655 100644
--- a/src/device.c
+++ b/src/device.c
@@ -626,6 +626,9 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->attios_offline, g_free);
 	g_slist_free_full(device->svc_callbacks, svc_dev_remove);
 
+	/* Reset callbacks since the device is going to be freed */
+	gatt_db_register(device->db, NULL, NULL, NULL, NULL);
+
 	attio_cleanup(device);
 
 	gatt_db_unref(device->db);
-- 
2.4.3

