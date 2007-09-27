Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 27 Sep 2007 15:48:04 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Pierre-Yves Paulus <py@idlum.be>
Message-ID: <20070927154804.17487b20@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <46FBA4A7.70200@idlum.be>
References: <46F92586.5070402@idlum.be> <200709271429.09910.rjw@sisk.pl>
	<46FBA4A7.70200@idlum.be>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, BlueZ@sc8-sf-spam2.sourceforge.net,
        development <bluez-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] Warnings and Bug on 2.6.23-rc6 closing rfcomm
 links (device_move() API ?)
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Thu, 27 Sep 2007 14:40:07 +0200,
Pierre-Yves Paulus <py@idlum.be> wrote:

> Hello,
> 
> >> Yet another report, once again while putting rfcomm system under load. 
> >> Several USB adapters, several links.
> > 
> > Is this a regression or does it happen with 2.6.22 too?
> 
> I've not tested with 2.6.22, but have done it a few days ago with 
> 2.6.21-2-486 (stock debian package), and got the 2 Oops below. Maybe 
> that's a different problem, or maybe not?
> 
> 
> kobject_add failed for rfcomm1 with -EEXIST, don't try to register 
> things with the same name in the same directory.

There's something wrong with rfcomm trying to create objects with
duplicate names...

>   [<c01babdc>] kobject_shadow_add+0x13b/0x16d
>   [<c01bad94>] kobject_set_name+0x2b/0x92
>   [<c0217128>] device_add+0xab/0x5fb
>   [<c01ba8ad>] kobject_get+0xf/0x13
>   [<c0217b84>] device_create+0x77/0x97
>   [<c0201632>] tty_register_device+0xb5/0xbd
>   [<c01bd839>] vsnprintf+0x44f/0x48b
>   [<d02df627>] rfcomm_dev_ioctl+0x212/0x48f [rfcomm]
>   [<d00495b3>] dl_done_list+0x117/0x1a6 [ohci_hcd]
>   [<d02de21c>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
>   [<c0235739>] sock_ioctl+0x19f/0x1be
>   [<c02358ab>] sys_getsockopt+0x60/0x9c
>   [<c023559a>] sock_ioctl+0x0/0x1be
>   [<c015dfc1>] do_ioctl+0x19/0x4c
>   [<c015e1f3>] vfs_ioctl+0x1ff/0x216
>   [<c015e256>] sys_ioctl+0x4c/0x66
>   [<c0103b90>] syscall_call+0x7/0xb
>   =======================
> BUG: unable to handle kernel NULL pointer dereference at virtual address 
> 0000006f
>   printing eip:
> c01bb361
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in: rfcomm l2cap button ac battery ipv6 dm_snapshot 
> dm_mirror dm_mod softdog loop parport_pc parport snd_cs5535audio hci_usb 
> bluetooth floppy snd_ac97_codec rtc ac97_bus pcspkr psmouse serio_raw 
> snd_pcm snd_timer snd soundcore snd_page_alloc geode_rng geode_aes 
> blkcipher tsdev evdev usbhid hid reiserfs ide_disk generic ohci_hcd 
> usbcore amd74xx ide_core ata_generic 8139cp 8139too mii sata_via libata 
> scsi_mod thermal processor fan
> CPU:    0
> EIP:    0060:[<c01bb361>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.21-2-486 #1)
> EIP is at kref_get+0x6/0x3d
> eax: 0000006f   ebx: 0000006f   ecx: c4b94ad4   edx: 00000000
> esi: c5c5cc00   edi: cef74c00   ebp: ffffffea   esp: c5783e50
> ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
> Process hcid (pid: 13094, ti=c5782000 task=ca09e5a0 task.ti=c5782000)
> Stack: c4b94ac8 00000000 00000286 c7c7eca0 00000057 c01ba8ad c5c5ccb8 
> c0216bb4
>         c0216bcd 00000000 c4b94aa0 c5c5cc00 cef74c00 cef74cf8 d02dfa60 
> 00000009
>         00000000 cef74cf8 00000000 ca09e5a0 c01157a6 00100100 00200200 
> 00000100
> Call Trace:
>   [<c01ba8ad>] kobject_get+0xf/0x13
>   [<c0216bb4>] get_device+0xe/0x14
>   [<c0216bcd>] device_move+0x13/0xe2
>   [<d02dfa60>] rfcomm_tty_open+0x17d/0x189 [rfcomm]
>   [<c01157a6>] default_wake_function+0x0/0xc
>   [<c02034c9>] tty_open+0x167/0x29b
>   [<c0156b8e>] chrdev_open+0xc5/0xea
>   [<c015d345>] open_namei+0x257/0x543
>   [<c0156ac9>] chrdev_open+0x0/0xea
>   [<c0153801>] __dentry_open+0xb7/0x16d
>   [<c0153931>] nameidata_to_filp+0x24/0x33
>   [<c0153977>] do_filp_open+0x37/0x3e
>   [<c01539c4>] do_sys_open+0x46/0xcd
>   [<c0153a84>] sys_open+0x1c/0x1e
>   [<c0103b90>] syscall_call+0x7/0xb
>   =======================
> Code: cc d3 f5 ff e8 58 a3 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 
> ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 38 
> 00 75 29 c7 44 24 0c b9 09 2a c0 c7 44 24 08 20 00 00 00
> EIP: [<c01bb361>] kref_get+0x6/0x3d SS:ESP 0068:c5783e50

...which may very well lead to this bug if it ignored the error from
the failing device_create() above. But I'm not familiar with the rfcomm
code, sorry.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
