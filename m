Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bcm203x module causes kernel panic on boot
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex Holland <ah160@student.cs.york.ac.uk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402141501.30698.ah160@student.cs.york.ac.uk>
References: <402E2E29.7040207@yahoo.com> <1076769794.14758.2.camel@pegasus>
	 <200402141501.30698.ah160@student.cs.york.ac.uk>
Content-Type: text/plain
Message-Id: <1076771748.14758.9.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 14 Feb 2004 16:15:48 +0100

Hi Alex,

> I use a Belkin F8T001, and bluez-bluefw has always been a bit tempremental 
> with me, so I jumped at the chance of using the bcm203x module in the kernel. 
> Looking through the mailing list, I copied BCM2033-FW.bin and BCM2033-MD.hex 
> to /usr/lib/hotplug/firmware/, unmerged bluefw gave things a try from a power 
> off.
> 
> Below, I've pasted sections of the subsequent boot sequence. If the PC's 
> turned on from power off (so the adaptor has no firmware already loaded, my 
> PC will kernel panic, but continue booting and work okay, with the bluetooth 
> subsystem working perfectly. Subsequent soft-reboots load Linux without any 
> kernel panics, with bluetooth still working perfectly.
> 
> So, is this panic purely cosmetic, or is something fundamentally bad going on? 
> In addition, could I suggest some documentation on the kernel help page for 
> the bcm203x module to say where the firmware should be acquired/kept?
> 
> Bluetooth: Core ver 2.3
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: HCI USB driver ver 2.4
> modprobe: FATAL: Module hci_usb already in kernel.
> Started device management daemon v1.3.25 for /dev
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> c018253a
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c018253a>]    Not tainted
> EFLAGS: 00010246
> EIP is at sysfs_release+0x2a/0x90
> eax: cf4f9a00   ebx: 00000000   ecx: cf9c8e40   edx: cf4f9ac8
> esi: c136cac0   edi: cffe4f00   ebp: cf4da0c0   esp: cf5e9f68
> ds: 007b   es: 007b   ss: 0068
> Process default.hotplug (pid: 302, threadinfo=cf5e8000 task=c130c6e0)
> Stack: cf4f9ac8 cf9c8e40 00000000 c014fb40 cf4da0c0 cf9c8e40 cf939180 cf9c8e40
>        00000000 cf7e4c80 cf5e8000 c014e199 cf9c8e40 cf7e4c80 cf7e4c80 cf9c8e40
>        00000001 c014e231 cf9c8e40 cf7e4c80 00000001 080d7f40 c0108f47 00000001
> Call Trace:
>  [<c014fb40>] __fput+0x100/0x120
>  [<c014e199>] filp_close+0x59/0x90
>  [<c014e231>] sys_close+0x61/0xa0
>  [<c0108f47>] syscall_call+0x7/0xb
> 
> Code: 8b 43 04 85 c0 74 1f bb 00 e0 ff ff 21 e3 ff 43 14 ff 88 c0

this is a problem with the early run of hotplug scripts and not a
problem of the Bluetooth subsystem. Run the oops through ksymoops and
post it to the LKML, because it belongs there.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
