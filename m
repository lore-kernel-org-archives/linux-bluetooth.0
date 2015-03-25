Return-Path: <cyrus@holtmann.org>
From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
To: =?iso-8859-1?Q?J=FCrgen_Bausa?= <Juergen.Bausa@online.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Broadcom 43340 BT support
Date: Wed, 25 Mar 2015 02:10:21 +0000
Message-ID: <BLUPR03MB373ECFD040731619E7473B5F50B0@BLUPR03MB373.namprd03.prod.outlook.com>
References: <201503242237.07923.Juergen.Bausa@online.de>
In-Reply-To: <201503242237.07923.Juergen.Bausa@online.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jürgen Bausa <Juergen.Bausa@online.de>  Sent: Wednesday, March 25, 2015 5:37 AM
> To: linux-bluetooth@vger.kernel.org
> Subject: Broadcom 43340 BT support
> 
> I have a laptop (asus x205ta / intel-baytrail) with the broadcom 43340
> chipset. However, while wireless is working now, bluetooth is not. I am
> running debian jessie 32 bit with kernel 4.0rc4:
> 
> root@lina:/home/jba# hciconfig --all
> hci0:   Type: BR/EDR  Bus: SDIO
>         BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1
>         Link policy:
>         Link mode: SLAVE ACCEPT
> 
> root@lina:/home/jba# grep Bluetooth /var/log/messages
> Mar 24 21:30:44 lina kernel: [    6.521598] Bluetooth: Core ver 2.20
> Mar 24 21:30:44 lina kernel: [    6.521634] Bluetooth: HCI device and
> connection manager initialized
> Mar 24 21:30:44 lina kernel: [    6.521642] Bluetooth: HCI socket layer
> initialized
> Mar 24 21:30:44 lina kernel: [    6.521649] Bluetooth: L2CAP socket layer
> initialized
> Mar 24 21:30:44 lina kernel: [    6.521664] Bluetooth: SCO socket layer
> initialized
> Mar 24 21:30:44 lina kernel: [    6.557743] Bluetooth: Generic Bluetooth
> SDIO
> driver ver 0.1
> Mar 24 21:30:45 lina kernel: [   10.922564] Bluetooth: BNEP (Ethernet
> Emulation) ver 1.3
> Mar 24 21:30:45 lina kernel: [   10.922571] Bluetooth: BNEP filters:
> protocol
> multicast
> Mar 24 21:30:45 lina kernel: [   10.922579] Bluetooth: BNEP socket layer
> initialized
> 
> 
> I have no idea where to start in order to enable BT. is there a driver
> yet? Do I need a firmware file? Where to get it, where to put it?
> 
> Any hints welcome.
> 
> Regards,
> 
> Juergen

For BCM43340 BT, there need firmware, you can ask Broadcom support to generate one firmware for your real board.

Regards,
Andy
