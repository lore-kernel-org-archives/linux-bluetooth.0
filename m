Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
Message-Id: <20041124035850.4c086e3a.henryk@ploetzli.ch>
In-Reply-To: <41A3ACE2.4030501@xmission.com>
References: <41A22C0B.4050008@xmission.com>
	<41A234FA.7020303@xmission.com>
	<20041123033429.132bf84b.henryk@ploetzli.ch>
	<41A2B331.4010001@xmission.com>
	<20041123070621.50569968.henryk@ploetzli.ch>
	<41A3471C.4000602@xmission.com>
	<20041123203836.046fb4f4.henryk@ploetzli.ch>
	<41A3ACE2.4030501@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__24_Nov_2004_03_58_50_+0100_fLxsaa9Xgc3WIlaU"
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
Date: Wed, 24 Nov 2004 03:58:50 +0100

--Signature=_Wed__24_Nov_2004_03_58_50_+0100_fLxsaa9Xgc3WIlaU
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Tue, 23 Nov 2004 14:34:26 -0700 schrieb Brad Midgley:

> we just send one sbc frame then? I was assuming that but not sure.

Yes, for the beginning.

> Are you saying we should put 0x9c in the stream or it should be in the
> stream already? The SBC-specific stuff is definitely where my=20
> understanding ends.

It's already there. The format of an SBC frame is defined in the A2DP
spec p. 53. They all start with a fixed length header of four bytes
(that's what struct sbc_frame_header is) and then some more data (the
length of which is calculated by calc_frame_len). We must send the whole
frame (that is header plus data).

> I think what we have in CVS looks better but it doesn't sound better
> :(

Hmm, I made it behaving to the specs (I think) (and yes, this time I
actually made sure I committed it) and don't hear anything now.=20

> Are you using the bluetake too?

Yes.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Wed__24_Nov_2004_03_58_50_+0100_fLxsaa9Xgc3WIlaU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBo/jtIjWgKE0OA2gRAgbZAJsGIohj4J+z0GLRpHKMTASvmD3ntgCffuK0
9qyTkH+11ywCBlz/WEDNr3I=
=0R2D
-----END PGP SIGNATURE-----

--Signature=_Wed__24_Nov_2004_03_58_50_+0100_fLxsaa9Xgc3WIlaU--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
