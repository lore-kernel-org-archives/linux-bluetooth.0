Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E9B60E.2010509@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco crash without daemon
References: <41E91B7A.1070303@egabriel.de> <41E925F4.3060907@dark-reality.de> <41E92C83.8010406@egabriel.de> <41E9349C.8060001@dark-reality.de> <41E96812.7030903@egabriel.de>
In-Reply-To: <41E96812.7030903@egabriel.de>
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
Date: Sun, 16 Jan 2005 01:32:14 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ligi wrote:
|
| I am using Gentoo and here alsa is an ebuild that wants alsa not to be
| compiled in the kernel it has to be external( build from
| alsa-driver-1.0.8rc2.tar.bz2 by that ebuild of portage ).
| But snd_hwdep is loaded and there is no complaining of missing things
| - this method just fails...
| Has anyone some Hint ?

Just wanted to note that you don't need the external alsa driver
package, only alsalib (I'm using gentoo, too). Of course this only
applies if your other soundcards are supported well by the kernel.

Maybe you should try using the kernel alsa stuff and drop the external
alsa stuff, it's not supposed to work this way. Especially because
snd-bt-sco is linked against the KERNEL alsa stuff, not your external
driver stuff, so I think this might very well be the source of the problem.

Why do you want to use the external alsa-driver anyway?

best regards,
~  Lars

- -------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



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

iD8DBQFB6bV+QWC6DTWkDAoRAsLqAKCwR/tq9OSqGfNzkx7nBgXG8OoxbACgsoIT
je9e6N4HDQtRHUnfLlqyKX4=
=4FnC
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
