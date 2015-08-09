Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: btusb regression / 0a12:0001 CSR
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55C6F858.5080808@web.de>
Date: Sun, 9 Aug 2015 10:44:55 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BC6C2463-83DF-4825-95FC-A55A5B825B0A@holtmann.org>
References: <55C6F858.5080808@web.de>
To: Norbert Holze <norbert.holze@web.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Norbert,

> My bluetooth usb-stick worked fine with kernel up to 3.19. With 4.x
> there is no hci device found.
> 
> lsusb
> Bus 004 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle (HCI mode)
> 
> hcitool dev
> Devices:
> 
> sudo hciconfig
> hci0: Type: BR/EDR Bus: USB
> BD Address: 00:15:83:15:A3:0B ACL MTU: 672:4 SCO MTU: 48:1
> DOWN
> RX bytes:890 acl:0 sco:0 events:30 errors:0
> TX bytes:126 acl:0 sco:0 commands:30 errors:0
> 
> sudo hciconfig hci0 up
> Can't init device hci0: Operation not supported (95)
> 
> rfkill list
> 0: hci0: Bluetooth
> Soft blocked: no
> Hard blocked: no
> 1: phy0: Wireless LAN
> Soft blocked: no
> Hard blocked: no
> 
> Is this a regression. Or does it work in different way with 4.x?

your controller has this issue:

< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Unsupported Feature or Parameter Value (0x11)
        Max num keys: 0
        Num keys: 0

When this command fails for whatever reason, the power on procedure fails. It is indicated that this command is supported, but it seems that this actually not fully true.

Please report the section from /sys/kernel/debug/usb/devices that corresponds to your device.

Regards

Marcel

