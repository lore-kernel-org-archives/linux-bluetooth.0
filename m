Return-Path: <cyrus@holtmann.org>
Message-ID: <496F35E8.9060503@powercraft.nl>
Date: Thu, 15 Jan 2009 14:11:04 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: totem-xine segfault when playing dvd with menu and bluez bluetooth
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello everybody,

I have been trying to track and report some for me serious issues, when
trying to play dvds using bluetooth speakers and headsets. I reported
the problem on debian.org and gdb backtraces are included:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=511670

bluez version: today build git version
(previous bluez version had the same problem)
http://filebin.ca/tpbgsp/bluez-utils_4.27git_i386.deb
http://filebin.ca/txmdsd/bluez-gnome_1.9git_i386.deb

totem-xine --version
 GNOME totem 2.22.2

Any ideas,

Best regards,

Jelle de Jong
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAklvNecACgkQ1WclBW9j5HlDuwP/Tv2WctttPgWIKnIy8acx5ftc
Hp7VPwByMzR5o6mdsEz+zDOTVvxJ9UXJc8K2KLiQh6M1G2nV7MFT0t+RtvzA5rCY
4gj/GMu+VSshg6U2MEAvBGtPKNfepkoGN1aFwEPS7ZwXaVIE8DkDcBgH27CLRDrF
rFlvEBQdf9fjWvZG7/8=
=1ctc
-----END PGP SIGNATURE-----
