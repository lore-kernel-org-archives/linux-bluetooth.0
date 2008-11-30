Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth and "IRQ 19 and nobody cared" on a HP 8510w with
 Debian 2.6.24 or 2.6.26
From: Marcel Holtmann <marcel@holtmann.org>
To: Tyson Whitehead <twhitehead@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, david@hardeman.nu,
	drzues@drzues.cx
In-Reply-To: <200811271149.35176.twhitehead@gmail.com>
References: <200811271149.35176.twhitehead@gmail.com>
Content-Type: text/plain
Date: Sun, 30 Nov 2008 09:49:23 +0100
Message-Id: <1228034963.9176.2.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tyson,

> I've been getting these "irq 19: nobody cared (try booting with "irqpoll" 
> option)" messages on my HP 8510w.  Recently I googled it, which lead me to the 
> following discussion from another fellow with the same problem on the LKML
> 
> http://lkml.org/lkml/2008/6/24/357
> 
> In this discussion it was mentioned that pressing the radio kill switch 
> stopped this message from appearing, which implied it might be iwl4965.
> 
> I had already tried blacklisting the iwl4965 module (adding it to 
> /etc/modprobe.d/blacklist) with no success.  But it got me thinking radio, so 
> I tried blacklisting hci_usb and there were no more "irq 19: nobody cared" 
> messages.  Loading hci_usb subsequently resulted in a message within 10min.
> 
> I tried this another three times to verify it (reboot, wait 30min with no 
> messages, load hci_usb, and a message appears within 10min).  Hopefully David 
> will be able to verify these results also apply to his 8510w as well.
> 
> I've attached the output of "lsusb -v".  Is there any other information that 
> would help, or something I can do (kernel log messages are as was given by 
> David in the original LKML list, but I could attach another if you wish)?

start using the btusb driver instead of hci_usb. And even while you
think this might be caused by Bluetooth, you should report it to the USB
guys since the USB host controller is responsible for that interrupt.

Regards

Marcel


