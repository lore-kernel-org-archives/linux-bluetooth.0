Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup | ALSA connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   snd-bt-sco@corinis.net
In-Reply-To: <4118C5FC.1050502@dark-reality.de>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>
	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
	 <1092140041.4564.96.camel@pegasus>  <4118C5FC.1050502@dark-reality.de>
Content-Type: text/plain
Message-Id: <1092145515.4564.143.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 Aug 2004 15:45:16 +0200

Hi Lars,

> | Lets connect the SCO channel throught the socket interface and then tell
> | the kernel via an IOCTL to change this into an ALSA device. We do the
> | same for RFCOMM where we convert a socket into a TTY.
> |
> | Most of the snd-bt-sco source will be useless, because it handles the in
> | kernel socket programming and you don't need that inside the SCO module.
> 
> yes, of course, the basic connection handling will change. But we alsa
> has some registration issues like, what encodings are supported, volume
> change hooks and stuff.
> 
> I think we'll get the following [correct me if I'm wrong]:
> 
> BlueZ stuff:
> - - connection handling (should this be solved like in the hidd daemon?)

the connection handling is the AT based stuff of the headset or
handsfree profile and that can be done in a headset/handsfree profile
daemon. The hidd is different, because it has to move the L2CAP sockets
into the kernel space. We don't need this here.

> - - listening for incoming audio connection requests from the headset
> (button press)

It is part of the connection handling, because button press is an AT
event on the RFCOMM channel.

> - - listening for server audio connection requests from alsa

This is also connection handling stuff. In this case you must wait for
an incoming SCO connection (HS case). For the AG case you are in charge
to create the SCO link.

> - - opening SCO connection, creating an alsa compatible device

The same. Creating the ALSA device is only an IOCTL away. You should
take a look at the source code of the rfcomm program to see how this is
done for RFCOMM TTY devices.

> Alsa stuff:
> - -provide alsa information like supported audio encodings

the current settings of the SCO links are stored as voice_setting in the
hci_dev structure.

> - -notice the BlueZ module if some program looks for a connection

If you mean with that when someone opens the DSP device we should create
the connection, then this will fail. The RFCOMM channel must be created
first and this is part of the connection handling from userspace. The
kernel can't do anything here.

> It would be great if a device (headset) could be connected somehow
> (tool) manually like hidd --connect <BTADDR>; in this case, an RFCOMM
> connection will be build.
> 
> The bluez module than notices the alsa module that there spawned a new
> device, telling alsa module what codecs to propagate (this should be
> possible because something similar works for usb audio stuff with
> hotplugging).

The general workflow should be something like this:

	- create RFCOMM channel and start AT handling
	- create SCO socket if needed
	- issue ioctl to make SCO socket an ALSA device

At this point the SCO packets would go from the HCI device to the ALSA
layer without userspace intervention and the userspace program has only
to take care of the AT handling.

> I see some problems when an application opens and closes the audio
> channel rapidly (gnomemeeting does this when playing the ring sound);
> maybe we could implement something like a release timeout before the SCO
> connection is truely terminated.
> 
> My mein issue with the current implementation is that if no SCO
> connection is open, the audio device is simply blocked. Bad habit; it
> must look transparent for the application, whether there is a BT headset
> connected to the stack or not, the device should be available (I think).
> Most programs check device state on startup, and the headset might not
> be connected at that time by the user.

This is not as easy as you think. Lets discuss this later.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
