Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4118CBFE.1070404@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>  <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>  <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>  <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>  <1092140041.4564.96.camel@pegasus>  <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk> <1092143505.4564.117.camel@pegasus> <Pine.LNX.4.59.9999.0408101412470.22497@brava.dcs.gla.ac.uk>
In-Reply-To: <Pine.LNX.4.59.9999.0408101412470.22497@brava.dcs.gla.ac.uk>
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
Date: Tue, 10 Aug 2004 15:22:06 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jonathan Paisley wrote:

| I haven't been keeping track of ALSA development recently. It sounds
| like you're saying that the API is going to be changing enough that
| simple modifications to the existing ALSA-interfacing code in snd-bt-sco
| will not be enough to keep it up to date. Does this mean it would be
| worth putting a hold on development of a properly-bluez-integrated
| driver until the ALSA subsystem has stabilised?

possibly, I don't know that their status is either. snd-bt-sco compiles
nice with kernel 2.6.7 (well nice... at least it does (Niko)) and also
with alsa-driver-1.0.5a (myself)...

I'll try to take the time to read through the alsa dev information to
find out what's going on there, but Marcel will be much more in touch
with the kernel-related stuff.

At least I managed to get and look into the headset profile, that
already helped much to clear things up :)

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGMv9QWC6DTWkDAoRAlCXAJwMq2qXbuqm2+zKqN2MSGKvb73mjgCbB7zw
8TqZ9t4iMRlrOk7oWiJ5QOo=
=aO9i
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
