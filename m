Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Hi all !
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <41A6F456.5040005@prim-time.fr>
References: <41A6046D.30800@xgarreau.org> <1101423126.6465.19.camel@pegasus>
	 <41A6F456.5040005@prim-time.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TjEU0eXNasrRo6jrB43n"
Message-Id: <1101469734.16162.10.camel@baroque.rococosoft.com>
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
Date: Fri, 26 Nov 2004 11:48:54 +0000


--=-TjEU0eXNasrRo6jrB43n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Xavier,

On Fri, 2004-11-26 at 10:16 +0100, Xavier Garreau wrote:
> >>I never used sdp api, did any of you wrote some white paper about=20
> >>bluetooth programming involving sdp (i found=20
> >>http://www.holtmann.org/papers/bluetooth/wtc2003_slides.pdf but it's no=
t=20
> >>dealing with sdp)
> >=20
> > the programs dund and pand show you how to advertise a SDP record.
>=20
> Thank you very much Marcel, this was a useful answer, as usual !
>=20
> I just have another (amybe silly) question ...
>=20
> In bluez/pan/pand/sdp.c
>      function bnep_sdp_register
>=20
> if sdp_record_register is succesful, the sdp_session is not closed=20
> whereas it is evrywhere else (when something fails).
>=20
> Does it means that sdp_record_register closes the sdp_session when it is=20
> successful ? That would mean we need to di sdp_connect foreach record we=20
> have to add (I know, we usually only have only one to do at a time, but=20
> that seems "strange" to me)

I think this is a bug. The session should always be explicitly closed.
Send in a patch :-)

> Regards !
> Xavier Garreau

Steve
--=20
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-TjEU0eXNasrRo6jrB43n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBpxgmlgMqgVzLyWcRAv4DAJ9GW2DMK+dgBFHvUY8k4GR5ZyOjgACeKISp
sFie66/fc1KNS74oMEwMStI=
=xs5x
-----END PGP SIGNATURE-----

--=-TjEU0eXNasrRo6jrB43n--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
