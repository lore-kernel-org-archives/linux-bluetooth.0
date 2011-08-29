Return-Path: <cyrus@holtmann.org>
Subject: Re: FW: [PATCH] Bluetooth-next: Add incremental indexing in sysfs
 HCI connection name.
From: etsang <Edwin.Tsang@ca.flextronics.com>
To: "Keren, Doron" <doronkeren@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,  Marcel Holtmann <marcel@holtmann.org>, "Ilia, Kolominsky" <iliak@ti.com>, "Hadar, Amir" <a-hadar@ti.com>
In-Reply-To: <13872098A06B02418CF379A158C0F1460162EB4DEB@dnce02.ent.ti.com>
References: <13872098A06B02418CF379A158C0F1460162EB4DEB@dnce02.ent.ti.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Aug 2011 09:23:42 -0400
Message-ID: <1314624222.2116.6.camel@etsang-laptop>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keren/Marcel,
Not sure if I am tracing down the same bug. It is related to kernel
panic when HID reconnect while it was not disconnect before. (may be
due to supervision timeout not set). It is easily reproduceable, Just
turn off the BT mouse, turn it on again.
---
kobject_add_internal failed for hci0:1 with -EEXIST, don't try to
register things with the same name in the same directory. 

add_conn: Failed to register connection device 
Unable to handle kernel NULL pointer dereference at virtual address 00000021=
 
pgd =3D eeb00000 
[00000021] *pgd=3Daead6031, *pte=3D00000000, *ppte=3D00000000 
Internal error: Oops: 17 [#1] PREEMPT SMP 
last sysfs file: /sys/devices/platform/omap2_mcspi.1/spi1.1/enabled 
Modules linked in: hsi_omap caif_hsi gps_drv(C) fm_drv(C) btwilink 
-----
Backtrace: 
[<c013f550>] (sysfs_create_dir+0x0/0xc8) from [<c01f1818>] (kobject_add_inte=
rnal+0xd8/0x1b4) 
 r6:ecfdf2c0 r5:efe1ac60 r4:efe1ac60 
[<c01f1740>] (kobject_add_internal+0x0/0x1b4) from [<c01f19f0>] (kobject_add=
_varg+0x40/0x50) 
 r8:eeb06ea4 r7:eeb06eb8 r6:00000000 r5:ecfdf2c0 r4:efe1ac60 
r3:eead5c94 
[<c01f19b0>] (kobject_add_varg+0x0/0x50) from [<c01f1a90>] (kobject_add+0x50=
/0x5c) 
 r6:00000000 r5:efe1ac60 r4:efe1ac58 r3:eead5c94 
[<c01f1a40>] (kobject_add+0x0/0x5c) from [<c027c2e4>] (device_add+0xa8/0x4b4=
) 
 r3:00000000 r2:00000000 
[<c027c23c>] (device_add+0x0/0x4b4) from [<c034b794>] (hid_add_device+0x144/=
0x188) 
[<c034b650>] (hid_add_device+0x0/0x188) from [<c04acc18>] (hidp_add_connecti=
on+0x2d8/0x5e8) 
 r6:eead5d54 r5:efe1a000 r4:eeb06e40 
[<c04ac940>] (hidp_add_connection+0x0/0x5e8) from [<c04ad908>] (hidp_sock_io=
ctl+0x11c/0x330) 
[<c04ad7ec>] (hidp_sock_ioctl+0x0/0x330) from [<c03b4c44>] (sock_ioctl+0x204=
/0x254) 
 r7:00000013 r6:400448c8 r5:000159a0 r4:400448c8 
[<c03b4a40>] (sock_ioctl+0x0/0x254) from [<c00fb930>] (vfs_ioctl+0x34/0xb4)=
 
 r6:400448c8 r5:000159a0 r4:e7de5460 r3:c03b4a40 
[<c00fb8fc>] (vfs_ioctl+0x0/0xb4) from [<c00fbfbc>] (do_vfs_ioctl+0x514/0x55=
c) 
 r6:400448c8 r5:e7de5460 r4:000159a0 r3:ed861360 
[<c00fbaa8>] (do_vfs_ioctl+0x0/0x55c) from [<c00fc044>] (sys_ioctl+0x40/0x64=
) 
[<c00fc004>] (sys_ioctl+0x0/0x64) from [<c0045200>] (ret_fast_syscall+0x0/0x=
30) 
 r7:00000036 r6:00000080 r5:000159a0 r4:00000013 
Code: e594300c e3530000 059f6098 15936018 (e5d65021) 
----- 

Edwin


On Sun, 2011-08-28 at 17:16 +0200, Keren, Doron wrote:
> Hi Marcel,
> 
> Please read further explanation in the lines below...
> 
> Thanks,
> Doron
> 
> > >> -----Original Message-----
> > >> From: David Herrmann [mailto:dh.herrmann@googlemail.com]
> > >> Sent: Thursday, August 18, 2011 3:38 PM
> > >> To: Keren, Doron
> > >> Subject: Re: [PATCH] Bluetooth-next: Add incremental indexing in sysf=
s
> > HCI
> > >> connection name.
> > >>
> > >> Hi Doron
> > >>
> > >> On Thu, Aug 18, 2011 at 2:25 PM, Keren, Doron <doronkeren@ti.com>
> > wrote:
> > >> > Hi David,
> > >> >
> > >> > Please write how did you reproduce the scenario?
> > >> > I'm repeating the scenario by connecting to HID keyboard (Logitech)=
.
> > >> > After the connection I'm pulling out the HID device batteries and
> > >> > Return the batteries fast before any Bluetooth timeout. Even with
> > this
> > >>
> > >> I use a bluetooth HID device, shut it down and reconnect. The bug
> > >> triggers quite randomly so I can't tell when it happens. It doesn't
> > >> matter what device I use.
> > >>
> > >> > Action it takes several times (~up to 10) to cause the kernel panic=
.
> > >> > My fix solves this kernel panic.
> > >>
> > >> I still get kernel panics. I don't get the sysfs-oops anymore, but
> > >> hidp_add_connection() still fails. As it happens quite randomly, I
> > >> can't reproduce it.
> > >>
> > >> > Regards,
> > >> > Doron
> > >>
> > >> Cheers
> > >> David
> > >
> > > I got the kernel panic before the fix, when the
> > "hci_conn_complete_evt()"
> > > comes and call "hci_conn_add_sysfs()", before the "hidp_session()"
> > finished
> > > and call "hci_conn_del_sysfs()".
> > > The HID device reconnects when the HID session waits for the 2 L2CAP
> > > channels delete event.
> > > The base-band is getting the reconnect attempt and because it is the
> > same
> > > device that is still connected, it sends immediately DISCONNECT and th=
en
> > > > CONNECT events with the same handle number.
> > 
> > > Why didn't you write that in your first email? ;) I now understand the
> > > issue. New connections are added in atomic-context, but the removal of
> > > old connections may sleep, so new connections may be initiated even
> > > though the removal of the old is still in progress. Locking doesn't
> > > apply here so a counter is the only way.
> > 
> > > My bug may be related to something else. I will try to investigate
> > > further but currently don't have time.
> > 
> > > BR,
> > > Doron
> > >
> > 
> > > I recommend writing your explanation to the list again and CC Marcel.
> > 
> > > Thanks
> > > David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


 =0A=
Legal Disclaimer:=0A=
The information contained in this message may be privileged and confidential=
. It is intended to be read only by the individual or entity to whom it is a=
ddressed or by their designee. If the reader of this message is not the inte=
nded recipient, you are on notice that any distribution of this message, in=
 any form, is strictly prohibited. If you have received this message in erro=
r, please immediately notify the sender and delete or destroy any copy of th=
is message=0A=
