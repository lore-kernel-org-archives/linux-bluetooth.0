Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42381DAA.20703@sinister.cz>
From: Trekie <trekie@sinister.cz>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MS-6871 isn't working
References: <42381514.3070701@sinister.cz>	 <1110971745.9818.131.camel@pegasus>  <423818DE.1060909@sinister.cz> <1110973336.9818.141.camel@pegasus>
In-Reply-To: <1110973336.9818.141.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 16 Mar 2005 12:51:06 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcel,

|>Maybe bluetooth is connected to that USB hub, but I can't do anything
|>with it. I can do almost whatever you say to make it working.
|
|
| we have seen this problems, but I don't know what's the real problem
| behind it. I assume some USB related stuff. What kernel version do you
| use? What USB host controller is this (lspci)?

kernel is 2.6.10 with gentoo patchset (2.6.10-gentoo-r6) and lspci shows
this:

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB
2.0 EHCI Controller (rev 03)


Regards

David
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCOB2pMcA3II2AlaIRAlirAKDVr11eEd/zQcGjH8kI5Z4uNPJjYgCfUSx9
NmIXCTWekQlq4O9keKWEWTY=
=uhGD
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
