Return-Path: <jp@dcs.gla.ac.uk>
Date: Tue, 10 Aug 2004 15:39:04 +0100 (BST)
From: Jonathan Paisley <jp@dcs.gla.ac.uk>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   snd-bt-sco@corinis.net
Subject: Re: [snd-bt-sco] Re: [Bluez-devel] snd-bt-sco development teamup |
 ALSA connection
In-Reply-To: <1092148605.4564.159.camel@pegasus>
Message-ID: <Pine.LNX.4.59.9999.0408101538210.22497@brava.dcs.gla.ac.uk>
References: <4117AB9A.9010909@dark-reality.de>  <1092071356.4564.12.camel@pegasus>
 <4117B098.5020805@dark-reality.de>  <1092073167.4564.26.camel@pegasus>
 <4117C0AB.2010609@superbug.demon.co.uk>  <1092090364.4564.46.camel@pegasus>
 <41180E64.1010007@dark-reality.de>  <1092140041.4564.96.camel@pegasus>
 <4118C5FC.1050502@dark-reality.de>  <1092145515.4564.143.camel@pegasus>
 <Pine.LNX.4.59.9999.0408101448200.22497@brava.dcs.gla.ac.uk>
 <1092148605.4564.159.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Tue, 10 Aug 2004 4:36pm +0200, Marcel Holtmann wrote:

>>> The general workflow should be something like this:
>>>
>>> 	- create RFCOMM channel and start AT handling
>>> 	- create SCO socket if needed
>>> 	- issue ioctl to make SCO socket an ALSA device
>>
>> I think that the creation of ALSA devices and binding of SCO socket to an
>> ALSA device should be separate operations. That way, an ALSA device can
>> exist with no attached headset. Using the technique described above, that
>> device can be demand-connected to a particular SCO socket.
>
> if this works we may can implement something like "rfcomm bind ...". The
> creation of the ALSA device can be handled through a SCO raw socket like
> we did it for RFCOMM.

Sounds ideal. Now we need to find somebody with enough time to implement 
it! :)
