Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4117C0AB.2010609@superbug.demon.co.uk>
Date: Mon, 09 Aug 2004 19:21:31 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de> <1092073167.4564.26.camel@pegasus>
In-Reply-To: <1092073167.4564.26.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Lars,
> 
> 
>>| And as I said before, the best way is to extend the current SCO kernel
>>| module with an ALSA interface, because the basic idea of snd-bt-sco is
>>| wrong.
>>
>>I think you are absolutly right, but can you explain a bit more what you
>>have in mind? No code fragments or stuff, just how you think this might
>>be structured and integrated best. I think you are the person who knows
>>most about this topic.
> 
> 
> I think the SCO driver should provide two interfaces. The first one we
> know already is a socket interface to the SCO packets and the second
> should handle the SCO packets directly over into an ALSA interface. May
> you would like to switch between these two via an IOCTL, like we did it
> for the RFCOMM layer.
> 
> Regards
> 
> Marcel
> 

I looked at doing ALSA -> SCO interface a long time ago, but gave up due 
to what I considered limitations with the current bluetooth stack.

To summarise, we need low latency, full duplex, and to provide that, we 
need to accurately be able to determine and control the buffer sizes. 
The current bluetooth stack has no api to help us in this regard, and 
therefore will not work very well.

James
