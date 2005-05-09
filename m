Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Regarding a2recv
Message-Id: <20050509143856.4a5437c7.henryk@ploetzli.ch>
In-Reply-To: <427EE734.4030303@xmission.com>
References: <20050506060525.32b209ca.henryk@ploetzli.ch>
	<20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
	<20050509005413.3787d2d7.henryk@ploetzli.ch>
	<427EE734.4030303@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__9_May_2005_14_38_56_+0200_JoZ+SF+PxNSiljxj"
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
Date: Mon, 9 May 2005 14:38:56 +0200

--Signature=_Mon__9_May_2005_14_38_56_+0200_JoZ+SF+PxNSiljxj
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sun, 08 May 2005 22:29:40 -0600 schrieb Brad Midgley:

> The only tricky part is the MAX_ADDITIONAL_CODEC stuff. Make sure we=20
> only try to send one codec when we're reporting our sink's
> capabilities  and accept multiple codecs when we're reading
> capabilities.

Ugh, yes. It would be possible to simple address infos[] beyond the
borders that are set by 1 + MAX_ADDITIONAL_CODEC if it is made sure that
there is that much space assigned. (If I recall correctly that's a
common technique to get varying length fields in structs.) However, from
the header it is not clear how many capabilities there will be, which is
something I don't like. We would have to resort to an all-zero seid_info
or something like that to denote the end of the packet (the read
function must than insert that, and the write function would have to
send up to that border).

> Maybe what you're proposing will clean up the "optional" error codes
> in places like open_stream_rsp. The header would look different so
> you could distinguish the error codes and compute the size properly
> when sending.=20

That was exactly the idea.

> Be sure we accept the extended size with the error codes when
> receiving.

I'm not accustomed to bluetooth socket programming but I guess what I'm
doing currently (simply read() up to a maximum (mtu?) size, check the
returned size and optionally the header and cast the buffer to our
struct) is fine for that purpose.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Mon__9_May_2005_14_38_56_+0200_JoZ+SF+PxNSiljxj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCf1nmIjWgKE0OA2gRAlT8AJ9QYTPndLbaRQbscYYuo3xn6XYI+QCgu9tQ
Z5mcOITvsYZXuhKDyFL+RUY=
=rWmP
-----END PGP SIGNATURE-----

--Signature=_Mon__9_May_2005_14_38_56_+0200_JoZ+SF+PxNSiljxj--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
