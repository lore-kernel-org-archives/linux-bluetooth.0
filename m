Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
Message-Id: <20041121064655.0b04dd8a.henryk@ploetzli.ch>
In-Reply-To: <cbf0aec9041118052714481128@mail.gmail.com>
References: <418DB442.2050801@uen.org>
	<41925793.3050404@xmission.com>
	<1100113055.25879.73.camel@pegasus>
	<419543B3.8050601@xmission.com>
	<1100306337.7349.29.camel@pegasus>
	<41957BC1.507@xmission.com>
	<1100351199.7349.50.camel@pegasus>
	<41970F25.4020902@xmission.com>
	<1100446172.21403.16.camel@pegasus>
	<419B7292.9080706@xmission.com>
	<cbf0aec9041118052714481128@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__21_Nov_2004_06_46_56_+0100_sioIcoXb6AManvEn"
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
Date: Sun, 21 Nov 2004 06:46:55 +0100

--Signature=_Sun__21_Nov_2004_06_46_56_+0100_sioIcoXb6AManvEn
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Thu, 18 Nov 2004 14:27:26 +0100 schrieb Henryk Pl=F6tz:

> I have problems synthesizing the PCM audio samples but can parse all
> of the example SBC streams just fine.

Ok, catched it. I reimplemented the SBC analyzer and synthesizer  in
Octave which is easier to play around with and found that my C
synthesizer was working fine - on wrong subband samples. The bitstream
unpacker had a bug which made it shift the incoming bits once to often.=20

So sbc-test from the CVS is now able to decode 4 and 8 subband mono SBC
files (there's something wrong with stereo, I'll look into that
shortly).=20

I also moved all my static const tables to a separate header file and
replaced my cos() calls with precomputed tables. The decoder is still
about 5 times slower than the reference one, though.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sun__21_Nov_2004_06_46_56_+0100_sioIcoXb6AManvEn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBoCvXIjWgKE0OA2gRAp/VAKCOhr+LAucWEH10KBAOxFDxudTHwACfaq5X
LWB3XycpI29/ic91eDI/Lqk=
=mU0e
-----END PGP SIGNATURE-----

--Signature=_Sun__21_Nov_2004_06_46_56_+0100_sioIcoXb6AManvEn--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
