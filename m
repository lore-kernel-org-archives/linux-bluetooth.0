Return-Path: <James@superbug.demon.co.uk>
Message-ID: <403CB172.8070103@superbug.demon.co.uk>
Date: Wed, 25 Feb 2004 14:30:10 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
CC: Marcel Holtmann <marcel@holtmann.org>,
   =?ISO-8859-1?Q?Fred_Sch=E4tt?=
 =?ISO-8859-1?Q?gen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
Subject: Re: [Bluez-devel] sco link help needed
References: <4034CA08.50500@soft.uni-linz.ac.at> <200402251359.00791.mtortonesi@ing.unife.it> <1077715546.2919.77.camel@pegasus> <200402251504.47809.mtortonesi@ing.unife.it>
In-Reply-To: <200402251504.47809.mtortonesi@ing.unife.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Mauro Tortonesi wrote:
>>
>>You can send PCM audio over a SCO socket, but you can't expect that the
>>PCM stream on the other side is byte by byte the same. It only sounds
>>the same.
> 
> 
> i haven't tried, but i don't suppose that infinite series of zeros i get on 
> the receiver sounds just like art blakey's alamode. there is surely something 
> wrong in the transfer process. could it be the fact that my hosts have an 
> usb-uhci controller?
> 

If you are receiving only zeros at the far end, the problem is with the 
sco driver or the hci-usb driver or the uhci_hcd driver.

I currently think the hci-usb driver is at fault, but I am doing 
research with the linux usb developers to discover how they think it 
should be done, and then I will look at the hci-usb driver and see if it 
is doing things correctly.

With my system, the urbs are failing the submit_urb in the hci-usb 
driver on kernel 2.6.3, so the hci-usb driver must be doing something 
wrong as the new kernel usb code does more checks in order to catch 
badly behaved applications. I think they are taking the approach that if 
an application is behaving badly, make it fail completely, thus forcing 
the program writter to correct it. Seems like a good policy to me. It is 
better to have an application working 100% of the time or 0% of the 
time, rather than randomly working/not working.

Cheers
James
