Return-Path: <jp-www@dcs.gla.ac.uk>
Date: Tue, 10 Aug 2004 14:03:25 +0100 (BST)
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
In-Reply-To: <1092140041.4564.96.camel@pegasus>
Message-ID: <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>
References: <4117AB9A.9010909@dark-reality.de>  <1092071356.4564.12.camel@pegasus>
  <4117B098.5020805@dark-reality.de>  <1092073167.4564.26.camel@pegasus>
 <4117C0AB.2010609@superbug.demon.co.uk>  <1092090364.4564.46.camel@pegasus>
 <41180E64.1010007@dark-reality.de> <1092140041.4564.96.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 10 Aug 2004 2:14pm +0200, Marcel Holtmann wrote:

>> | Actually you think that we need it, but I am still not sure that this is
>> | really needed in case of the concept of the SCO packet from the HCI and
>> | the SCO handling that is done on link manager/chip level. However you
>> | can still convince me with real code.
>>
>> I have to agree with Marcel here. I've been using snd-bt-sco for a while
>> now with my HBH-35 Sony Ericsson Headset, and it works pretty well. Of
>> course I don't know much about how audio is processed here, but the
>> snd-bt-sco layer simply connects the sco socket to the alsa audio
>> socket. There's not much stuff about full duplex or low latency done,
>> I'm pretty sure I'd have noticed.
>
> and the snd-bt-sco driver uses socket programming from within a kernel
> thread. If we remove that and include it directly into the SCO driver I
> think we have all what we need ;)

I'll chime in here to say that I agree with this too! (as the original 
author of the snd-bt-sco hack).

I'd also mention that I didn't find latency to be a problem, but I know 
that there are issues resulting from lack of buffering that cause audio 
dropouts for the listener. This lack of buffering, however, is a result of 
the design of the driver and not a fundamental limitation in bluez.


>> Maybe it would be possible to use some of the snd-bt-sco code here,
>> because only the userspace daemon that "wraps" the sound sockets
>> together must be "integrated" (well, it's functionality) into BlueZ,
>> while the snd-bt-sco alsa driver could remain nearly the same, just
>> accessing the BlueZ/alsa interface instead of BlueZ/SCO?
>
> Lets connect the SCO channel throught the socket interface and then tell
> the kernel via an IOCTL to change this into an ALSA device. We do the
> same for RFCOMM where we convert a socket into a TTY.
>
> Most of the snd-bt-sco source will be useless, because it handles the in
> kernel socket programming and you don't need that inside the SCO module.

Again, this sounds like a reasonable way to do things. I'd imagine that 
the ALSA device will have to hang around in the absence of an active SCO 
connection in order that programs using the device can keep it open while 
a headset comes and goes. Therefore it'd be necessary to have a mechanism 
to dynamically create ALSA devices, and another for binding active SCO 
sockets to those devices.

As far as the existing snd-bt-sco source goes, I think there's a 
significant amount of code that can be saved. Most of the code is dealing 
with the ALSA integration, management of the mixer and pcm interfaces etc. 
The kernel thread that does the socket programming can be ripped out 
(along with the ioctl handlers that set it up) and replaced with 
timer-driven code which talks directly to the SCO module.
