Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jul 2009 12:06:13 +0100
From: James Le Cuirot <chewi@aura-online.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Super fast audio with alsa
Message-ID: <20090715120613.15f4f1ec@symphony>
In-Reply-To: <ea2906620907150355k23a2dd8cl26f7d916f775e6e3@mail.gmail.com>
References: <ea2906620907140856r718f5f76k59a461dfc9dd666c@mail.gmail.com>
	<ea2906620907150355k23a2dd8cl26f7d916f775e6e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 15 Jul 2009 11:55:52 +0100
Daniel Castro <castromd@tcd.ie> wrote:

> I have a Motorola S9 headset, and I followed the instructions in
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices to configure it to
> listen music with Audacious.
> I also have blueman installed which makes it very easy to pair and
> connect.
> 
> It kinda' works, but most of the times the audio goes super fast, it
> goes through the whole song in seconds, and CPU usage gets very high.
> When it works, if I leave it then it keeps working, but as soon as I
> start doing stuff like next song, play/pause it get messy again.
> 
> Not sure it makes sense?
> Can someone help? Need more info? Can you point me in the right
> direction?

I have the Motorola S9 and it works with ALSA for me but I'm not sure
if I ever tried it through Audacious. Did you try it via a plug device
or did you use the device directly?

Personally I'm waiting for PulseAudio's bluetooth support to get
completed because I find the ALSA driver a bit unreliable and
impractical. It sometimes crashes the player and heaven forbid you go
out of range!

James
