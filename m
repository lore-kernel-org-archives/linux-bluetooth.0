Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4115F36B.8090202@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] another problem with hidd/MX900 mouse
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
Date: Sun, 08 Aug 2004 11:33:31 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi again,

the MX900 works flawless now with both an Epox BTD on my notebook and
the docking station from Logitech on my desktop PC. Great work, thanks a
lot :)

But there is one issue not directly connected to the mouse, and I hope
you can help me out here.

hidd (I think) registers the mouse after connection as /dev/mouse2, and
X11 uses it without any issues - as long as the mouse is connected
*before* the X11-Server is started. Without a connected mouse, there's
no /dev/mouse2, and I don't know how to tell the X11 server "hey look
again the pointing device appeared".

Another option might be some kind of "mirror" for the device, i.e. with gpm.

Any ideas how to make the mouse working without restarting X11 (and all
running programs...)

thanks,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBFfNrQWC6DTWkDAoRAvNZAKCF5/G4mLJYPXtDvGkw5ckQkwRgFACgiCCQ
RsBfJAs+5vlPnAthi94ye/Y=
=xS27
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
