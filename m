Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E96812.7030903@egabriel.de>
From: ligi <ligi@egabriel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco crash without daemon
References: <41E91B7A.1070303@egabriel.de> <41E925F4.3060907@dark-reality.de> <41E92C83.8010406@egabriel.de> <41E9349C.8060001@dark-reality.de>
In-Reply-To: <41E9349C.8060001@dark-reality.de>
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
Date: Sat, 15 Jan 2005 19:59:30 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


ok - i have installed the mh1 patch now but that did not solve my
problem. I had a little look on the code and the problematic line
seems to be:

~     /* open hwdep on audio device */
~        if ((err = snd_hwdep_open(&handle, hwdep_name, O_RDWR)) < 0) {
~                error("btsco open  (%i-%i): %s\n", card, dev,
snd_strerror(err));
~                return -1;
~        }

I am using Gentoo and here alsa is an ebuild that wants alsa not to be
compiled in the kernel it has to be external( build from
alsa-driver-1.0.8rc2.tar.bz2 by that ebuild of portage ).
But snd_hwdep is loaded and there is no complaining of missing things
- - this method just fails...
Has anyone some Hint ?


ligi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6WgS3NorRo/jFWIRAtJBAKDchAK+HqeCW/H1DjjRBh2yt4VX9gCfVXR/
USHgCsykPm4tsJmNHSh42GI=
=VQLx
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
