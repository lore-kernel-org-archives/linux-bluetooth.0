Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] caching A2DP/alsa connection
Message-ID: <20050918114545.GA5175@uni-duesseldorf.de>
References: <432CE905.6050006@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <432CE905.6050006@xmission.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 18 Sep 2005 13:45:45 +0200

Brad Midgley <bmidgley@xmission.com> wrote:
> I remember you were trying to keep the headset connection open between 
> the quick audio device close and reopen that some clients like xmms do.

That would probably be good, as I have seen xmms fail for some reason
on a relevant percentage of opens, which makes xmms stall in
"Stop"-mode. You can immediately press "Play" again and it will usually
work, but it's annoying, if you aren't sitting in fornt of the PC (where
you could use the internal soundcard anyway).


> I started thinking we need to put esd or another audio server or alsa 
> layer between the apps and our libalsa a2dp connection. 

This might be a good idea. I have been thinking about the same to do
away with some of the headaches of the skype hijacker.

Basically, a sound server is a good thing in itself, as it allows to
multiplex several audio sources, thus avoiding not hearing softphones
ring while watching a video clip or listening to mp3s.

Moreover it would save me the ugly hack I do in the skype-hijacker
to switch around the sound, if one could _tell_ the soundserver
to switch devices.

>From what I have seen by a quick glance over the various soundservers,
artsd seems to offer most oft the functionality I'd like to see.
Especially it offers a remote control application (artsshell) that might
be easily adapted to offer a few more commands (like changing output
device).


> Could we extend the caching to work between different apps this way? 

We could even avoid implementing it ourselves. "-s auto-suspend time"
seems to do what you are asking for.

And for apps that don't support arts natively, there is the artsdsp
wrapper which will try to capture application output.


> We may even be able  to use a soft mixer to get simultaneous clients...

What I am not yet sure of, is if artsd supports multiple output devices
in a more generic way than what I just thought aloud about switching them 
using the command channel.

What I am thinking of here is either
(simple version) have multiple artsds and have apps connect to the
                 appropriate daemon to select their output device.
(nice and complex) have a single artsd that handles all output devices
                   and individual mixers for each application<->device
				   pair.

I suppose this hasn't been an issue up to now, as usually a PC had only 
1 soundcard and there wasn't much sense in using a second one.

However now with networked sound devices, you may want to have an XMMS
playing music in the livingroom via a secondary soundcard that transmits
there via a hardware RF-link device, while the primary card emits
the sounds of some game your son is playing on the console and the 
btsco device is dealing with a VoIP call of your wife ...

I suppose you get the idea.

So basically what I suggest is:

- let's discuss, what we'd like to see and how to accomplish it most
  easily.
- let's get in touch with the developers of the sound daemon that looks
  like being easiest to adapt.
- maybe we can get them to implement our suggestions, or we can help out
  with that.

> This is part of the reason I've been slow to jump in. It seems like I'd 
> need to understand alsa up and down to know how to best make this work.

Hmm. I think alsa is not quite part of the solution, rather part of the
problem.

Don't get me wrong - I like alsa - the interface is much better than OSS
with respect to supporting multiple channels etc., and I am not a fan of 
soundservers either (don't run one, as I haven't needed one yet), but
the more I think of it, the more I get the impression that using a
soundserver is the correct solution.

The point that pulls me toward that view is, that a soundserver will
give us _virtualization_ of the audio device, not only _arbitration_, 
as the OS interface does.

I.e. with ALSA/OSS/etc. we will always have a problem when running more
than one program on the same audio device. We can trick around that a
little by using the multichannel facilities of some cards (I run xmms on
hwdev:0.1 usually to avoid it interfering with other apps), but we will
always have some corner cases that don't work well.

What I envision is a "next generation" mixer application that will start
up showing all sound devices and all sound using applications in a
matrix and i can click which combination I'd like to modify, before a
normal (or rather a somewhat limited) mixer pops up.
(I doesn't make sense to offer the mixer settings that are
 hardware-specific [like line-in/CDROM/Beeper feeds] in the 
 app-specific mixer)

Moreover it should be easy to configure applications to output on a
specific device, or even a specific device combination (like an inbound
VoIP ring going out on all available channels).


Phew. That went long. I'll probably better lean back now and hear some
of your opinions about this vision.

CU, Andy

-- 
= Andreas Beck                    |  Email :  <becka-sig@bedatec.de>         =


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
