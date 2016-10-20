Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1476991861.2007.2.camel@gmail.com>
Subject: Re: BT / serial regression introduced during the recent 4.9-rc1
 merge?
From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne
        <jerome.debretagne@gmail.com>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 20 Oct 2016 21:31:01 +0200
In-Reply-To: <1476815643.1658.3.camel@gmail.com>
References: <1476815643.1658.3.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I've compiled the latest bluetooth-next branch and I'm facing what looks
> like a regression to me (still on a Lenovo ThinkPad 8 tablet): btattach
> doesn't properly initialize the Broadcom BCM2E55 chipset anymore. 
> 
> I'm getting various timeout messages in dmesg:
> 
> [   13.188057] Bluetooth: hci0 command 0xfc45 tx timeout
> [   16.093068] serial8250_interrupt: 4158 callbacks suppressed
> [   16.093072] serial8250: too much work for irq39
> [   16.094287] serial8250: too much work for irq39
> ...
> [   16.103868] serial8250: too much work for irq39
> [   21.100041] serial8250_interrupt: 4167 callbacks suppressed
> [   21.100044] serial8250: too much work for irq39
> ...
> [   21.222065] Bluetooth: hci0: BCM: failed to write clock (-110)
> [   23.238528] Bluetooth: hci0 command 0x0c03 tx timeout
> [   26.104253] serial8250_interrupt: 4165 callbacks suppressed
> [   26.104257] serial8250: too much work for irq39
> 
> which I never had before and Bluetooth never actually starts.
> 
> I've gone back in time and it doesn't work either with a kernel built at
> e6445f52d9c8b0e6557a45fa7d0e8e088d430a8c "Merge tag 'usb-4.9-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb".
> 
> It still worked at commit a2f195a73eba807006fb0cb882ecb552c06eea00
> "bluetooth: bcm203x: don't print error when allocating urb fails" though,
> which was the last previous commit modifying files in drivers/bluetooth in
> the bluetooth-next branch.

Continuing to bissect, the regression seems to have appeared during commit:
   e6dce825fba05f447bd22c865e27233182ab3d79    Merge tag 'tty-4.9-rc1' of
   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty

   Pull tty and serial updates from Greg KH:
     "Here is the big tty and serial patch set for 4.9-rc1. [...]"

just to let you know the state of my investigation. Now, I'll switch to
bissect the 111 commits introduced within that merge. To be continued.

Regards,

Jérôme
