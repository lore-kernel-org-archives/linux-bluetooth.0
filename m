Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] emulator: Fix uninitialised memory usage on inquiry
Date: Wed,  5 Jun 2013 16:35:16 -0400
Message-Id: <1370464516-5706-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This happens when using "btvirt -l2" and running "discoverable on" on
hci1 and "scan on" on hci0 using bluetoothctl:

==1870== Syscall param write(buf) points to uninitialised byte(s)
==1870==    at 0x4114443: __write_nocancel (syscall-template.S:82)
==1870==    by 0x804B503: send_packet (btdev.c:478)
==1870==    by 0x804B599: send_event (btdev.c:503)
==1870==    by 0x804B8C0: inquiry_complete (btdev.c:589)
==1870==    by 0x804C538: default_cmd (btdev.c:881)
==1870==    by 0x804E5DE: process_cmd (btdev.c:1559)
==1870==    by 0x804E646: btdev_receive_h4 (btdev.c:1577)
==1870==    by 0x804A487: vhci_read_callback (vhci.c:82)
==1870==    by 0x804923E: mainloop_run (mainloop.c:142)
==1870==    by 0x8048FD4: main (main.c:145)
==1870==  Address 0x41e4d0f is 15 bytes inside a block of size 258
alloc'd
==1870==    at 0x402B56C: malloc (vg_replace_malloc.c:270)
==1870==    by 0x804B531: send_event (btdev.c:490)
==1870==    by 0x804B8C0: inquiry_complete (btdev.c:589)
==1870==    by 0x804C538: default_cmd (btdev.c:881)
==1870==    by 0x804E5DE: process_cmd (btdev.c:1559)
==1870==    by 0x804E646: btdev_receive_h4 (btdev.c:1577)
==1870==    by 0x804A487: vhci_read_callback (vhci.c:82)
==1870==    by 0x804923E: mainloop_run (mainloop.c:142)
==1870==    by 0x8048FD4: main (main.c:145)
==1870==
---
 emulator/btdev.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d88c853..6e00cc6 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -583,6 +583,7 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
 			ir.pscan_rep_mode = 0x00;
 			ir.pscan_period_mode = 0x00;
 			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
+			ir.clock_offset = 0x0000;
 			ir.rssi = -60;
 			memcpy(ir.data, btdev_list[i]->ext_inquiry_rsp, 240);
 
@@ -599,6 +600,7 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
 			ir.pscan_rep_mode = 0x00;
 			ir.pscan_period_mode = 0x00;
 			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
+			ir.clock_offset = 0x0000;
 			ir.rssi = -60;
 
 			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT_WITH_RSSI,
@@ -612,6 +614,7 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
 			ir.pscan_period_mode = 0x00;
 			ir.pscan_mode = 0x00;
 			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
+			ir.clock_offset = 0x0000;
 
 			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT,
 							&ir, sizeof(ir));
-- 
1.7.9.5

