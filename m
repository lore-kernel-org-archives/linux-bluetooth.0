Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Broadcom 43340 BT support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <201503242237.07923.Juergen.Bausa@online.de>
Date: Tue, 24 Mar 2015 16:42:29 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <F2171E58-C919-4EEB-9305-6BC3858A7242@holtmann.org>
References: <201503242237.07923.Juergen.Bausa@online.de>
To: =?utf-8?Q?J=C3=BCrgen_Bausa?= <juergen.Bausa@online.de>,
	Arend Van Spriel <arend@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juergen,

> I have a laptop (asus x205ta / intel-baytrail) with the broadcom 43340 
> chipset. However, while wireless is working now, bluetooth is not. I am 
> running debian jessie 32 bit with kernel 4.0rc4:
> 
> root@lina:/home/jba# hciconfig --all
> hci0:   Type: BR/EDR  Bus: SDIO
>        BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
>        DOWN 
>        RX bytes:0 acl:0 sco:0 events:0 errors:0
>        TX bytes:0 acl:0 sco:0 commands:0 errors:0
>        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>        Packet type: DM1 DH1 HV1 
>        Link policy: 
>        Link mode: SLAVE ACCEPT 

can you figure out which driver is claiming that it is SDIO based? I assumed the Baytrail Bluetooth controllers are all attached via UARTs. I didn't know that Broadcom had Bluetooth on SDIO. The WiFi part yes, but the Bluetooth part should be on an UART.

Please also check with "rfkill list" if the device might be blocked.

Arend might know more, but you would need to dig into the list of SDIO devices. Sadly I think Linux does not yet have a lssdio tool. So maybe lshw can get us some info on what the kernel thinks about this device. Alternatively you need to dig you sysfs and look at ACPI. Maybe dmesg reveals something useful.

Regards

Marcel

