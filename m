Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EA44F4.50606@egabriel.de>
From: ligi <ligi@egabriel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco crash without daemon
References: <41E91B7A.1070303@egabriel.de> <41E925F4.3060907@dark-reality.de> <41E92C83.8010406@egabriel.de> <41E9349C.8060001@dark-reality.de> <41E96812.7030903@egabriel.de> <41E9B60E.2010509@dark-reality.de>
In-Reply-To: <41E9B60E.2010509@dark-reality.de>
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
Date: Sun, 16 Jan 2005 11:41:56 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lars Grunewaldt wrote:

| ligi wrote: | | I am using Gentoo and here alsa is an ebuild that
| wants alsa not to be | compiled in the kernel it has to be
| external( build from | alsa-driver-1.0.8rc2.tar.bz2 by that ebuild
| of portage ). | But snd_hwdep is loaded and there is no complaining
| of missing things | - this method just fails... | Has anyone some
| Hint ?
|
| Just wanted to note that you don't need the external alsa driver
| package, only alsalib (I'm using gentoo, too). Of course this only
| applies if your other soundcards are supported well by the kernel.
|
| Maybe you should try using the kernel alsa stuff and drop the
| external alsa stuff, it's not supposed to work this way. Especially
| because snd-bt-sco is linked against the KERNEL alsa stuff, not
| your external driver stuff, so I think this might very well be the
| source of the problem.
|
Yes it was. Big up  - you made my Day a brighter Day ;-)

| Why do you want to use the external alsa-driver anyway?
|
It recommended to use the external Driver in the Gentoo docs - and i
found nothing in the btsco docs that says something diffrent - so i
used the external Driver ( Well -  I like the external Driver Concept
(in a world with so much devices ) more too .... )

| best regards, ~  Lars
|
PS: You can mark the SouthWing NeoVoice Headset ( on a Sitecom USB ->
BT Dongle ) as working for btsco - there is no wiki so I cant do this
now !-)
btw. anyone interested in a btscoWiki ?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6kTz3NorRo/jFWIRAk8EAJ92zMrOsojDhiIR582UC5eNsSr+rQCgrwRB
VuOS+rI7y+e+Gn5+jnimQG4=
=8HE2
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
