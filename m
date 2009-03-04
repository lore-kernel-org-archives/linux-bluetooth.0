Return-Path: <cyrus@holtmann.org>
Subject: Re: another "blacklist" device for hci_usb
From: Marcel Holtmann <marcel@holtmann.org>
To: Derek Chan <dwc+lkml@OCF.Berkeley.EDU>
Cc: maxk@qualcomm.com, linux-bluetooth@vger.kernel.org
In-Reply-To: <20090304075902.GB3004@OCF.Berkeley.EDU>
References: <20090226091707.GG9042@OCF.Berkeley.EDU>
	 <1235857191.6074.39.camel@localhost.localdomain>
	 <20090304075902.GB3004@OCF.Berkeley.EDU>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 22:00:55 +0100
Message-Id: <1236200455.6670.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Derek,

> >> I've got a USB bluetooth adapter that needed some of those handy module
> >> params to get SCO working.
> >>
> >> Bus 001 Device 004: ID 0a5c:2121 Broadcom Corp. BCM2210 Bluetooth
> 
> > send "hciconfig -a" before and after your patch. You have to prove to me
> > that you really need this patch.
> 
> Before: (2.6.26-1-686, no options for hci_usb)
> hci0:   Type: USB
>         BD Address: 00:50:B6:80:76:1A ACL MTU: 1017:8 SCO MTU: 64:0
>         UP RUNNING PSCAN 
>         RX bytes:939 acl:0 sco:0 events:23 errors:0
>         TX bytes:342 acl:0 sco:0 commands:23 errors:0
>         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'server-0'
>         Class: 0x080100
>         Service Classes: Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 2.0 (0x3) HCI Rev: 0x4118 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
>         Manufacturer: Broadcom Corporation (15)
> 
> After: (2.6.26-1-686, options hci_usb reset=1 force_scofix=1)
> hci0:   Type: USB
>         BD Address: 00:50:B6:80:76:1A ACL MTU: 1017:8 SCO MTU: 64:8
>         UP RUNNING PSCAN 
>         RX bytes:1511 acl:0 sco:0 events:31 errors:0
>         TX bytes:366 acl:0 sco:0 commands:31 errors:0
>         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'server-0'
>         Class: 0x080100
>         Service Classes: Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 2.0 (0x3) HCI Rev: 0x4118 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
>         Manufacturer: Broadcom Corporation (15)
> 
> > Also please post a patch against btusb.c since hci_usb.c has been
> > removed.
> 
> I didn't actually patch hci_usb.  Since the options were there, it was
> easier to use them.  As requested, I've gone back through gitweb to pull
> this file to patch.  See attached.

please post the content of /proc/bus/usb/devices for that dongle and
also please send patches against bluetooth-next-2.6 or net-next-2.6
trees.

Regards

Marcel


