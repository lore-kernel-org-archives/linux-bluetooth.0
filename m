Return-Path: <cyrus@holtmann.org>
Subject: Re: Getting/setting Inquiry trasmit power level unsolved
From: Marcel Holtmann <marcel@holtmann.org>
To: Natale Vinto <ebballon@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <c6e9632c0912140824m5650d242w8296dd756943993f@mail.gmail.com>
References: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>
	 <1258286232.3299.27.camel@violet>
	 <c6e9632c0911170853g5ef4061cr75c42c71a1a87b7d@mail.gmail.com>
	 <1258491418.2003.37.camel@violet>
	 <c6e9632c0911171318l1b60fa85h55b3e6083777d516@mail.gmail.com>
	 <c6e9632c0911180959p3e56668aqc298a673baea7350@mail.gmail.com>
	 <1258568114.2003.128.camel@violet>
	 <c6e9632c0911271011p1268ee8ek16e389fc779e0d77@mail.gmail.com>
	 <c6e9632c0912140824m5650d242w8296dd756943993f@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Dec 2009 09:55:14 -0800
Message-Id: <1260813314.4041.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natale,

> I finally got the Belkin F8T016, linked from CSR website (
> http://www.csr.com/applications/qual-mod.php?catID=14 ) as qualified
> end product with CSR's BlueCore chip.
> I read this spec:
> Bluetooth v2.1 + EDR
> Class 2
> 
> The output is always the same:
> 
> # hciconfig hci0
> hci0:   Type: USB
>         BD Address: 00:0A:3A:xx:xx:xx ACL MTU: 1021:8 SCO MTU: 64:1
>         UP RUNNING PSCAN
>         RX bytes:1129 acl:0 sco:0 events:42 errors:0
>         TX bytes:1616 acl:0 sco:0 commands:42 errors:0
> 
> # lsusb
> Bus 002 Device 006: ID 050d:016a Belkin Components
> 
> # hciconfig hci0 commands | grep "Inquiry Transmit Power Level"
>         'Read Inquiry Transmit Power Level'
>         'Write Inquiry Transmit Power Level'
> 
> (started hcidump here)
> 
> # hciconfig hci0 inqtpl
> hci0:   Type: USB
>         BD Address: 00:0A:3A:xx:xx:xx ACL MTU: 1021:8 SCO MTU: 64:1
>         Inquiry transmit power level: 0
> 
> # hciconfig hci0 inqtpl 1
> 
> # hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.42
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Read Inquiry Response Transmit Power Level (0x03|0x0058) plen 0
> > HCI Event: Command Complete (0x0e) plen 5
>     Read Inquiry Response Transmit Power Level (0x03|0x0058) ncmd 1
>     status 0x00 level 0
> < HCI Command: Write Inquiry Response Transmit Power Level (0x03|0x0059) plen 1
>     level 1
> > HCI Event: Command Complete (0x0e) plen 4
>     Write Inquiry Response Transmit Power Level (0x03|0x0059) ncmd 1
>     status 0x00
> 
> but inquiry transmit level remains 0
> # hciconfig hci0 inqtpl
> hci0:   Type: USB
>         BD Address: 00:0A:3A:xx:xx:xx ACL MTU: 1021:8 SCO MTU: 64:1
>         Inquiry transmit power level: 0
> 
> This try made on Ubuntu 9.10 2.6.31 (kernel.org) and 2.6.31-16-generic
> (Ubuntu kernel)
> # dpkg -l bluez
> ii  bluez                   4.51-0ubuntu2           Bluetooth tools and daemons
> 
> So I wonder what is the problem...have I to flash in someway some firmware?

you would have to talk to CSR here. I have no idea what their firmware
is doing.

Regards

Marcel


