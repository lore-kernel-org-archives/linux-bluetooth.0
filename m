Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4118D6B9.3090708@superbug.demon.co.uk>
Date: Tue, 10 Aug 2004 15:07:53 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Jonathan Paisley <jp-www@dcs.gla.ac.uk>,
   Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>	 <1092140041.4564.96.camel@pegasus>	 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>	 <1092143505.4564.117.camel@pegasus> <4118D049.9060000@superbug.demon.co.uk> <1092145771.4564.148.camel@pegasus>
In-Reply-To: <1092145771.4564.148.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>>I prefer the ALSA integration would be written from scratch, because the
>>>original driver was written for a 2.4 kernel and we must concentrate on
>>>the 2.6 series. The ALSA subsytem will be cleaned up in the next kernel
>>>releases and the magic casting stuff they do is still wrong.
>>
>>The latest alsa cvs fixes the magic casting stuff.
> 
> 
> as I said, I don't care about what is in the ALSA CVS or their external
> drivers. The main focus is the ALSA subsystem in the mainline kernel.
> 
> So everone who will work on this have this in mind and start with the
> latest 2.6 kernel. If the ALSA stuff in their CVS is newer, then ping
> them to merge it mainline.
> 
> Regards
> 
> Marcel
> 

I can get modules added to the alsa cvs. I would think that newly 
developed modules should go into cvs first, and then backported to older 
kernel versions. After all, the only way to get snd-bt-sco into the 
linux kernel proper, is via the alsa cvs.
There are various staging steps in the alsa cvs, before a module in the 
alsa cvs gets into the linux kernel proper.

Of course the snd-bt-sco module will just be a bit of shim code between 
alsa and blues. With the major work done in a user space bluetooth profile.

One advantage of alsa, is that once a module is in the alsa cvs, it will 
will always function correctly on all kernel versions, so back porting 
is not an issue with alsa.

James
