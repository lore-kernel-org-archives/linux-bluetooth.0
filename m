Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4041512B.6050703@superbug.demon.co.uk>
Date: Sun, 29 Feb 2004 02:40:43 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix to enable bluez SCO USB urbs.
References: <403FD968.6010004@superbug.demon.co.uk> <1077972736.2843.60.camel@pegasus>
In-Reply-To: <1077972736.2843.60.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>Here is a patch for /usr/src/linux-2.6.3/drivers/bluetooth/hci_usb.c
>>
>>Without the interval set, the latest kernel 2.6.3 usb code will reject 
>>the usb_submit_urb().
>>
>>Without this patch no ISOC urbs are submitted, and thus no SCO data is 
>>passed.
> 
> 
> the same patch is already in 2.6.4-rc1.
> 
> 
>>The proper fix would really be to only enable these when a SCO 
>>connection is actually open.
> 
> 
> Of course. Send me patches for it.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
Where do I get the most up to date bluetooth kernel modules?
I cannot find them in the sf.net CVS.
I also cannot find any info on where to get them on the www.bluez.org 
web site.


Cheers
James
