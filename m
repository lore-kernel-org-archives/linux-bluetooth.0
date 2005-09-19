Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <432E0AFB.4050800@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] caching A2DP/alsa connection
References: <432CE905.6050006@xmission.com> <20050918114545.GA5175@uni-duesseldorf.de>
In-Reply-To: <20050918114545.GA5175@uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 18 Sep 2005 18:48:59 -0600

Andreas

I was thinking specifically about the stereo audio driver but it applies 
to handsfree/headsets.

> From what I have seen by a quick glance over the various soundservers,
> artsd seems to offer most oft the functionality I'd like to see.
> Especially it offers a remote control application (artsshell) that might
> be easily adapted to offer a few more commands (like changing output
> device).

I want to avoid a sound server that is tied to a specific desktop. What 
about alsa's dmix? it seems to do what we want and at a lower level 
where it would work for everyone... 
http://alsa.opensrc.org/index.php?page=DmixPlugin

> - let's discuss, what we'd like to see and how to accomplish it most
>   easily.
> - let's get in touch with the developers of the sound daemon that looks
>   like being easiest to adapt.
> - maybe we can get them to implement our suggestions, or we can help out
>   with that.

I like the thoughts you're having about this... here's what how I want 
it to behave:

- bluetooth audio connection is brought up on demand; best if control 
connection is brought up on demand too

- audio connection is held open for a slight delay after the device is 
closed or idle in case it's to be used again soon

- audio device can be used by multiple apps (writing) but just one app 
reading (in the case of sco)

- reading audio "from" the a2dp device can be redirected to another 
device like a hardwired mic

headset negotiation and avrcp (on newer a2dp sets) gets more complicated:

- generate dbus events for button presses on the headset
- accept dbus events to initiate headset "ring" function

I guess the next step is to find out if dmix is useful here.

Brad


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
