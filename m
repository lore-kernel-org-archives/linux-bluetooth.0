Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40A2888C.5040805@gmx.de>
From: Lasse Jansen <l.jansen@gmx.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Headset with snd-bt-sco
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
Date: Wed, 12 May 2004 22:26:52 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,
I have some problems with making my BT headset work. Bluetooth works, I
can e.g. exchange files with my T610. For the Headset I downloaded the
snd-bt-sco driver (http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/),
kernel-2.6.4 and alsa-1.0.3 as said in the README. Everything went fine,
when I run
| btsco-0.2/btsco 00:0D:FD:00:7B:CC 1
I hear a little background noise. When I increase/decrease the volume at
the headset, it will be printed on the screen, so there is a connection.

But when I try to play a sound file, nothing happens. E.g.
| aplay -D plughw:Headset /usr/kde/3.2/share/sounds/KDE_Logout_new.wav
hangs in a loop. Xmms says "couldn't open audio".
I have deactivated the "loopback" option in the mixer settings.

Any ideas?

Thanks,
Lasse Jansen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAooiDcVlhtTruR0sRAuCIAJ90n/Vqqrr3YllidiFJdMdiEyo/ugCfaldz
X6dm/Jig7UuWK4V2r1gQ0ME=
=TE8v
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
