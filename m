Return-Path: <James@superbug.demon.co.uk>
Message-ID: <3F3037A3.3000003@superbug.demon.co.uk>
Date: Wed, 06 Aug 2003 00:02:59 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: Max Krasnyansky <maxk@qualcomm.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI USB driver and SCO support
References: <5.1.0.14.2.20030805101803.0c38f768@unixmail.qualcomm.com>
	<1060121840.935.25.camel@pegasus>
In-Reply-To: <1060121840.935.25.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Max,
> 
> 
>>>the patch from Jonathan Paisley is working fine. I have tested it on
>>>2.4.18 to 2.4.21 and we can safely use two ISOC TX and RX URB's by
>>>default. 
>>
>>Yep, I was going to apply his patch.
> 
> 
> but without choosing the correct ISOC alternate setting it is useless :(

I think the "ISOC alternate setting" are USB specific, so I think work 
should be contained in hci_usb, and not require core modifications.
To this end, I think it would be helpful to separate INT and BULK 
traffic from SCO traffic.
SCO is realtime, INT and BULK are not, so they require different buffer 
handling.
To this end, INT and BULK work well with queues, and SCO are better 
suited to ring buffers.
