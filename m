Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E51B65.2050704@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Multiple Headsets
References: <01de01c4f89f$e6d0d230$6f04a8c0@ZBOX>
In-Reply-To: <01de01c4f89f$e6d0d230$6f04a8c0@ZBOX>
Content-Type: text/plain; charset=windows-874; format=flowed
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
Date: Wed, 12 Jan 2005 13:43:17 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

it seems there's no need to hardcode anything in the kernel anymore,
because there's a module
~ parameter for hci_usb now that makes it possible to switch the
alternate setting (by replugging
the dongle).

please don't use html for mails.
- - Lars

Suriyan wrote:
| Hi,
|
| I used to success with multiple headsets by a few hardcoded in BlueZ
stack,
| steps & results found in serveral recently "Re: multi rfcomm/sco
connection"
| subject.
|
| Regards,
| Suriyan.
|
|
|
|
| -------------------------------------------------------
| The SF.Net email is sponsored by: Beat the post-holiday blues
| Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
| It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
| _______________________________________________
| Bluez-devel mailing list
| Bluez-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/bluez-devel
|


- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5RtkQWC6DTWkDAoRAsFfAKCHVZBgoMml8Cw2vpaKit8TVc7EWACgwvE3
tkqC5FFw0hw+bJNdkMXgn1g=
=dVOo
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
