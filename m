Return-Path: <hal-bounces@lists.freedesktop.org>
Date: Mon, 27 Aug 2007 16:11:45 +0200
From: Lennart Poettering <mzuny@0pointer.de>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [patch] spec: Update alsa namespace to include virtual device
Message-ID: <20070827141144.GA3190@tango.0pointer.de>
References: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>,
        hal@lists.freedesktop.org
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 23.08.07 19:22, Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wr=
ote:

> Hi
> =

> Thanks to the great work of Bluez-guys, bluez-utils audio service is
> now able to deal with several audio devices. Those Bluetooth devices
> are accessed by a "bluetooth" ALSA plugin (see
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices)
> =

> There is only a few missing pieces to make those devices discoverable wit=
h HAL.
> =

> The following patch changes the "alsa" namespace so that "virtual
> devices" can also be described (a former approach was to use
> alsa.virtual or alsa_virtual new namespace, but alsa.virtual does not
> inherit alsa property, and both namespaces have a lot in common).

Uh oh. I am not convinced that adding "virtual" devices to the HAL
tree is a good idea. I mean, bt is basically a transport protocol and
audio-over-bt just a service offered via bt. I mean, you wouldn't want
to include all Avahi-found hw devices in the HAL tree, would you?

Let's keep services out of HAL. HAL should be for hw devices only.  Of
course, it is difficult to draw the line here.

OTOH i must say that this would make it very easy for me to add bt
support to PA, so I am not inherently opposed. However, I don't really
think going through ALSA for bt audio makes too much sense for PA. It
is probably better to integrate bt and PA directly, without having
this unnecessary abstraction in between.

> Thus, a  mandatory property "is_hardware" is introduced. If this value
> is true, the current mandatory keys remain mandatory. If not, then the
> client should use "device_name" to "open" the device.
> =

> Arguable:
> - should "device_name" be optional? (currently, application hard-code
> the prefix "hw")

Hmm. I don't think "device_name" makes sense. For example, if one is
interested in surround audio one has to open the device as
surround51:0, or if one wants spdif one has to open it as iec985:0. The
prefix "hw:" is only relevant for stereo analog outputs. =


What I would like to see is that the ALSA devices in HAL would export
a property which tells us which prefixes make sense. I.e. one that
tells me in advance that a device is capable of surround sound, or has
a SPDIF output.

Lennart

-- =

Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
_______________________________________________
hal mailing list
hal@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/hal
