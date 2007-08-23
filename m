Return-Path: <hal-bounces@lists.freedesktop.org>
Subject: Re: [Bluez-devel] [patch] spec: Update alsa namespace to include
	virtual device
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200708232056.19885.kretz@kde.org>
References: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
	<200708231906.50942.kretz@kde.org> <1187893205.15402.75.camel@violet>
	<200708232056.19885.kretz@kde.org>
Date: Thu, 23 Aug 2007 21:27:02 +0200
Message-Id: <1187897222.15402.87.camel@violet>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, Lennart Poettering <mztfg@0pointer.de>,
        hal@lists.freedesktop.org
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Matthias,

> > when it comes to Bluetooth and other virtual devices with no real
> > hardware as backend the world changes a bit. You really do have to
> > change your way of thinking here since ALSA isn't the central place of
> > information anymore. Actually ALSA has no clue whatsoever.
> >
> > The Bluetooth audio support is designed around a central audio daemon
> > that takes care of mono headsets and high quality stereo headsets. This
> > daemon does all needed protocol handling and can be controlled via
> > D-Bus. Without this daemon you don't get any sound at all. This daemon
> > however handles only the control part of the audio protocol. All the
> > real audio data encoding and decoding is done in a plugin. Besides the
> > currently existing ALSA plugin, we have plans for GStreamer and
> > PulseAudio plugins.
> >
> > In case of the ALSA plugin you can use it to connect to the default
> > headset or using a specific remote device address. This all works in the
> > background and yes, if you get the hint listing right it would show up
> > in applications that can list virtual devices. However the .asoundrc is
> > user specific and not touched by the audio daemon. The daemon is a
> > system process that can handle multiple headsets at one time which could
> > be used by different users on the same system.
> >
> > So for the audio daemon, we don't know anything about the user and its
> > settings and we actually don't care at all. We know that we have a
> > configured device that can be used via the ALSA plugin with this
> > specific Bluetooth address. That is what we know and that is what we
> > will give to HAL. What the user does with this information is fully up
> > to the user and not the daemons responsibility.
> >
> > This means whatever kind of hint system you have or don't have, it
> > doesn't give us any advantage. Please remember that virtual sounds cards
> > are totally dynamic. They come and go as they like. The daemon is fully
> > integrated into the Bluetooth authorization framework and for example a
> > headset can decide to connect back to your machine when you press its
> > button and it becomes available and usable at exactly that point.
> > The .asoundrc is to static for this. The only unique identifier that can
> > be used to identify a Bluetooth headset is its address. The profile to
> > use (mono or stereo) can be a second parameter, but the daemon can
> > determine the best profile to use by itself.
> 
> Thanks a lot. I think I understand the issue a bit better now.
> 
> Questions:
> - the entry in .asoundrc as documented on 
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices#Alsaconfiguration is optional
> - using the ALSA plugin a bluetooth audio device can always (when it's 
> connected and authorized) be accessed 
> using "bluetooth:<address>[,parameter]"?

the .asoundrc is optional. It is more a convenient file to set the
default PCM or friendly PCM names in case you use aplay etc. You can
always specify the plugin name and its parameters.

In case of Bluetooth this means we will even auto-connect to that device
if not connected. At some point you even be able to use it even if not
connected. In this case you will hear and get silence.

> If that is so, then I suggest to list a bluetooth device advertising its audio 
> capabilities (this possibly means to say what parameters are supported) and 
> its address. Then an application can construct the ALSA "device" string 
> itself or, if it has the support, use that information to talk with the 
> bluetooth device directly.
> 
> That would mean those devices don't show up as ALSA devices in HAL at all.

And why shouldn't they show up as ALSA device? They are ALSA devices.
You must realize that Bluetooth is only a transport. And yes, we can
export Bluetooth devices with audio attributes in HAL. We will actually
do this at some point in a really generic way, but that doesn't help in
this case.

The extended ALSA syntax is a way to help applications to find a
possible sound device. If you separate device by transport then every
application needs to be changed to find Bluetooth devices. Why should
they know about it. The application wants to use ALSA for sound input
and output. So they ask HAL for an ALSA device. If this happens to be
using Bluetooth. Who cares? The application certainly doesn't.

While Bluetooth has always been the first technology pushing for changes
in various subsystem, it will not be the last. So having a generic way
for notifying about virtual sound cards and giving an ALSA device string
to the application that will do the right thing is the correct approach.
Otherwise you have to change applications again, when Wireless USB,
Ultra-wideband or whatever comes along and allows sound input and output
over virtual hardware.

Regards

Marcel


_______________________________________________
hal mailing list
hal@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/hal
