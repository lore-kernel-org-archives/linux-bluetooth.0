Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup | ALSA connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4118D9ED.4030705@dark-reality.de>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>
	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
	 <1092140041.4564.96.camel@pegasus>  <4118C5FC.1050502@dark-reality.de>
	 <1092145515.4564.143.camel@pegasus>  <4118D9ED.4030705@dark-reality.de>
Content-Type: text/plain
Message-Id: <1092150078.4564.178.camel@pegasus>
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
Date: Tue, 10 Aug 2004 17:01:18 +0200

Hi Lars,

> Please, let me try it again:

ok, lets start over ;)

> [STRUCTURE]
> 
> so we get three parts, bluez kernel (BZ), user space daemon (USD) and
> alsa driver (AD).
> 
> kernel/bluez kernel stuff (BZ):
> This part resides in the kernel. It already does. It handles what
> happens to the devices, i.e. converts the SCO device into an alsa device
> node on request. It builds (not requests!) the connections for RFCOMM
> and SCO (of course, that is what it does now too).
> 
> user space daemon (USD):
> requests headset RFCOMM connect (from the user, like "bthsd --connect
> <BTADDR>" or something alike, just an example) and handles the AT
> commands. This is what our btsco program does right now, but I'd like to
> have a real daemon here that is once started and then runs totally in
> the background. Most AT handling that is needed is already implemented.
> 
> alsa driver (AD):
> the alsa-specific stuff, like reporting to alsa applications what
> channels exist, what audio props they have and so on

actually only two parts are needed. The SCO kernel driver and a headset
userspace daemon.

The SCO module register the SCO socket and register for handling SCO
packets with the BlueZ core. The SCO raw socket can be used for control
other things. It can also register the ALSA device, because most stuff
will be only moving data packets from the BlueZ core to ALSA and vice
versa. So the SCO module will depend on the ALSA and BlueZ core.

The other part is the userspace daemon that includes the SDP, RFCOMM, AT
handling, ALSA setup etc.

> [INTEROPERABILITY]
> 
> There are two main sources that may demand things and that must be
> supported:
> 1. the headset: if the user presses the button, an AT is send. This must
> be caught by USD, that opens the SCO connection in the usual way. Now
> some ioctl kernel mojo happens to make the SCO connection usable for
> alsa programs (I'm not sure how it works, but is sounds easy)
> 
> 2. the AD itself: a program might open the audio channel, than the AD
> must notice the USD (or BZ?) to ring the headset bell so the user
> notices, or open the SCO channel directly, depending on configuration;
> also we must be able to change volume and stuff.
> 
> those two must be able to communicate in some way. The HS sends AT
> commands that are handled by the USD, but how can the alsa driver i.e.
> request an channel open? Or, from whom (USD or BZ?)

If it is possible to poll the ALSA hwdep in some way this will be
possible, but you must remeber that every kernel releated stuff will
never be profile related. The kernel stuff is about protocol and all
profile specific parts are done in userspace.

> Of course it's not that easy, but concerning the device existing problem
> the device is reported by the alsa driver, and that one does not depend
> on an existing RFCOMM connection or something, so it should be possible
> to load the "snd-bt-sco" alsa module (like it is now) so the program
> thinks that the driver exists. Audio data should be taken from /dev/null
> or something alike to make sure the application does not break when
> trying to access the dummy device.

Every SCO link depend on an existing ACL connection. In case of the
headset and handsfree profiles these means no SCO link without the
RFCOMM connection.

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
