Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4118E14F.6090100@superbug.demon.co.uk>
Date: Tue, 10 Aug 2004 15:53:03 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   snd-bt-sco@corinis.net
Subject: Re: [Bluez-devel] snd-bt-sco development teamup | ALSA connection
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>	 <1092140041.4564.96.camel@pegasus>  <4118C5FC.1050502@dark-reality.de> <1092145515.4564.143.camel@pegasus>
In-Reply-To: <1092145515.4564.143.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Now from the alsa point of view.

Marcel Holtmann wrote:
> Hi Lars,
> 
> 
>>| Lets connect the SCO channel throught the socket interface and then tell
>>| the kernel via an IOCTL to change this into an ALSA device. We do the
>>| same for RFCOMM where we convert a socket into a TTY.
>>|
>>| Most of the snd-bt-sco source will be useless, because it handles the in
>>| kernel socket programming and you don't need that inside the SCO module.
>>
>>yes, of course, the basic connection handling will change. But we alsa
>>has some registration issues like, what encodings are supported, volume
>>change hooks and stuff.
>>
>>I think we'll get the following [correct me if I'm wrong]:
>>
>>BlueZ stuff:
>>- - connection handling (should this be solved like in the hidd daemon?)
> 
> 
> the connection handling is the AT based stuff of the headset or
> handsfree profile and that can be done in a headset/handsfree profile
> daemon. The hidd is different, because it has to move the L2CAP sockets
> into the kernel space. We don't need this here.
> 
> 
>>- - listening for incoming audio connection requests from the headset
>>(button press)
> 
> 
> It is part of the connection handling, because button press is an AT
> event on the RFCOMM channel.
Agreed, not anything alsa can do about it either. If a connection comes 
from the headset, there is no way to channel this information via alsa 
up to the application, so the application has to have a separate control 
channel for these messages. E.g. ON/OFF Hook. But theoretically Volume 
Up/down could be passed, and ON/OFF hook could be passed as a hidden 
mixer control, but for other Bluetooth profiles, where dialed digits are 
passed, there would be not method to pass those through alsa, so, in my 
view, it is better not to use alsa for any of the RFCOMM messages, and 
provice a separate messages link to the application for those.

> 
> 
>>- - listening for server audio connection requests from alsa
> 
> 
> This is also connection handling stuff. In this case you must wait for
> an incoming SCO connection (HS case). For the AG case you are in charge
> to create the SCO link.
So, you are suggesting that an app, opening an alsa pcm device should 
automatically link up the RFCOMM channel etc, and be able to send sound 
to a headset. That is unworkable for a number of different reasons. One 
being that the app that opens the alsa pcm device should also be 
controlling the RFCOMM channel separately, for reasons I gave above.

> 
> 
>>- - opening SCO connection, creating an alsa compatible device
> 
> 
> The same. Creating the ALSA device is only an IOCTL away. You should
> take a look at the source code of the rfcomm program to see how this is
> done for RFCOMM TTY devices.

The creation of an alsa device name should be linked to which bluetooth 
device it is talking to. For example, once a pairing is set up, the user 
application can always talk to the same alsa device name to send sound 
to the headset, for every call to that headset. I.E. link alsa device 
name to pairing, and not create a new one for each RFCOMM connection.
E.g. All SCO connectionns to headset A be called ./pcm0p/sub0 & 
./pcm0c/sub0.
All SCO connections to headset B be called  ./pcm1p/sub0 & ./pcm1c/sub0.

It is possible for an user space application to specifically use pcm0 or 
pcm1, so that information could be passed from bluez to tell the 
application which device to use for this call.

> 
> 
>>Alsa stuff:
>>- -provide alsa information like supported audio encodings
> 
> 
> the current settings of the SCO links are stored as voice_setting in the
> hci_dev structure.

alsa provides detailed ways for hardware to inform alsa which formats 
the hardware can do. This information can be reset each time the alsa 
pcm device is opened. alsa-lib will then automatically do format 
conversion between the user application and what the hardware can do.
So, if a blues interface fixes all SCO connections to format X, but then 
the format changes, alsa will sense that the next time a pcm device is 
opened.

> 
> 
>>- -notice the BlueZ module if some program looks for a connection
> 
> 
> If you mean with that when someone opens the DSP device we should create
> the connection, then this will fail. The RFCOMM channel must be created
> first and this is part of the connection handling from userspace. The
> kernel can't do anything here.

Agreed, some of the reasons for this are explained above.

> 
> 
>>It would be great if a device (headset) could be connected somehow
>>(tool) manually like hidd --connect <BTADDR>; in this case, an RFCOMM
>>connection will be build.
>>
>>The bluez module than notices the alsa module that there spawned a new
>>device, telling alsa module what codecs to propagate (this should be
>>possible because something similar works for usb audio stuff with
>>hotplugging).
> 
> 
> The general workflow should be something like this:
> 
> 	- create RFCOMM channel and start AT handling
> 	- create SCO socket if needed
> 	- issue ioctl to make SCO socket an ALSA device

Could the SCO socket be open and closed when the alsa pcm device is 
opened and closed? Of course the SCO socket will fail to open, unless 
the user space application has previously set up the RFCOMM channel.
The alsa api process goes:
open, set params, prepare, start...pass sound samples...stop, close.
It would be nice if SCO packets only happened at the "start" point, the 
ceased at the "stop" point.

> 
> At this point the SCO packets would go from the HCI device to the ALSA
> layer without userspace intervention and the userspace program has only
> to take care of the AT handling.
> 
> 
>>I see some problems when an application opens and closes the audio
>>channel rapidly (gnomemeeting does this when playing the ring sound);
>>maybe we could implement something like a release timeout before the SCO
>>connection is truely terminated.
>>
>>My mein issue with the current implementation is that if no SCO
>>connection is open, the audio device is simply blocked. Bad habit; it
>>must look transparent for the application, whether there is a BT headset
>>connected to the stack or not, the device should be available (I think).
>>Most programs check device state on startup, and the headset might not
>>be connected at that time by the user.

That is difficult, so you want to setup a link to the headset, start 
playing sound, the headset goes out of range and the RFCOMM link times 
out. But later the headset comes into range, and you want the headset
to start playing sound again, and during this time, the application can 
happily keep sending samples to the alsa pcm device?
As Marcel says...not easy.

> 
> 
> This is not as easy as you think. Lets discuss this later.
> 
> Regards
> 
> Marcel
> 
