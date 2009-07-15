Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jul 2009 12:44:52 +0100
From: James Le Cuirot <chewi@aura-online.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Super fast audio with alsa
Message-ID: <20090715124452.68d53e4e@symphony>
In-Reply-To: <ea2906620907150416k43589f23m27cf8bbe49caa02a@mail.gmail.com>
References: <ea2906620907140856r718f5f76k59a461dfc9dd666c@mail.gmail.com>
	<ea2906620907150355k23a2dd8cl26f7d916f775e6e3@mail.gmail.com>
	<20090715120613.15f4f1ec@symphony>
	<ea2906620907150416k43589f23m27cf8bbe49caa02a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 15 Jul 2009 12:16:51 +0100
Daniel Castro <castromd@tcd.ie> wrote:

> 2009/7/15 James Le Cuirot <chewi@aura-online.co.uk>:
> > I have the Motorola S9 and it works with ALSA for me but I'm not
> > sure if I ever tried it through Audacious. Did you try it via a
> > plug device or did you use the device directly?  
> 
> not sure how to answer your question.
> 
> so i created the ~/.asoundrc file with:
> pcm.S9bluetoothraw {
>    type bluetooth
>    device 00:0D:FD:23:1A:DE
> }
> pcm.S9bluetooth {
>     type plug
>     slave {
>         pcm S9bluetoothraw
>     }
> }
> 
> and then from audacious I tell it to use ALSA Output plugin for it's
> audio system and set S9bluetooth as the audio device.

That is what I meant. Should work. I'm no expert so I can't suggest
much more than trying something other than Audacious but I'm guessing
you have already.

James
