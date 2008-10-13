Return-Path: <cyrus@holtmann.org>
From: "Pierre Savary" <pierre.savary@kerlink.fr>
To: "BlueZ-Dev" <bluez-devel@lists.sourceforge.net>,
	<bluez-users@lists.sourceforge.net>
Date: Mon, 13 Oct 2008 15:15:04 +0200
Message-ID: <001301c92d35$b5c40990$214c1cb0$@savary@kerlink.fr>
MIME-Version: 1.0
Subject: [Bluez-devel] problems with kernel 2.6.23 + bluez 3.36 + SCO
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi All,
We develop an application for our board based on SCO. We use the kernel
version 2.6.23 and the bluez-lib 3.36. However we have a lot of problems and
some "kernel panic". Below this message you will find some of these kernel
messages.
How can we stop it? Have you ever saw that?
Thanks in advance,
Best Regards,

Pierre

/*********
 * TRACES:
 *********/

/***************************************************************************
***********/
kobject_add failed for sco001E3B2EC8D8 with -EEXIST, don't try to register
things with the same name in the same directory.
[<c00efc48>] (dump_stack+0x0/0x14) from [<c01bd7dc>]
(kobject_shadow_add+0x190/0x1ac)
[<c01bd64c>] (kobject_shadow_add+0x0/0x1ac) from [<c01bd80c>]
(kobject_add+0x14/0x18)
 r7:c7d7c0f0 r6:c0471fac r5:c7d7c088 r4:c045fa20
[<c01bd7f8>] (kobject_add+0x0/0x18) from [<c01e8b20>]
(device_add+0x94/0x5e8)
[<c01e8a8c>] (device_add+0x0/0x5e8) from [<c0286c7c>] (add_conn+0x1c/0x8c)
[<c0286c60>] (add_conn+0x0/0x8c) from [<c0118090>]
(run_workqueue+0xb8/0x14c)
 r5:c0286c60 r4:c045fa20
[<c0117fd8>] (run_workqueue+0x0/0x14c) from [<c0118224>]
(worker_thread+0x100/0x114)
 r5:c045fa28 r4:c0470000
[<c0118124>] (worker_thread+0x0/0x114) from [<c011bb20>] (kthread+0x54/0x7c)
 r7:00000000 r6:00000000 r5:c0118124 r4:fffffffc
[<c011bacc>] (kthread+0x0/0x7c) from [<c010a89c>] (do_exit+0x0/0x75c)
 r5:00000000 r4:00000000
add_conn: Failed to register connection device
/***************************************************************************
***********/

/***************************************************************************
***********/
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c7174000
[00000000] *pgd=00000000
Internal error: Oops: 805 [#1]
Modules linked in: g_file_storage
CPU: 0    Not tainted  (2.6.23.KLK #961)
PC is at __bug+0x20/0x2c
LR is at 0xc030825c
pc : [<c00efabc>]    lr : [<c030825c>]    psr: 60000093
sp : c7171bc8  ip : c030825c  fp : c7171bd4
r10: c032d600  r9 : 00000020  r8 : 0000000a
r7 : 00000000  r6 : c045c160  r5 : c045e420  r4 : c05e68e0
r3 : 00000000  r2 : 00000001  r1 : 00000001  r0 : 00000021
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 27174000  DAC: 00000015
Process hcid (pid: 352, stack limit = 0xc7170258)
Stack: (0xc7171bc8 to 0xc7172000)
1bc0:                   c7171c00 c7171bd8 c0144670 c00efaac c050b3c0
a0000093 
1be0: c032d600 00000020 00000000 00000001 00000001 c7171c20 c7171c04
c0144ad0 
1c00: c0144404 c050b3c0 60000013 c0458d40 00000200 c7171c44 c7171c24
c022c634 
1c20: c0144a50 00000005 60000013 c06fa320 000000f4 c6a81609 c7171c78
c7171c48 
1c40: c01f9c58 c022c5f8 ffffb010 c7171c6c c050b140 60000013 c06fa320
c06fa32c 
1c60: 000000f5 c07ecc00 c7171de0 c7171c9c c7171c7c c01f9e48 c01f9b70
c0700d20 
1c80: 00000000 c7199c00 c71dfc00 000000f5 c7171cbc c7171ca0 c01f9234
c01f9db0 
1ca0: c0700d20 c71dfc00 c71dfcc0 c0322ce0 c7171cd0 c7171cc0 c01f93b4
c01f90e0 
1cc0: c050b140 c7171ce8 c7171cd4 c02821c8 c01f9364 c71dfc00 c050b140
c7171d04 
1ce0: c7171cec c0282a80 c0282164 00000000 c0322d04 0000000a c7171d1c
c7171d08 
1d00: c010d698 c02829dc 00000001 c0322d44 c7171d3c c7171d20 c010d1d8
c010d620 
1d20: 60000013 c07ecc00 c0322d18 c6a81608 c7171d50 c7171d40 c010d288
c010d18c 
1d40: c7170000 c7171d6c c7171d54 c010d370 c010d254 c050b140 c07ecc00
00000003 
1d60: c7171d84 c7171d70 c022ac20 c010d2f8 c050b140 c71dfc00 c7171dbc
c7171d88 
1d80: c0286354 c022abac 000000f5 c7171eec c7171dbc 00000003 000000f5
c7171e2c 
1da0: c3e66ba0 c7171eec c7171f78 c7171eec c7171e20 c7171dc0 c0227dac
c0286114 
1dc0: c7171dcc c022cdd8 c022ccd8 000000f5 c3e6a060 00000001 00000000
c7171de0 
1de0: 00000000 00000000 c7171eec 00000003 00000000 00000000 00000000
c7171e2c 
1e00: c0227cc8 00000000 c7171e2c c7171e74 00000003 c7171edc c7171e28
c0147ff8 
1e20: c0227cdc 00000000 00000000 c0309c14 00000001 00000000 00000001
ffffffff 
1e40: c3e66ba0 00000000 00000000 00000000 00000000 c0468320 00000000
00000000 
1e60: c010d2f8 c0468320 c011c014 c7171e6c c7171e6c 00000000 00000000
c7171ed0 
1e80: c7171dc0 c7171e90 000000f5 c010d2f8 000000f5 c71dfc00 beb41628
00000003 
1ea0: c7170000 c7171eec c7171eec 00000018 00000000 00000003 c3e66ba0
000000f5 
1ec0: 00000001 000000f5 c7171eec c7171f78 c7171f54 c7171ee0 c0148288
c0147f48 
1ee0: c7171f78 c0227cc8 c7171eec beb41644 00000000 beb41643 00000000
beb418b0 
1f00: 00000000 c022abac 00000010 0000c001 00000000 00000c52 00000000
beb4177c 
1f20: 00000002 00000010 c3e6a060 00000003 ffffffea c7171f78 00000000
00000000 
1f40: c7170000 00000010 c7171f74 c7171f58 c0148474 c01481e8 c7171f78
c3e66bc0 
1f60: c3e66ba0 c7171f78 c7171fa4 c7171f78 c0148540 c0148414 00000000
00000000 
1f80: 00000000 beb41628 00000003 0000000f 00000092 c00ebf64 00000000
c7171fa8 
1fa0: c00ebdc0 c0148504 beb41628 00000003 0000000f beb41628 00000003
4026f000 
1fc0: beb41628 00000003 0000000f beb41628 beb418b2 000007d0 00000010
0000000f 
1fe0: 000031d0 beb41614 40135068 40207810 60000010 0000000f 00011000
00000000 
Backtrace: 
[<c00efa9c>] (__bug+0x0/0x2c) from [<c0144670>]
(cache_alloc_refill+0x27c/0x5ac)
[<c01443f4>] (cache_alloc_refill+0x0/0x5ac) from [<c0144ad0>]
(__kmalloc+0x90/0xc8)
[<c0144a40>] (__kmalloc+0x0/0xc8) from [<c022c634>] (__alloc_skb+0x4c/0xf4)
 r7:00000200 r6:c0458d40 r5:60000013 r4:c050b3c0
[<c022c5e8>] (__alloc_skb+0x0/0xf4) from [<c01f9c58>]
(bcsp_prepare_pkt+0xf8/0x240)
 r8:c6a81609 r7:000000f4 r6:c06fa320 r5:60000013 r4:00000005
[<c01f9b60>] (bcsp_prepare_pkt+0x0/0x240) from [<c01f9e48>]
(bcsp_dequeue+0xa8/0x138)
[<c01f9da0>] (bcsp_dequeue+0x0/0x138) from [<c01f9234>]
(hci_uart_tx_wakeup+0x164/0x1a8)
 r8:000000f5 r7:c71dfc00 r6:c7199c00 r5:00000000 r4:c0700d20
[<c01f90d0>] (hci_uart_tx_wakeup+0x0/0x1a8) from [<c01f93b4>]
(hci_uart_send_frame+0x60/0x70)
 r7:c0322ce0 r6:c71dfcc0 r5:c71dfc00 r4:c0700d20
[<c01f9354>] (hci_uart_send_frame+0x0/0x70) from [<c02821c8>]
(hci_send_frame+0x74/0x78)
 r4:c050b140
[<c0282154>] (hci_send_frame+0x0/0x78) from [<c0282a80>]
(hci_cmd_task+0xb4/0x10c)
 r5:c050b140 r4:c71dfc00
[<c02829cc>] (hci_cmd_task+0x0/0x10c) from [<c010d698>]
(tasklet_action+0x88/0xdc)
 r6:0000000a r5:c0322d04 r4:00000000
[<c010d610>] (tasklet_action+0x0/0xdc) from [<c010d1d8>]
(__do_softirq+0x5c/0xc8)
 r5:c0322d44 r4:00000001
[<c010d17c>] (__do_softirq+0x0/0xc8) from [<c010d288>]
(do_softirq+0x44/0x50)
 r7:c6a81608 r6:c0322d18 r5:c07ecc00 r4:60000013
[<c010d244>] (do_softirq+0x0/0x50) from [<c010d370>]
(local_bh_enable+0x88/0xac)
 r4:c7170000
[<c010d2e8>] (local_bh_enable+0x0/0xac) from [<c022ac20>]
(release_sock+0x84/0x88)
 r6:00000003 r5:c07ecc00 r4:c050b140
[<c022ab9c>] (release_sock+0x0/0x88) from [<c0286354>]
(hci_sock_sendmsg+0x250/0x270)
 r5:c71dfc00 r4:c050b140
[<c0286104>] (hci_sock_sendmsg+0x0/0x270) from [<c0227dac>]
(sock_aio_write+0xe4/0xec)
[<c0227ccc>] (sock_aio_write+0x4/0xec) from [<c0147ff8>]
(do_sync_readv_writev+0xc0/0x110)
 r8:00000003 r7:c7171e74 r6:c7171e2c r5:00000000 r4:c0227cc8
[<c0147f38>] (do_sync_readv_writev+0x0/0x110) from [<c0148288>]
(do_readv_writev+0xb0/0x1b0)
[<c01481d8>] (do_readv_writev+0x0/0x1b0) from [<c0148474>]
(vfs_writev+0x70/0x7c)
[<c0148404>] (vfs_writev+0x0/0x7c) from [<c0148540>] (sys_writev+0x4c/0x74)
 r6:c7171f78 r5:c3e66ba0 r4:c3e66bc0
[<c01484f4>] (sys_writev+0x0/0x74) from [<c00ebdc0>]
(ret_fast_syscall+0x0/0x2c)
 r8:c00ebf64 r7:00000092 r6:0000000f r5:00000003 r4:beb41628
Code: e1a01000 e59f000c eb00656b e3a03000 (e5833000) 
obcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
m at91-pcm: buffer underrun on SSC0 PCM out (SSC_SR=0xc, count=131908)
seKernel panic - not syncing: Fatal exception in interrupt
lect
Stop_HFPWriter
Stop_HFPHandshakeTimer
Stop_HFPScoReader
Stop_HFPScoReader: unregister callback from select
Stop_HFPScoReader: closing socket 54
Stop_HFPScoReader: socket is closed
Stop_HFPScoAcceptor
Close_Socket
Close_Socket: closing socket 52
Close_Socket: socket is closed
Create_ServiceRecord
Register_Service
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 2
bcsp_recv: Out-of-order packet arrived, got 1 expected 2
bcsp_recv: Out-of-order packet arrived, got 0 expected 4
bcsp_recv: Out-of-order packet arrived, got 1 expected 4
bcsp_recv: Out-of-order packet arrived, got 2 expected 4
bcsp_recv: Out-of-order packet arrived, got 3 expected 4
bcsp_recv: Out-of-order packet arrived, got 0 expected 4
bcsp_recv: Out-of-order packet arrived, got 1 expected 4
bcsp_recv: Out-of-order packet arrived, got 2 expected 4
bcsp_recv: Out-of-order packet arrived, got 3 expected 4
bcsp_recv: Out-of-order packet arrived, got 0 expected 4
bcsp_recv: Out-of-order packet arrived, got 1 expected 4
bcsp_recv: Out-of-order packet arrived, got 2 expected 4
bcsp_recv: Out-of-order packet arrived, got 3 expected 4
bcsp_recv: Out-of-order packet arrived, got 0 expected 4
bcsp_recv: Out-of-order packet arrived, got 1 expected 4
bcsp_recv: Out-of-order packet arrived, got 2 expected 4
bcsp_recv: Out-of-order packet arrived, got 3 expected 4
bcsp_recv: Out-of-order packet arrived, got 0 expected 4
bcsp_recv: Out-of-order packet arrived, got 1 expected 4
bcsp_recv: Out-of-order packet arrived, got 2 expected 4
bcsp_recv: Out-of-order packet arrived, got 3 expected 4
bcsp_recv: Out-of-order packet arrived, got 0 expected 4
bcsp_recv: Out-of-order packet arrived, got 1 expected 4
bcsp_recv: Out-of-order packet arrived, got 2 expected 4
bcsp_recv: Out-of-order packet arrived, got 3 expected 4
kernel BUG at mm/slab.c:2983!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c7174000
[00000000] *pgd=00000000
Internal error: Oops: 805 [#2]
Modules linked in: g_file_storage
CPU: 0    Tainted: G      D  (2.6.23.KLK #961)
PC is at __bug+0x20/0x2c
LR is at 0xc030825c
pc : [<c00efabc>]    lr : [<c030825c>]    psr: 60000093
sp : c71718b0  ip : c030825c  fp : c71718bc
r10: c032d600  r9 : 00000020  r8 : 0000001b
r7 : 00000000  r6 : c045c160  r5 : c045e420  r4 : c05e68e0
r3 : 00000000  r2 : 00000001  r1 : 00000001  r0 : 00000021
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 27174000  DAC: 00000015
Process hcid (pid: 352, stack limit = 0xc7170258)
Stack: (0xc71718b0 to 0xc7172000)
18a0:                                     c71718e8 c71718c0 c0144670
c00efaac 
18c0: 00000100 a0000093 c032d600 00000020 00000070 00000070 00000000
c7171908 
18e0: c71718ec c0144ad0 c0144404 00000100 c050a800 c62b5000 60000013
c7171930 
1900: c717190c c01d0030 c0144a50 c03290a4 c0329148 c002d0c0 00000000
00000070 
1920: c050a800 c7171958 c7171934 c01d0184 c01cffa4 c03290a4 c0329148
00000070 
1940: c050a800 00000100 c03290b4 c7171990 c717195c c01e6f08 c01d016c
00000000 
1960: 00100b12 c03242f0 c0700600 00000000 00000000 00000006 bf000000
c7171b80 
1980: 00000008 c71719b0 c7171994 c0129b2c c01e6de0 c0309d2c 00000006
c0326278 
19a0: 00000000 c71719c8 c71719b4 c012ae6c c0129af8 c0309d2c 00000006
c71719e8 
19c0: c71719cc c00eb044 c012ade4 ffffffff fefff000 00000006 c00efabc
c7171a40 
19e0: c71719ec c00eba48 c00eb010 0000b29a 00000000 000001e3 c031e3dc
00001773 
1a00: c031e3e0 c031e3dc c00efabc bf000000 c7171b80 00000008 c7171a40
c7171a34 
1a20: c7171a34 c0108068 c01b94d8 20000013 ffffffff c7171a60 c7171a54
c00eff24 
1a40: c0107f1c c02d9404 00000000 00000080 00000100 c7171a80 c7171a64
c00f11ec 
1a60: c00efcb4 ffffffff c0468320 00000805 c7171b80 c7171abc c7171a84
c00f14cc 
1a80: c00f1190 00000000 00000000 c7171aac 00000805 ffffffff 00000000
00000805 
1aa0: c7171b80 00000000 60000093 c032d600 c7171ad4 c7171ac0 c00f150c
c00f12e0 
1ac0: ffffffff c0306170 c7171b7c c7171ad8 c00eb1e0 c00f14fc c7171ae4
c0108798 
1ae0: c01dfbd8 00008867 c0308268 60000093 c7171b14 c7171b00 c0108838
c0108740 
1b00: 00008867 00008867 c7171b38 c7171b18 c0108d24 c0108b08 c031e818
c7171bbc 
1b20: c02d92ac c031e839 00000021 c7171ba4 c7171b3c c010900c c0108b50
c7170000 
1b40: 00000001 c70de3a0 c7171b74 c0309c14 00000001 c0326278 00000000
ffffffff 
1b60: c7171bb4 c045c160 00000000 0000000a c7171bd4 c7171b80 c00eba00
c00eb1b4 
1b80: 00000021 00000001 00000001 00000000 c05e68e0 c045e420 c045c160
00000000 
1ba0: 0000000a 00000020 c032d600 c7171bd4 c030825c c7171bc8 c030825c
c00efabc 
1bc0: 60000093 ffffffff c7171c00 c7171bd8 c0144670 c00efaac c050b3c0
a0000093 
1be0: c032d600 00000020 00000000 00000001 00000001 c7171c20 c7171c04
c0144ad0 
1c00: c0144404 c050b3c0 60000013 c0458d40 00000200 c7171c44 c7171c24
c022c634 
1c20: c0144a50 00000005 60000013 c06fa320 000000f4 c6a81609 c7171c78
c7171c48 
1c40: c01f9c58 c022c5f8 ffffb010 c7171c6c c050b140 60000013 c06fa320
c06fa32c 
1c60: 000000f5 c07ecc00 c7171de0 c7171c9c c7171c7c c01f9e48 c01f9b70
c0700d20 
1c80: 00000000 c7199c00 c71dfc00 000000f5 c7171cbc c7171ca0 c01f9234
c01f9db0 
1ca0: c0700d20 c71dfc00 c71dfcc0 c0322ce0 c7171cd0 c7171cc0 c01f93b4
c01f90e0 
1cc0: c050b140 c7171ce8 c7171cd4 c02821c8 c01f9364 c71dfc00 c050b140
c7171d04 
1ce0: c7171cec c0282a80 c0282164 00000000 c0322d04 0000000a c7171d1c
c7171d08 
1d00: c010d698 c02829dc 00000001 c0322d44 c7171d3c c7171d20 c010d1d8
c010d620 
1d20: 60000013 c07ecc00 c0322d18 c6a81608 c7171d50 c7171d40 c010d288
c010d18c 
1d40: c7170000 c7171d6c c7171d54 c010d370 c010d254 c050b140 c07ecc00
00000003 
1d60: c7171d84 c7171d70 c022ac20 c010d2f8 c050b140 c71dfc00 c7171dbc
c7171d88 
1d80: c0286354 c022abac 000000f5 c7171eec c7171dbc 00000003 000000f5
c7171e2c 
1da0: c3e66ba0 c7171eec c7171f78 c7171eec c7171e20 c7171dc0 c0227dac
c0286114 
1dc0: c7171dcc c022cdd8 c022ccd8 000000f5 c3e6a060 00000001 00000000
c7171de0 
1de0: 00000000 00000000 c7171eec 00000003 00000000 00000000 00000000
c7171e2c 
1e00: c0227cc8 00000000 c7171e2c c7171e74 00000003 c7171edc c7171e28
c0147ff8 
1e20: c0227cdc 00000000 00000000 c0309c14 00000001 00000000 00000001
ffffffff 
1e40: c3e66ba0 00000000 00000000 00000000 00000000 c0468320 00000000
00000000 
1e60: c010d2f8 c0468320 c011c014 c7171e6c c7171e6c 00000000 00000000
c7171ed0 
1e80: c7171dc0 c7171e90 000000f5 c010d2f8 000000f5 c71dfc00 beb41628
00000003 
1ea0: c7170000 c7171eec c7171eec 00000018 00000000 00000003 c3e66ba0
000000f5 
1ec0: 00000001 000000f5 c7171eec c7171f78 c7171f54 c7171ee0 c0148288
c0147f48 
1ee0: c7171f78 c0227cc8 c7171eec beb41644 00000000 beb41643 00000000
beb418b0 
1f00: 00000000 c022abac 00000010 0000c001 00000000 00000c52 00000000
beb4177c 
1f20: 00000002 00000010 c3e6a060 00000003 ffffffea c7171f78 00000000
00000000 
1f40: c7170000 00000010 c7171f74 c7171f58 c0148474 c01481e8 c7171f78
c3e66bc0 
1f60: c3e66ba0 c7171f78 c7171fa4 c7171f78 c0148540 c0148414 00000000
00000000 
1f80: 00000000 beb41628 00000003 0000000f 00000092 c00ebf64 00000000
c7171fa8 
1fa0: c00ebdc0 c0148504 beb41628 00000003 0000000f beb41628 00000003
4026f000 
1fc0: beb41628 00000003 0000000f beb41628 beb418b2 000007d0 00000010
0000000f 
1fe0: 000031d0 beb41614 40135068 40207810 60000010 0000000f 00011000
00000000 
Backtrace: 
[<c00efa9c>] (__bug+0x0/0x2c) from [<c0144670>]
(cache_alloc_refill+0x27c/0x5ac)
[<c01443f4>] (cache_alloc_refill+0x0/0x5ac) from [<c0144ad0>]
(__kmalloc+0x90/0xc8)
[<c0144a40>] (__kmalloc+0x0/0xc8) from [<c01d0030>]
(tty_buffer_request_room+0x9c/0x138)
 r7:60000013 r6:c62b5000 r5:c050a800 r4:00000100
[<c01cff94>] (tty_buffer_request_room+0x0/0x138) from [<c01d0184>]
(tty_insert_flip_string+0x28/0x84)
[<c01d015c>] (tty_insert_flip_string+0x0/0x84) from [<c01e6f08>]
(atmel_interrupt+0x138/0x73c)
[<c01e6dd0>] (atmel_interrupt+0x0/0x73c) from [<c0129b2c>]
(handle_IRQ_event+0x44/0x80)
[<c0129ae8>] (handle_IRQ_event+0x0/0x80) from [<c012ae6c>]
(handle_level_irq+0x98/0xf0)
 r7:00000000 r6:c0326278 r5:00000006 r4:c0309d2c
[<c012add4>] (handle_level_irq+0x0/0xf0) from [<c00eb044>]
(asm_do_IRQ+0x44/0x6c)
 r5:00000006 r4:c0309d2c
[<c00eb000>] (asm_do_IRQ+0x0/0x6c) from [<c00eba48>] (__irq_svc+0x28/0x60)
Exception stack(0xc71719ec to 0xc7171a34)
19e0:                            0000b29a 00000000 000001e3 c031e3dc
00001773 
1a00: c031e3e0 c031e3dc c00efabc bf000000 c7171b80 00000008 c7171a40
c7171a34 
1a20: c7171a34 c0108068 c01b94d8 20000013 ffffffff

 r7:c00efabc r6:00000006 r5:fefff000 r4:ffffffff
[<c0107f08>] (panic+0x0/0x188) from [<c00eff24>] (die+0x280/0x2d4)
 r3:00000100 r2:00000080 r1:00000000 r0:c02d9404
[<c00efca4>] (die+0x0/0x2d4) from [<c00f11ec>] (__do_kernel_fault+0x6c/0x7c)
[<c00f1180>] (__do_kernel_fault+0x0/0x7c) from [<c00f14cc>]
(do_page_fault+0x1fc/0x21c)
 r7:c7171b80 r6:00000805 r5:c0468320 r4:ffffffff
[<c00f12d0>] (do_page_fault+0x0/0x21c) from [<c00f150c>]
(do_translation_fault+0x20/0x80)
[<c00f14ec>] (do_translation_fault+0x0/0x80) from [<c00eb1e0>]
(do_DataAbort+0x3c/0xa0)
 r5:c0306170 r4:ffffffff
[<c00eb1a4>] (do_DataAbort+0x0/0xa0) from [<c00eba00>]
(__dabt_svc+0x40/0x60)
Exception stack(0xc7171b80 to 0xc7171bc8)
1b80: 00000021 00000001 00000001 00000000 c05e68e0 c045e420 c045c160
00000000 
1ba0: 0000000a 00000020 c032d600 c7171bd4 c030825c c7171bc8 c030825c
c00efabc 
1bc0: 60000093 ffffffff

 r8:0000000a r7:00000000 r6:c045c160 r5:c7171bb4 r4:ffffffff
[<c00efa9c>] (__bug+0x0/0x2c) from [<c0144670>]
(cache_alloc_refill+0x27c/0x5ac)
[<c01443f4>] (cache_alloc_refill+0x0/0x5ac) from [<c0144ad0>]
(__kmalloc+0x90/0xc8)
[<c0144a40>] (__kmalloc+0x0/0xc8) from [<c022c634>] (__alloc_skb+0x4c/0xf4)
 r7:00000200 r6:c0458d40 r5:60000013 r4:c050b3c0
[<c022c5e8>] (__alloc_skb+0x0/0xf4) from [<c01f9c58>]
(bcsp_prepare_pkt+0xf8/0x240)
 r8:c6a81609 r7:000000f4 r6:c06fa320 r5:60000013 r4:00000005
[<c01f9b60>] (bcsp_prepare_pkt+0x0/0x240) from [<c01f9e48>]
(bcsp_dequeue+0xa8/0x138)
[<c01f9da0>] (bcsp_dequeue+0x0/0x138) from [<c01f9234>]
(hci_uart_tx_wakeup+0x164/0x1a8)
 r8:000000f5 r7:c71dfc00 r6:c7199c00 r5:00000000 r4:c0700d20
[<c01f90d0>] (hci_uart_tx_wakeup+0x0/0x1a8) from [<c01f93b4>]
(hci_uart_send_frame+0x60/0x70)
 r7:c0322ce0 r6:c71dfcc0 r5:c71dfc00 r4:c0700d20
[<c01f9354>] (hci_uart_send_frame+0x0/0x70) from [<c02821c8>]
(hci_send_frame+0x74/0x78)
 r4:c050b140
[<c0282154>] (hci_send_frame+0x0/0x78) from [<c0282a80>]
(hci_cmd_task+0xb4/0x10c)
 r5:c050b140 r4:c71dfc00
[<c02829cc>] (hci_cmd_task+0x0/0x10c) from [<c010d698>]
(tasklet_action+0x88/0xdc)
 r6:0000000a r5:c0322d04 r4:00000000
[<c010d610>] (tasklet_action+0x0/0xdc) from [<c010d1d8>]
(__do_softirq+0x5c/0xc8)
 r5:c0322d44 r4:00000001
[<c010d17c>] (__do_softirq+0x0/0xc8) from [<c010d288>]
(do_softirq+0x44/0x50)
 r7:c6a81608 r6:c0322d18 r5:c07ecc00 r4:60000013
[<c010d244>] (do_softirq+0x0/0x50) from [<c010d370>]
(local_bh_enable+0x88/0xac)
 r4:c7170000
[<c010d2e8>] (local_bh_enable+0x0/0xac) from [<c022ac20>]
(release_sock+0x84/0x88)
 r6:00000003 r5:c07ecc00 r4:c050b140
[<c022ab9c>] (release_sock+0x0/0x88) from [<c0286354>]
(hci_sock_sendmsg+0x250/0x270)
 r5:c71dfc00 r4:c050b140
[<c0286104>] (hci_sock_sendmsg+0x0/0x270) from [<c0227dac>]
(sock_aio_write+0xe4/0xec)
[<c0227ccc>] (sock_aio_write+0x4/0xec) from [<c0147ff8>]
(do_sync_readv_writev+0xc0/0x110)
 r8:00000003 r7:c7171e74 r6:c7171e2c r5:00000000 r4:c0227cc8
[<c0147f38>] (do_sync_readv_writev+0x0/0x110) from [<c0148288>]
(do_readv_writev+0xb0/0x1b0)
[<c01481d8>] (do_readv_writev+0x0/0x1b0) from [<c0148474>]
(vfs_writev+0x70/0x7c)
[<c0148404>] (vfs_writev+0x0/0x7c) from [<c0148540>] (sys_writev+0x4c/0x74)
 r6:c7171f78 r5:c3e66ba0 r4:c3e66bc0
[<c01484f4>] (sys_writev+0x0/0x74) from [<c00ebdc0>]
(ret_fast_syscall+0x0/0x2c)
 r8:c00ebf64 r7:00000092 r6:0000000f r5:00000003 r4:beb41628
/***************************************************************************
***********/




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
