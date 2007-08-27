Return-Path: <hal-bounces@lists.freedesktop.org>
Subject: Re: [patch] spec: Update alsa namespace to include virtual device
From: Marcel Holtmann <marcel@holtmann.org>
To: Lennart Poettering <mzuny@0pointer.de>
In-Reply-To: <20070827144720.GA6448@tango.0pointer.de>
References: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
	<20070827141144.GA3190@tango.0pointer.de>
	<1188225287.15402.324.camel@violet>
	<20070827144720.GA6448@tango.0pointer.de>
Date: Mon, 27 Aug 2007 17:09:28 +0200
Message-Id: <1188227368.15402.336.camel@violet>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>,
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

> > At some point in the future we gonna integrate Bluetooth much deeper
> > into HAL as currently done. Right now we only see the kernel side of
> > Bluetooth represented in HAL. This needs some restructure to make it
> > work smoothly and needs some extra time, but we are getting there.
> 
> If the bt devices are exported in sysfs in the kernel already it is no
> longer hal that synthesizes them. Which makes these things much
> cleaner I would say.
> 
> Synthesizing virtual devices at the HAL level doesn't look like such a
> good idea to me, smells kludgy. But doing this on a lower level might
> make sense.

the physical link (the piconet connection) is exported via the kernel
and visible via sysfs. If you run RFCOMM (serial port), BNEP (network)
or HIDP (input) over it then it links it together. If the protocol runs
in userspace like A2DP for stereo headsets then the kernel knows nothing
about it and can't link it together. This also means that HAL can't do
anything about it since it lacks these information.

In the overall end there should be no difference in a physical sound
card or a virtual one that use Bluetooth (or Wireless USB or whatever).
The only big difference is actually that these are connected or
disconnected. It is more than hotplug since we can virtually plugin
these devices by connecting to them. And so on. Not really trivial to
solve. My current goal is the less userspace application need to know
the better.

> > > OTOH i must say that this would make it very easy for me to add bt
> > > support to PA, so I am not inherently opposed. However, I don't really
> > > think going through ALSA for bt audio makes too much sense for PA. It
> > > is probably better to integrate bt and PA directly, without having
> > > this unnecessary abstraction in between.
> > 
> > I am currently working on the GStreamer sink. If you provide an exported
> > plugin API for PulseAudio, you can have that easily. Otherwise it might
> > not happen.
> 
> A stable plugin API is not going to happen anytime soon, sorry. Also,
> it is not really practical to develop plugins out-of-tree. I
> acknowledge the demand for it, but the plugin API is just too quickly
> moving.
> 
> Hmm, I'd love to add proper BT support to PA myself, but unfortunately
> I lack the hardware for it. It would be much easier to keep it up to
> date for me then.

We are in a chicken-egg situation here. To write a plugin you need to
use our SBC encoder and our IPC. Both of them are internal only.

Regards

Marcel


_______________________________________________
hal mailing list
hal@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/hal
