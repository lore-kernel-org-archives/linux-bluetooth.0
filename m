Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Feb 2011 21:53:09 -0600
From: David Fries <david@fries.net>
To: linux-bluetooth@vger.kernel.org
Subject: [HACK PATCH] N900 l2cap connect crash, NULL parent
Message-ID: <20110211035309.GA22204@spacedout.fries.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's a patch to avoid a very repeatable crash in the N900.  If I
take a Motorola S305 bluetooth headset that was previously paried with
the N900, turn it on, and press the play button before the headphones
automatically pair with the cell phone, the N900 will crash (and
reboot) in pairing.  If I wait until after they have paired there
isn't any problem.  The patch is against the kernel-power
2.6.28-maemo46 by Thomas Tanner, the stock Nokia PR1.2 oops looked
the same, I just haven't gone back to that kernel.

All of the original oops dumps had the same backtrace functions,
(see original.txt for the full oops)

Backtrace: 
l2cap_load+0x7e8/0xa94 [l2cap]
l2cap_sock_destruct+0x124/0x1484 [l2cap]
l2cap_recv_acldata+0x0/0x1f0 [l2cap]
hci_rx_task+0x0/0x298 [bluetooth]
tasklet_action+0x0/0xc0
__do_softirq+0x0/0xf4
irq_exit+0x0/0xa8

I first cherry picked the kernel patch by Andrei Emeltchenko
e501d0553a7580fcc6654d7f58a5f061d31d00af
"Bluetooth: Check L2CAP pending status before sending connect request"

It was still crashing, but the backtrace changed,
(see pending_protect.txt for the full oops)

Backtrace: 
l2cap_conn_start+0x0/0x2ac [l2cap]
l2cap_recv_frame+0x0/0x12bc [l2cap]
l2cap_recv_acldata+0x0/0x1f0 [l2cap]
hci_rx_task+0x0/0x298 [bluetooth]
tasklet_action+0x0/0xc0
__do_softirq+0x0/0xf4
irq_exit+0x0/0xa8

Then I added the following patch to protected against a NULL parent,
and it no longer crashes.  I'm not sure what to think about the above
"pending status" patch, I added a check and the
__l2cap_no_conn_pending function added by that patch never sees a
pending connection, but it did change the backtrace, so I'm confused.
But then again the original trace lists l2cap_load, which only
contains a return statement, and shouldn't be prone to making NULL
pointer dereferences anyawy.

I also attached two syslogs, one with out touching the headset while
it powered on and paired,
cut_no_press.txt

and another with pressing the button before it paired.  This one
prints the debug message instead of the crash that would have
happened.
avoided crash in l2cap_conn_start parent 00000000 result 1 status 2
cut_with_press.txt


There's also a patch on android.git.kernel.org
"Bluetooth: Hack: Don't dereference null pointer."
http://android.git.kernel.org/?p=kernel/common.git;a=commit;h=5a2ad658a5efea775a00b162c1062ce33e8e3aaa

and a bug report on bugs.maemo.org
https://bugs.maemo.org/show_bug.cgi?id=10510


Subject: [PATCH] work around for l2cap NULL dereference in l2cap_conn_start

just skip the dereference, print sk
---
 net/bluetooth/l2cap.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ed83c1f..c5b4fbf 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -408,7 +408,16 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
-					parent->sk_data_ready(parent, 0);
+					if(!parent) {
+						printk(KERN_DEBUG "avoided "
+							"crash in %s sk %p "
+							"result %d status %d\n",
+							__func__, sk,
+							rsp.result, rsp.status);
+					} else {
+						parent->sk_data_ready(parent,
+							0);
+					}
 
 				} else {
 					sk->sk_state = BT_CONFIG;
-- 
1.7.2.3


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="original.txt"

Log Entry 23 (at position 22)
[43998.551239] Unable to handle kernel NULL pointer dereference at virtual address 00000144
[43998.551300] pgd = ccb24000
[43998.551330] [00000144] *pgd=8cb0d031, *pte=00000000, *ppte=00000000
[43998.551391] Internal error: Oops: 17 [#1] PREEMPT
[43998.551422] Modules linked in: sd_mod scsi_mod iphb rfcomm panic_info_buff sco l2cap ext3 jbd omaplfb ext4 mbcache pvrsrvkm jbd2 bridgedriver ipv6 g_file_storage uinput board_rx51_camera omap_previewer_hack omap34xxcam_mod isp_mod iovmm videobuf_dma_sg videobuf_core omap3_iommu iommu2 iommu dspbridge ssi_mcsaab_imp phonet mmc_block cmt_speech joydev omap_hsmmc wl12xx smc91x mii omap_ssi hci_h4p omap_wdt mac80211 crc7 nokia_av mmc_core tsc2005 bluetooth fmtx_si4713 videodev ad5820 adp1653 smia_sensor et8ek8 rtc_twl4030 smiaregs v4l1_compat compat_ioctl32 leds_lp5523 leds_twl4030_vibra lis302dl twl4030_wdt tsl2563 v4l2_int_device led_class rtc_core
[43998.552001] CPU: 0    Not tainted  (2.6.28.10power46 #1)
[43998.552062] PC is at l2cap_load+0x9ec/0xa94 [l2cap]
[43998.552185] LR is at hci_conn_security+0x50/0xc8 [bluetooth]
[43998.552215] pc : [<bf2cdb28>]    lr : [<bf07bc2c>]    psr: 20000153
[43998.552246] sp : cc89bb30  ip : cc89bb10  fp : cc89bb5c
[43998.552276] r10: 00000000  r9 : c4e7c814  r8 : c6c05100
[43998.552307] r7 : c6c05100  r6 : cc89a000  r5 : c263aa00  r4 : 00000000
[43998.552337] r3 : 00000000  r2 : 00000002  r1 : 00000000  r0 : 00000000
[43998.552368] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment user
[43998.552429] Control: 10c5387d  Table: 8cb24018  DAC: 00000015
[43998.552459] Process bluetoothd (pid: 945, stack limit = 0xcc89a2e8)
[43998.552490] Stack: (0xcc89bb30 to 0xcc89c000)
[43998.552520] bb20:                                     00000001 c03a1b40 00400041 00020001 
[43998.552581] bb40: 00000000 00000002 c4e7c810 cc89a000 cc89bc7c cc89bb60 bf2cf14c bf2cd930 
[43998.552673] bb60: cc89a000 c0062170 cc89bb84 c2597c00 c0052f90 00000008 cc89bb94 cc89bb88 
[43998.552764] bb80: c0062180 00000008 cc89bbcc cc89bb98 c0061e38 c006217c cfe3dc84 00000000 
[43998.552856] bba0: cc89bba0 cc89bba0 00000025 00000102 cc89a000 c03b3080 00000102 cc89a000 
[43998.552947] bbc0: cc89bbfc cc89bbd0 c005cd48 c005cbcc c03817cc 00000025 00000025 00000000 
[43998.553039] bbe0: 00000001 00000001 00000000 c6ddcb4d cc89bc14 cc89bc00 c005d0f8 c004f8ac 
[43998.553100] bc00: 00000025 00000000 cc89bc2c cc89bc18 c002c088 c005d094 c269a07c c269a07c 
[43998.553192] bc20: cfc92000 fffff010 cc89bc64 cc89bc38 c00623ec c0061a74 c81a17f3 a0000153 
[43998.553283] bc40: c81a174d c269a07c fffff010 0008020b 0000000b 00000010 c6c05100 c2597c00 
[43998.553375] bc60: 0000000b cc89a000 cc89a000 0000200b cc89bc9c cc89bc80 bf2d0930 bf2ce0f8 
[43998.553466] bc80: c269a000 c2597c00 cfc92000 0000000b cc89bcc4 cc89bca0 bf079b54 bf2d087c 
[43998.553527] bca0: 00000000 cc89a000 c03b3080 00000001 00000014 0000000a cc89bcdc cc89bcc8 
[43998.553619] bcc0: c005cef8 bf0799fc 00000102 cc89a000 cc89bd0c cc89bce0 c005cccc c005ce8c 
[43998.553710] bce0: c038203c 00000049 00000049 00000000 cee9fd60 00000001 00000000 cee9fd60 
[43998.553802] bd00: cc89bd24 cc89bd10 c005d0d4 c005cc74 00000049 00000000 cc89bd3c cc89bd28 
[43998.553894] bd20: c002c088 c005d094 ffffffff d8200000 cc89bda4 cc89bd40 c0299184 c002c00c 
[43998.553955] bd40: cee99ccc 00000002 00000000 00000000 c055a360 00000001 cee9fd60 c2597b40 
[43998.554046] bd60: cc89be28 c2597b88 cee9fd60 cc89bda4 00000000 cc89bd88 fffffffa c008e2c0 
[43998.554138] bd80: 60000153 ffffffff 0000168e cee9fd60 00000001 c2597b40 cc89bdc4 cc89bda8 
[43998.554229] bda0: c008e50c c008e214 0000168e 00000000 cc89a000 c2597b40 cc89be14 cc89bdc8 
[43998.554321] bdc0: c0090b24 c008e4f8 c00cc518 c0156de4 cee9fcc0 cc84ba50 cee9fcc0 00000000 
[43998.554382] bde0: 00000000 c00cc4f4 c055a2c0 00000000 ce5f1680 cc84ba50 cc84ba50 00000000 
[43998.554473] be00: 40026000 cd456480 cc89be64 cc89be18 c009ea7c c0090a6c ccb25000 00000000 
[43998.554565] be20: 00000000 cc983894 00000000 00000001 40026000 00000000 00000001 00000000 
[43998.554656] be40: ce5f1680 00001000 cc84ba50 000
Log Entry 24 (at position 23)
<7>mtdoops: Ready 23, 24 (no erase)
[43998.555419] ccb24000 40026000 cc89bec4 cc89be68 
[43998.555450] be60: c009fd68 c009ea34 00000001 00000000 00000000 cc89be80 c021b4c8 c021adb0 
[43998.555541] be80: 00000000 cd456480 cc89beac 00000098 ccb25000 c00b7b04 cfc921d8 cd4564b4 
[43998.555633] bea0: ce5f1680 cd456480 cc84ba50 cc89bfb0 00000017 40026000 cc89befc cc89bec8 
[43998.555725] bec0: c029b08c c009f9fc c0074e14 c0040740 ffffffff c029af20 c0372894 00000017 
[43998.555816] bee0: cc89bfb0 40026000 40025fb1 00000013 cc89bfac cc89bf00 c002c270 c029af2c 
[43998.555877] bf00: 00000000 00000000 cc89bf34 cc89bf18 bf079fd4 c0219fa0 00000000 cc89a000 
[43998.555969] bf20: c03b3080 00000001 cc89bf4c cc89bf38 c005cef8 bf079c94 00000102 cc89a000 
[43998.556060] bf40: cc89bf7c cc89bf50 c005cd48 c005cbcc c038203c 00000049 00000049 00000000 
[43998.556152] bf60: 400251f2 00000001 00000000 00000013 cc89bf94 cc89bf80 c005d0f8 c004f8ac 
[43998.556213] bf80: 00000049 00000000 cc89bfac ffffffff 40025fb0 40025f96 0000001a 00069700 
[43998.556304] bfa0: 00000000 cc89bfb0 c02995a0 c002c23c 00069700 40025fb0 00000000 00000030 
[43998.556396] bfc0: 40025fff 40025fb0 40025f96 0000001a 00069700 40025fb1 00000013 bea5ca54 
[43998.556488] bfe0: 0006971a bea5c9c0 0003b904 0003b924 20000050 ffffffff 805e2021 805e2421 
[43998.556579] Backtrace: 
[43998.556610] [<bf2cd924>] (l2cap_load+0x7e8/0xa94 [l2cap]) from [<bf2cf14c>] (l2cap_sock_destruct+0x1184/0x1484 [l2cap])
[43998.556701]  r7:cc89a000 r6:c4e7c810 r5:00000002 r4:00000000
[43998.556762] [<bf2ce0ec>] (l2cap_sock_destruct+0x124/0x1484 [l2cap]) from [<bf2d0930>] (l2cap_recv_acldata+0xc0/0x1f0 [l2cap])
[43998.556854] [<bf2d0870>] (l2cap_recv_acldata+0x0/0x1f0 [l2cap]) from [<bf079b54>] (hci_rx_task+0x164/0x298 [bluetooth])
[43998.557006]  r7:0000000b r6:cfc92000 r5:c2597c00 r4:c269a000
[43998.557067] [<bf0799f0>] (hci_rx_task+0x0/0x298 [bluetooth]) from [<c005cef8>] (tasklet_action+0x78/0xc0)
[43998.557220] [<c005ce80>] (tasklet_action+0x0/0xc0) from [<c005cccc>] (__do_softirq+0x64/0xf4)
[43998.557281]  r5:cc89a000 r4:00000102
[43998.557312] [<c005cc68>] (__do_softirq+0x0/0xf4) from [<c005d0d4>] (irq_exit+0x4c/0xa8)
[43998.557403] [<c005d088>] (irq_exit+0x0/0xa8) from [<c002c088>] (__exception_text_start+0x88/0xa8)
[43998.557464]  r5:00000000 r4:00000049
[43998.557495] [<c002c000>] (__exception_text_start+0x0/0xa8) from [<c0299184>] (__irq_svc+0x44/0xa4)
[43998.557586] Exception stack(0xcc89bd40 to 0xcc89bd88)
[43998.557617] bd40: cee99ccc 00000002 00000000 00000000 c055a360 00000001 cee9fd60 c2597b40 
[43998.557708] bd60: cc89be28 c2597b88 cee9fd60 cc89bda4 00000000 cc89bd88 fffffffa c008e2c0 
[43998.557800] bd80: 60000153 ffffffff                                                       
[43998.557861]  r5:d8200000 r4:ffffffff
[43998.557922] [<c008e208>] (find_get_page+0x0/0xc0) from [<c008e50c>] (find_lock_page+0x20/0x74)
[43998.558013]  r7:c2597b40 r6:00000001 r5:cee9fd60 r4:0000168e
[43998.558074] [<c008e4ec>] (find_lock_page+0x0/0x74) from [<c0090b24>] (filemap_fault+0xc4/0x454)
[43998.558135]  r7:c2597b40 r6:cc89a000 r5:00000000 r4:0000168e
[43998.558197] [<c0090a60>] (filemap_fault+0x0/0x454) from [<c009ea7c>] (__do_fault+0x54/0x4a8)
[43998.558258] [<c009ea28>] (__do_fault+0x0/0x4a8) from [<c009fd68>] (handle_mm_fault+0x378/0x864)
[43998.558349] [<c009f9f0>] (handle_mm_fault+0x0/0x864) from [<c029b08c>] (do_page_fault+0x16c/0x2c0)
[43998.558410] [<c029af20>] (do_page_fault+0x0/0x2c0) from [<c002c270>] (do_DataAbort+0x40/0xa0)
[43998.558502] [<c002c230>] (do_DataAbort+0x0/0xa0) from [<c02995a0>] (ret_from_exception+0x0/0x10)
[43998.558593] Exception stack(0xcc89bfb0 to 0xcc89bff8)
[43998.558593] bfa0:                                     00069700 40025fb0 00000000 00000030 
[43998.558685] bfc0: 40025fff 40025fb0 40025f96 0000001a 00069700 40025fb1 00000013 bea5ca54 
[43998.558776] bfe0: 0006971a bea5c9c0 0003b904 0003b924 20000050 ffffffff                   
[43998.558868]  r8:00069700 r7:0000001a r6:40025f96 r5:40025fb0 r4:ffffffff
[43998.558929] Code: e14b22b0 e1a00003 e3a02002 e14b21b
Log Entry 25 (at position 24)
<7>mtdoops: Ready 24, 25 (no erase)
[43998.559661] (e5933144) 

Log Entry 26 (at position 25)
[43998.560180] mtdoops: Ready 25, 26 (no erase)
[43998.560363] Kernel panic - not syncing: Fatal exception in interrupt
[43998.560394] Panic info buffer:
[43998.560424] OSSO_PRODUCT_HARDWARE='RX-51'
[43998.560455] OSSO_PRODUCT_NAME='N900'
[43998.560455] OSSO_PRODUCT_FULL_NAME='Nokia N900'
[43998.560485] OSSO_PRODUCT_RELEASE_NAME='Maemo 5'
[43998.560485] OSSO_PRODUCT_RELEASE_FULL_NAME='Maemo 5'
[43998.560516] OSSO_PRODUCT_RELEASE_VERSION='20.2010.36-2.002'
[43998.560516] OSSO_PRODUCT_WLAN_CHANNEL='fcc/us'
[43998.560546] OSSO_PRODUCT_KEYBOARD='English, Dutch'
[43998.560546] OSSO_PRODUCT_REGION='English America'
[43998.560577] OSSO_PRODUCT_SHORT_NAME='Nokia N900'
[43998.560577] OSSO_VERSION='RX-51_2009SE_20.2010.36-2.002_PR_002'
[43998.560607] 

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pending_protect.txt"

Log Entry 27 (at position 26)
[  216.312866] Unable to handle kernel NULL pointer dereference at virtual address 00000144
[  216.312927] pgd = ce50c000
[  216.312957] [00000144] *pgd=00000000
[  216.313018] Internal error: Oops: 5 [#1] PREEMPT
[  216.313018] Modules linked in: sd_mod scsi_mod iphb rfcomm panic_info_buff sco l2cap ext3 jbd ext4 mbcache omaplfb jbd2 pvrsrvkm bridgedriver ipv6 g_file_storage uinput board_rx51_camera omap_previewer_hack omap34xxcam_mod isp_mod iovmm videobuf_dma_sg videobuf_core omap3_iommu iommu2 iommu dspbridge ssi_mcsaab_imp mmc_block phonet joydev cmt_speech omap_hsmmc wl12xx smc91x mii omap_ssi omap_wdt hci_h4p nokia_av mmc_core mac80211 crc7 tsc2005 bluetooth fmtx_si4713 rtc_twl4030 et8ek8 ad5820 adp1653 smia_sensor lis302dl leds_lp5523 leds_twl4030_vibra rtc_core twl4030_wdt videodev v4l1_compat compat_ioctl32 tsl2563 led_class smiaregs v4l2_int_device
[  216.313598] CPU: 0    Not tainted  (2.6.28.10power46 #1)
[  216.313690] PC is at l2cap_conn_start+0x204/0x2ac [l2cap]
[  216.313812] LR is at hci_conn_security+0x50/0xc8 [bluetooth]
[  216.313842] pc : [<bf2cdb28>]    lr : [<bf07bc2c>]    psr: 20000153
[  216.313873] sp : ce53bda0  ip : ce53bd80  fp : ce53bdcc
[  216.313903] r10: 00000000  r9 : c5522814  r8 : cff6e500
[  216.313934] r7 : cff6e500  r6 : ce53a000  r5 : c5657400  r4 : 00000000
[  216.313995] r3 : 00000000  r2 : 00000002  r1 : 00000000  r0 : 00000000
[  216.314025] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment user
[  216.314056] Control: 10c5387d  Table: 8e50c018  DAC: 00000015
[  216.314086] Process dbus-daemon (pid: 735, stack limit = 0xce53a2e8)
[  216.314117] Stack: (0xce53bda0 to 0xce53c000)
[  216.314147] bda0: 00000800 cee57d80 00410040 00020001 00000000 00000002 c5522810 ce53a000 
[  216.314239] bdc0: ce53beec ce53bdd0 bf2cf14c bf2cd930 cfeba3c0 00000000 00000000 cfc65840 
[  216.314331] bde0: 00000000 00000008 00000000 ce53be40 ce53be90 00000008 00000800 00000001 
[  216.314422] be00: ce53a000 ce53bf20 ce53be84 ce53be18 c0213cc0 c028401c 00000040 cc9ab0c0 
[  216.314483] be20: 00000000 cfeba3c0 00000040 00000800 cee57d80 cee2e19c ce53bdd4 ce53be40 
[  216.314575] be40: 00000000 00000000 ce53bf20 00000001 00000000 00000000 00000040 ce53be90 
[  216.314666] be60: ce53be90 cd7ceb40 ce53bf70 00000800 2a07c490 00000000 ce53bf44 ce53be88 
[  216.314758] be80: c00bb8c4 c0213be8 c553687c c553687c cfccdc00 ffffd80d ce53bed4 ce53bea8 
[  216.314849] bea0: c00623ec c0061a74 00000000 a0000153 00000000 c553687c ffffd80d 0008020b 
[  216.314910] bec0: 0000000b 00000010 cff6e500 cfc65840 0000000b ce53a000 ce53a000 0000200b 
[  216.315002] bee0: ce53bf0c ce53bef0 bf2d0930 bf2ce0f8 c5536800 cfc65840 cfccdc00 0000000b 
[  216.315093] bf00: ce53bf34 ce53bf10 bf079b54 bf2d087c 00000000 ce53a000 c03b3080 00000001 
[  216.315185] bf20: 00000014 0000000a ce53bf4c ce53bf38 c005cef8 bf0799fc 00000102 ce53a000 
[  216.315277] bf40: ce53bf7c ce53bf50 c005cccc c005ce8c c038203c 00000049 00000049 00000000 
[  216.315338] bf60: 2a07eb80 00000001 00000000 2a156350 ce53bf94 ce53bf80 c005d0d4 c005cc74 
[  216.315429] bf80: 00000049 00000000 ce53bfac ce53bf98 c002c088 c005d094 ffffffff d8200000 
[  216.315521] bfa0: 00000000 ce53bfb0 c0299384 c002c00c 2a07eb80 00000003 00000003 00000024 
[  216.315612] bfc0: 00000000 2a07eb80 2a07eb80 2a041000 2a07eca0 00000001 2a156350 befee8ec 
[  216.315673] bfe0: 00000371 befee8a0 2a017ce4 2a016608 20000050 ffffffff fd7ff5ff 7753f4f7 
[  216.315765] Backtrace: 
[  216.315795] [<bf2cd924>] (l2cap_conn_start+0x0/0x2ac [l2cap]) from [<bf2cf14c>] (l2cap_recv_frame+0x1060/0x12bc [l2cap])
[  216.315948]  r7:ce53a000 r6:c5522810 r5:00000002 r4:00000000
[  216.315979] [<bf2ce0ec>] (l2cap_recv_frame+0x0/0x12bc [l2cap]) from [<bf2d0930>] (l2cap_recv_acldata+0xc0/0x1f0 [l2cap])
[  216.316131] [<bf2d0870>] (l2cap_recv_acldata+0x0/0x1f0 [l2cap]) from [<bf079b54>] (hci_rx_task+0x164/0x298 [bluetooth])
[  216.316284]  r7:0000000b r6:cfccdc00 r5:cfc65840 r4:c5536800
[  216.316314] [<bf0799f0>] (hci_rx_task+0x0/0x298 [bluetooth]) from [<c005cef8>] (tasklet_action+0x78/0xc0)
[  216.317230] (tasklet_action+0x0/0xc0) from [<c005cccc>] (__do_softirq+0x64/0xf4)
[  216.317291]  r5:ce53a000 r4:00000102
[  216.317321] [<c005cc68>] (__do_softirq+0x0/0xf4) from [<c005d0d4>] (irq_exit+0x4c/0xa8)
[  216.317382] [<c005d088>] (irq_exit+0x0/0xa8) from [<c002c088>] (__exception_text_start+0x88/0xa8)
[  216.317474]  r5:00000000 r4:00000049
[  216.317504] [<c002c000>] (__exception_text_start+0x0/0xa8) from [<c0299384>] (__irq_usr+0x44/0xa0)
[  216.317596] Exception stack(0xce53bfb0 to 0xce53bff8)
[  216.317626] bfa0:                                     2a07eb80 00000003 00000003 00000024 
[  216.317718] bfc0: 00000000 2a07eb80 2a07eb80 2a041000 2a07eca0 00000001 2a156350 befee8ec 
[  216.317779] bfe0: 00000371 befee8a0 2a017ce4 2a016608 20000050 ffffffff                   
[  216.317871]  r5:d8200000 r4:ffffffff
[  216.317901] Code: e14b22b0 e1a00003 e3a02002 e14b21be (e5933144) 

Log Entry 29 (at position 28)
[  216.318481] mtdoops: Ready 28, 29 (no erase)
[  216.318542] Kernel panic - not syncing: Fatal exception in interrupt
[  216.318603] Panic info buffer:
[  216.318634] OSSO_PRODUCT_HARDWARE='RX-51'
[  216.318634] OSSO_PRODUCT_NAME='N900'
[  216.318664] OSSO_PRODUCT_FULL_NAME='Nokia N900'
[  216.318664] OSSO_PRODUCT_RELEASE_NAME='Maemo 5'
[  216.318695] OSSO_PRODUCT_RELEASE_FULL_NAME='Maemo 5'
[  216.318695] OSSO_PRODUCT_RELEASE_VERSION='20.2010.36-2.002'
[  216.318725] OSSO_PRODUCT_WLAN_CHANNEL='fcc/us'
[  216.318725] OSSO_PRODUCT_KEYBOARD='English, Dutch'
[  216.318756] OSSO_PRODUCT_REGION='English America'
[  216.318756] OSSO_PRODUCT_SHORT_NAME='Nokia N900'
[  216.318786] OSSO_VERSION='RX-51_2009SE_20.2010.36-2.002_PR_002'
[  216.318786] 

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cut_no_press.txt"

l2cap_connect_ind: hdev hci0, bdaddr 01:01:01:01:01:01
l2cap_connect_cfm: hcon cfe3a000 bdaddr 01:01:01:01:01:01 status 0
l2cap_conn_add: hcon cfe3a000 conn c9298700
l2cap_conn_ready: conn c9298700
bluetoothd[943]: link_key_request (sba=02:02:02:02:02:02, dba=03:03:03:03:03:03)
l2cap_security_cfm: conn c9298700
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x02 len 4 id 0x02
l2cap_connect_req: psm 0x01 scid 0x0041
l2cap_sock_init: sk c74c2a00
__l2cap_chan_add: conn c9298700, psm 0x01, dcid 0x0041
l2cap_sock_set_timer: sk c74c2a00 state 2 timeout 5120
l2cap_build_cmd: conn c9298700, code 0x03, ident 0x02, len 8
l2cap_send_cmd: code 0x03
l2cap_build_cmd: conn c9298700, code 0x0a, ident 0x01, len 2
l2cap_send_cmd: code 0x0a
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x02 len 4 id 0x03
l2cap_connect_req: psm 0x19 scid 0x0040
l2cap_sock_init: sk c74c2000
__l2cap_chan_add: conn c9298700, psm 0x19, dcid 0x0040
l2cap_sock_set_timer: sk c74c2000 state 2 timeout 5120
l2cap_build_cmd: conn c9298700, code 0x03, ident 0x03, len 8
l2cap_send_cmd: code 0x03
l2cap_build_cmd: conn c9298700, code 0x0a, ident 0x02, len 2
l2cap_send_cmd: code 0x0a
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x0b len 8 id 0x01
l2cap_information_rsp: type 0x0002 result 0x00
l2cap_conn_start: conn c9298700
l2cap_build_cmd: conn c9298700, code 0x03, ident 0x03, len 8
l2cap_send_cmd: code 0x03
l2cap_build_cmd: conn c9298700, code 0x03, ident 0x02, len 8
l2cap_send_cmd: code 0x03
bluetoothd[943]: link_key_request (sba=02:02:02:02:02:02, dba=03:03:03:03:03:03)
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x0b len 8 id 0x02
l2cap_information_rsp: type 0x0002 result 0x00
l2cap_conn_start: conn c9298700
l2cap_build_cmd: conn c9298700, code 0x03, ident 0x03, len 8
l2cap_send_cmd: code 0x03
l2cap_sock_accept: sk ce58be00 timeo 0
l2cap_sock_accept: new socket c74c2000
l2cap_sock_getsockopt: sk c74c2000
l2cap_sock_getsockopt_old: sk c74c2000
l2cap_sock_getname: sock c7184480, sk c74c2000
l2cap_sock_getname: sock c7184480, sk c74c2000
l2cap_security_cfm: conn c9298700
l2cap_build_cmd: conn c9298700, code 0x03, ident 0x03, len 8
l2cap_send_cmd: code 0x03
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x04 len 8 id 0x04
l2cap_config_req: dcid 0x0040 flags 0x00
l2cap_parse_conf_req: sk c74c2a00
l2cap_get_conf_opt: type 0x01 len 2 val 0x30
l2cap_add_conf_opt: type 0x01 len 2 val 0x30
l2cap_build_cmd: conn c9298700, code 0x05, ident 0x04, len 10
l2cap_send_cmd: code 0x05
l2cap_build_conf_req: sk c74c2a00
l2cap_build_cmd: conn c9298700, code 0x04, ident 0x03, len 4
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn c9298700 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x05 len 6 id 0x03
l2cap_config_rsp: scid 0x0040 flags 0x00 result 0x00
l2cap_chan_ready: sk c74c2a00, parent cd560400
l2cap_sock_clear_timer: sock c74c2a00 state 1
l2cap_sock_accept: sk cd560400 timeo 2147483647
l2cap_sock_accept: new socket c74c2a00
l2cap_sock_getname: sock c7184600, sk c74c2a00
l2cap_recv_acldata: conn c9298700 len 24 flags 0x2
l2cap_recv_frame: len 20, cid 0x0040
l2cap_data_channel: sk c74c2a00, len 20
l2cap_sock_getname: sock c7184600, sk c74c2a00
l2cap_sock_getsockopt: sk c74c2a00
l2cap_sock_getsockopt_old: sk c74c2a00
l2cap_sock_getname: sock c7184600, sk c74c2a00
l2cap_sock_sendmsg: sock c7184600, sk c74c2a00
l2cap_do_send: sk c74c2a00 len 29
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x06 len 4 id 0x05
l2cap_disconnect_req: scid 0x0040 dcid 0x0041
l2cap_build_cmd: conn c9298700, code 0x07, ident 0x05, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock c74c2000 state 7
l2cap_chan_del: sk c74c2000, conn c9298700, err 104
l2cap_sock_release: sock c7184480, sk c74c2000
l2cap_sock_shutdown: sock c7184480, sk c74c2000
l2cap_sock_kill: sk c74c2000 state 9
l2cap_sock_destruct: sk c74c2000
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x06 len 4 id 0x06
l2cap_disconnect_req: scid 0x0041 dcid 0x0040
l2cap_build_cmd: conn c9298700, code 0x07, ident 0x06, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock c74c2a00 state 1
l2cap_chan_del: sk c74c2a00, conn c9298700, err 104
l2cap_sock_release: sock c7184600, sk c74c2a00
l2cap_sock_shutdown: sock c7184600, sk c74c2a00
l2cap_sock_kill: sk c74c2a00 state 9
l2cap_sock_destruct: sk c74c2a00
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x02 len 4 id 0x07
l2cap_connect_req: psm 0x03 scid 0x0042
l2cap_sock_init: sk c148d200
__l2cap_chan_add: conn c9298700, psm 0x03, dcid 0x0042
l2cap_sock_set_timer: sk c148d200 state 2 timeout 5120
l2cap_build_cmd: conn c9298700, code 0x03, ident 0x07, len 8
l2cap_send_cmd: code 0x03
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x04 len 8 id 0x08
l2cap_config_req: dcid 0x0040 flags 0x00
l2cap_parse_conf_req: sk c148d200
l2cap_get_conf_opt: type 0x01 len 2 val 0x84
l2cap_add_conf_opt: type 0x01 len 2 val 0x84
l2cap_build_cmd: conn c9298700, code 0x05, ident 0x08, len 10
l2cap_send_cmd: code 0x05
l2cap_build_conf_req: sk c148d200
l2cap_add_conf_opt: type 0x01 len 2 val 0x3f5
l2cap_build_cmd: conn c9298700, code 0x04, ident 0x04, len 8
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn c9298700 len 18 flags 0x2
l2cap_recv_frame: len 14, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x05 len 10 id 0x04
l2cap_config_rsp: scid 0x0040 flags 0x00 result 0x00
l2cap_chan_ready: sk c148d200, parent cdbba200
l2cap_sock_clear_timer: sock c148d200 state 1
l2cap_sock_accept: sk cdbba200 timeo 0
l2cap_sock_accept: new socket c148d200
l2cap_recv_acldata: conn c9298700 len 8 flags 0x2
l2cap_recv_frame: len 4, cid 0x0040
l2cap_data_channel: sk c148d200, len 4
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 4
l2cap_recv_acldata: conn c9298700 len 18 flags 0x2
l2cap_recv_frame: len 14, cid 0x0040
l2cap_data_channel: sk c148d200, len 14
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 14
l2cap_recv_acldata: conn c9298700 len 8 flags 0x2
l2cap_recv_frame: len 4, cid 0x0040
l2cap_data_channel: sk c148d200, len 4
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 4
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 8
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0040
l2cap_data_channel: sk c148d200, len 8
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 8
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0040
l2cap_data_channel: sk c148d200, len 8
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 5
l2cap_recv_acldata: conn c9298700 len 9 flags 0x2
l2cap_recv_frame: len 5, cid 0x0040
l2cap_data_channel: sk c148d200, len 5
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x02 len 4 id 0x09
l2cap_connect_req: psm 0x01 scid 0x0043
l2cap_sock_init: sk ccb63c00
__l2cap_chan_add: conn c9298700, psm 0x01, dcid 0x0043
l2cap_sock_set_timer: sk ccb63c00 state 2 timeout 5120
l2cap_build_cmd: conn c9298700, code 0x03, ident 0x09, len 8
l2cap_send_cmd: code 0x03
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x04 len 8 id 0x0a
l2cap_config_req: dcid 0x0041 flags 0x00
l2cap_parse_conf_req: sk ccb63c00
l2cap_get_conf_opt: type 0x01 len 2 val 0x30
l2cap_add_conf_opt: type 0x01 len 2 val 0x30
l2cap_build_cmd: conn c9298700, code 0x05, ident 0x0a, len 10
l2cap_send_cmd: code 0x05
l2cap_build_conf_req: sk ccb63c00
l2cap_build_cmd: conn c9298700, code 0x04, ident 0x05, len 4
l2cap_send_cmd: code 0x04
l2cap_security_cfm: conn c9298700
l2cap_security_cfm: conn c9298700
l2cap_recv_acldata: conn c9298700 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x05 len 6 id 0x05
l2cap_config_rsp: scid 0x0041 flags 0x00 result 0x00
l2cap_chan_ready: sk ccb63c00, parent cd560400
l2cap_sock_clear_timer: sock ccb63c00 state 1
l2cap_sock_accept: sk cd560400 timeo 2147483647
l2cap_sock_accept: new socket ccb63c00
l2cap_sock_getname: sock c7184780, sk ccb63c00
l2cap_recv_acldata: conn c9298700 len 17 flags 0x2
l2cap_recv_acldata: Start: total len 24, frag len 17
l2cap_recv_acldata: conn c9298700 len 7 flags 0x1
l2cap_recv_acldata: Cont: frag len 7 (expecting 7)
l2cap_recv_frame: len 20, cid 0x0041
l2cap_data_channel: sk ccb63c00, len 20
l2cap_sock_getname: sock c7184780, sk ccb63c00
l2cap_sock_getsockopt: sk ccb63c00
l2cap_sock_getsockopt_old: sk ccb63c00
l2cap_sock_getname: sock c7184780, sk ccb63c00
l2cap_sock_sendmsg: sock c7184780, sk ccb63c00
l2cap_do_send: sk ccb63c00 len 25
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x06 len 4 id 0x0b
l2cap_disconnect_req: scid 0x0043 dcid 0x0041
l2cap_build_cmd: conn c9298700, code 0x07, ident 0x0b, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock ccb63c00 state 1
l2cap_chan_del: sk ccb63c00, conn c9298700, err 104
l2cap_sock_release: sock c7184780, sk ccb63c00
l2cap_sock_shutdown: sock c7184780, sk ccb63c00
l2cap_sock_kill: sk ccb63c00 state 9
l2cap_sock_destruct: sk ccb63c00
l2cap_recv_acldata: conn c9298700 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0040
l2cap_data_channel: sk c148d200, len 15
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 18
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_recv_acldata: conn c9298700 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0040
l2cap_data_channel: sk c148d200, len 15
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 130
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_recv_acldata: conn c9298700 len 18 flags 0x2
l2cap_recv_frame: len 14, cid 0x0040
l2cap_data_channel: sk c148d200, len 14
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 28
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_recv_acldata: conn c9298700 len 28 flags 0x2
l2cap_recv_frame: len 24, cid 0x0040
l2cap_data_channel: sk c148d200, len 24
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_recv_acldata: conn c9298700 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0040
l2cap_data_channel: sk c148d200, len 15
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 32
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_recv_acldata: conn c9298700 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0040
l2cap_data_channel: sk c148d200, len 15
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_recv_acldata: conn c9298700 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0040
l2cap_data_channel: sk c148d200, len 15
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_recv_acldata: conn c9298700 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0040
l2cap_data_channel: sk c148d200, len 15
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_recv_acldata: conn c9298700 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0040
l2cap_data_channel: sk c148d200, len 15
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 10
l2cap_sock_create: sock c7184780
l2cap_sock_init: sk c9076200
l2cap_sock_bind: sk c9076200
l2cap_sock_connect: sk c9076200
l2cap_do_connect: 04:04:04:04:04:04 -> 01:01:01:01:01:01 psm 0x19
__l2cap_chan_add: conn c9298700, psm 0x19, dcid 0x0000
l2cap_sock_set_timer: sk c9076200 state 5 timeout 5120
l2cap_build_cmd: conn c9298700, code 0x02, ident 0x06, len 4
l2cap_send_cmd: code 0x02
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x03 len 8 id 0x06
l2cap_connect_rsp: dcid 0x0044 scid 0x0041 result 0x01 status 0x02
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x03 len 8 id 0x06
l2cap_connect_rsp: dcid 0x0044 scid 0x0041 result 0x00 status 0x00
l2cap_build_conf_req: sk c9076200
l2cap_build_cmd: conn c9298700, code 0x04, ident 0x07, len 4
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x04 len 8 id 0x0c
l2cap_config_req: dcid 0x0041 flags 0x00
l2cap_parse_conf_req: sk c9076200
l2cap_get_conf_opt: type 0x01 len 2 val 0x37f
l2cap_add_conf_opt: type 0x01 len 2 val 0x37f
l2cap_build_cmd: conn c9298700, code 0x05, ident 0x0c, len 10
l2cap_send_cmd: code 0x05
l2cap_recv_acldata: conn c9298700 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x05 len 6 id 0x07
l2cap_config_rsp: scid 0x0041 flags 0x00 result 0x00
l2cap_chan_ready: sk c9076200, parent 00000000
l2cap_sock_clear_timer: sock c9076200 state 1
l2cap_sock_getsockopt: sk c9076200
l2cap_sock_getsockopt_old: sk c9076200
l2cap_sock_getname: sock c7184780, sk c9076200
l2cap_sock_getname: sock c7184780, sk c9076200
l2cap_sock_create: sock c7184900
l2cap_sock_init: sk c453f800
l2cap_sock_bind: sk c453f800
l2cap_sock_connect: sk c453f800
l2cap_do_connect: 04:04:04:04:04:04 -> 01:01:01:01:01:01 psm 0x17
__l2cap_chan_add: conn c9298700, psm 0x17, dcid 0x0000
l2cap_sock_set_timer: sk c453f800 state 5 timeout 5120
l2cap_build_cmd: conn c9298700, code 0x02, ident 0x08, len 4
l2cap_send_cmd: code 0x02
l2cap_sock_sendmsg: sock c7184780, sk c9076200
l2cap_do_send: sk c9076200 len 2
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x03 len 8 id 0x08
l2cap_connect_rsp: dcid 0x0045 scid 0x0042 result 0x01 status 0x02
l2cap_recv_acldata: conn c9298700 len 10 flags 0x2
l2cap_recv_frame: len 6, cid 0x0041
l2cap_data_channel: sk c9076200, len 6
l2cap_sock_sendmsg: sock c7184780, sk c9076200
l2cap_do_send: sk c9076200 len 3
l2cap_recv_acldata: conn c9298700 len 20 flags 0x2
l2cap_recv_frame: len 16, cid 0x0041
l2cap_data_channel: sk c9076200, len 16
l2cap_sock_sendmsg: sock c7184780, sk c9076200
l2cap_do_send: sk c9076200 len 3
l2cap_recv_acldata: conn c9298700 len 20 flags 0x2
l2cap_recv_frame: len 16, cid 0x0041
l2cap_data_channel: sk c9076200, len 16
l2cap_sock_sendmsg: sock c7184780, sk c9076200
l2cap_do_send: sk c9076200 len 14
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x03 len 8 id 0x08
l2cap_connect_rsp: dcid 0x0045 scid 0x0042 result 0x00 status 0x00
l2cap_build_conf_req: sk c453f800
l2cap_build_cmd: conn c9298700, code 0x04, ident 0x09, len 4
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x04 len 8 id 0x0d
l2cap_config_req: dcid 0x0042 flags 0x00
l2cap_parse_conf_req: sk c453f800
l2cap_get_conf_opt: type 0x01 len 2 val 0x37f
l2cap_add_conf_opt: type 0x01 len 2 val 0x37f
l2cap_build_cmd: conn c9298700, code 0x05, ident 0x0d, len 10
l2cap_send_cmd: code 0x05
l2cap_recv_acldata: conn c9298700 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x05 len 6 id 0x09
l2cap_config_rsp: scid 0x0042 flags 0x00 result 0x00
l2cap_chan_ready: sk c453f800, parent 00000000
l2cap_sock_clear_timer: sock c453f800 state 1
l2cap_sock_getsockopt: sk c453f800
l2cap_sock_getsockopt_old: sk c453f800
l2cap_sock_getname: sock c7184900, sk c453f800
l2cap_sock_getname: sock c7184900, sk c453f800
input: 03:03:03:03:03:03 as /class/input/input4
l2cap_recv_acldata: conn c9298700 len 6 flags 0x2
l2cap_recv_frame: len 2, cid 0x0041
l2cap_data_channel: sk c9076200, len 2
l2cap_sock_sendmsg: sock c7184780, sk c9076200
l2cap_do_send: sk c9076200 len 3
l2cap_recv_acldata: conn c9298700 len 6 flags 0x2
l2cap_recv_frame: len 2, cid 0x0041
l2cap_data_channel: sk c9076200, len 2
l2cap_sock_create: sock c7184a80
l2cap_sock_init: sk c74c2200
l2cap_sock_bind: sk c74c2200
l2cap_sock_connect: sk c74c2200
l2cap_do_connect: 04:04:04:04:04:04 -> 01:01:01:01:01:01 psm 0x19
__l2cap_chan_add: conn c9298700, psm 0x19, dcid 0x0000
l2cap_sock_set_timer: sk c74c2200 state 5 timeout 5120
l2cap_build_cmd: conn c9298700, code 0x02, ident 0x0a, len 4
l2cap_send_cmd: code 0x02
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x03 len 8 id 0x0a
l2cap_connect_rsp: dcid 0x0046 scid 0x0043 result 0x01 status 0x02
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x03 len 8 id 0x0a
l2cap_connect_rsp: dcid 0x0046 scid 0x0043 result 0x00 status 0x00
l2cap_build_conf_req: sk c74c2200
l2cap_build_cmd: conn c9298700, code 0x04, ident 0x0b, len 4
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn c9298700 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x04 len 8 id 0x0e
l2cap_config_req: dcid 0x0043 flags 0x00
l2cap_parse_conf_req: sk c74c2200
l2cap_get_conf_opt: type 0x01 len 2 val 0x37f
l2cap_add_conf_opt: type 0x01 len 2 val 0x37f
l2cap_build_cmd: conn c9298700, code 0x05, ident 0x0e, len 10
l2cap_send_cmd: code 0x05
l2cap_recv_acldata: conn c9298700 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x05 len 6 id 0x0b
l2cap_config_rsp: scid 0x0043 flags 0x00 result 0x00
l2cap_chan_ready: sk c74c2200, parent 00000000
l2cap_sock_clear_timer: sock c74c2200 state 1
l2cap_sock_getsockopt: sk c74c2200
l2cap_sock_getsockopt_old: sk c74c2200
l2cap_sock_getname: sock c7184a80, sk c74c2200
l2cap_sock_getname: sock c7184a80, sk c74c2200
ke_recv[1337]: device_added:2549: udi: /org/freedesktop/Hal/devices/computer_logicaldev_input_1
ke_recv[1337]: device_added:2629: /org/freedesktop/Hal/devices/computer_logicaldev_input_1 is not a storage or volume
l2cap_sock_sendmsg: sock c7184780, sk c9076200
l2cap_do_send: sk c9076200 len 3
l2cap_recv_acldata: conn c9298700 len 6 flags 0x2
l2cap_recv_frame: len 2, cid 0x0041
l2cap_data_channel: sk c9076200, len 2
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184a80, sk c74c2200
l2cap_do_send: sk c74c2200 len 846
l2cap_sock_sendmsg: sock c7184780, sk c9076200
l2cap_do_send: sk c9076200 len 3
l2cap_recv_acldata: conn c9298700 len 6 flags 0x2
l2cap_recv_frame: len 2, cid 0x0041
l2cap_data_channel: sk c9076200, len 2
browser[1505]: GLIB CRITICAL ** Gtk - gtk_widget_show: assertion `GTK_IS_WIDGET (widget)' failed
l2cap_recv_acldata: conn c9298700 len 7 flags 0x2
l2cap_recv_frame: len 3, cid 0x0041
l2cap_data_channel: sk c9076200, len 3
l2cap_sock_sendmsg: sock c7184780, sk c9076200
l2cap_do_send: sk c9076200 len 2
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x06 len 4 id 0x0f
l2cap_disconnect_req: scid 0x0045 dcid 0x0042
l2cap_build_cmd: conn c9298700, code 0x07, ident 0x0f, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock c453f800 state 1
l2cap_chan_del: sk c453f800, conn c9298700, err 104
l2cap_sock_release: sock c7184900, sk c453f800
l2cap_sock_shutdown: sock c7184900, sk c453f800
l2cap_sock_kill: sk c453f800 state 9
l2cap_sock_destruct: sk c453f800
l2cap_recv_acldata: conn c9298700 len 8 flags 0x2
l2cap_recv_frame: len 4, cid 0x0040
l2cap_data_channel: sk c148d200, len 4
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 4
l2cap_recv_acldata: conn c9298700 len 8 flags 0x2
l2cap_recv_frame: len 4, cid 0x0040
l2cap_data_channel: sk c148d200, len 4
l2cap_sock_sendmsg: sock c7184600, sk c148d200
l2cap_do_send: sk c148d200 len 4
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x06 len 4 id 0x10
l2cap_disconnect_req: scid 0x0042 dcid 0x0040
l2cap_build_cmd: conn c9298700, code 0x07, ident 0x10, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock c148d200 state 1
l2cap_chan_del: sk c148d200, conn c9298700, err 104
l2cap_sock_release: sock c7184600, sk c148d200
l2cap_sock_shutdown: sock c7184600, sk c148d200
l2cap_sock_kill: sk c148d200 state 9
l2cap_sock_destruct: sk c148d200
l2cap_recv_acldata: conn c9298700 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn c9298700
l2cap_sig_channel: code 0x06 len 4 id 0x11
l2cap_disconnect_req: scid 0x0046 dcid 0x0043
l2cap_build_cmd: conn c9298700, code 0x07, ident 0x11, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock c74c2200 state 1
l2cap_chan_del: sk c74c2200, conn c9298700, err 104
l2cap_sock_shutdown: sock c7184a80, sk c74c2200
l2cap_sock_release: sock c7184a80, sk c74c2200
l2cap_sock_shutdown: sock c7184a80, sk c74c2200
l2cap_sock_kill: sk c74c2200 state 9
l2cap_sock_destruct: sk c74c2200
ke_recv[1337]: device_removed:2638: udi: /org/freedesktop/Hal/devices/computer_logicaldev_input_1
iphbd: client with socket 8 disappeared
l2cap_sock_release: sock c7184780, sk c9076200
l2cap_sock_shutdown: sock c7184780, sk c9076200
l2cap_sock_clear_timer: sock c9076200 state 1
__l2cap_sock_close: sk c9076200 state 1 socket c7184780
l2cap_sock_set_timer: sk c9076200 state 8 timeout 5120
l2cap_build_cmd: conn c9298700, code 0x06, ident 0x0c, len 4
l2cap_send_cmd: code 0x06
l2cap_disconn_cfm: hcon cfe3a000 reason 8
l2cap_conn_del: hcon cfe3a000 conn c9298700, err 110
l2cap_sock_clear_timer: sock c9076200 state 8
l2cap_chan_del: sk c9076200, conn c9298700, err 110
l2cap_sock_kill: sk c9076200 state 9
l2cap_sock_destruct: sk c9076200
kb_lock (GPIO 113) is now closed
kb_lock (GPIO 113) is now open
systemui-tklock[1048]: Method call received from: :1.12, iface: com.nokia.system_ui.request, method: tklock_open

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cut_with_press.txt"

kb_lock (GPIO 113) is now open
l2cap_connect_ind: hdev hci0, bdaddr 01:01:01:01:01:01
l2cap_connect_cfm: hcon cfe3b000 bdaddr 01:01:01:01:01:01 status 0
l2cap_conn_add: hcon cfe3b000 conn cb807080
l2cap_conn_ready: conn cb807080
bluetoothd[943]: link_key_request (sba=02:02:02:02:02:02, dba=03:03:03:03:03:03)
l2cap_security_cfm: conn cb807080
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x02 len 4 id 0x02
l2cap_connect_req: psm 0x19 scid 0x0041
l2cap_sock_init: sk ccb63c00
__l2cap_chan_add: conn cb807080, psm 0x19, dcid 0x0041
l2cap_sock_set_timer: sk ccb63c00 state 2 timeout 5120
l2cap_build_cmd: conn cb807080, code 0x03, ident 0x02, len 8
l2cap_send_cmd: code 0x03
l2cap_build_cmd: conn cb807080, code 0x0a, ident 0x01, len 2
l2cap_send_cmd: code 0x0a
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x02 len 4 id 0x03
l2cap_connect_req: psm 0x01 scid 0x0040
l2cap_sock_init: sk c74c2a00
__l2cap_chan_add: conn cb807080, psm 0x01, dcid 0x0040
l2cap_sock_set_timer: sk c74c2a00 state 2 timeout 5120
l2cap_build_cmd: conn cb807080, code 0x03, ident 0x03, len 8
l2cap_send_cmd: code 0x03
l2cap_build_cmd: conn cb807080, code 0x0a, ident 0x02, len 2
l2cap_send_cmd: code 0x0a
l2cap_recv_acldata: conn cb807080 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x0b len 8 id 0x01
l2cap_information_rsp: type 0x0002 result 0x00
l2cap_conn_start: conn cb807080
l2cap_build_cmd: conn cb807080, code 0x03, ident 0x03, len 8
l2cap_send_cmd: code 0x03
l2cap_build_cmd: conn cb807080, code 0x03, ident 0x02, len 8
l2cap_send_cmd: code 0x03
l2cap_sock_accept: sk ce58be00 timeo 0
l2cap_sock_accept: new socket ccb63c00
l2cap_sock_getsockopt: sk ccb63c00
l2cap_sock_getsockopt_old: sk ccb63c00
l2cap_sock_getname: sock c718f480, sk ccb63c00
l2cap_sock_getname: sock c718f480, sk ccb63c00
bluetoothd[943]: link_key_request (sba=02:02:02:02:02:02, dba=03:03:03:03:03:03)
l2cap_recv_acldata: conn cb807080 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x0b len 8 id 0x02
l2cap_information_rsp: type 0x0002 result 0x00
l2cap_conn_start: conn cb807080
avoided crash in l2cap_conn_start parent 00000000 result 1 status 2
l2cap_recv_acldata: conn cb807080 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x04 len 8 id 0x04
l2cap_config_req: dcid 0x0041 flags 0x00
l2cap_parse_conf_req: sk c74c2a00
l2cap_get_conf_opt: type 0x01 len 2 val 0x30
l2cap_add_conf_opt: type 0x01 len 2 val 0x30
l2cap_build_cmd: conn cb807080, code 0x05, ident 0x04, len 10
l2cap_send_cmd: code 0x05
l2cap_build_conf_req: sk c74c2a00
l2cap_build_cmd: conn cb807080, code 0x04, ident 0x03, len 4
l2cap_send_cmd: code 0x04
l2cap_build_cmd: conn cb807080, code 0x03, ident 0x02, len 8
l2cap_send_cmd: code 0x03
l2cap_security_cfm: conn cb807080
l2cap_sock_clear_timer: sock ccb63c00 state 7
l2cap_recv_acldata: conn cb807080 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x05 len 6 id 0x03
l2cap_config_rsp: scid 0x0041 flags 0x00 result 0x00
l2cap_chan_ready: sk c74c2a00, parent cd560400
l2cap_sock_clear_timer: sock c74c2a00 state 1
l2cap_sock_accept: sk cd560400 timeo 2147483647
l2cap_sock_accept: new socket c74c2a00
l2cap_sock_getname: sock c718fd80, sk c74c2a00
l2cap_recv_acldata: conn cb807080 len 17 flags 0x2
l2cap_recv_acldata: Start: total len 24, frag len 17
l2cap_recv_acldata: conn cb807080 len 7 flags 0x1
l2cap_recv_acldata: Cont: frag len 7 (expecting 7)
l2cap_recv_frame: len 20, cid 0x0041
l2cap_data_channel: sk c74c2a00, len 20
l2cap_sock_getname: sock c718fd80, sk c74c2a00
l2cap_sock_getsockopt: sk c74c2a00
l2cap_sock_getsockopt_old: sk c74c2a00
l2cap_sock_getname: sock c718fd80, sk c74c2a00
l2cap_sock_sendmsg: sock c718fd80, sk c74c2a00
l2cap_do_send: sk c74c2a00 len 29
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x06 len 4 id 0x05
l2cap_disconnect_req: scid 0x0040 dcid 0x0041
l2cap_build_cmd: conn cb807080, code 0x07, ident 0x05, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock c74c2a00 state 1
l2cap_chan_del: sk c74c2a00, conn cb807080, err 104
l2cap_sock_release: sock c718fd80, sk c74c2a00
l2cap_sock_shutdown: sock c718fd80, sk c74c2a00
l2cap_sock_kill: sk c74c2a00 state 9
l2cap_sock_destruct: sk c74c2a00
l2cap_recv_acldata: conn cb807080 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x04 len 8 id 0x06
l2cap_config_req: dcid 0x0040 flags 0x00
l2cap_parse_conf_req: sk ccb63c00
l2cap_get_conf_opt: type 0x01 len 2 val 0x37f
l2cap_add_conf_opt: type 0x01 len 2 val 0x37f
l2cap_build_cmd: conn cb807080, code 0x05, ident 0x06, len 10
l2cap_send_cmd: code 0x05
l2cap_build_conf_req: sk ccb63c00
l2cap_build_cmd: conn cb807080, code 0x04, ident 0x04, len 4
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn cb807080 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x05 len 6 id 0x04
l2cap_config_rsp: scid 0x0040 flags 0x00 result 0x00
l2cap_chan_ready: sk ccb63c00, parent 00000000
l2cap_sock_clear_timer: sock ccb63c00 state 1
l2cap_sock_getsockopt: sk ccb63c00
l2cap_sock_getsockopt_old: sk ccb63c00
l2cap_sock_getname: sock c718f480, sk ccb63c00
l2cap_sock_getname: sock c718f480, sk ccb63c00
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x02 len 4 id 0x07
l2cap_connect_req: psm 0x03 scid 0x0042
l2cap_sock_init: sk cc8c0e00
__l2cap_chan_add: conn cb807080, psm 0x03, dcid 0x0042
l2cap_sock_set_timer: sk cc8c0e00 state 2 timeout 5120
l2cap_build_cmd: conn cb807080, code 0x03, ident 0x07, len 8
l2cap_send_cmd: code 0x03
l2cap_recv_acldata: conn cb807080 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x04 len 8 id 0x08
l2cap_config_req: dcid 0x0041 flags 0x00
l2cap_parse_conf_req: sk cc8c0e00
l2cap_get_conf_opt: type 0x01 len 2 val 0x84
l2cap_add_conf_opt: type 0x01 len 2 val 0x84
l2cap_build_cmd: conn cb807080, code 0x05, ident 0x08, len 10
l2cap_send_cmd: code 0x05
l2cap_build_conf_req: sk cc8c0e00
l2cap_add_conf_opt: type 0x01 len 2 val 0x3f5
l2cap_build_cmd: conn cb807080, code 0x04, ident 0x05, len 8
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn cb807080 len 18 flags 0x2
l2cap_recv_frame: len 14, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x05 len 10 id 0x05
l2cap_config_rsp: scid 0x0041 flags 0x00 result 0x00
l2cap_chan_ready: sk cc8c0e00, parent cdbba200
l2cap_sock_clear_timer: sock cc8c0e00 state 1
l2cap_sock_accept: sk cdbba200 timeo 0
l2cap_sock_accept: new socket cc8c0e00
l2cap_recv_acldata: conn cb807080 len 8 flags 0x2
l2cap_recv_frame: len 4, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 4
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 4
l2cap_recv_acldata: conn cb807080 len 18 flags 0x2
l2cap_recv_frame: len 14, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 14
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 14
l2cap_recv_acldata: conn cb807080 len 8 flags 0x2
l2cap_recv_frame: len 4, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 4
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 4
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 8
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 8
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 8
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 8
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 5
l2cap_recv_acldata: conn cb807080 len 9 flags 0x2
l2cap_recv_frame: len 5, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 5
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x02 len 4 id 0x09
l2cap_connect_req: psm 0x01 scid 0x0043
l2cap_sock_init: sk ccb63800
__l2cap_chan_add: conn cb807080, psm 0x01, dcid 0x0043
l2cap_sock_set_timer: sk ccb63800 state 2 timeout 5120
l2cap_build_cmd: conn cb807080, code 0x03, ident 0x09, len 8
l2cap_send_cmd: code 0x03
l2cap_recv_acldata: conn cb807080 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x04 len 8 id 0x0a
l2cap_config_req: dcid 0x0042 flags 0x00
l2cap_parse_conf_req: sk ccb63800
l2cap_get_conf_opt: type 0x01 len 2 val 0x30
l2cap_add_conf_opt: type 0x01 len 2 val 0x30
l2cap_build_cmd: conn cb807080, code 0x05, ident 0x0a, len 10
l2cap_send_cmd: code 0x05
l2cap_build_conf_req: sk ccb63800
l2cap_build_cmd: conn cb807080, code 0x04, ident 0x06, len 4
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn cb807080 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x05 len 6 id 0x06
l2cap_config_rsp: scid 0x0042 flags 0x00 result 0x00
l2cap_chan_ready: sk ccb63800, parent cd560400
l2cap_sock_clear_timer: sock ccb63800 state 1
l2cap_sock_accept: sk cd560400 timeo 2147483647
l2cap_sock_accept: new socket ccb63800
l2cap_sock_getname: sock c718f180, sk ccb63800
l2cap_recv_acldata: conn cb807080 len 24 flags 0x2
l2cap_recv_frame: len 20, cid 0x0042
l2cap_data_channel: sk ccb63800, len 20
l2cap_sock_getname: sock c718f180, sk ccb63800
l2cap_sock_getsockopt: sk ccb63800
l2cap_sock_getsockopt_old: sk ccb63800
l2cap_sock_getname: sock c718f180, sk ccb63800
l2cap_sock_sendmsg: sock c718f180, sk ccb63800
l2cap_do_send: sk ccb63800 len 25
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x06 len 4 id 0x0b
l2cap_disconnect_req: scid 0x0043 dcid 0x0042
l2cap_build_cmd: conn cb807080, code 0x07, ident 0x0b, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock ccb63800 state 1
l2cap_chan_del: sk ccb63800, conn cb807080, err 104
l2cap_sock_release: sock c718f180, sk ccb63800
l2cap_sock_shutdown: sock c718f180, sk ccb63800
l2cap_sock_kill: sk ccb63800 state 9
l2cap_sock_destruct: sk ccb63800
l2cap_recv_acldata: conn cb807080 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 15
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 18
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_recv_acldata: conn cb807080 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 15
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 130
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_sock_sendmsg: sock c718f480, sk ccb63c00
l2cap_do_send: sk ccb63c00 len 2
l2cap_recv_acldata: conn cb807080 len 18 flags 0x2
l2cap_recv_frame: len 14, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 14
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 28
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_recv_acldata: conn cb807080 len 10 flags 0x2
l2cap_recv_frame: len 6, cid 0x0040
l2cap_data_channel: sk ccb63c00, len 6
l2cap_sock_sendmsg: sock c718f480, sk ccb63c00
l2cap_do_send: sk ccb63c00 len 3
l2cap_recv_acldata: conn cb807080 len 20 flags 0x2
l2cap_recv_frame: len 16, cid 0x0040
l2cap_data_channel: sk ccb63c00, len 16
l2cap_sock_sendmsg: sock c718f480, sk ccb63c00
l2cap_do_send: sk ccb63c00 len 3
l2cap_recv_acldata: conn cb807080 len 28 flags 0x2
l2cap_recv_frame: len 24, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 24
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_recv_acldata: conn cb807080 len 20 flags 0x2
l2cap_recv_frame: len 16, cid 0x0040
l2cap_data_channel: sk ccb63c00, len 16
l2cap_sock_sendmsg: sock c718f480, sk ccb63c00
l2cap_do_send: sk ccb63c00 len 14
l2cap_recv_acldata: conn cb807080 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 15
l2cap_recv_acldata: conn cb807080 len 8 flags 0x2
l2cap_recv_frame: len 4, cid 0x0040
l2cap_data_channel: sk ccb63c00, len 4
l2cap_recv_acldata: conn cb807080 len 6 flags 0x2
l2cap_recv_frame: len 2, cid 0x0040
l2cap_data_channel: sk ccb63c00, len 2
bluetoothd[943]: SET_CONFIGURATION request rejected: Stream End Point in Use (19)
l2cap_sock_sendmsg: sock c718f480, sk ccb63c00
l2cap_do_send: sk ccb63c00 len 4
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 32
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_sock_create: sock c718f180
l2cap_sock_init: sk ccb63800
l2cap_sock_bind: sk ccb63800
l2cap_sock_connect: sk ccb63800
l2cap_do_connect: 04:04:04:04:04:04 -> 01:01:01:01:01:01 psm 0x17
__l2cap_chan_add: conn cb807080, psm 0x17, dcid 0x0000
l2cap_sock_set_timer: sk ccb63800 state 5 timeout 5120
l2cap_build_cmd: conn cb807080, code 0x02, ident 0x07, len 4
l2cap_send_cmd: code 0x02
l2cap_recv_acldata: conn cb807080 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x03 len 8 id 0x07
l2cap_connect_rsp: dcid 0x0044 scid 0x0042 result 0x01 status 0x02
l2cap_recv_acldata: conn cb807080 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 15
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_recv_acldata: conn cb807080 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 15
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_recv_acldata: conn cb807080 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 15
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_recv_acldata: conn cb807080 len 19 flags 0x2
l2cap_recv_frame: len 15, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 15
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 10
l2cap_recv_acldata: conn cb807080 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x03 len 8 id 0x07
l2cap_connect_rsp: dcid 0x0044 scid 0x0042 result 0x00 status 0x00
l2cap_build_conf_req: sk ccb63800
l2cap_build_cmd: conn cb807080, code 0x04, ident 0x08, len 4
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn cb807080 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x04 len 8 id 0x0c
l2cap_config_req: dcid 0x0042 flags 0x00
l2cap_parse_conf_req: sk ccb63800
l2cap_get_conf_opt: type 0x01 len 2 val 0x37f
l2cap_add_conf_opt: type 0x01 len 2 val 0x37f
l2cap_build_cmd: conn cb807080, code 0x05, ident 0x0c, len 10
l2cap_send_cmd: code 0x05
l2cap_recv_acldata: conn cb807080 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x05 len 6 id 0x08
l2cap_config_rsp: scid 0x0042 flags 0x00 result 0x00
l2cap_chan_ready: sk ccb63800, parent 00000000
l2cap_sock_clear_timer: sock ccb63800 state 1
l2cap_sock_getsockopt: sk ccb63800
l2cap_sock_getsockopt_old: sk ccb63800
l2cap_sock_getname: sock c718f180, sk ccb63800
l2cap_sock_getname: sock c718f180, sk ccb63800
input: 03:03:03:03:03:03 as /class/input/input9
ke_recv[1337]: device_added:2549: udi: /org/freedesktop/Hal/devices/computer_logicaldev_input_1
ke_recv[1337]: device_added:2629: /org/freedesktop/Hal/devices/computer_logicaldev_input_1 is not a storage or volume
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x06 len 4 id 0x0d
l2cap_disconnect_req: scid 0x0044 dcid 0x0042
l2cap_build_cmd: conn cb807080, code 0x07, ident 0x0d, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock ccb63800 state 1
l2cap_chan_del: sk ccb63800, conn cb807080, err 104
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x06 len 4 id 0x0e
l2cap_disconnect_req: scid 0x0041 dcid 0x0040
l2cap_build_cmd: conn cb807080, code 0x07, ident 0x0e, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock ccb63c00 state 1
l2cap_chan_del: sk ccb63c00, conn cb807080, err 104
l2cap_recv_acldata: conn cb807080 len 8 flags 0x2
l2cap_recv_frame: len 4, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 4
l2cap_sock_release: sock c718f180, sk ccb63800
l2cap_sock_shutdown: sock c718f180, sk ccb63800
l2cap_sock_kill: sk ccb63800 state 9
l2cap_sock_destruct: sk ccb63800
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 4
ke_recv[1337]: device_removed:2638: udi: /org/freedesktop/Hal/devices/computer_logicaldev_input_1
l2cap_sock_release: sock c718f480, sk ccb63c00
l2cap_sock_shutdown: sock c718f480, sk ccb63c00
l2cap_sock_kill: sk ccb63c00 state 9
l2cap_sock_destruct: sk ccb63c00
l2cap_recv_acldata: conn cb807080 len 8 flags 0x2
l2cap_recv_frame: len 4, cid 0x0041
l2cap_data_channel: sk cc8c0e00, len 4
l2cap_sock_sendmsg: sock c718fd80, sk cc8c0e00
l2cap_do_send: sk cc8c0e00 len 4
l2cap_recv_acldata: conn cb807080 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn cb807080
l2cap_sig_channel: code 0x06 len 4 id 0x0f
l2cap_disconnect_req: scid 0x0042 dcid 0x0041
l2cap_build_cmd: conn cb807080, code 0x07, ident 0x0f, len 4
l2cap_send_cmd: code 0x07
l2cap_sock_clear_timer: sock cc8c0e00 state 1
l2cap_chan_del: sk cc8c0e00, conn cb807080, err 104
l2cap_sock_release: sock c718fd80, sk cc8c0e00
l2cap_sock_shutdown: sock c718fd80, sk cc8c0e00
l2cap_sock_kill: sk cc8c0e00 state 9
l2cap_sock_destruct: sk cc8c0e00
l2cap_disconn_cfm: hcon cfe3b000 reason 19
l2cap_conn_del: hcon cfe3b000 conn cb807080, err 104
kb_lock (GPIO 113) is now closed
systemui-tklock[1048]: Method call received from: :1.12, iface: com.nokia.system_ui.request, method: tklock_close
kb_lock (GPIO 113) is now open
kb_lock (GPIO 113) is now closed
systemui-tklock[1048]: Method call received from: :1.12, iface: com.nokia.system_ui.request, method: tklock_open
kb_lock (GPIO 113) is now open

--FL5UXtIhxfXey3p5--
