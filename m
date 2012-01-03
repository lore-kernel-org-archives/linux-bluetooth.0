Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Jan 2012 22:51:31 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [BUG] Sleeping inside a RCU reader
Message-ID: <20120103015131.GA1239@samus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I found this bug (trace attached) and I don't think I will be able to
start working on it in the next 11 hours, so this email is to make
the life of anyone who wants to work on it a little easier. (If anyone
wishes to work on this, please respond this email).

I was able to reproduce it consistenly doing a "hciconfig <dev> down"
with an established connection. I was using LE devices, but it seems that
the types of the devices don't matter.

The problem is that cancel_delayed_work_sync() called inside
hci_conn_del() is blocking, because of and called in the context of an RCU
(inside hci_conn_hash_flush()).

Cheers,
-- 
Vinicius

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="locking-bug-rcu.txt"

[  220.604374] general protection fault: 0000 [#1] SMP
[  220.605032] CPU 0
[  220.605032] Modules linked in: bnep hci_uart rfcomm btusb bluetooth ftdi_sio usbserial [last unloaded: bluetooth]
[  220.605032]
[  220.605032] Pid: 2046, comm: hciconfig Not tainted 3.2.0-rc2+ #1 Bochs Bochs
[  220.605032] RIP: 0010:[<ffffffff81056e0b>]  [<ffffffff81056e0b>] __lock_acquire+0x9e/0xd60
[  220.605032] RSP: 0018:ffff88003c6dfae8  EFLAGS: 00010046
[  220.605032] RAX: 0000000000000046 RBX: ffff88003e1b0f40 RCX: 0000000000000000
[  220.605032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: dead4ead00000920
[  220.605032] RBP: ffff88003c6dfb98 R08: 0000000000000002 R09: 0000000000000001
[  220.605032] R10: ffff8800bc6dfb9d R11: 0000000000000096 R12: 0000000000000046
[  220.605032] R13: 0000000000000002 R14: 0000000000000000 R15: dead4ead00000920
[  220.605032] FS:  00007f7842c6f700(0000) GS:ffff88003fc00000(0000) knlGS:0000000000000000
[  220.605032] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  220.605032] CR2: 00007f7842c95c11 CR3: 000000003d00f000 CR4: 00000000000006b0
[  220.605032] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  220.605032] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  220.605032] Process hciconfig (pid: 2046, threadinfo ffff88003c6de000, task ffff88003e1b0f40)
[  220.605032] Stack:
[  220.605032]  ffff880000000000 ffffffff00000001 0000000000000000 ffffffff81427a97
[  220.605032]  0000000000037c23 0000000000037c23 ffff88003c6dfb68 ffffffff8103061b
[  220.605032]  0000000000000049 ffffffff00037c23 00000000ffffffff 0000000000000001
[  220.605032] Call Trace:
[  220.605032]  [<ffffffff81427a97>] ? _raw_spin_unlock_irqrestore+0x39/0x5c
[  220.605032]  [<ffffffff8103061b>] ? console_unlock+0x1f7/0x206
[  220.605032]  [<ffffffff81057ee3>] lock_acquire+0x8a/0xa7
[  220.605032]  [<ffffffff81039c57>] ? lock_timer_base.isra.17+0x26/0x4b
[  220.605032]  [<ffffffff814274b9>] _raw_spin_lock_irqsave+0x49/0x5c
[  220.605032]  [<ffffffff81039c57>] ? lock_timer_base.isra.17+0x26/0x4b
[  220.605032]  [<ffffffff81039c57>] lock_timer_base.isra.17+0x26/0x4b
[  220.605032]  [<ffffffff81039ddf>] del_timer+0x26/0x71
[  220.605032]  [<ffffffff811cdd8d>] ? kobject_put+0x45/0x49
[  220.605032]  [<ffffffff81042606>] __cancel_work_timer+0x30/0xfa
[  220.605032]  [<ffffffff810426dd>] cancel_delayed_work_sync+0xd/0xf
[  220.605032]  [<ffffffffa0124d76>] hci_conn_del+0x5a/0x19d [bluetooth]
[  220.605032]  [<ffffffffa0124f6a>] hci_conn_hash_flush+0xb1/0xc9 [bluetooth]
[  220.605032]  [<ffffffffa0120e91>] hci_dev_do_close+0x163/0x28b [bluetooth]
[  220.605032]  [<ffffffffa0121b61>] hci_dev_close+0x26/0x47 [bluetooth]
[  220.605032]  [<ffffffffa012e419>] hci_sock_ioctl+0x123/0x348 [bluetooth]
[  220.605032]  [<ffffffff812fc285>] sock_do_ioctl+0x22/0x40
[  220.605032]  [<ffffffff812fc6a0>] sock_ioctl+0x20e/0x21d
[  220.605032]  [<ffffffff810c5916>] do_vfs_ioctl+0x469/0x4aa
[  220.605032]  [<ffffffff81427add>] ? _raw_spin_unlock+0x23/0x36
[  220.605032]  [<ffffffff8105464b>] ? trace_hardirqs_off_caller+0xa3/0x10b
[  220.605032]  [<ffffffff81427e59>] ? retint_swapgs+0x13/0x1b
[  220.605032]  [<ffffffff810c59a8>] sys_ioctl+0x51/0x75
[  220.605032]  [<ffffffff81428652>] system_call_fastpath+0x16/0x1b
[  220.605032] Code: 8d 58 ff ff ff 74 24 e8 28 15 18 00 85 c0 0f 84 76 0c 00 00 83 3d c5 0b 13 01 00 be cf 0b 00 00 0f 85 64 0c 00 00 e9 e9 0b 00 00
[  220.605032]  81 3f 60 bf 96 81 b8 01 00 00 00 44 0f 44 e8 83 fe 01 77 0c
[  220.605032] RIP  [<ffffffff81056e0b>] __lock_acquire+0x9e/0xd60
[  220.605032]  RSP <ffff88003c6dfae8>
[  220.605032] ---[ end trace b1b0a7fd049894c1 ]---
[  220.605032] note: hciconfig[2046] exited with preempt_count 1
[  220.605032] BUG: sleeping function called from invalid context at kernel/rwsem.c:21
[  220.605032] in_atomic(): 1, irqs_disabled(): 1, pid: 2046, name: hciconfig
[  220.605032] INFO: lockdep is turned off.
[  220.605032] irq event stamp: 3118
[  220.605032] hardirqs last  enabled at (3117): [<ffffffff81427a9e>] _raw_spin_unlock_irqrestore+0x40/0x5c
[  220.605032] hardirqs last disabled at (3118): [<ffffffff8142748a>] _raw_spin_lock_irqsave+0x1a/0x5c
[  220.605032] softirqs last  enabled at (2924): [<ffffffff81301746>] release_sock+0x148/0x151
[  220.605032] softirqs last disabled at (2922): [<ffffffff814275f0>] _raw_spin_lock_bh+0x11/0x4f
[  220.605032] Pid: 2046, comm: hciconfig Tainted: G      D      3.2.0-rc2+ #1
[  220.605032] Call Trace:
[  220.605032]  [<ffffffff810559e1>] ? print_irqtrace_events+0x9d/0xa1
[  220.605032]  [<ffffffff810277fd>] __might_sleep+0xfe/0x103
[  220.605032]  [<ffffffff81426bfa>] down_read+0x1f/0x56
[  220.605032]  [<ffffffff81049ddd>] ? hrtimer_try_to_cancel+0x7f/0x8d
[  220.605032]  [<ffffffff81062bd6>] acct_collect+0x49/0x185
[  220.605032]  [<ffffffff81032e57>] do_exit+0x1f0/0x6ee
[  220.605032]  [<ffffffff810313c7>] ? kmsg_dump+0x84/0x12d
[  220.605032]  [<ffffffff81030611>] ? console_unlock+0x1ed/0x206
[  220.605032]  [<ffffffff810045ac>] oops_end+0x97/0x9c
[  220.605032]  [<ffffffff810046d8>] die+0x55/0x61
[  220.605032]  [<ffffffff8100255c>] do_general_protection+0x12c/0x134
[  220.605032]  [<ffffffff81428055>] general_protection+0x25/0x30
[  220.605032]  [<ffffffff81056e0b>] ? __lock_acquire+0x9e/0xd60
[  220.605032]  [<ffffffff81056dd5>] ? __lock_acquire+0x68/0xd60
[  220.605032]  [<ffffffff81427a97>] ? _raw_spin_unlock_irqrestore+0x39/0x5c
[  220.605032]  [<ffffffff8103061b>] ? console_unlock+0x1f7/0x206
[  220.605032]  [<ffffffff81057ee3>] lock_acquire+0x8a/0xa7
[  220.605032]  [<ffffffff81039c57>] ? lock_timer_base.isra.17+0x26/0x4b
[  220.605032]  [<ffffffff814274b9>] _raw_spin_lock_irqsave+0x49/0x5c
[  220.605032]  [<ffffffff81039c57>] ? lock_timer_base.isra.17+0x26/0x4b
[  220.605032]  [<ffffffff81039c57>] lock_timer_base.isra.17+0x26/0x4b
[  220.605032]  [<ffffffff81039ddf>] del_timer+0x26/0x71
[  220.605032]  [<ffffffff811cdd8d>] ? kobject_put+0x45/0x49
[  220.605032]  [<ffffffff81042606>] __cancel_work_timer+0x30/0xfa
[  220.605032]  [<ffffffff810426dd>] cancel_delayed_work_sync+0xd/0xf
[  220.605032]  [<ffffffffa0124d76>] hci_conn_del+0x5a/0x19d [bluetooth]
[  220.605032]  [<ffffffffa0124f6a>] hci_conn_hash_flush+0xb1/0xc9 [bluetooth]
[  220.605032]  [<ffffffffa0120e91>] hci_dev_do_close+0x163/0x28b [bluetooth]
[  220.605032]  [<ffffffffa0121b61>] hci_dev_close+0x26/0x47 [bluetooth]
[  220.605032]  [<ffffffffa012e419>] hci_sock_ioctl+0x123/0x348 [bluetooth]
[  220.605032]  [<ffffffff812fc285>] sock_do_ioctl+0x22/0x40
[  220.605032]  [<ffffffff812fc6a0>] sock_ioctl+0x20e/0x21d
[  220.605032]  [<ffffffff810c5916>] do_vfs_ioctl+0x469/0x4aa
[  220.605032]  [<ffffffff81427add>] ? _raw_spin_unlock+0x23/0x36
[  220.605032]  [<ffffffff8105464b>] ? trace_hardirqs_off_caller+0xa3/0x10b
[  220.605032]  [<ffffffff81427e59>] ? retint_swapgs+0x13/0x1b
[  220.605032]  [<ffffffff810c59a8>] sys_ioctl+0x51/0x75
[  220.605032]  [<ffffffff81428652>] system_call_fastpath+0x16/0x1b
[  220.695701] BUG: scheduling while atomic: hciconfig/2046/0x10000002
[  220.696929] INFO: lockdep is turned off.

--EVF5PPMfhYS0aIcm--
