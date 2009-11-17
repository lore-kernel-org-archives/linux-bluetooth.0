Return-Path: <cyrus@holtmann.org>
Subject: Re: Getting/setting Inquiry trasmit power level unsolved
From: Marcel Holtmann <marcel@holtmann.org>
To: Natale Vinto <ebballon@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <c6e9632c0911170853g5ef4061cr75c42c71a1a87b7d@mail.gmail.com>
References: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>
	 <1258286232.3299.27.camel@violet>
	 <c6e9632c0911170853g5ef4061cr75c42c71a1a87b7d@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Nov 2009 21:56:58 +0100
Message-ID: <1258491418.2003.37.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natale,

so first of all, stop TOP posting. Otherwise I just going to ignore your
emails. This is an open source mailing that follows proper standards and
etiquette,
 
> I have a 2.1+EDR bluetooth usb dongle from Cubic 3c Corp.
> 
> Here there is a picture of it:
> http://www.ec21.com/global/common/imageView.jsp?title=Sell%20bluetooth%20mini%20dongle,%20100m&img=http://image.ec21.com/image/skye112/OF0007943009_1/Sell_bluetooth_mini_dongle_100m.jpg
> 
> The command  hciconfig hci0 gives this result on 2.6.31 Kubuntu Karmic:
> hci0:   Type: USB
>         BD Address: 00:15:83:0C:1F:55 ACL MTU: 310:10 SCO MTU: 64:8
>         UP RUNNING PSCAN
>         RX bytes:999 acl:0 sco:0 events:30 errors:0
>         TX bytes:367 acl:0 sco:0 commands:28 errors:0
> 
> Here you are some useful information about it:
> 
> lsusb:
> Bus 002 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> Bluetooth Dongle (HCI mode)
> 
> lsmod | grep bt:
> btusb                  11568  2
> bluetooth              53828  9 rfcomm,sco,bnep,l2cap,btusb
> usbcore               146288  4 btusb,ehci_hcd,uhci_hcd
> 
> so I get always:
> hciconfig hci0 inqtpl
> Can't read inquiry transmit power level on hci0: Input/output error (5)
> 
> either on Ubuntu/Debian Bluez 4.x/3.x
> 
> so isn't it a CSR based chip? I thought they would work fine with TPL, isn't it?

# hciconfig hci0 inqtpl
hci0:	Type: USB
	BD Address: 00:19:DB:xx:xx:xx ACL MTU: 310:10 SCO MTU: 64:8
	Inquiry transmit power level: 4

# hcidump -X -V
< HCI Command: Read Inquiry Response Transmit Power Level (0x03|0x0058) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Inquiry Response Transmit Power Level (0x03|0x0058) ncmd 1
    status 0x00 level 4

Looks all good to me and works perfectly fine with the CSR dongle, I
tested this with.

Regards

Marcel


