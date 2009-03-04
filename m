Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Mar 2009 23:59:02 -0800
From: Derek Chan <dwc+lkml@OCF.Berkeley.EDU>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: maxk@qualcomm.com, linux-bluetooth@vger.kernel.org
Subject: Re: another "blacklist" device for hci_usb
Message-ID: <20090304075902.GB3004@OCF.Berkeley.EDU>
References: <20090226091707.GG9042@OCF.Berkeley.EDU> <1235857191.6074.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <1235857191.6074.39.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 28, 2009 at 10:39:51PM +0100, Marcel Holtmann wrote:
>> I've got a USB bluetooth adapter that needed some of those handy module
>> params to get SCO working.
>>
>> Bus 001 Device 004: ID 0a5c:2121 Broadcom Corp. BCM2210 Bluetooth

> send "hciconfig -a" before and after your patch. You have to prove to me
> that you really need this patch.

Before: (2.6.26-1-686, no options for hci_usb)
hci0:   Type: USB
        BD Address: 00:50:B6:80:76:1A ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN 
        RX bytes:939 acl:0 sco:0 events:23 errors:0
        TX bytes:342 acl:0 sco:0 commands:23 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'server-0'
        Class: 0x080100
        Service Classes: Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x4118 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
        Manufacturer: Broadcom Corporation (15)

After: (2.6.26-1-686, options hci_usb reset=1 force_scofix=1)
hci0:   Type: USB
        BD Address: 00:50:B6:80:76:1A ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN 
        RX bytes:1511 acl:0 sco:0 events:31 errors:0
        TX bytes:366 acl:0 sco:0 commands:31 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'server-0'
        Class: 0x080100
        Service Classes: Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x4118 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
        Manufacturer: Broadcom Corporation (15)

> Also please post a patch against btusb.c since hci_usb.c has been
> removed.

I didn't actually patch hci_usb.  Since the options were there, it was
easier to use them.  As requested, I've gone back through gitweb to pull
this file to patch.  See attached.

 - Derek


-- 
Be the change you want to see in the world
        -- Mahatma Gandhi

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="btusb.patch"

--- btusb.c.orig	2009-03-03 23:48:07.000000000 -0800
+++ btusb.c	2009-03-03 23:49:09.000000000 -0800
@@ -101,6 +101,9 @@
 	{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },
 
+	/* Broadcom BCM2210 */
+	{ USB_DEVICE(0x0a5c, 0x2121), .driver_info = BTUSB_RESET | BTUSB_WRONG_SCO_MTU },
+
 	/* Broadcom BCM2046 */
 	{ USB_DEVICE(0x0a5c, 0x2146), .driver_info = BTUSB_RESET },
 	{ USB_DEVICE(0x0a5c, 0x2151), .driver_info = BTUSB_RESET },

--3V7upXqbjpZ4EhLz--
