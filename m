Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluez for Motorola EZX mobile phones
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <44158472.9090302@fillibach.de>
References: <1142259275.19093.10.camel@localhost>
	 <44158472.9090302@fillibach.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eRgYfyrg4W54m0GlxIhq"
Message-Id: <1142273485.1696.4.camel@localhost>
Mime-Version: 1.0
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
Date: Mon, 13 Mar 2006 19:11:25 +0100


--=-eRgYfyrg4W54m0GlxIhq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > backported the modules from 2.4.31-mh1 to the custom Motorola kernel,
> > which is based on 2.4.20.=20
> > My question is now what to do with the patch.
> Could you send it to openezx.org?
I will, as soon as it's finished.
I noticed there's a bug in rfcomm left:

The newest BlueZ modules use a function tty_wakeup() that isn't present
in the 2.4.20 tree. Does anyone have an idea how to replace that
function with one that is available in the old kernel? Maybe just
wake_up_interruptible?

Yours, Florian

--=-eRgYfyrg4W54m0GlxIhq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEFbXN7CzyshGvatgRAr37AJ9ugCO/k5GwJJXQuQr7ks417yL2fACg/EOi
JkHGpQ530sC/1634GXxOacU=
=Cn3J
-----END PGP SIGNATURE-----

--=-eRgYfyrg4W54m0GlxIhq--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
