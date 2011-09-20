Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 20 Sep 2011 17:18:53 -0500
Message-ID: <CABUK1ahePWTKf5m0f701hC1X3ZxXQec5d-YDoNe=VHBDwc=x2w@mail.gmail.com>
Subject: hci_recv_frame failure
From: Pavan Savoy <pavan_savoy@sify.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am beginning to see some unexpected hci_recv_frame failures on doing
a hciconfig hci0 down.
Un-expected because I am not seeing this always.

Also, I have added these logs to check why hci_recv_frame is failing...
@@ -1630,6 +1636,12 @@ int hci_recv_frame(struct sk_buff *skb)
        if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
                                && !test_bit(HCI_INIT, &hdev->flags))) {
                kfree_skb(skb);
+               if (!hdev)
+                       printk(KERN_ERR"problem 1\n");
+               if (!test_bit(HCI_UP, &hdev->flags))
+                       printk(KERN_ERR"problem 2\n");
+               if (!test_bit(HCI_INIT, &hdev->flags))
+                       printk(KERN_ERR"problem 3\n");

So, any hints as to why HCI_UP and HCI_INIT would be cleared during
hci_recv_frame ?
Note: this seems to happen during hciconfig hci0 down after bringing
down bluetoothd.



root@android:/ # [   76.329437] hci0: type 2 len 13
[   76.355712] hci0: type 1 len 5
[   76.361450] problem 2
[   76.363891] problem 3
[   76.366333] Bluetooth: Unable to push skb to HCI core(-6)
[   76.372100] (stc):  proto stack 4's ->recv failed
[   76.376953] problem 2
[   76.379577] problem 3
[   76.382019] Bluetooth: Unable to push skb to HCI core(-6)
[   76.387786] (stc):  proto stack 2's ->recv failed
[   76.393432] hci0: type 1 len 4
[   76.436340] (stc): remove_channel_from_table: id 2
[   76.442077] (stc): remove_channel_from_table: id 3
[   76.455963] (stc): remove_channel_from_table: id 4
[   76.462524] (stc):  all chnl_ids unregistered
[   76.467803] (stk) :ldisc_install = 0
[   76.473175] (stc): st_tty_close
[   76.484832] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[   76.493499] pgd = c6758000
[   76.496307] [00000000] *pgd=86429831, *pte=00000000, *ppte=00000000
[   76.502868] Internal error: Oops: 817 [#1] PREEMPT SMP
[   76.508270] Modules linked in:
[   76.511474] CPU: 0    Tainted: G        W
(3.0.1-00250-g143aaa3-dirty #5)
[   76.518829] PC is at __skb_recv_datagram+0x134/0x298
[   76.524047] LR is at __raw_spin_lock_irqsave+0x3c/0xac
[   76.529418] pc : [<c03e8b7c>]    lr : [<c0521204>]    psr: 60000093
[   76.529418] sp : c6af7d50  ip : 00000001  fp : c6af7dac
[   76.541412] r10: c03e8d10  r9 : c6af6000  r8 : 00000000
[   76.546875] r7 : c6c49470  r6 : c6c49464  r5 : c6c49400  r4 : c6bc7600
[   76.553710] r3 : 00000000  r2 : 00000000  r1 : 60000013  r0 : 00000000
[   76.560546] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
<snip...>

[   77.506134] Backtrace:
[   77.508697] [<c03e8a48>] (__skb_recv_datagram+0x0/0x298) from
[<c03e8d08>] (skb_recv_datagram+0x28/0x30)
[   77.518615] [<c03e8ce0>] (skb_recv_datagram+0x0/0x30) from
[<c04ef2f0>] (hci_sock_recvmsg+0x50/0x12c)
[   77.528259] [<c04ef2a0>] (hci_sock_recvmsg+0x0/0x12c) from
[<c03dc1fc>] (sock_aio_read+0x14c/0x164)
[   77.537719]  r8:c7659e00 r7:00000404 r6:00000000 r5:c05795e8 r4:c6af7e18
[   77.544769] [<c03dc0b0>] (sock_aio_read+0x0/0x164) from [<c010bccc>]
(do_sync_read+0xb4/0xe4)
[   77.553710] [<c010bc18>] (do_sync_read+0x0/0xe4) from [<c010c9d4>]
(vfs_read+0x148/0x150)
[   77.562255] [<c010c88c>] (vfs_read+0x0/0x150) from [<c010cab8>]
(sys_read+0x44/0x74)
[   77.570343]  r8:bec4f6f8 r7:00000404 r6:c6d00900 r5:00000000 r4:00000000
[   77.577392] [<c010ca74>] (sys_read+0x0/0x74) from [<c004e840>]
(ret_fast_syscall+0x0/0x30)
[   77.586029]  r8:c004e9e8 r7:00000003 r6:00000000 r5:000114a0 r4:bec4f6f8
[   77.593078] Code: e585306c e894000c e5840000 e5840004 (e5832000)
[   77.599517] ---[ end trace 65f8ea860415c055 ]---
[   77.604370] Kernel panic - not syncing: Fatal exception
[   77.609832] Backtrace:
[   77.612426] [<c0052924>] (dump_backtrace+0x0/0x110) from [<c051d6d0>]
(dump_stack+0x18/0x1c)
[   77.621276]  r7:c0624dc8 r6:00000817 r5:c6af6000 r4:c06f2250
[   77.627227] [<c051d6b8>] (dump_stack+0x0/0x1c) from [<c051d768>]
(panic+0x94/0x1c0)
[   77.635253] [<c051d6d4>] (panic+0x0/0x1c0) from [<c0052eb0>]
(die+0x1c8/0x1d4)
[   77.642822]  r3:c0724498 r2:00000001 r1:c6f6ea40 r0:c0624388
[   77.648773] [<c0052ce8>] (die+0x0/0x1d4) from [<c00565cc>]
(__do_kernel_fault+0x7c/0x8c)
[   77.657257] [<c0056550>] (__do_kernel_fault+0x0/0x8c) from
[<c0056718>] (do_page_fault+0x13c/0x204)
[   77.666717]  r9:c6af7d08 r8:00000817 r7:00000000 r6:00000817 r5:c6533dc0
[   77.673583] r4:00000001
[   77.676361] [<c00565dc>] (do_page_fault+0x0/0x204) from [<c00484f8>]
(do_DataAbort+0x3c/0xa0)
[   77.685302] [<c00484bc>] (do_DataAbort+0x0/0xa0) from [<c004e2ac>]
(__dabt_svc+0x4c/0x60)
[   77.693847] Exception stack(0xc6af7d08 to 0xc6af7d50)
[   77.699157] 7d00:                   00000000 60000013 00000000
00000000 c6bc7600 c6c49400
[   77.707733] 7d20: c6c49464 c6c49470 00000000 c6af6000 c03e8d10
c6af7dac 00000001 c6af7d50
[   77.716308] 7d40: c0521204 c03e8b7c 60000093 ffffffff
[   77.721588] [<c03e8a48>] (__skb_recv_datagram+0x0/0x298) from
[<c03e8d08>] (skb_recv_datagram+0x28/0x30)
[   77.731536] [<c03e8ce0>] (skb_recv_datagram+0x0/0x30) from
[<c04ef2f0>] (hci_sock_recvmsg+0x50/0x12c)
[   77.741180] [<c04ef2a0>] (hci_sock_recvmsg+0x0/0x12c) from
[<c03dc1fc>] (sock_aio_read+0x14c/0x164)
[   77.750671]  r8:c7659e00 r7:00000404 r6:00000000 r5:c05795e8 r4:c6af7e18
[   77.757720] [<c03dc0b0>] (sock_aio_read+0x0/0x164) from [<c010bccc>]
(do_sync_read+0xb4/0xe4)
[   77.766662] [<c010bc18>] (do_sync_read+0x0/0xe4) from [<c010c9d4>]
(vfs_read+0x148/0x150)
[   77.775238] [<c010c88c>] (vfs_read+0x0/0x150) from [<c010cab8>]
(sys_read+0x44/0x74)
[   77.783355]  r8:bec4f6f8 r7:00000404 r6:c6d00900 r5:00000000 r4:00000000
[   77.790405] [<c010ca74>] (sys_read+0x0/0x74) from [<c004e840>]
(ret_fast_syscall+0x0/0x30)
[   77.799072]  r8:c004e9e8 r7:00000003 r6:00000000 r5:000114a0 r4:bec4f6f8
[   77.806121] Rebooting in 5 seconds..
[   81.987213] Restarting Linux version 3.0.1-00250-g143aaa3-dirty
(x0130808local@dtx0130808ub) (gcc version 4.3.3 (Sourcery G++ Lite
2009q1-203) ) #5 SMP PREEMPT Tue Sep 20 14:50:31 CDT 2011
[   81.987213]
