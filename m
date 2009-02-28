Return-Path: <cyrus@holtmann.org>
Subject: Re: another "blacklist" device for hci_usb
From: Marcel Holtmann <marcel@holtmann.org>
To: Derek Chan <dwc+lkml@OCF.Berkeley.EDU>
Cc: maxk@qualcomm.com, linux-bluetooth@vger.kernel.org
In-Reply-To: <20090226091707.GG9042@OCF.Berkeley.EDU>
References: <20090226091707.GG9042@OCF.Berkeley.EDU>
Content-Type: text/plain
Date: Sat, 28 Feb 2009 22:39:51 +0100
Message-Id: <1235857191.6074.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Derek,

> I've got a USB bluetooth adapter that needed some of those handy module
> params to get SCO working.
> 
> Bus 001 Device 004: ID 0a5c:2121 Broadcom Corp. BCM2210 Bluetooth
> 
> I'm running on 2.6.26-13 from debian lenny, with an sco.ko with an ESCO
> disabling patch, but I also tried it on 2.6.28.7 (with disable_esco=1).
> It seems to be required that force_scofix=1 be on, but I noticed none of the
> IDs only contain the SCO fix (http://git.kernel.org/?p=linux/kernel/git/holtmann/bluetooth-2.6.git;a=blob;f=drivers/bluetooth/hci_usb.c;h=3c453924f8386c9b92050ae978967d188ec3b4da;hb=57f8f7b60db6f1ed2c6918ab9230c4623a9dbe37#l105) so I added
> the reset=1 as well.

send "hciconfig -a" before and after your patch. You have to prove to me
that you really need this patch.

Also please post a patch against btusb.c since hci_usb.c has been
removed.

Regards

Marcel


