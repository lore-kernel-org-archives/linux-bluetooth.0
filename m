Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E267C4.5030906@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multiple Headsets
References: <41E25ECD.2000505@fcse.co.uk>
In-Reply-To: <41E25ECD.2000505@fcse.co.uk>
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
Date: Mon, 10 Jan 2005 12:32:20 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

first, it would be a good idea to update to the latest available sources
(that is, 2.6.10 kernel and mh10 patchset).

I think we do support multiple sco connections now, but you must either
use 8-bit-audio (by hacking the btsco stuff) or hack the kernel.

The problem in short: the hci_usb driver that handles the bt dongles
needs to know how many data has to be send. So if using two 16bit
channels, it needs to switch to the 32bit-mode, not the 16bit mode that
is used by default.

This switching is not handled automatically by now (or, not handled in
any way to be precise), and while we are talking about it a lot, I think
nobody fixed this by now (this includes me).

Maybe you want to dig the list archives and have a look at discussions
about sco...

best regards,
~  Lars


Jeff Fern wrote:
| Hello all,
|
| I have sucessfully got Bluez and the bt-snd-sco alsa stuff working with
| my debian 2.6.9 and mh5 patch.
|
| What I would like to do is get two headsets working, as two seperate
| audio devices so I can cat /dev/dsp1 to /dev/dsp2 and pass audio through.
|
| Whenever I currently try and connect two headsets, the second one
| reports the SCO channel is already in use.
|
| I do have two bluetooth USB dongles that can be used (although would
| like to just use one if possible).
|
| I should point out that my background is in Java and not C, so although
| I have examined the bt-snd-sco and btsco source files, I do not
| understand them enough to be able to see what is going on.
|
| Any help would be much appreciated,
|
| Regards,
|
| -Jeff Fern
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

iD8DBQFB4mfEQWC6DTWkDAoRAgVkAKCsMX0puS8uFwQ9QkrUEcL///9Y5ACgmgif
v6/EiGDihE5EE9yU8ZdbAU8=
=X+Qu
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
