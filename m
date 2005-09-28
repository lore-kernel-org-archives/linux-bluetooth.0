Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <433AC55B.3000809@grimmer.com>
From: Lenz Grimmer <lenz@grimmer.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15
Subject: [Bluez-devel] Success report: snd_bt_sco with Nokia HDW-3
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
Date: Wed, 28 Sep 2005 18:31:23 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

(please Cc: me on replies as I am not subscribed to the bluez-devel list)

I just wanted to drop you a note to let you know that I succeeded in
getting my Nokia HDW-3 Bluetooth headset working with the current CVS
version of the snd_bt_sco driver. Great job! Finally I can use a VoIP
soft phone (kphone) on my Linux box (IBM Thinkpad T42) without having to
mess with cables :)

The headset emits a ring tone when I send SIGUSR1 to the btsco program,
I have not yet explored how to use the buttons.

I have posted a more detailed description on my blog:

  http://tinyurl.com/95a8e

It would be great if you could add the HDW-3 to the list supported
headsets on http://bluetooth-alsa.sourceforge.net/ - I first was a bit
hesitant to purchase one that was not listed on there...

Also, SUSE 10.0RC1 ships with a more recent version of automake (1.9) -
it might be good to update the bootstrap script accordingly (1.9 worked
just fine, too). Oh, and there is no "libbluetooth-devel" or
"bluetooth-devel" package on SUSE - it's called "bluez-libs" there...

Thanks and keep up the good work!

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDOsVaSVDhKrJykfIRAuOiAJ9zZON/5WEf4/s3j8urxDF22qXGXQCeP1vv
sI3p20jiftNhIzp0ROWFMlA=
=1T1+
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
