Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 17:25:39 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: Re: Two crashes
Message-ID: <20120601202539.GA31580@samus>
References: <20120601195809.GA30006@shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120601195809.GA30006@shutemov.name>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kirill,

On 22:58 Fri 01 Jun, Kirill A. Shutemov wrote:
> Bcc: 
> Subject: Two creashes
> Reply-To: 
> 
> Hi,
> 
> I'm playing with my brand new headset since yesterday and I've got two
> oopses already on Linus tree -- af56e0a.
> 
> I don't have a specific steps to reproduce it unfortunately.
> 
> Here they are:
> 
> [ 7192.272997] PGD 0 
> [ 7192.273008] Oops: 0002 [#1] PREEMPT SMP 
> [ 7192.273025] CPU 1 
> [ 7192.273039] Modules linked in: rfcomm bnep acpi_cpufreq btusb bluetooth iwlwifi thermal mperf battery container ac processor
> [ 7192.273078] 
> [ 7192.273089] Pid: 3169, comm: bluetoothd Not tainted 3.4.0-09208-gaf56e0a #30 Hewlett-Packard HP EliteBook 8440p/172A
> [ 7192.273130] RIP: 0010:[<ffffffffa0119bf6>]  [<ffffffffa0119bf6>] bt_accept_unlink+0x46/0xa0 [bluetooth]
> [ 7192.273162] RSP: 0018:ffff88012fab9db8  EFLAGS: 00010246
> [ 7192.273183] RAX: 0000000000000000 RBX: ffff88012e2ad400 RCX: ffff88012e2ad670
> [ 7192.273209] RDX: ffff88012e2ad670 RSI: ffff88012fab9d60 RDI: ffff88012e2ad400
> [ 7192.273235] RBP: ffff88012fab9dc8 R08: ffff88012fab8000 R09: 0000000000000001
> [ 7192.273261] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88012e2ad400
> [ 7192.273286] R13: ffff8801330a3c00 R14: ffff88012e2ad400 R15: ffff88012f8d9a70
> [ 7192.273312] FS:  00007fbda55ca700(0000) GS:ffff880137c40000(0000) knlGS:0000000000000000
> [ 7192.273345] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 7192.273367] CR2: 000000000000015c CR3: 000000013098f000 CR4: 00000000000007e0
> [ 7192.273396] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 7192.273423] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [ 7192.273452] Process bluetoothd (pid: 3169, threadinfo ffff88012fab8000, task ffff880131bb8000)
> [ 7192.273482] Stack:
> [ 7192.273494]  ffff8801330a3c00 ffff88012f8d9a70 ffff88012fab9e18 ffffffffa0119d1c
> [ 7192.273521]  ffff88012f8d9800 ffff88012f8d9a70 ffff88012fab9df8 ffff88012f8d9800
> [ 7192.273549]  ffff880131bb8000 0000000000000000 ffff8801330a3c00 0000000000000000
> [ 7192.273575] Call Trace:
> [ 7192.273590]  [<ffffffffa0119d1c>] bt_accept_dequeue+0xcc/0x190 [bluetooth]
> [ 7192.273622]  [<ffffffffa013fadd>] l2cap_sock_accept+0x11d/0x220 [bluetooth]
> [ 7192.273650]  [<ffffffff8109bb90>] ? try_to_wake_up+0x2b0/0x2b0
> [ 7192.273675]  [<ffffffff814f698a>] sys_accept4+0xea/0x1f0
> [ 7192.273700]  [<ffffffff8113b078>] ? vfs_write+0x138/0x180
> [ 7192.273721]  [<ffffffff814f6a9b>] sys_accept+0xb/0x10
> [ 7192.273743]  [<ffffffff815f67a6>] system_call_fastpath+0x1a/0x1f
> [ 7192.273782] Code: 00 48 8d 83 70 02 00 00 48 8b 93 78 02 00 00 48 89 51 08 48 89 0a 48 89 83 70 02 00 00 48 89 83 78 02 00 00 48 8b 83 80 02 00 00 <66> 83 a8 5c 01 00 00 01 48 c7 83 80 02 00 00 00 00 00 00 f0 ff 
> [ 7192.273873]  RSP <ffff88012fab9db8>
> [ 7192.273887] CR2: 000000000000015c
> [ 7192.283325] ---[ end trace 673b3cde39738f63 ]---

This looks like this patch ( http://thread.gmane.org/gmane.linux.bluez.kernel/26089 ) may help.
It would be great if you could give it a try.

> 
> [23163.957570] general protection fault: 0000 [#1] PREEMPT SMP 
> [23163.957605] CPU 3 
> [23163.957622] Modules linked in: rfcomm bnep acpi_cpufreq iwlwifi btusb bluetooth mperf thermal battery container processor ac
> [23163.957665] 
> [23163.957676] Pid: 4498, comm: bluetoothd Not tainted 3.4.0-09208-gaf56e0a #30 Hewlett-Packard HP EliteBook 8440p/172A
> [23163.957732] RIP: 0010:[<ffffffffa00fa5cd>]  [<ffffffffa00fa5cd>] l2cap_chan_destroy+0x2d/0x80 [bluetooth]
> [23163.957769] RSP: 0018:ffff8801131a5ca8  EFLAGS: 00010296
> [23163.957791] RAX: dead000000200200 RBX: ffff88012dd72800 RCX: 0000000000000000
> [23163.957819] RDX: dead000000100100 RSI: ffff88012fef0f60 RDI: ffffffffa010cb80
> [23163.957846] RBP: ffff8801131a5cb8 R08: ffff8801131a4000 R09: ffffffff81b8e240
> [23163.957874] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88012dd72b48
> [23163.957901] R13: ffff8801131cea00 R14: ffff88012dd72800 R15: ffff8801131ce818
> [23163.957929] FS:  00007f00eb792700(0000) GS:ffff880137cc0000(0000) knlGS:0000000000000000
> [23163.957960] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [23163.957983] CR2: 00007f036a19aec0 CR3: 000000011335a000 CR4: 00000000000007e0
> [23163.958011] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [23163.958038] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [23163.958068] Process bluetoothd (pid: 4498, threadinfo ffff8801131a4000, task ffff88012fef0f60)
> [23163.958105] Stack:
> [23163.958119]  ffff8801131a5cb8 ffff88012dd71800 ffff8801131a5cd8 ffffffffa0101ba5
> [23163.958156]  ffff8801131ceb30 ffff8801131ceb30 ffff8801131a5ce8 ffffffffa0101cc9
> [23163.958199]  ffff8801131a5d48 ffffffffa00f5e18 ffff8801131a5d18 ffff8801131ceb40
> [23163.958240] Call Trace:
> [23163.958269]  [<ffffffffa0101ba5>] l2cap_sock_kill+0x45/0xa0 [bluetooth]
> [23163.958309]  [<ffffffffa0101cc9>] l2cap_sock_close_cb+0x9/0x10 [bluetooth]
> [23163.958347]  [<ffffffffa00f5e18>] l2cap_conn_del+0xd8/0x190 [bluetooth]
> [23163.958388]  [<ffffffffa00ffb72>] l2cap_disconn_cfm+0x32/0x60 [bluetooth]
> [23163.958431]  [<ffffffffa00e2a5d>] hci_conn_hash_flush+0xad/0xe0 [bluetooth]
> [23163.958475]  [<ffffffffa00ddc61>] hci_dev_do_close+0xc1/0x3f0 [bluetooth]
> [23163.958521]  [<ffffffffa00df0fe>] hci_dev_close+0x2e/0x70 [bluetooth]
> [23163.958575]  [<ffffffffa00f2e03>] hci_sock_ioctl+0x1a3/0x3b0 [bluetooth]
> [23163.958616]  [<ffffffff8112a4ac>] ? kmem_cache_free+0x8c/0x90
> [23163.958656]  [<ffffffff814f390b>] sock_do_ioctl+0x2b/0x70
> [23163.958683]  [<ffffffff814f3be1>] sock_ioctl+0x71/0x2a0
> [23163.958711]  [<ffffffff8114c38f>] do_vfs_ioctl+0x8f/0x530
> [23163.958748]  [<ffffffff8115811f>] ? mntput+0x1f/0x30
> [23163.958777]  [<ffffffff8113cb3b>] ? fput+0x15b/0x240
> [23163.958806]  [<ffffffff8114c8c9>] sys_ioctl+0x99/0xa0
> [23163.958837]  [<ffffffff815f67a6>] system_call_fastpath+0x1a/0x1f
> [23163.958880] Code: 89 e5 53 48 89 fb 48 83 ec 08 48 c7 c7 80 cb 10 a0 e8 e8 67 4f e1 48 8b 83 30 03 00 00 48 c7 c7 80 cb 10 a0 48 8b 93 28 03 00 00 <48> 89 42 08 48 89 10 48 b8 00 01 10 00 00 00 ad de 48 89 83 28 
> [23163.958984]  RSP <ffff8801131a5ca8>
> [23163.994613] ---[ end trace 25c921f2dbcc4129 ]---


This one I still have no clue.


Thanks for the reports.

> 
> -- 
>  Kirill A. Shutemov
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Cheers,
-- 
Vinicius
