Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4118BEBE.2010505@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] "comlicated" setup - known issues for	hid	and	SCO?
References: <4117A907.7010006@dark-reality.de>	 <1092071597.4564.17.camel@pegasus>  <4117B376.3030507@dark-reality.de>	 <1092073484.4564.32.camel@pegasus>  <4117BA71.5000800@dark-reality.de> <1092090585.4564.51.camel@pegasus>
In-Reply-To: <1092090585.4564.51.camel@pegasus>
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
Date: Tue, 10 Aug 2004 14:25:34 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
| Hi Lars,

| so both devices are in the same piconet. There should be no problem, but
| from my position I can't tell you anything more.

I think this message might have something to do with the problem:

hci_scodata_packet: hci0 SCO packet for unknown connection handle 44

My main problem does not even seem to be connected to the mouse, because
it also happens when the mouse is far far away and not connected.

In about 50% of SCO connections the sound coming from the headset is
totally garbage (not the sound send TO the headset!); I think this might
be connected to another report here on the list when someone mentioned
he had to cut the first byte when recording audio from an SCO channel
(because I'm using 16bit right now, too). This never happend with 8bit
transmissions over SCO.

Any ideas?

Kernel is 2.6.7 with mh4 patch.

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGL6+QWC6DTWkDAoRAl2lAJ4ktMZ3xgDH5euwJmISKE/bM6l4XwCfci3X
kXpVLb9uy8Nwu8qXP5rzBVg=
=qY1P
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
