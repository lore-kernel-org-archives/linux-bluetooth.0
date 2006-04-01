Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <442EC2B6.70901@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-users] snd-bt-sco doesnt load automaticly
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
Date: Sat, 01 Apr 2006 21:13:10 +0300

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hay all,
I am running Gentoo kernel  2.6.15.4
my /etc/modules.d/alsa reads:

# ALSA portion
alias char-major-116 snd

alias snd-card-0 snd-via82xx
alias snd-card-1 snd-bt87x
alias snd-card-2 snd-bt-sco
alias snd-card-3 snd-usb-audio
alias snd-card-4 snd-usb-audio

It used to load the sco BT , but now doesnt.
When I run modprobe snd-bt-sco , it does load.

Niv
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFELsK2kwazfG0MmCYRAicGAJ9Oma8queMwY8EsxgAbeKcospx0SgCfdK2N
eT8pareSD6rI8ZraemG1o2E=
=DiF0
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
