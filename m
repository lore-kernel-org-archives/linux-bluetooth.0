Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4371B708.2050001@web.de>
From: Dirk Stockmann <dirk.stockmann@web.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Periodic noise on microphone with bt_sco [Solved]
References: <436F1C3B.5020002@web.de> <436F4D85.4030404@csr.com>	 <436F5602.1040105@web.de> <436F5B5C.7070506@csr.com>	 <436F608D.4020407@web.de>  <436F6FEA.4030207@csr.com> <1131376874.5824.127.camel@blade>
In-Reply-To: <1131376874.5824.127.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 09 Nov 2005 09:44:56 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

first of all I want to thank everybody for the help. I learned a lot
about bluetooth and finally got it working, so I am happy ;-).

I installed the newest hcidump and used the -A option to capture the
sound data. It already contained the noise - so it was produced by the
headset. Then I repeated the test with the mobile phone and there was
also some noise - this time.
After some test (most have looked silly) I found out that it is caused
by feedback between the RF, the speaker and the microphone. It
disappeared when I held the headset to the ear with my hand - that must
have been the case with the first test with my mobile.
I applied a small strip of self-adhesive aluminiumfoil to a specific
part of the headset, the noise is now completely gone.

Dirk

- --
Key can be found on:
http://sks.keyserver.penguin.de
hkp://sks.keyserver.penguin.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDcbcHLi2VR2b1/voRAvu4AJ4jiOUWxDdmbdRhy9+yYg/9s+btfwCgzJHh
n1xu77CYpfBcBHPdDyC2SwE=
=Pg/A
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
