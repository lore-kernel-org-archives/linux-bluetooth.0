Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4118D9ED.4030705@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco development teamup | ALSA connection
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>	 <1092140041.4564.96.camel@pegasus>  <4118C5FC.1050502@dark-reality.de> <1092145515.4564.143.camel@pegasus>
In-Reply-To: <1092145515.4564.143.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 10 Aug 2004 16:21:33 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
| Hi Lars,
|>BlueZ stuff:
|>- - connection handling (should this be solved like in the hidd daemon?)
|
|
| the connection handling is the AT based stuff of the headset or
| handsfree profile and that can be done in a headset/handsfree profile
| daemon. The hidd is different, because it has to move the L2CAP sockets
| into the kernel space. We don't need this here.

Well, I just ment from the user perspective, and it really looks nearly
identically to me. Of course what happens in the kernel is TOTALLY
different!

I agree with most other stuff you wrote, it was the same that I meant.

|>Alsa stuff:
|>- -provide alsa information like supported audio encodings
|
| the current settings of the SCO links are stored as voice_setting in the
| hci_dev structure.
|

Great. Not usable until the alsa module has read it from hci_dev and
reformatted it, so that an alsa application can make use of this
information. Yes? :)

|>- -notice the BlueZ module if some program looks for a connection
|
| If you mean with that when someone opens the DSP device we should create
| the connection, then this will fail. The RFCOMM channel must be created
| first and this is part of the connection handling from userspace. The
| kernel can't do anything here.

Uh, now this gets complicated. We should try to speak in the same terms.
I'm pretty sure it's my fault, but I'm a bit new to this stuff.

|>It would be great if a device (headset) could be connected somehow
|>(tool) manually like hidd --connect <BTADDR>; in this case, an RFCOMM
|>connection will be build.
|>
|>The bluez module than notices the alsa module that there spawned a new
|>device, telling alsa module what codecs to propagate (this should be
|>possible because something similar works for usb audio stuff with
|>hotplugging).
|
|
| The general workflow should be something like this:
|
| 	- create RFCOMM channel and start AT handling
| 	- create SCO socket if needed
| 	- issue ioctl to make SCO socket an ALSA device
|
| At this point the SCO packets would go from the HCI device to the ALSA
| layer without userspace intervention and the userspace program has only
| to take care of the AT handling.

Yes, that is what I meant, of course. But we should line out who (which
code/program) does what, because this is the main reason for
misunderstanding right now.

Please, let me try it again:

[STRUCTURE]

so we get three parts, bluez kernel (BZ), user space daemon (USD) and
alsa driver (AD).

kernel/bluez kernel stuff (BZ):
This part resides in the kernel. It already does. It handles what
happens to the devices, i.e. converts the SCO device into an alsa device
node on request. It builds (not requests!) the connections for RFCOMM
and SCO (of course, that is what it does now too).

user space daemon (USD):
requests headset RFCOMM connect (from the user, like "bthsd --connect
<BTADDR>" or something alike, just an example) and handles the AT
commands. This is what our btsco program does right now, but I'd like to
have a real daemon here that is once started and then runs totally in
the background. Most AT handling that is needed is already implemented.

alsa driver (AD):
the alsa-specific stuff, like reporting to alsa applications what
channels exist, what audio props they have and so on

[INTEROPERABILITY]

There are two main sources that may demand things and that must be
supported:
1. the headset: if the user presses the button, an AT is send. This must
be caught by USD, that opens the SCO connection in the usual way. Now
some ioctl kernel mojo happens to make the SCO connection usable for
alsa programs (I'm not sure how it works, but is sounds easy)

2. the AD itself: a program might open the audio channel, than the AD
must notice the USD (or BZ?) to ring the headset bell so the user
notices, or open the SCO channel directly, depending on configuration;
also we must be able to change volume and stuff.

those two must be able to communicate in some way. The HS sends AT
commands that are handled by the USD, but how can the alsa driver i.e.
request an channel open? Or, from whom (USD or BZ?)

|>I see some problems when an application opens and closes the audio
|>channel rapidly (gnomemeeting does this when playing the ring sound);
|>maybe we could implement something like a release timeout before the SCO
|>connection is truely terminated.
|>
|>My main issue with the current implementation is that if no SCO
|>connection is open, the audio device is simply blocked. Bad habit; it
|>must look transparent for the application, whether there is a BT headset
|>connected to the stack or not, the device should be available (I think).
|>Most programs check device state on startup, and the headset might not
|>be connected at that time by the user.
|
|
| This is not as easy as you think. Lets discuss this later.

Of course it's not that easy, but concerning the device existing problem
the device is reported by the alsa driver, and that one does not depend
on an existing RFCOMM connection or something, so it should be possible
to load the "snd-bt-sco" alsa module (like it is now) so the program
thinks that the driver exists. Audio data should be taken from /dev/null
or something alike to make sure the application does not break when
trying to access the dummy device.

Of course this should not be our first concern, but I think it's a good
idea to think of such things before beginning development...

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGNnsQWC6DTWkDAoRAvENAJ9bst1uL+oDjFXM/V9ioCzzcklgCgCffTVQ
8FDDQp18ZuM3j3w/KTHvdps=
=gqoc
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
