Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EF0C15.3040705@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth headset - connects but no audio
References: <41EE3974.1010604@fastwebnet.it> <41EE5112.1040502@dark-reality.de> <41EE4ACD.9070105@fastwebnet.it> <41EE66A2.1040106@dark-reality.de> <41EE69F3.1030401@fastwebnet.it> <41EE989A.7030206@dark-reality.de> <41EED6AE.1080205@fastwebnet.it>
In-Reply-To: <41EED6AE.1080205@fastwebnet.it>
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
Date: Thu, 20 Jan 2005 02:40:37 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

WiseLYNX wrote:
| | use a vanilla kernel.
|
| I did a try, with vanilla 2.6.10 directly from kernel.org. guess what?
| doesn't work neither that way :(
|
| | no really, no idea :)
|
| mh.. may it be a hint the fact this (the "Permission denied" and "Too
| many levels of symbolic links" errors) happened _after_ I applied the
| mh1 patch?

well it *should* work with this setup, as it works on my system with
stock 2.6.10 plus mh1 patches. Anything else special, like, are you
using an SMP kernel?

Maybe it's a problem with your dongle, do you have access to another one
to test this? (local setup: epox bt-dg03 + sony/eri. hbh-35 headset)

best regards,
~  Lars

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

iD8DBQFB7wwUQWC6DTWkDAoRAhORAJ9dV//SYKnhv8I8JqtEO+JHyreD3gCeOT1O
bOedFmkBNJTCTh6kEj7wF8Q=
=pX58
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
