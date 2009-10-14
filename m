Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20091013120018.GA29395@elf.ucw.cz>
References: <20091013120018.GA29395@elf.ucw.cz>
Date: Wed, 14 Oct 2009 14:55:06 +0800
Message-ID: <a8e1da0910132355g5e2b786p529b4b522c19e75a@mail.gmail.com>
Subject: Re: 2.6.32-rc3+: bluetooth needs lockdep anotation?
From: Dave Young <hidave.darkstar@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 13, 2009 at 8:00 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I just got this in my dmesg:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Pavel
>
>
> drivers/usb/core/inode.c: creating file '005'
> hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0002
> hub 1-0:1.0: hub_suspend
> usb usb1: bus auto-suspend
> ehci_hcd 0000:00:1d.7: suspend root hub
> uhci_hcd 0000:00:1d.3: reserve dev 5 ep81-INT, period 1, phase 0, 23 us
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.
> turning off the locking correctness validator.
> Pid: 1696, comm: udevd Not tainted 2.6.32-rc3-00192-gd33e6ec-dirty #78
> Call Trace:
> =C2=A0[<c079e978>] ? printk+0x18/0x1a
> =C2=A0[<c0256432>] __lock_acquire+0x492/0xac0
> =C2=A0[<c0256ac8>] lock_acquire+0x68/0x90
> =C2=A0[<c067e3cd>] ? skb_dequeue+0x1d/0x70
> =C2=A0[<c07a1a5b>] _spin_lock_irqsave+0x3b/0x50
> =C2=A0[<c067e3cd>] ? skb_dequeue+0x1d/0x70
> =C2=A0[<c067e3cd>] skb_dequeue+0x1d/0x70
> =C2=A0[<c067f084>] skb_queue_purge+0x14/0x30
> =C2=A0[<c071fe8f>] l2cap_recv_frame+0x5df/0x32c0
> =C2=A0[<c025617d>] ? __lock_acquire+0x1dd/0xac0
> =C2=A0[<c025617d>] ? __lock_acquire+0x1dd/0xac0
> =C2=A0[<c067e2d9>] ? skb_queue_tail+0x39/0x50
> =C2=A0[<c025617d>] ? __lock_acquire+0x1dd/0xac0
> =C2=A0[<c025617d>] ? __lock_acquire+0x1dd/0xac0
> =C2=A0[<c0722d02>] l2cap_recv_acldata+0x192/0x3d0
> =C2=A0[<c0713d50>] ? hci_rx_task+0x280/0x460
> =C2=A0[<c0722b70>] ? l2cap_recv_acldata+0x0/0x3d0
> =C2=A0[<c0713d83>] hci_rx_task+0x2b3/0x460
> =C2=A0[<c025617d>] ? __lock_acquire+0x1dd/0xac0
> =C2=A0[<c02362d0>] tasklet_action+0x50/0xb0
> =C2=A0[<c0236a35>] __do_softirq+0x85/0x110
> =C2=A0[<c0236aed>] do_softirq+0x2d/0x40
> =C2=A0[<c0236c55>] irq_exit+0x65/0x90
> =C2=A0[<c0204c1f>] do_IRQ+0x4f/0xc0
> =C2=A0[<c025617d>] ? __lock_acquire+0x1dd/0xac0
> =C2=A0[<c02034a9>] common_interrupt+0x29/0x30
> =C2=A0[<c07a183a>] ? _spin_unlock_irqrestore+0x2a/0x40
> =C2=A0[<c0223f00>] __wake_up+0x40/0x50
> =C2=A0[<c030167e>] journal_stop+0x27e/0x2b0
> =C2=A0[<c02f4577>] __ext3_journal_stop+0x27/0x50
> =C2=A0[<c02ecdd9>] ext3_delete_inode+0x99/0xf0
> =C2=A0[<c02ecd40>] ? ext3_delete_inode+0x0/0xf0
> =C2=A0[<c02accf2>] generic_delete_inode+0x72/0x110
> =C2=A0[<c02acddf>] generic_drop_inode+0x4f/0x80
> =C2=A0[<c02abcf7>] iput+0x47/0x50
> =C2=A0[<c02a926f>] dentry_iput+0x6f/0xf0
> =C2=A0[<c02a93a5>] d_kill+0x25/0x50
> =C2=A0[<c02a9abd>] dput+0x5d/0x110
> =C2=A0[<c02a4125>] do_rmdir+0xb5/0xe0
> =C2=A0[<c024a296>] ? up_read+0x16/0x30
> =C2=A0[<c021c19e>] ? do_page_fault+0x15e/0x250
> =C2=A0[<c02a41b0>] sys_rmdir+0x10/0x20
> =C2=A0[<c0202e50>] sysenter_do_call+0x12/0x31
> Registered led device: iwl-phy0::radio
> Registered led device: iwl-phy0::assoc
> Registered led device: iwl-phy0::RX
> Registered led device: iwl-phy0::TX
> wlan0: Selected IBSS BSSID 7a:ad:1e:84:b0:4c based on configured SSID
> Registered led device: iwl-phy0::radio
> Registered led device: iwl-phy0::assoc
> Registered led device: iwl-phy0::RX
> Registered led device: iwl-phy0::TX
> wlan0: Selected IBSS BSSID 7a:ad:1e:84:b0:4c based on configured SSID
>
>

Hi,

I have a pending patch for this:
http://marc.info/?l=3Dlinux-bluetooth&m=3D125504924206686&w=3D2

--=20
Regards
dave
