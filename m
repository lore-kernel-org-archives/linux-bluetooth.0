Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.61.0410241307180.7693@block.bubble>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Disabling HID Boot Protocol
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
Date: Sun, 24 Oct 2004 13:11:54 +0200 (CEST)

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello everyone,

I'm using a MS Bluetooth Optical Desktop and would like to
use the hotkeys again. I have kernel 2.6.8.1-mh1 and bluez-utils
2.10.. According to the mailing list archives, this version of 
hidp.ko should already support report mode, however, I couldn't
find any description on how to enable it. I suppose it's necessary
to pass the correct "-b <subclass>" parameter to hidd?

hcidump -x doesn't show any packets when the multimedia keys
are pressed, so I suspect the boot protocol is still in use,
even though hidd --show doesn't say so.

Yours, Florian
- -- 
Homo homini lupus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBe43+7CzyshGvatgRAln5AJ0QEbSMDR4fDa2AUWgWUBeIKnKpdQCbB607
HVIswFPgW6QRCCmQ8hFu6w4=
=8DIS
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
