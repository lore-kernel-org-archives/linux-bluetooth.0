Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4230599B.70909@summet.com>
From: Jay Summet <jay@summet.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Mathias Adam serial patch for 2.6.x kernel, Socket CF and BrainBox
 CF, working!
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
Date: Thu, 10 Mar 2005 09:28:43 -0500

-----BEGIN PGP SIGNED MESSAGE-----

I have tested the patch Mathias Adam posted to this list a week ago on kernel
2.6.8.1-24mdk (a Mandrake version of 2.6.8). It applied cleanly, and made my
socket compact flash card (rev H) work great!

It also fixed the same type of problem I was having with an older BrainBox CF
(H4 mode) card!  (The brainbox card works, but does not support encryption.)

If you missed it, I archived the patch here:
http://www.summet.com/x31/socket.html

Thanks  Mathias!

Jay
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQCVAwUBQjBZm7WkkhmZq4xxAQFfwwP/WXiJtCzgtUVVDegkbmZJ6AAlO9fUTDOL
jOWJplrbineYJWLxx8SyEEgjrLQN2ydN3bkX43FEWot8WVUf3Xw4EZN7OIUQhRlQ
6zySPe2FUVNfL/uBEGkC+aQMXSjpoJ2s3wDq9x7Y+PM7V5FcpQAFg6PcFtp5HQxJ
6EOzFOHCwWQ=
=LEDX
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
