Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
From: Marcel Holtmann <marcel@holtmann.org>
To: Sigrid Kronenberger <skronenberger@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040812203428.0bd25290@localhost>
References: <20040811231204.18574a27@localhost>
	 <1092262417.4564.259.camel@pegasus> <20040812194818.7d3d1ce6@localhost>
	 <1092334021.28711.169.camel@pegasus>  <20040812203428.0bd25290@localhost>
Content-Type: text/plain
Message-Id: <1092336801.28711.172.camel@pegasus>
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
Date: Thu, 12 Aug 2004 20:53:21 +0200

Hi Sigrid,

> Bluetooth: Core ver 2.3
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: BlueFRITZ! USB driver ver 1.1
> bfusb_probe: Firmware request failed
> bfusb: probe of 1-2:1.0 failed with error -5
> drivers/usb/core/usb.c: registered new driver bfusb
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000028
>  printing eip:
> c016b532
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c016b532>]    Not tainted VLI
> EFLAGS: 00010246
> EIP is at dnotify_flush+0x12/0x70
> eax: c16c3c80   ebx: df36b4a0   ecx: 00000001   edx: 00000000
> esi: df240d80   edi: df36b4a0   ebp: df1cff8c   esp: df1cff80
> ds: 007b   es: 007b   ss: 0068
> Process firmware.agent (pid: 451, threadinfo=df1ce000 task=df1d1980)
> Stack: df36b4a0 00000000 df240d80 df1cffa8 c01536a6 df36b4a0 df240d80
> df36b4a0 
>        00000000 00000009 df1cffbc c0153727 df36b4a0 df240d80 00000001
> df1ce000 
>        c010afb9 00000001 00000000 00000000 00000000 00000009 bffffa98
> 00000006 
> Call Trace:
>  [<c01536a6>] filp_close+0x36/0x70
>  [<c0153727>] sys_close+0x47/0x60
>  [<c010afb9>] sysenter_past_esp+0x52/0x79
> 
> Code: 12 25 ff ff ff 7f 09 c1 85 d2 75 f0 89 8b 28 01 00 00 5b 5d c3 8d
> 74 26 00 55 89 e5 57 56 53 8b 7d 08 8b 75 0c 8b 47 08 8b 50 08 <66> 8b
> 42 28 25 00 f0 00 00 3d 00 40 00 00 74 0e 8d 65 f4 5b 5e 

and this is the problem. The firmware loading generates an oops. You
must install a newer kernel (at least 2.6.8-rc3) before we can proceed.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
