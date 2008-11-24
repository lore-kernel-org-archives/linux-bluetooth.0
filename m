Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0FA78263-FBE1-4B03-8849-C0E05380E827@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ron Murray <rjmx@rjmx.net>
In-Reply-To: <4924548A.5020909@rjmx.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: bcm203x bluetooth dongle still does not work in kernel 2.6.27.6
Date: Mon, 24 Nov 2008 03:50:06 +0100
References: <4924548A.5020909@rjmx.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

>   I have a couple of boxes that I'm using with (admittedly fairly old)
> Tecon bluetooth devices using the BCM-2033 chipset, and I've been  
> having
> trouble with them since you switched to the workqueue. For quite some
> time I applied the patch referred to in the message below, and that
> worked, but it wouldn't apply on kernel 2.6.27. Rather than fix it, I
> decided to try the kernel driver as-is, with patchy results. Sometimes
> it works, sometimes it doesn't. The symptoms are the same as below: my
> syslog says
>
> Nov 19 12:38:45 rjmx kernel: firmware: requesting BCM2033-MD.hex
> Nov 19 12:38:45 rjmx kernel: firmware: requesting BCM2033-FW.bin
>
>   but nothing seems to happen: an 'lsusb' still gives
>
> Bus 001 Device 004: ID 0a5c:2033 Broadcom Corp. BCM2033 Bluetooth
>
>   ... which is the wrong ID for a device that's had its firmware
> properly loaded. The firmware files themselves seem to be readable,  
> and
> in fact an 'ls -lut' gives me a "last access time" similar to the  
> actual
> time I tried plugging in the device.

I don't have the Tecon device and my BCM2033 is at home. So I can't  
tell you what's going on here. Play with the drivers source code. It  
is pretty simple.

Regards

Marcel

