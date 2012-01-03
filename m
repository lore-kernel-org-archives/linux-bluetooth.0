Return-Path: <cyrus@holtmann.org>
Message-ID: <4F02C822.2000207@monom.org>
Date: Tue, 03 Jan 2012 10:19:30 +0100
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [BUG] Sleeping inside a RCU reader
References: <20120103015131.GA1239@samus>
In-Reply-To: <20120103015131.GA1239@samus>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

not sure if the bt is about the same issue. I was able to trigger this
after a pairing failed (the reason for this is still unknown to me, I am 
debugging this. See the urb failures) and then stopping bluetoothd.

BTW, this is bluetooth-next from yesterday.

cheers,
daniel


Jan  3 10:08:24 candlejack kernel: [66006.248288] usb 5-2: BOGUS urb flags, 2 --> 0
Jan  3 10:08:24 candlejack kernel: [66006.248293] Bluetooth: hci0 urb ffff8801fcfe83c0 submission failed (22)
Jan  3 10:08:28 candlejack kernel: [66010.256231] usb 5-2: BOGUS urb flags, 2 --> 0
Jan  3 10:08:28 candlejack kernel: [66010.256237] Bluetooth: hci0 urb ffff8800375693c0 submission failed (22)
Jan  3 10:09:00 candlejack abrt: detected unhandled Python exception in './test-device'
Jan  3 10:09:02 candlejack abrt: detected unhandled Python exception in './test-device'
Jan  3 10:09:04 candlejack bluetoothd[4913]: Terminating
Jan  3 10:09:05 candlejack kernel: [66046.284261] Bluetooth: unknown link type 97
Jan  3 10:09:05 candlejack kernel: [66046.284281] BUG: unable to handle kernel paging request at 0000000000050002
Jan  3 10:09:05 candlejack kernel: [66046.284330] IP: [<ffffffff817ea271>] _raw_spin_lock_irqsave+0x11/0x30
Jan  3 10:09:05 candlejack kernel: [66046.284368] PGD 0 
Jan  3 10:09:05 candlejack kernel: [66046.284386] Oops: 0002 [#1] SMP 
Jan  3 10:09:05 candlejack kernel: [66046.284414] CPU 1 
Jan  3 10:09:05 candlejack kernel: [66046.284427] Modules linked in: rfcomm bnep btusb bluetooth [last unloaded: scsi_wait_scan]
Jan  3 10:09:05 candlejack kernel: [66046.284498] 
Jan  3 10:09:05 candlejack kernel: [66046.284510] Pid: 4913, comm: bluetoothd Tainted: G          I  3.2.0-rc2+ #5 Hewlett-Packard HP xw4600 Workstation/0AA0h
Jan  3 10:09:05 candlejack kernel: [66046.284567] RIP: 0010:[<ffffffff817ea271>]  [<ffffffff817ea271>] _raw_spin_lock_irqsave+0x11/0x30
Jan  3 10:09:05 candlejack kernel: [66046.284607] RSP: 0018:ffff8801a6141c98  EFLAGS: 00010096
Jan  3 10:09:05 candlejack kernel: [66046.284629] RAX: 0000000000000296 RBX: 0000000000050002 RCX: 0000000000000047
Jan  3 10:09:05 candlejack kernel: [66046.284656] RDX: 0000000000000100 RSI: ffff8801a6141ce0 RDI: 0000000000050002
Jan  3 10:09:05 candlejack kernel: [66046.284689] RBP: ffff8801a6141c98 R08: 0000000000000000 R09: 0000000000000000
Jan  3 10:09:05 candlejack kernel: [66046.284716] R10: 0000000000000000 R11: 0000000000000001 R12: ffff880165a9b4f0
Jan  3 10:09:05 candlejack kernel: [66046.284745] R13: ffff8801a6141ce0 R14: 0000000000050003 R15: 000000000000000f
Jan  3 10:09:05 candlejack kernel: [66046.284772] FS:  00007f8ff6ff1740(0000) GS:ffff88023fc80000(0000) knlGS:0000000000000000
Jan  3 10:09:05 candlejack kernel: [66046.284802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan  3 10:09:05 candlejack kernel: [66046.284825] CR2: 0000000000050002 CR3: 0000000194066000 CR4: 00000000000406e0
Jan  3 10:09:05 candlejack kernel: [66046.284852] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jan  3 10:09:05 candlejack kernel: [66046.284880] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jan  3 10:09:05 candlejack kernel: [66046.284907] Process bluetoothd (pid: 4913, threadinfo ffff8801a6140000, task ffff880199d6cb00)
Jan  3 10:09:05 candlejack kernel: [66046.284938] Stack:
Jan  3 10:09:05 candlejack kernel: [66046.284951]  ffff8801a6141cc8 ffffffff81052c89 ffff880165a9b4f0 0000000000000000
Jan  3 10:09:05 candlejack kernel: [66046.285006]  ffff8802361e15d0 ffff8800512a6330 ffff8801a6141d18 ffffffff81053f4e
Jan  3 10:09:05 candlejack kernel: [66046.285062]  ffffffffa002a7c2 ffff8801a6141cc0 0000000000000000 ffff880165a9b400
Jan  3 10:09:05 candlejack kernel: [66046.285113] Call Trace:
Jan  3 10:09:05 candlejack kernel: [66046.285131]  [<ffffffff81052c89>] lock_timer_base+0x39/0x70
Jan  3 10:09:05 candlejack kernel: [66046.285157]  [<ffffffff81053f4e>] del_timer+0x3e/0x110
Jan  3 10:09:05 candlejack kernel: [66046.285187]  [<ffffffffa00080d4>] hci_conn_del+0x44/0x290 [bluetooth]
Jan  3 10:09:05 candlejack kernel: [66046.285217]  [<ffffffffa00083a0>] hci_conn_hash_flush+0x80/0xf0 [bluetooth]
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffffa0002c1b>] hci_dev_do_close+0xbb/0x320 [bluetooth]
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffffa00047dd>] hci_dev_close+0x2d/0x70 [bluetooth]
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffffa001552a>] hci_sock_ioctl+0x1aa/0x3f0 [bluetooth]
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffff817f1a96>] ? ftrace_call+0x5/0x2b
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffff8162b3c0>] sock_do_ioctl+0x30/0x70
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffff8162c449>] sock_ioctl+0x79/0x2f0
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffff81133a88>] do_vfs_ioctl+0x98/0x550
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffff810b0586>] ? ftrace_test_stop_func+0x16/0x20
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffff817f1a96>] ? ftrace_call+0x5/0x2b
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffff81133fd1>] sys_ioctl+0x91/0xa0
Jan  3 10:09:05 candlejack kernel: [66046.285249]  [<ffffffff817f1ceb>] system_call_fastpath+0x16/0x1b
Jan  3 10:09:05 candlejack kernel: [66046.285249] Code: 40 00 8d 8a 00 01 00 00 89 d0 f0 66 0f b1 0f 66 39 d0 0f 94 c0 0f b6 c0 5d c3 55 48 89 e5 e8 e7 77 00 00 9c 58 fa ba 00 01 00 00 <f0> 66 0f c1 17 0f b6 ce 38 d1 74 0c 0f 1f 00 f3 90 0f b6 17 38 
Jan  3 10:09:05 candlejack kernel: [66046.285249] RIP  [<ffffffff817ea271>] _raw_spin_lock_irqsave+0x11/0x30
Jan  3 10:09:05 candlejack kernel: [66046.285249]  RSP <ffff8801a6141c98>
Jan  3 10:09:05 candlejack kernel: [66046.285249] CR2: 0000000000050002
Jan  3 10:09:05 candlejack kernel: [66046.287210] ---[ end trace 4eaa2a86a8e2da24 ]---
Jan  3 10:09:05 candlejack kernel: [66047.254031] Bluetooth: hci0 command tx timeout
