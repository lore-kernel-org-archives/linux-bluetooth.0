Return-Path: <jp@dcs.gla.ac.uk>
Date: Tue, 10 Aug 2004 14:20:07 +0100 (BST)
From: Jonathan Paisley <jp@dcs.gla.ac.uk>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
In-Reply-To: <1092143505.4564.117.camel@pegasus>
Message-ID: <Pine.LNX.4.59.9999.0408101412470.22497@brava.dcs.gla.ac.uk>
References: <4117AB9A.9010909@dark-reality.de>  <1092071356.4564.12.camel@pegasus>
 <4117B098.5020805@dark-reality.de>  <1092073167.4564.26.camel@pegasus>
 <4117C0AB.2010609@superbug.demon.co.uk>  <1092090364.4564.46.camel@pegasus>
 <41180E64.1010007@dark-reality.de>  <1092140041.4564.96.camel@pegasus>
 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>
 <1092143505.4564.117.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 10 Aug 2004 3:11pm +0200, Marcel Holtmann wrote:

>> I'd also mention that I didn't find latency to be a problem, but I know
>> that there are issues resulting from lack of buffering that cause audio
>> dropouts for the listener. This lack of buffering, however, is a result of
>> the design of the driver and not a fundamental limitation in bluez.
>
> the point is that dropping packets and generating zero packets is
> already part of the Bluetooth chip. This means we will get a correct
> stream from the hardware and we must only make sure that we deliver our
> packets in time as long as the hardware is able to buffer it.

Agreed. The problem I've seen is due to the driver not providing packets 
in time to the SCO layer. As such, the hardware doesn't get a chance to 
buffer.

>> As far as the existing snd-bt-sco source goes, I think there's a
>> significant amount of code that can be saved. Most of the code is dealing
>> with the ALSA integration, management of the mixer and pcm interfaces etc.
>> The kernel thread that does the socket programming can be ripped out
>> (along with the ioctl handlers that set it up) and replaced with
>> timer-driven code which talks directly to the SCO module.
>
> I prefer the ALSA integration would be written from scratch, because the
> original driver was written for a 2.4 kernel and we must concentrate on
> the 2.6 series. The ALSA subsytem will be cleaned up in the next kernel
> releases and the magic casting stuff they do is still wrong.

I haven't been keeping track of ALSA development recently. It sounds like 
you're saying that the API is going to be changing enough that simple 
modifications to the existing ALSA-interfacing code in snd-bt-sco will not 
be enough to keep it up to date. Does this mean it would be worth putting 
a hold on development of a properly-bluez-integrated driver until the ALSA 
subsystem has stabilised?
