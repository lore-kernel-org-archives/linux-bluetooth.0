Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN and kernel 2.4.26
From: Bastian Ballmann <Crazydj@chaostal.de>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1088427485.3774.203.camel@pegasus>
References: <1088271695.29447.5.camel@espy.crazydj.de>
	 <1088364052.3774.67.camel@pegasus>
	 <1088372482.2430.4.camel@espy.crazydj.de>
	 <1088406110.3774.91.camel@pegasus>
	 <1088413956.2508.3.camel@espy.crazydj.de>
	 <1088414347.3774.170.camel@pegasus>
	 <1088418472.2513.6.camel@espy.crazydj.de>
	 <1088419003.3774.179.camel@pegasus>
	 <1088423529.2513.15.camel@espy.crazydj.de>
	 <1088427485.3774.203.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tR3To679jYaTk0A0RjZP"
Message-Id: <1088428991.2513.23.camel@espy.crazydj.de>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Jun 2004 15:23:11 +0200


--=-tR3To679jYaTk0A0RjZP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Mon, 2004-06-28 at 14:58, Marcel Holtmann wrote:

> I don't think so, because I looked at the patch and this seems to
> introducing the problem:

I thought it would be enough to disable all patches in my .config
and recompile the kernel, but that seems to be wrong...

> And here is the fix for pand to also work with the patch:

Yes, that works. Thanks a lot! :P
Greets

Basti

--=-tR3To679jYaTk0A0RjZP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA4Bu+3rCd3KdGxg4RAh/kAKCSk4wD5RxpJqZBuju8YCwIsfgizQCeP2nX
qWdk5a6yRIAJMLLJb4pcYnQ=
=5upy
-----END PGP SIGNATURE-----

--=-tR3To679jYaTk0A0RjZP--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
