Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030805104610.0c10d7a8@unixmail.qualcomm.com>
Date: Tue, 05 Aug 2003 10:48:47 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, James Courtier-Dutton <James@superbug.demon.co.uk>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] HCI USB driver and SCO support
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1059989717.921.35.camel@pegasus>
References: <3F2B8207.1040200@superbug.demon.co.uk>
	<1059787251.22190.17.camel@pegasus> <3F2B8207.1040200@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 02:35 AM 8/4/2003, Marcel Holtmann wrote:
>Hi James,
>
>> If we are going to use the SCO channels for sound output from 
>> applications, it would be very useful if we could provide some sort of 
>> ring buffer support, with hardware pointer updates.
>> Currently, there are no callbacks from sco to the application layer, 
>> telling it how many sound samples have actually left the PC for the 
>> Bluetooth device. This is a requirement if we are to support any sound 
>> card simulation layer above the SCO layer.
>> Until this is resolved, we will not be able to implement alsa or oss 
>> support.
>
>I don't care about this at the moment, because the current problem is
>the hci_usb driver. We need to adjust the alternate setting for the ISOC
>interface on demand. And this setting depends on the voice setting (8 or
>16 bit) and the number of SCO connections. If the used alternate setting
>is not correct, you don't get any correct audio data over the SCO link.
Yep. I agree. Let's fix the driver/core interaction first.

>> The current method for allocation of the URB is incompatible with kernel 
>> 2.6.
>> bluez currently allocates it's own urb as a structure inside _urb.
>> In 2.6, the requirement is to get the usb subsystem to allocate the urb, 
>>   and then set the urb->context pointer to point to any bluez specific 
>> state information.
>> If the urb allocation is adjusted, it will then work on both 2.4 and 2.6
>
>There was a discussion between Max and Greg about this topic on the
>Linux USB mailing list. You should read this first.
Yeah, I was going to add a few fields to 'struct urb' :).

Max
