Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AB1804.8070807@Uni-Bielefeld.de>
From: Nick <Nick.Thomas@Uni-Bielefeld.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hello
References: <41AA81F0.8080005@bielefeld.ccc.de> <1101694796.9527.13.camel@pegasus>
In-Reply-To: <1101694796.9527.13.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 29 Nov 2004 13:37:24 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


|
| check with "hciconfig hci0 revision" (as root) for the setting of
| the SCO routing. I think it is set to PCM.

you were right:

(0:1)root@Muramasa:~$ hciconfig hci0 revision
hci0:   Type: USB
~        BD Address: 00:60:57:02:95:FE ACL MTU: 192:8  SCO MTU: 64:8
~        HCI 12.7
~        Chip version: BlueCore01b
~        SCO mapping:  PCM

so, is that the way it should be?


~    ,nick

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBqxgE40bmwXROfRURAvqRAKDsXeO6wiHySifzPpDzAh8sIOBT6ACeJELH
cVbkAU1OiN0vPgXBjvcpzpg=
=lamt
-----END PGP SIGNATURE-----



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
