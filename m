Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
Message-Id: <20041123203836.046fb4f4.henryk@ploetzli.ch>
In-Reply-To: <41A3471C.4000602@xmission.com>
References: <41A22C0B.4050008@xmission.com>
	<41A234FA.7020303@xmission.com>
	<20041123033429.132bf84b.henryk@ploetzli.ch>
	<41A2B331.4010001@xmission.com>
	<20041123070621.50569968.henryk@ploetzli.ch>
	<41A3471C.4000602@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Nov_2004_20_38_36_+0100_Ho2uM7ZQvvPqfdt7"
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
Date: Tue, 23 Nov 2004 20:38:36 +0100

--Signature=_Tue__23_Nov_2004_20_38_36_+0100_Ho2uM7ZQvvPqfdt7
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Tue, 23 Nov 2004 07:20:12 -0700 schrieb Brad Midgley:

> I changed how the sbc_info values are translated into sbc_elements and
> I think we're getting the right values now:

Yupp, looks correct to me. So does the new hcidumps's job of decoding
it.

> 	s_config.sbc_elements.channel_mode =3D 8 >> sbc_info.channel_mode;

Heh, that's a clever way of doing this.=20


I also saw that you were modifying the way a2play packs its frame though
that still doesn't look right to me. Maybe we should talk about our
interpretation of the specs in this case.

The way I see this we should have a media packet header from AVDTP p. 45
and a media payload from A2DP p. 23. The media packet header should be
12 octets in length (as we don't use any CSRC). I think a2play does
these right, except for the timestamp (I'll come to that in a second).

Next thing should be media payload header from A2DP which is 1 octet in
length and correct, too.

Then there should be an SBC frame as per A2DP p. 53 just like my code
produces them. That should start with 0x9C which I can't see anywhere in
the a2play output.

Now I saw Marcel tried adding a timestamp (which I did, too, without
any effects, sadly). The way I read section 4.3.3.1 of A2DP would be
that there should be an imaginary clock counting at the sampling
frequency of the SBC frames and whose value should then be put into the
timestamp field. Or, simply put: Count the samples sent so far.=20

I've modified the CVS to my beliefs. Please correct me if you think I'm
wrong.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Tue__23_Nov_2004_20_38_36_+0100_Ho2uM7ZQvvPqfdt7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBo5HEIjWgKE0OA2gRAv62AJ9wQ5eZsTu/Xe1KzR7T18d47qsGEACgnVX7
sGM0cJNJrJuBRHP9clCaSEM=
=aHKU
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Nov_2004_20_38_36_+0100_Ho2uM7ZQvvPqfdt7--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
