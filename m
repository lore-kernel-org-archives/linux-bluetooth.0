Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.61.0411011023040.15228@block.bubble>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] MS BT Keyboard problem solved
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 1 Nov 2004 10:26:37 +0100 (CET)

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello everyone,

remember my keyboard which refused to handle the multimedia
buttons, boot mode or not? Well, the solution was easier than
I thought - obviously, once the keyboard is in boot mode, it 
refuses to go back, even if hidd tells otherwise. I just had
to remove the batteries, wait a few seconds, pop them back in
and voila, the multimedia keys work as expected (with 2.6.8.1-mh1).

Thanks for reading,
Yours, Florian
- -- 
Homo homini lupus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBhgFR7CzyshGvatgRAvSDAJwMbdtiJR4r8D2aFzdttWS94lLbtACfZdQL
0yOLdauYJs4SBjWAOvtQpbM=
=/VRL
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
