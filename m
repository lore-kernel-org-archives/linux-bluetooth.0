Return-Path: <jp-www@dcs.gla.ac.uk>
In-Reply-To: <1087431863.4309.39.camel@pegasus>
References: <40A9E6CB.4010505@dark-reality.de> <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk> <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus> <40AA11AB.6010307@dark-reality.de> <1084888843.4327.1.camel@pegasus> <40D0CE71.2010208@dark-reality.de> <1087427168.4309.30.camel@pegasus> <40D0DFFE.7020701@dark-reality.de> <1087431863.4309.39.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E1B5DFDA-C050-11D8-9772-000A95A4D990@dcs.gla.ac.uk>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco do?
Date: Thu, 17 Jun 2004 12:24:22 +0100
To: Lars Grunewaldt <lgw@dark-reality.de>
List-ID: <bluez-devel.lists.sourceforge.net>

On 17 Jun 2004, at 1:24, Marcel Holtmann wrote:

> Hi Lars,
>
>> Now I'm lost again. Is there an audio transcoding somewhere in the SCO
>> layer, so that I could simply send PCM_S16 and the SCO layer 
>> transcodes
>> the audio if the headset does not support this? I mean there must be a
>> reason why the original snd-bt-sco developer hardcoded the 8bit format
>> instead of using 16 bit.
>
> the reason was me, because my first SCO test was with a 3Com PCMCIA 
> card
> and 8bit is less data than 16bit ;)

When I wrote the ALSA driver initially I fairly arbitrarily chose 8-bit 
rather than 16-bit sound format.

>> To make my headset work for now (need my "phone") I used that bad 
>> kernel
>> patch again, but I'll try to do everything to avoid that in the 
>> release.
>> I just have to understand what's going on...
>
> I don't see your problem. Simply use 16bit PCM in the ALSA code.

This should work fine. Reconfigure the sound format descriptors in the 
ALSA driver to describe 16 bit audio instead of 8 bit.
