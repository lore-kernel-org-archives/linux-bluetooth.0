Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <421D9F51.80905@nue.et-inf.uni-siegen.de>
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: jjia@cs.ubc.ca
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pan and brctl addif question
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 24 Feb 2005 10:33:05 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jack,

| Sorry to keep asking hciemu related question. The reason I like
| hciemu so much is not only I am poor  :-) , but also I was supposed
| to set up a virtual environment of multiple piconets, so my team
| members can play around with some scatternet routing stuff. I've seen
| someone from this list achieved that. Now, I am following the Pan
| Howto, but I have some problems:
|
| 1. After running
|
| #pand -s -r GN -i 7F:00:00:01:00:0A #pand -i 7F:00:00:01:00:0B -c
| 7F:00:00:01:00:0A
|
| I am hoping 7F:00:00:01:00:0A to be GN, and 7F:00:00:01:00:0B to be
| PANU, but when I run pand -l, I got the following:
|
| bnep1 7F:00:00:01:00:0B GN bnep0 7F:00:00:01:00:0A PANU
|
| So, it seems 7F:00:00:01:00:0B being GN
|
| 2. I cannot add bnepX to pan0 using brctl, although I can add my eth0
| to it. After running:
|
| #brctl addif pan0 bnep0
|
| I got:
|
| can't add bnep0 to bridge pan0: Cannot assign requested address

Besides possible other problems of PAN operation with hciemu (that I'm
not aware of), you'll definitely get into trouble using BT device
addresses that start with '7F'. Bits 0 and 1 of the most significant
byte of the device address have a special significance:

One of them determines whether the address is a unicast or multicast
(when set) address. The other one determines whether the address has a
local (when set) or global scope. BT device addresses conform with the
IEEE 802 MAC address specification (you may want to do a web search on
this), where this is defined. With either one set, you'll encounter
trouble with the bridging code (and possibly the BlueZ PAN code?).

Make sure you use addresses where these bits are not set.


Hope this helps,

Michael


- --
============================================
Michael Schmidt
- --------------------------------------------
Institute for Digital Communications Systems
University of Siegen, Germany
- --------------------------------------------
http:   www.dcs.uni-siegen.de
e-mail: schmidt@nue.et-inf.uni-siegen.de
mobile: +49 179 7810214
============================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCHZ9RQxcxBvLsRaoRAqUwAKC/UOGXU6+ZpNNjGN0gSyfv8E7MJACbB8NS
DpNSGRbcWZEb3/pcpH/xfsw=
=S97v
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
