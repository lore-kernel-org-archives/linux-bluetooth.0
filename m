Return-Path: <James@superbug.demon.co.uk>
Message-ID: <3F30361B.2000507@superbug.demon.co.uk>
Date: Tue, 05 Aug 2003 23:56:27 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI USB driver and SCO support
References: <3F2B8207.1040200@superbug.demon.co.uk>
	<1059787251.22190.17.camel@pegasus> <3F2B8207.1040200@superbug.demon.co.uk>
	<5.1.0.14.2.20030805104610.0c10d7a8@unixmail.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20030805104610.0c10d7a8@unixmail.qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Max Krasnyansky wrote:
> At 02:35 AM 8/4/2003, Marcel Holtmann wrote:
> 
>>Hi James,
>>
>>
>>>If we are going to use the SCO channels for sound output from 
>>>applications, it would be very useful if we could provide some sort of 
>>>ring buffer support, with hardware pointer updates.
>>>Currently, there are no callbacks from sco to the application layer, 
>>>telling it how many sound samples have actually left the PC for the 
>>>Bluetooth device. This is a requirement if we are to support any sound 
>>>card simulation layer above the SCO layer.
>>>Until this is resolved, we will not be able to implement alsa or oss 
>>>support.
>>
>>I don't care about this at the moment, because the current problem is
>>the hci_usb driver. We need to adjust the alternate setting for the ISOC
>>interface on demand. And this setting depends on the voice setting (8 or
>>16 bit) and the number of SCO connections. If the used alternate setting
>>is not correct, you don't get any correct audio data over the SCO link.
> 
> Yep. I agree. Let's fix the driver/core interaction first.
> 
> 

I would like to help with bluez developement, but it seems that bluez 
developement is not done on kernel 2.6, so I cannot help.
All kernel usb development is done on kernel 2.6, so why developement of 
the bluez hci_usb driver is not also done on kernel 2.6 is a mystery to me.
