Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <436F1C3B.5020002@web.de>
From: Dirk Stockmann <dirk.stockmann@web.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Periodic noise on microphone with bt_sco (BTA-6030 Dongle, Motorola
 H500 Headset)
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
Date: Mon, 07 Nov 2005 10:19:55 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have successfully compiled and installed the newest bt_sco driver and
userspace programs on SuSE 10.0 (2.6.13 Kernel). And basically it works
great: playback is fine and also the microphone is working.
The problem is that the sound coming from the microphone is overlayed
with a annoying buzz. The buzz is not very loud but clearly hearable and
quite distracting.
The base frequency of the buzz is about 266Hz. If that helps I could
post a short recorded sample.
I would be very grateful to get pointers what to do to get rid of that
buzz. I am a experienced programmer with some low-level kernel
knowledge, so I would also invest some time in debugging if I would knew
for what I should look.

Thanks,
Dirk
- --
Key can be found on:
http://sks.keyserver.penguin.de
hkp://sks.keyserver.penguin.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFDbxw7Li2VR2b1/voRAqzKAJinAs89WaKcf2vo67gBMJbe2RLSAJwPT6wy
suH7s3ULGZVkdpSWEKjNKQ==
=m6ND
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
