Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Jan 2010 19:23:34 -0600
From: pigiron@gmx.com
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: headset target seems to be playing but no sound
Message-ID: <20100125192334.6725779d@atom.pigiron.org>
In-Reply-To: <1264393316.22989.862.camel@pc.interlinx.bc.ca>
References: <8396c2281001242007n5ae20eccj53d496f1297e5d22@mail.gmail.com>
	<8396c2281001242013y1246bcaaq73ad85ff82f57cab@mail.gmail.com>
	<1264393316.22989.862.camel@pc.interlinx.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 24 Jan 2010 23:21:56 -0500 "Brian J. Murrell" <brian@interlinx.bc.ca>
wrote:

> On Mon, 2010-01-25 at 12:13 +0800, Chao Deng wrote: 
> > Hi, Brain,
> > 
> > I have the same problem like you. Do you find the root cause of it?
> 
> Nope, not a clue.  Unfortunately my posting here didn't get any ideas of
> why or what I should do to debug either.  I kinda gave up, yet again, as
> I have done many times in the last 2-3 years of simply trying to get a
> Bluetooth headset working on Linux.  Sadly it always seems like the
> answer is "next [kernel|bluez] release -- it should work great".
> 
> > The kernel I used is 2.6.31, and the bluez is 4.51
> 
> Seems we are in the same boat.
> 
> Sorry I don't have better answers for you.
> 
> b.
> 

Yep. It's unfortunate that no one responded. I've spent many hours digging into
this bug, and was hoping that others my have some valid pointers/directions.

Anyway, I'm not a Bluez developer, nor do I speak fluent "Bluetooth", but
here's what I've found so far...

This is not a new bug. Galaha Shine found the crux of the problem back in 2008:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-September/010721.html

and after firing up my debugger, this still seems to be the same issue today
(at least when I looked at the previous releases).

As you may know, headsets can have different bluetooth capabilities described
in their profiles. There's the HSP/HFP profiles for doing things like talking on
the phone, and then there's the A2DP profile for listening in stereo. And there
are others.

Brian, you don't state which profile you're using when it fails, but from
looking at your hcidump info, it appears like it's HSP or HFP because your data
packets are 48 bytes long... which is the MTU size in Bluez for HSP/HFP. When
using the A2DP profile (if supported by your headset), the data packets are
much larger.

Chao, I have 2 sets of Motorola S805's also, and it can do both of those
"types" of profiles. If the headset is put into HFP mode, then you experience
the joy of this problem. In A2DP mode, it (mostly) works if you only want to
listen in stereo.

The root cause of the problem (at least from my debugging experience) is that if
you are using HSP or HFP mode... and your application is talking directly to
ALSA (like "aplay" does)... then your audio data eventually makes it's way to
the snd_pcm_rate_commit_area() function in ALSA in 48 byte (MTU sized) "chunks".
But, if this function receives less than a "slave_size" amount of data, it
simply drops it by calling the snd_pcm_rewind() function.

To super simplify the problem description, Bluez keeps sending 48 byte "chunks"
of audio data, that ALSA happily ignores... nice.

Just like Galaha, I'm stuck trying finding a solution. I tried his Bluez patch,
but it doesn't work. And so far, I've not been able to get my head wrapped
around even a "big picture" of the Bluez SCO data path to find an acceptable
alternative. With the goal being to create a (hopefully suitable) patch to some
component, somewhere... anywhere. Or possibly there's another solution??? Any
help would be appreciated. 

It *appears* that others *may* be having some success using PulseAudio for
this, but I prefer not to go there... just call me stubborn.
