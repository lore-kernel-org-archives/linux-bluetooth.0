Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41180E64.1010007@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus>  <4117C0AB.2010609@superbug.demon.co.uk> <1092090364.4564.46.camel@pegasus>
In-Reply-To: <1092090364.4564.46.camel@pegasus>
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
Date: Tue, 10 Aug 2004 01:53:08 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:

|>To summarise, we need low latency, full duplex, and to provide that, we
|>need to accurately be able to determine and control the buffer sizes.
|>The current bluetooth stack has no api to help us in this regard, and
|>therefore will not work very well.
|
|
| Actually you think that we need it, but I am still not sure that this is
| really needed in case of the concept of the SCO packet from the HCI and
| the SCO handling that is done on link manager/chip level. However you
| can still convince me with real code.

I have to agree with Marcel here. I've been using snd-bt-sco for a while
now with my HBH-35 Sony Ericsson Headset, and it works pretty well. Of
course I don't know much about how audio is processed here, but the
snd-bt-sco layer simply connects the sco socket to the alsa audio
socket. There's not much stuff about full duplex or low latency done,
I'm pretty sure I'd have noticed.

Of course this is useless if you want to do, say, proper audio handling
in a way ProTools would do it, but for VoIP and Gateway phone I never
had much of a problem.

If audio latency could be reduced (I'd estimate it at about 250ms-400ms
for input->output loopback) it would be a nice enhancement, but I won't
state that "this can't be done with current Bluez".

I'm just not really sure where to start now ;)

Marcel, what exactly do you mean by "implementing an alsa interface"?
Should there be an interface [like SCO] that is than accessed by an
additional alsa driver?

Maybe it would be possible to use some of the snd-bt-sco code here,
because only the userspace daemon that "wraps" the sound sockets
together must be "integrated" (well, it's functionality) into BlueZ,
while the snd-bt-sco alsa driver could remain nearly the same, just
accessing the BlueZ/alsa interface instead of BlueZ/SCO?

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGA5kQWC6DTWkDAoRAv1rAKCiObAKyOieEGVYQXaXUL/miJoRhQCePGgG
ccqZc1X2B3oRPW+WvLrSD6c=
=pgzQ
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
