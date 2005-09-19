Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] caching A2DP/alsa connection
Message-ID: <20050919113953.GA5536@uni-duesseldorf.de>
References: <432CE905.6050006@xmission.com> <20050918114545.GA5175@uni-duesseldorf.de> <432E0AFB.4050800@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <432E0AFB.4050800@xmission.com>
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
Date: Mon, 19 Sep 2005 13:39:53 +0200

Brad Midgley <bmidgley@xmission.com> wrote:
> I was thinking specifically about the stereo audio driver but it applies 
> to handsfree/headsets.

Yes. No matter what kind of extra soundcard you have. As soon as it is
more than one, you will probably have use for these ideas.

> >From what I have seen by a quick glance over the various soundservers,
> >artsd seems to offer most oft the functionality I'd like to see.
> >Especially it offers a remote control application (artsshell) that might
> >be easily adapted to offer a few more commands (like changing output
> >device).
> I want to avoid a sound server that is tied to a specific desktop. 

It actually isn't. I run fvwm2, and artsd works fine without starting
too much other crap. However:

> What about alsa's dmix? 

I didn't know that, and I think I like it. 

> it seems to do what we want and at a lower level where it would work 
> for everyone... 

Yes. Very nice. I suppose it is implemented in the ALSA libs - right?

> http://alsa.opensrc.org/index.php?page=DmixPlugin

> - bluetooth audio connection is brought up on demand; best if control 
> connection is brought up on demand too

Yeah. As said, I envision some kind od "dynamic" mix application that
shows all currently active sound-using programs and all currently
available sound devices.

Moreover this program should be scriptable for automating certain
behaviours.

> - audio connection is held open for a slight delay after the device is 
> closed or idle in case it's to be used again soon

I'm not sure how it is done currently. I'm not even sure, if it is easy
to do if it is done from within the alsa library, but I got to look at 
the code first.

> - audio device can be used by multiple apps (writing) but just one app 
> reading (in the case of sco)

I have just tested it and multi-app-writing works. I pushed 3 mp3s in
parallel which is more than my 2 channel card normally does.

> - reading audio "from" the a2dp device can be redirected to another 
> device like a hardwired mic

Yeah. Basically I'd like to see some kind of "switchboard".


> headset negotiation and avrcp (on newer a2dp sets) gets more complicated:
> - generate dbus events for button presses on the headset
> - accept dbus events to initiate headset "ring" function

Yeah. I'll probably have to look into dbus, as more and more apps start
using it.

> I guess the next step is to find out if dmix is useful here.

It looks like it is. Thanks for that pointer.


CU, Andy


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
