Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC packer done, kind of
Message-Id: <20041123074829.7f978ce7.henryk@ploetzli.ch>
In-Reply-To: <1101191260.26578.43.camel@pegasus>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	<1101191260.26578.43.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Nov_2004_07_48_29_+0100_33QHFpzeo+l/yHXN"
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
Date: Tue, 23 Nov 2004 07:48:29 +0100

--Signature=_Tue__23_Nov_2004_07_48_29_+0100_33QHFpzeo+l/yHXN
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Tue, 23 Nov 2004 07:27:40 +0100 schrieb Marcel Holtmann:

> these are good news. So I really must code the sbcenc tool now. In
> what fields do I have to put the PCM stream and what other things must
> I set?

You'll have to get yourself a shiny new struct sbc_frame, fill in the
metadata and then put the pcm samples in the pcm_sample member. Then do
the regular init (only once), analyze, pack (which do the reverse of
their decoding counterparts).

My test code looked kind of like this:

struct sbc_frame frame;
struct sbc_encoder_state estate;

frame.sampling_frequency =3D 44.1;
frame.blocks =3D 16;
frame.channel_mode =3D DUAL_CHANNEL;
frame.channels =3D 2;
frame.allocation_method =3D SNR;
frame.subbands =3D 8;
frame.bitpool =3D 64;
   =20
for(int i =3D 0; i < frame.subbands*frame.blocks; i++) {
  frame.pcm_sample[0][i] =3D ((double)i /
                (double)(frame.subbands*frame.blocks))* (1<<15);   =20
  frame.pcm_sample[1][i] =3D ((double)i /
                (double)(frame.subbands*frame.blocks))* (1<<15) * (-1);=20
}   =20

sbc_encoder_init(&estate, &frame);
sbc_analyze_audio(&estate, &frame);
framelen =3D sbc_pack_frame(stream+pos, &frame, streamlength-pos-1);


I'm not sure to which value the pcm samples should be normalized. For
starters I'd recommend keeping them between -2^15 and 2^15.

> Actually that is the main point behind using tabs with the size of 8
> spaces. Code that uses too much nested structures become unreadable
> and you start thinking of how you can make this easier and make it
> looking a little bit nicer. In most cases the answer is inline
> functions.

Well yes. For most programs that's entirely true but in this special
case of only a few ever recurring tight loops (some of them even copied
literally from the spec) I don't see how littering the otherwise linear
functionality all over the file would make it easier to read. I'd rather
say the opposite was true.

Oh why, I'll do my very best ...

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Tue__23_Nov_2004_07_48_29_+0100_33QHFpzeo+l/yHXN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBot1BIjWgKE0OA2gRApCrAKDrsxYTCK3rmk1d8LXjuDiXLmxw9wCgveWY
WGNlOqmTct4PtRniEnOiCcs=
=DyA0
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Nov_2004_07_48_29_+0100_33QHFpzeo+l/yHXN--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
