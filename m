Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
Message-Id: <20050424181947.4a2f1656.henryk@ploetzli.ch>
In-Reply-To: <20050424134746.GA31151@externe.net>
References: <1114345112.10706.64.camel@pegasus>
	<20050424134746.GA31151@externe.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__24_Apr_2005_18_19_47_+0200_k1Ngpa6yp=VdaHiz"
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
Date: Sun, 24 Apr 2005 18:19:47 +0200

--Signature=_Sun__24_Apr_2005_18_19_47_+0200_k1Ngpa6yp=VdaHiz
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sun, 24 Apr 2005 09:47:47 -0400 schrieb Guylhem Aznar:

> - for kernel integration, linus &co may not be interested in a
> kernel-side sbc decoder- they will certainly ask for a /dev/ entry
> taking the native format - in that case already encoded sbc.=20

and

> Later on, like rfcomm manages rfcomm0 etc. entries, some a2dp tool
> could bind a2dp peripherals to /dev/a2dpN where SBC audio would be
> expected and streamed to the a2dp peripheral bound there.

My 0.02EUR: There is a problem here. Mayank turned up a very valid point
in his "a2play code not according to the specifications" posting: Having
the SBC encoding decoupled from the AVDTP negotiation is not a good
thing. One of the primary problems of the current pipe approach (and
expecting applications to stream SBC into a socket/device/whatever is
not different in this regard) is that the format of the SBC stream
(sample rate, channel mode, etc.) will have to depend on the
capabilities of the receiver, but there is no feedback to the encoder
about that.

Therefore the best implementation would be to put the actual encoding
into the same layer of code that does the negotiation, or at least put
the control over the encoder there. Otherwise you wouldn't have the
simple "open and write something into it" semantics most other devices
have, but would need to have something along the lines of "open the
device, offer it some audio formats, let it do the negotation, read back
the audio format that is to be used, encode the audio stream into that
format".=20

And also coupling /dev/a2dpN tightly to SBC format would make it even
harder (or impossible) to support other audio formats as A2DP does.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sun__24_Apr_2005_18_19_47_+0200_k1Ngpa6yp=VdaHiz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCa8cnIjWgKE0OA2gRAv86AJ9ypFyoh5m3lAAjB2a5YDwas3iYUwCffqCn
joTA5KP+gc/txkqaGPEgmNw=
=nfm8
-----END PGP SIGNATURE-----

--Signature=_Sun__24_Apr_2005_18_19_47_+0200_k1Ngpa6yp=VdaHiz--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
