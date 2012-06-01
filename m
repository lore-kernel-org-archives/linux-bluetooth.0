Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 20:18:31 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
	linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: Re: Two crashes
Message-ID: <20120601231831.GJ24769@joana>
References: <20120601195809.GA30006@shutemov.name>
 <20120601202539.GA31580@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120601202539.GA31580@samus>
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2012-06-01 17:25:39 -0300]:

> Hi Kirill,
> 
> On 22:58 Fri 01 Jun, Kirill A. Shutemov wrote:
> > Bcc: 
> > Subject: Two creashes
> > Reply-To: 
> > 
> > Hi,
> > 
> > I'm playing with my brand new headset since yesterday and I've got two
> > oopses already on Linus tree -- af56e0a.
> > 
> > I don't have a specific steps to reproduce it unfortunately.

Can you try to reproduce it somehow, that would be very helpful to us.

> > 
> > Here they are:
> > 
> > [ 7192.272997] PGD 0 
> > [ 7192.273008] Oops: 0002 [#1] PREEMPT SMP 
> > [ 7192.273025] CPU 1 
> > [ 7192.273039] Modules linked in: rfcomm bnep acpi_cpufreq btusb bluetooth iwlwifi thermal mperf battery container ac processor
> > [ 7192.273078] 
> > [ 7192.273089] Pid: 3169, comm: bluetoothd Not tainted 3.4.0-09208-gaf56e0a #30 Hewlett-Packard HP EliteBook 8440p/172A
> > [ 7192.273130] RIP: 0010:[<ffffffffa0119bf6>]  [<ffffffffa0119bf6>] bt_accept_unlink+0x46/0xa0 [bluetooth]
> > [ 7192.273162] RSP: 0018:ffff88012fab9db8  EFLAGS: 00010246
> > [ 7192.273183] RAX: 0000000000000000 RBX: ffff88012e2ad400 RCX: ffff88012e2ad670
> > [ 7192.273209] RDX: ffff88012e2ad670 RSI: ffff88012fab9d60 RDI: ffff88012e2ad400
> > [ 7192.273235] RBP: ffff88012fab9dc8 R08: ffff88012fab8000 R09: 0000000000000001
> > [ 7192.273261] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88012e2ad400
> > [ 7192.273286] R13: ffff8801330a3c00 R14: ffff88012e2ad400 R15: ffff88012f8d9a70
> > [ 7192.273312] FS:  00007fbda55ca700(0000) GS:ffff880137c40000(0000) knlGS:0000000000000000
> > [ 7192.273345] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> > [ 7192.273367] CR2: 000000000000015c CR3: 000000013098f000 CR4: 00000000000007e0
> > [ 7192.273396] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 7192.273423] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > [ 7192.273452] Process bluetoothd (pid: 3169, threadinfo ffff88012fab8000, task ffff880131bb8000)
> > [ 7192.273482] Stack:
> > [ 7192.273494]  ffff8801330a3c00 ffff88012f8d9a70 ffff88012fab9e18 ffffffffa0119d1c
> > [ 7192.273521]  ffff88012f8d9800 ffff88012f8d9a70 ffff88012fab9df8 ffff88012f8d9800
> > [ 7192.273549]  ffff880131bb8000 0000000000000000 ffff8801330a3c00 0000000000000000
> > [ 7192.273575] Call Trace:
> > [ 7192.273590]  [<ffffffffa0119d1c>] bt_accept_dequeue+0xcc/0x190 [bluetooth]
> > [ 7192.273622]  [<ffffffffa013fadd>] l2cap_sock_accept+0x11d/0x220 [bluetooth]
> > [ 7192.273650]  [<ffffffff8109bb90>] ? try_to_wake_up+0x2b0/0x2b0
> > [ 7192.273675]  [<ffffffff814f698a>] sys_accept4+0xea/0x1f0
> > [ 7192.273700]  [<ffffffff8113b078>] ? vfs_write+0x138/0x180
> > [ 7192.273721]  [<ffffffff814f6a9b>] sys_accept+0xb/0x10
> > [ 7192.273743]  [<ffffffff815f67a6>] system_call_fastpath+0x1a/0x1f
> > [ 7192.273782] Code: 00 48 8d 83 70 02 00 00 48 8b 93 78 02 00 00 48 89 51 08 48 89 0a 48 89 83 70 02 00 00 48 89 83 78 02 00 00 48 8b 83 80 02 00 00 <66> 83 a8 5c 01 00 00 01 48 c7 83 80 02 00 00 00 00 00 00 f0 ff 
> > [ 7192.273873]  RSP <ffff88012fab9db8>
> > [ 7192.273887] CR2: 000000000000015c
> > [ 7192.283325] ---[ end trace 673b3cde39738f63 ]---
> 
> This looks like this patch ( http://thread.gmane.org/gmane.linux.bluez.kernel/26089 ) may help.
> It would be great if you could give it a try.

Vinicius, I think you added the wrong link here.

	Gustavo
