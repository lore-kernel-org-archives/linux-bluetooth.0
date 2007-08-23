Return-Path: <hal-bounces@lists.freedesktop.org>
Subject: Re: [Bluez-devel] [patch] spec: Update alsa namespace to include
	virtual device
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200708231906.50942.kretz@kde.org>
References: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
	<200708231906.50942.kretz@kde.org>
Date: Thu, 23 Aug 2007 20:20:05 +0200
Message-Id: <1187893205.15402.75.camel@violet>
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

> I don't agree with this approach, i.e. the listing of virtual ALSA devices 
> through HAL, especially the forcing of the device_name. The application might 
> be smarter than HAL, once it knows enough about the hardware. For example the 
> hw: devices in many cases are not what you want...
> 
> Since libasound 1.0.14 we have snd_device_name_hint available to list virtual 
> devices (they get listed once you add a hint section in your .asoundrc file). 
> What we're missing is a way to link virtual devices to hardware, meaning if 
> Hardware "xy" becomes available virtual device "foo" starts to be useful 
> (only "polling" works from what I know).
> 
> So what I'd like to see is something along the lines of:
> - HAL notifies me that a Bluetooth device with audio support became available.
> - With the id I get from HAL I can query libasound which virtual devices are 
> using this device, or if that's not possible iterate over all virtual devices 
> that didn't work before and try to open them and see whether they work now.
> 
> You made the example "bluetooth:00:19:4F:DB:04:40,hifi" in the patch. Is it 
> possible to always access ALSA bluetooth devices that way? Then perhaps the 
> HAL entry on the bluetooth device should list give me the necessary hints to 
> construct that string myself?

when it comes to Bluetooth and other virtual devices with no real
hardware as backend the world changes a bit. You really do have to
change your way of thinking here since ALSA isn't the central place of
information anymore. Actually ALSA has no clue whatsoever.

The Bluetooth audio support is designed around a central audio daemon
that takes care of mono headsets and high quality stereo headsets. This
daemon does all needed protocol handling and can be controlled via
D-Bus. Without this daemon you don't get any sound at all. This daemon
however handles only the control part of the audio protocol. All the
real audio data encoding and decoding is done in a plugin. Besides the
currently existing ALSA plugin, we have plans for GStreamer and
PulseAudio plugins.

In case of the ALSA plugin you can use it to connect to the default
headset or using a specific remote device address. This all works in the
background and yes, if you get the hint listing right it would show up
in applications that can list virtual devices. However the .asoundrc is
user specific and not touched by the audio daemon. The daemon is a
system process that can handle multiple headsets at one time which could
be used by different users on the same system.

So for the audio daemon, we don't know anything about the user and its
settings and we actually don't care at all. We know that we have a
configured device that can be used via the ALSA plugin with this
specific Bluetooth address. That is what we know and that is what we
will give to HAL. What the user does with this information is fully up
to the user and not the daemons responsibility.

This means whatever kind of hint system you have or don't have, it
doesn't give us any advantage. Please remember that virtual sounds cards
are totally dynamic. They come and go as they like. The daemon is fully
integrated into the Bluetooth authorization framework and for example a
headset can decide to connect back to your machine when you press its
button and it becomes available and usable at exactly that point.
The .asoundrc is to static for this. The only unique identifier that can
be used to identify a Bluetooth headset is its address. The profile to
use (mono or stereo) can be a second parameter, but the daemon can
determine the best profile to use by itself.

Regards

Marcel


_______________________________________________
hal mailing list
hal@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/hal
