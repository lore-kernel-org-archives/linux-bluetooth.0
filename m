Return-Path: <hal-bounces@lists.freedesktop.org>
Subject: Re: [patch] spec: Update alsa namespace to include virtual device
From: Marcel Holtmann <marcel@holtmann.org>
To: Lennart Poettering <mzuny@0pointer.de>
In-Reply-To: <20070827141144.GA3190@tango.0pointer.de>
References: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
	<20070827141144.GA3190@tango.0pointer.de>
Date: Mon, 27 Aug 2007 16:34:47 +0200
Message-Id: <1188225287.15402.324.camel@violet>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
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

Hi Lennart,

> > Thanks to the great work of Bluez-guys, bluez-utils audio service is
> > now able to deal with several audio devices. Those Bluetooth devices
> > are accessed by a "bluetooth" ALSA plugin (see
> > http://wiki.bluez.org/wiki/HOWTO/AudioDevices)
> > 
> > There is only a few missing pieces to make those devices discoverable with HAL.
> > 
> > The following patch changes the "alsa" namespace so that "virtual
> > devices" can also be described (a former approach was to use
> > alsa.virtual or alsa_virtual new namespace, but alsa.virtual does not
> > inherit alsa property, and both namespaces have a lot in common).
> 
> Uh oh. I am not convinced that adding "virtual" devices to the HAL
> tree is a good idea. I mean, bt is basically a transport protocol and
> audio-over-bt just a service offered via bt. I mean, you wouldn't want
> to include all Avahi-found hw devices in the HAL tree, would you?
> 
> Let's keep services out of HAL. HAL should be for hw devices only.  Of
> course, it is difficult to draw the line here.

Bluetooth is meant as cable replacement and in the same way as with
Wireless USB in the near future we do have a virtual cable between these
devices. The problem here is to export these information in a fully
generic way since the kernel doesn't know about them (compared to USB
and PCI for example). Our Bluetooth audio service has all the
information about configured audio headsets available, but HAL doesn't.
This means that all the audio applications don't see any Bluetooth
headsets until they include code to discover them via our audio service.
We don't want that, because it would mean that we have to touch every
audio application which is not needed. They don't care how it makes
sounds as long as they hear something.

As you said, Bluetooth is only a transport. It is like USB, PCI or
anything else we consider physically attached. There is no difference
here except that the physical connection is a radio. We try to make this
as transparent as possible. Meaning we auto-connect, re-connect etc. in
the background so that applications don't even have to care at all. To
make this work, Bluetooth has to look like any other hardware device.

At some point in the future we gonna integrate Bluetooth much deeper
into HAL as currently done. Right now we only see the kernel side of
Bluetooth represented in HAL. This needs some restructure to make it
work smoothly and needs some extra time, but we are getting there.

> OTOH i must say that this would make it very easy for me to add bt
> support to PA, so I am not inherently opposed. However, I don't really
> think going through ALSA for bt audio makes too much sense for PA. It
> is probably better to integrate bt and PA directly, without having
> this unnecessary abstraction in between.

I am currently working on the GStreamer sink. If you provide an exported
plugin API for PulseAudio, you can have that easily. Otherwise it might
not happen.

Regards

Marcel


_______________________________________________
hal mailing list
hal@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/hal
