Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4327D66A.1030304@cefriel.it>
From: Luca Pizzamiglio <pizzamiglio@cefriel.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] SCO & btsco
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
Date: Wed, 14 Sep 2005 09:51:06 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi to all.

I'm using btsco with a headset and it works very well.
Now I'm trying to record audio from another bt device (es. a phone):
using socket SCO interface I read data and I write it in a file (sound.raw);
I'm trying to understand what audio formats I receive.

bt specification says that bluetooth supports three audio formats:
- - CVSD
- - u-law
- - a-law

hciconfig hci0 voice command reports:

hci0:   Type: USB
        BD Address: 00:09:DD:10:4C:C6 ACL MTU: 192:8 SCO MTU: 64:8
        Voice setting: 0x0060 (Default Condition)
        Input Coding: Linear
        Input Data Format: 2's complement
        Input Sample Size: 16 bit
        # of bits padding at MSB: 0
        Air Coding Format: CVSD

I see from btsco sources that btsco support only mu-law format (it is a
comment), but the code check if voice setting is equal to 0x0060 (CVSD).
So, btsco support CVSD? There's a CVSD codec in btsco source code or I
have to implement a Bluez CVSD codec?

Cheers,
Pizza

- -------------------------------------------
Luca Pizzamiglio
CEFRIEL - Embedded Systems Design Unit
Via Fucini, 2 - 20133 MILANO (ITALY)
Phone:		+39 02 23954 343
e-mail:		pizzamiglio@cefriel.it
ICQ:		5046978
- -------------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDJ9ZqAoUy56ORfbERAiCgAJ99Bu1+gXGwGnaoigrmtlQCziMWJQCfVtMc
K7t5kgaiP17l2Q4uivDMQvE=
=KAmk
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
