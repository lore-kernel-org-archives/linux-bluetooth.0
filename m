Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4118C5FC.1050502@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Cc: snd-bt-sco@corinis.net
Subject: Re: [Bluez-devel] snd-bt-sco development teamup | ALSA connection
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de> <1092140041.4564.96.camel@pegasus>
In-Reply-To: <1092140041.4564.96.camel@pegasus>
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
Date: Tue, 10 Aug 2004 14:56:28 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:

|>Marcel, what exactly do you mean by "implementing an alsa interface"?
|>Should there be an interface [like SCO] that is than accessed by an
|>additional alsa driver?
|>
|>Maybe it would be possible to use some of the snd-bt-sco code here,
|>because only the userspace daemon that "wraps" the sound sockets
|>together must be "integrated" (well, it's functionality) into BlueZ,
|>while the snd-bt-sco alsa driver could remain nearly the same, just
|>accessing the BlueZ/alsa interface instead of BlueZ/SCO?
|
|
| Lets connect the SCO channel throught the socket interface and then tell
| the kernel via an IOCTL to change this into an ALSA device. We do the
| same for RFCOMM where we convert a socket into a TTY.
|
| Most of the snd-bt-sco source will be useless, because it handles the in
| kernel socket programming and you don't need that inside the SCO module.

yes, of course, the basic connection handling will change. But we alsa
has some registration issues like, what encodings are supported, volume
change hooks and stuff.

I think we'll get the following [correct me if I'm wrong]:

BlueZ stuff:
- - connection handling (should this be solved like in the hidd daemon?)
- - listening for incoming audio connection requests from the headset
(button press)
- - listening for server audio connection requests from alsa
- - opening SCO connection, creating an alsa compatible device

Alsa stuff:
- -provide alsa information like supported audio encodings
- -notice the BlueZ module if some program looks for a connection

It would be great if a device (headset) could be connected somehow
(tool) manually like hidd --connect <BTADDR>; in this case, an RFCOMM
connection will be build.

The bluez module than notices the alsa module that there spawned a new
device, telling alsa module what codecs to propagate (this should be
possible because something similar works for usb audio stuff with
hotplugging).

two cases (as they are also described in the Headset Profile):
1. AG connects to HS (like, some program opened our audio device) - ring
the bell so that the user knows there sould be a connection initiated by
pressing the button
2. auto-connect: AG connects to HS, simply build the SCO channel. this
should be an option. Don't wait for user button press (might be
interesting for programs that play a ring sound via audio on the headset)
3. HS connects to AG: build a SCO connection.
4. we should have some (simple) way to tell the audio/bluez interface to
"ring", so that a program like gnomemeeting could be enhanced to use the
bt-internal ring tone for connection request instead of playing a true
audio sound

I see some problems when an application opens and closes the audio
channel rapidly (gnomemeeting does this when playing the ring sound);
maybe we could implement something like a release timeout before the SCO
connection is truely terminated.

My mein issue with the current implementation is that if no SCO
connection is open, the audio device is simply blocked. Bad habit; it
must look transparent for the application, whether there is a BT headset
connected to the stack or not, the device should be available (I think).
Most programs check device state on startup, and the headset might not
be connected at that time by the user.

just my 2 cents :)
- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGMX8QWC6DTWkDAoRAoJDAKCKU8X5/ksEJjEXohjZ3U68P8TaIwCeIgB9
MMsXRaxv6JRFVnUiRDu+5a4=
=/w2t
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
