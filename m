Return-Path: <James@superbug.demon.co.uk>
Message-ID: <40393D4D.5070908@superbug.demon.co.uk>
Date: Sun, 22 Feb 2004 23:37:49 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: =?ISO-8859-1?Q?Fred_Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
Subject: Re: [Bluez-devel] sco link help needed
References: <4034CA08.50500@soft.uni-linz.ac.at>	 <200402191629.38846.bluez-devel@schaettgen.de>	 <40376D2B.1060904@superbug.demon.co.uk> <1077452836.2716.42.camel@pegasus>	 <403916CB.3060205@superbug.demon.co.uk> <1077485446.2832.14.camel@pegasus>	 <4039275F.5020802@superbug.demon.co.uk> <1077487791.2832.35.camel@pegasus>
In-Reply-To: <1077487791.2832.35.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>So you only want a basic read/write interface? No possibility for 
>>specifying low latency and setting accurate playback timing?
>>What would happen if the user wanted to use bluetooth headphones, and 
>>wanted sound to come out of the headphones, and the video from a DVD to 
>>be displayed on the computer screen. We need some way to ensure the two 
>>are in sync. A simple read/write interface cannot do that.
>>For playing a DVD, latency does not matter, what matters in accurate 
>>playback timing.
>>For Voice over IP, low latency is what matters.
>>I cannot see how your simple read/write interface can handle these 
>>options. The SCO interface should be able to handle all these.
> 
> 
> for incoming SCO data packets we can trust the timing of the Bluetooth
> chip. For outgoing SCO data from our side we should make sure that we
> don't send to much and overload the Bluetooth chip, but any good
> Bluetooth chip should be able to handle this and simply drop the
> unneeded packets.

What I am trying to say is that using read/write interfaces for realtime 
streams like SCO is just the wrong way to do it.
I have looked at snd-bluez-sco-2003-09-15.tar.gz and from what I can 
understand from it, the snd-bluez-sco kernel driver is just using simple 
read/write commands to a file descriptor given to it from the userspace 
daemon "bluezsco".

This approach will get sound to and from the bluetooth headset.
But SCO has the potential for so much more, so why are we restricting it?
We must allow for applications like VoIP and DVD playback. These need 
control over latency and playback timing accuracy. The current "file 
descriptor read/write" approach does not allow for that.

The bluetooth chip should not have to worry about dropping packets, the 
application should just send the chip packets when the chip wants them.

I am only asking for changes to the SCO side of things due to it's real 
time nature. Using network sockets for RFCOMM and bulk data transfers 
that are not real time in nature is fine.

Once we have proper real time SCO support, we can overlay the current 
SCO file descriptor read/write model on top if you still need it.

> 
> 
>>Ok, so you only want alsa to interface PCM (alsa's term for an audio 
>>channel, where the audio samples go.) directly to a SCO channel.
>>So, what about an application that supports alsa now. How will it set 
>>volume and mic levels on a bluetooth headset? Will the user have to add 
>>special bluetooth support to their application?
> 
> 
> This is what I meant with SCO interface. A SCO kernel module must also
> present an ALSA mixer, but it sends and receives the settings to and
> from an userspace application. So if you receive the AT command for
> increasing the volume on the RFCOMM channel, you signal this to the SCO
> kernel module and this changes the mixer settings. We will see what is
> best solution here after the SCO to ALSA PCM mapping is working.

Ok, doing that with the mixer is not a problem for me. mixer settings 
are not time critical, and simple two way IOCTLs for get/set volume etc. 
will work fine with the current userspace approach.

> 
> Regards
> 
> Marcel
> 
> 
Cheers

James
