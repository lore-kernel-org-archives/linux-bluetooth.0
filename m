Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4118F1AC.7070200@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco development teamup | ALSA connection
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>	 <1092140041.4564.96.camel@pegasus>  <4118C5FC.1050502@dark-reality.de>	 <1092145515.4564.143.camel@pegasus>  <4118D9ED.4030705@dark-reality.de> <1092150078.4564.178.camel@pegasus>
In-Reply-To: <1092150078.4564.178.camel@pegasus>
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
Date: Tue, 10 Aug 2004 18:02:52 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
| Hi Lars,
|
|>[STRUCTURE]
|>
|>so we get three parts, bluez kernel (BZ), user space daemon (USD) and
|>alsa driver (AD).
|
| actually only two parts are needed. The SCO kernel driver and a headset
| userspace daemon.
|
| The SCO module register the SCO socket and register for handling SCO
| packets with the BlueZ core. The SCO raw socket can be used for control
| other things. It can also register the ALSA device, because most stuff
| will be only moving data packets from the BlueZ core to ALSA and vice
| versa. So the SCO module will depend on the ALSA and BlueZ core.
|
| The other part is the userspace daemon that includes the SDP, RFCOMM, AT
| handling, ALSA setup etc.

hm, I can't say I agree. Maybe I'm just ignorant so I can't follow you here.

The advantage of splitting BZ kernel and alsa driver would be gaining
flexibility (i.e. people like me who can't use kernel alsa could stick
to alsa-driver...)

Of course I don't know that much about the internal processes, so if you
say it's a lot easier implemented like you propose, we should go for it.
I just find the idea strange to get an alsa sound device without loading
an alsa sound module - but after all the sco module will cover this, so
why not *shrug*.

|
|>[INTEROPERABILITY]
|>
|>There are two main sources that may demand things and that must be
|>supported:
|>1. the headset: if the user presses the button, an AT is send. This must
|>be caught by USD, that opens the SCO connection in the usual way. Now
|>some ioctl kernel mojo happens to make the SCO connection usable for
|>alsa programs (I'm not sure how it works, but is sounds easy)
|>
|>2. the AD itself: a program might open the audio channel, than the AD
|>must notice the USD (or BZ?) to ring the headset bell so the user
|>notices, or open the SCO channel directly, depending on configuration;
|>also we must be able to change volume and stuff.
|>
|>those two must be able to communicate in some way. The HS sends AT
|>commands that are handled by the USD, but how can the alsa driver i.e.
|>request an channel open? Or, from whom (USD or BZ?)
|
|
| If it is possible to poll the ALSA hwdep in some way this will be
| possible, but you must remeber that every kernel releated stuff will
| never be profile related. The kernel stuff is about protocol and all
| profile specific parts are done in userspace.

OK, so if we only have two parts, the BZ that handles alsa stuff two and
~ the user space daemon this is simplified because we only need to make
sure that USD and BZ can communicate (there won't be any AD any more ;)

One thing I don't get right now is this:
who of those two takes care of the alsa stuff, the user mode program or
the BZ code? I think of the functions like start/stop playback, get info
etc.pp. - the alsa driver functions. AFAIK an alsa driver must provide
this functions so that an application can use them. Where will they be
located?

|
|
|>Of course it's not that easy, but concerning the device existing problem
|>the device is reported by the alsa driver, and that one does not depend
|>on an existing RFCOMM connection or something
|
| Every SCO link depend on an existing ACL connection. In case of the
| headset and handsfree profiles these means no SCO link without the
| RFCOMM connection.

OK, I think we are not looking at the problem from the same site.

Of course there CAN'T be any SCO link. There can't be an RFCOMM link
either. But we *could* provide an interface that points into outer space
or something, so an application can read and write data to and from this
interface if no headset is present.

I don't know that much about simulating an audio socket (this is what
I'm talking about I think), and there will be some problems like timing
and stuff. But I think we have to do this anyway for two reasons:

a) I (yes, I :) want to be able to start gnomemeeting, noticing that my
headset is two stairs up. I want to fetch it, tell the userspace thingy
"look my headset <BTADDR>" and I don't want to tell my gnomemeeting that
it has to look again for audio interfaces. I think this would be a
feature and possible to achieve

b) again, just me: with the current solution the audio application locks
up if there is no open SCO socket available. Of course this is stupid,
and we'll have to address this if we want to have a solution for the "AG
requests connection [by opening alsa sound device for playback]". It's
not proper to lock the application until the user managed to activate
his headset by pressing that little button. Maybe he just wants to
cancel the call.

Sorry for picking at this, but it's important to me.

thanks for all people for your great interest, this looks really
promising :)

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGPGsQWC6DTWkDAoRAjU0AKCLZjNZ9uuwVgVxrYs26fmkgBJk4ACguIw2
qHR0pEXCGQ10rzgMQKmHbnE=
=r4OX
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
