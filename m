Return-Path: <cyrus@holtmann.org>
Subject: Re: New Broadcom chip in W510
From: Marcel Holtmann <marcel@holtmann.org>
To: Lu Ran <hephooey@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <201009190926.51131.hephooey@gmail.com>
References: <201009190926.51131.hephooey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 11:30:48 +0200
Message-ID: <1286271048.17473.66.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lu,

> I am having trouble to make my headset work in my new W510, it works fine in an 
> T61, with has almost identical software and setup with the new W510. The only 
> difference is I am now using a pure 64 bit system, while the old T61 is a 32 
> bit one, and the bluetooth chip is different. the id of the chip in T61 is 
> 0A5C:2110, while W510 has a chip from Broadcom with id 0A5C:217F. I noticed 
> there is a SCO fix for 0A5C:2110 in btusb.c. I tried to copy the line and 
> change the id to 0A5C:217F, but nothing changes. The headset can pair with the 
> laptop with no problem, but there seems to be no data transmition. And I get a 
> lot error messages in dmesg output like this:
> 
> btusb_submit_isoc_urb: hci0 urb ffff880060136e00 submission failed (28)
> 
> and
> 
> btusb_send_frame: hci0 urb ffff8801320e1a00 submission failed
> 
> the output of "hciconfig hci0 version" is
> 
> hci0:   Type: BR/EDR  Bus: USB
>         BD Address: 70:F3:95:34:2F:29  ACL MTU: 1021:8  SCO MTU: 64:8
>         HCI Version: 2.1 (0x4)  Revision: 0x168
>         LMP Version: 2.1 (0x4)  Subversion: 0x4203
>         Manufacturer: Broadcom Corporation (15)
> 
> And the output of "lsusb -v" is in the attachment. I will try to provide any 
> other information you need to analyse the problem.

can you show me the content of /proc/bus/usb/devices (or usbdevices.sh)
for that device.

Regards

Marcel


