Return-Path: <James@superbug.demon.co.uk>
Message-ID: <3F30D726.5030907@superbug.demon.co.uk>
Date: Wed, 06 Aug 2003 11:23:34 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: Max Krasnyansky <maxk@qualcomm.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI USB driver and SCO support
References: 
	<5.1.0.14.2.20030805101803.0c38f768@unixmail.qualcomm.com>	<1060121840.935.2
	5.camel@pegasus>  <3F3037A3.3000003@superbug.demon.co.uk>
	<1060159313.962.58.camel@pegasus>
In-Reply-To: <1060159313.962.58.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>>but without choosing the correct ISOC alternate setting it is useless :(
>>
>>I think the "ISOC alternate setting" are USB specific, so I think work 
>>should be contained in hci_usb, and not require core modifications.
> 
> 
> you basicly have two options
> 
> 	1) Parse events and commands inside the driver
> 	2) Let the core send a notify event to the driver
> 
> I already have done 1) for the number of SCO connections. It is very
> easy and it didn't blow-up the hci_usb code very much. After getting
> dynamic starting and stoping of ISOC URB's working I realized that all
> this won't help, if we don't adjust the ISOC alternate setting on
> demand. As I already said, the ISOC alternate setting depends on the
> number of SCO connections and the current voice setting (8 or 16 bit).
> So I have to parse the read_voice_setting and write_voice_setting
> commands and results. If you try this by yourself you will see, that
> this is not a job, which should be done in the driver. Keep the driver
> quite stupid and let it be what it is meant to be - a host transport
> driver.
> 
> And after knowing all this, the only way that makes sense at the moment
> is 2). Look at my patch and you will see that it is a clean extension to
> the core, because it only notify the driver about special events. What
> to do with this information is up to the driver.

I thought of this just after I sent the email. Sorry to trouble your on 
that point.

> 
> 
>>To this end, I think it would be helpful to separate INT and BULK 
>>traffic from SCO traffic.
>>SCO is realtime, INT and BULK are not, so they require different buffer 
>>handling.
>>To this end, INT and BULK work well with queues, and SCO are better 
>>suited to ring buffers.
> 
> 
> This is not quite correct. The hci_usb driver and the HCI core have to
> handle SCO traffic, but they don't have to know much about it. It is a
> packet type which have to be send and received. Nothing more, nothing
> less. The hci_usb driver uses ISOC endpoints to transfer SCO packets and
> BULK endpoints to transfer ACL packets. All other buffering which is
> needing have to be done in the sco module.
> 
> May I have to repeat myself - let us first finish the hci_usb driver
> with full SCO support. Max has agreed on my core change and I will push
> it for 2.4 and 2.5/2.6, so the hci_usb driver can be fixed very easy.
> 
> Regards
> 
> Marcel
> 
> 

I think you will find out later that SCO traffic needs a bit more than 
just packet send/receive. But I guess that I can add those features once 
you have fixed your stuff in hci_usb on kernel 2.6.

Cheers
James
