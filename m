Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EB7060.60106@egabriel.de>
From: ligi <ligi@egabriel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Error when executing rctest.c
References: <B72A22937C14184DB0AF3324476E9C791A53F9@MBOX22.stu.nus.edu.sg>
In-Reply-To: <B72A22937C14184DB0AF3324476E9C791A53F9@MBOX22.stu.nus.edu.sg>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Date: Mon, 17 Jan 2005 08:59:28 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Khoo Teck Ping wrote:

| Dear All
|
| I can compile rctest.c, but I get the following error when
| executing rctest.c
|
| Can't set L2CAP link mode. Protocol not available(92).
|

is l2cap compiled L2CAP in your kernel ? ( an option in Device Drivers
- -> Network -> Bluetooth @ 2.6.X )

| I am using Fedora Core 3 with a Silicon Wave USB dongle.
|
| Please advise. Thank You.
|
| Teck Ping
|


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB63Bg3NorRo/jFWIRApkCAKCHIKj/5RW608BMB1Xj2lbU8qKX5ACdEY7j
4PZQIN22bcJpR7dlOiKLo6Q=
=Upjr
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
