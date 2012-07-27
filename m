Return-Path: <cyrus@holtmann.org>
Sender: Jiri Slaby <jirislaby@gmail.com>
Message-ID: <50126FB8.5070200@suse.cz>
Date: Fri, 27 Jul 2012 12:38:48 +0200
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
To: Alin M Elena <alinm.elena@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: bluetooth not working since kernel 3.4.4
References: <10337447.lD117hnr9f@abbaton.ucd.ie>
In-Reply-To: <10337447.lD117hnr9f@abbaton.ucd.ie>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

FWD to upstream. For him, bluetooth in 3.5 vanilla does not work:

On 07/27/2012 12:02 AM, Alin M Elena wrote:
> since updating to kernel 3.4.4 my bluetooth stopped working...
> kde claims there is no adapter available and the same gnome...
> 
> 
> the device is
> Bus 004 Device 004: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of 
> BCM2046 Bluetooth)
> [alin@abbaton:~]: dmesg | grep bt
> [   15.862126] usbcore: registered new interface driver btusb
> [alin@abbaton:~]: hcitool dev
> Devices:
> 
> I have updated since to the new 3.5.0 kernel and the situation is the same.
> 
> 
> [alin@abbaton:~]: uname -a
> Linux abbaton.ucd.ie 3.5.0-1-desktop #1 SMP PREEMPT Tue Jul 24 13:38:05 UTC 
> 2012 (fb9c50b) x86_64 x86_64 x86_64 GNU/Linux
> 
> Anyone else seeing the same? any advice?



On 07/27/2012 11:33 AM, Alin M Elena wrote:
>> What was the last working kernel?
> 3.4.2 iirc
>
>> Does kernel-vanilla work? I suppose
>> not, if you confirm that, we could discuss this with upstream...
> just tried the last kernel-vanilla from Kerned:Head 3.5.0-2.1 and no
bluetooth
> adapter found..
>
> I forgot to mention earlier.
>
> rfkill list
> 0: hci0: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
>
> and I have tried the device in mac OSX and it works...
> the machine is a mac book pro 7,1.

regards,
-- 
js
suse labs
