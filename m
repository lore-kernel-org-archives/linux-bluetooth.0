Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hid2hci
From: Marcel Holtmann <marcel@holtmann.org>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040409153508.GA2123@aragorn.home.lxtec.de>
References: <20040409153508.GA2123@aragorn.home.lxtec.de>
Content-Type: text/plain
Message-Id: <1081531882.21596.23.camel@pegasus>
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
Date: Fri, 09 Apr 2004 19:31:22 +0200

Hi Elimar,

> Linux version 2.6.5--mh2-aragorn (root@aragorn) \
> (gcc-Version 3.3.3 (Debian 20040401)) #1 Fri Apr 9 14:53:38 CEST 2004
> 
> Running hid2hci out of bluez-utils2 produces following oops:
> 
> aragorn:/source/bluez/cvs/utils2/hid# ./hid2hci
> Switching device 05ac:1000 to HCI mode was successful
> usb 1-1: USB disconnect, address 2
> drivers/usb/input/hid-core.c: can't resubmit intr, 0001:01:1a.0-1/input0, status -19
> drivers/usb/input/hid-core.c: can't resubmit intr, 0001:01:1a.0-1/input1, status -19
> usb 1-1: new full speed USB device using address 3
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: F24786B8 LR: F24786C0 SP: EF3E7D00 REGS: ef3e7c50 TRAP: 0301    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 01DAD002, DSISR: 40000000
> TASK = ef4c9980[133] 'khubd' Last syscall: -1
> GPR00: 00000022 EF3E7D00 EF4C9980 EEE8E800 EF4E42E0 00000000 00000001 00000000
> GPR08: F2476F40 01DAD000 EEE8E800 28028224 88028222
> Call trace:
>  [f2478938] usb_set_interface+0x94/0x164 [usbcore]
>  [f243dadc] hci_usb_probe+0x21c/0x48c [hci_usb]
>  [f2472090] usb_probe_interface+0x80/0x98 [usbcore]
>  [c0161dcc] bus_match+0x50/0x8c
>  [c0161e60] device_attach+0x58/0xbc
>  [c01620e0] bus_add_device+0x7c/0xd8
>  [c0160980] device_add+0xb0/0x184
>  [f2478d24] usb_set_configuration+0x20c/0x25c [usbcore]
>  [f24733cc] usb_new_device+0x2bc/0x3d4 [usbcore]
>  [f2474e2c] hub_port_connect_change+0x1a0/0x298 [usbcore]
>  [f24751f8] hub_events+0x2d4/0x354 [usbcore]
>  [f24752b4] hub_thread+0x3c/0xf4 [usbcore]
>  [c000ad4c] kernel_thread+0x44/0x60

looks like another USB problem. Maybe the USB guys already have a fix
for it. Ask them.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
