Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EE989A.7030206@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth headset - connects but no audio
References: <41EE3974.1010604@fastwebnet.it> <41EE5112.1040502@dark-reality.de> <41EE4ACD.9070105@fastwebnet.it> <41EE66A2.1040106@dark-reality.de> <41EE69F3.1030401@fastwebnet.it>
In-Reply-To: <41EE69F3.1030401@fastwebnet.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 19 Jan 2005 18:27:54 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

WiseLYNX wrote:
| | no, it's not patched with mh1. Best thing would be to use the vanilla
| | kernel (i.e. get it directly from kernel.org) and patch it with -mh1
| | patchset from bluez. I'm using gentoo, too, btw, so it should work this
| | way.
|
| I patched manually the kernel. now I get this strange thing:
|
| # btsco 00:0E:07:4E:4B:3E
| Device is 1:0
| Failed to connect to SDP server: Permission denied
| Assuming channel 2
| Voice setting: 0x0060
| Can't connect RFCOMM channel: Too many levels of symbolic links
|

use a vanilla kernel.

no really, no idea :)

maybe someone else?
- - Lars

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

iD8DBQFB7piaQWC6DTWkDAoRArAIAKCXQJaIx7F72UeEIST/PC9RrmvWvACfav+R
C32YXYTZk0oaZknb86BW89Y=
=55+S
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
