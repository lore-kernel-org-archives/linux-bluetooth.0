Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1166359423.6557.35.camel@aeonflux.holtmann.net>
References: <1166076796.3984.9.camel@localhost>
	<20061214092546.GA6244@163.com>  <1166148309.3279.6.camel@localhost>
	<1166359423.6557.35.camel@aeonflux.holtmann.net>
Date: Sun, 17 Dec 2006 12:37:31 -0500
Message-Id: <1166377051.6846.10.camel@localhost>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Immediate disconnect after doing "hcitool cc"
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1179334703=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1179334703==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-I9lxdaf1xiw+7sXsUjb3"


--=-I9lxdaf1xiw+7sXsUjb3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thanks for the response. I'm unsure about how the ACL is created and how
I then do the auth to pair the devices. Is there any documentation as
I've just been going through the list of quoted documentation at the
bluez site and every thing I've read so far always talks about doing the
cc?

I remember that with running btsco it would do all the pairing and
prompt for the pin through the gnome-bluetooth applet. Is that what is
meant by the kernel doing the low-level ACL? The only thing is I haven't
looked back at compiling the code with kernel 2.6.19 - I think I had
some problems compiling the device module against the kernel so I will
need to review that again. It throws up an error - btsco.c:127: error:
syntax error before "snd_card_t" as the first before a whole lot more
warnings and errors.

Cheers,

JonB.

On Sun, 2006-12-17 at 13:43 +0100, Marcel Holtmann wrote:
> Hi Jon,
>=20
> > No. The disconnect happens at most maybe a couple of seconds after the
> > cc command has completed. I've tried:
> > hcitool cc 00:12:EE:E0:AB:CA; hcitool auth 00:12:EE:E0:AB:CA
>=20
> don't use "hcitool cc" for connecting devices. This command is not for
> general purpose use. Let the kernel create you low-level ACL, because it
> knows what to do.
>=20
> Regards
>=20
> Marcel

--=-I9lxdaf1xiw+7sXsUjb3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFhYBbu2cEic/xsEARAoqRAJ4w5BbfmUwh9749hKagbYCVw26HtgCg11bp
oRecnM1OgzRnyo08ih2epfY=
=OF58
-----END PGP SIGNATURE-----

--=-I9lxdaf1xiw+7sXsUjb3--



--===============1179334703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1179334703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1179334703==--
