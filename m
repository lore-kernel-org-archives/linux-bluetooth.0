Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth 2.1 USB adapter!
From: Marcel Holtmann <marcel@holtmann.org>
To: Ville Tervo <vtervo@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <d7c444d50810010157p4c67854ejf6317dbc60ac578f@mail.gmail.com>
References: <294606.8239.qm@web52903.mail.re2.yahoo.com>
	 <1222381386.6442.8.camel@californication>
	 <d7c444d50810010157p4c67854ejf6317dbc60ac578f@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 01 Oct 2008 11:06:21 +0200
Message-Id: <1222851981.11272.4.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

> I have A-link dongle with following records. This seems to require the
> same quirk. Tested with v2.6.26-mh4 and btusb module.
> 
> hci0:   Type: USB
>         BD Address: 00:02:72:16:15:F9 ACL MTU: 1021:8 SCO MTU: 64:1
>         UP RUNNING 
>         RX bytes:5385 acl:0 sco:0 events:70 errors:0
>         TX bytes:698 acl:0 sco:0 commands:48 errors:0
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'null-0'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 2.1 (0x4) HCI Rev: 0x5111 LMP Ver: 2.1 (0x4) LMP
> Subver: 0x420e
>         Manufacturer: Broadcom Corporation (15)
> 
> hci0:   Type: USB
>         BD Address: 00:02:72:16:15:F9 ACL MTU: 1021:8 SCO MTU: 64:1
>         Firmware 17.66 / 14

can you give me the simple lsusb and /proc/bus/usb/devices for this one
please.

Regards

Marcel


