Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F2A378.2040909@wershofen.de>
Date: Sat, 10 Mar 2007 13:24:24 +0100
From: Wolfgang Wershofen <wolfgang@wershofen.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45F08496.8000806@wershofen.de> <45F1A28D.7070502@xmission.com>
In-Reply-To: <45F1A28D.7070502@xmission.com>
Subject: Re: [Bluez-users] headsetd(plugz) vs. btsco - My experiences with
 BT	telephony
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brad Midgley schrieb:
> Wolfgang
> 
> Did you patch your kernel with the flowcontrol patch (plugz/patches)? It 
> might help the loud noise. Are you trying a recent version of plugz?

Yes, I patched the kernel - otherwise headsetd won't run.
I got plugz from cvs on Feb 6th. Just checked the CVS - no changes for
headsetd available since then, only a2dpd seems to have changed.

> 
> It sounds like you may have an audio server introducing latency with 
> btsco. It's more likely to happen with btsco accidentally since it shows 
> up as a "real" alsa kernel device.

What audio server could that be? I can't say, if the delay is always
there or only from time to time. But I'm sure, the delay only occurs
when I answer a call and not when I initiate the call.

Thx for your suggestions anyway.
Wolfgang
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF8qN4gUafbxFH+p8RAvtmAKCNbSoO8VzhG6uLSWnHVhvh0o7NbwCgjo8d
8jqQ51cHXsf2rZtiRnVeD3c=
=mtoT
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
