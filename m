Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
Message-Id: <20041122053213.2685bedd.henryk@ploetzli.ch>
In-Reply-To: <1101093515.7250.97.camel@pegasus>
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
	<20041121064655.0b04dd8a.henryk@ploetzli.ch>
	<1101059050.7250.39.camel@pegasus>
	<1101093515.7250.97.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__22_Nov_2004_05_32_13_+0100_ox.nT5rqS4.yN7rj"
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
Date: Mon, 22 Nov 2004 05:32:13 +0100

--Signature=_Mon__22_Nov_2004_05_32_13_+0100_ox.nT5rqS4.yN7rj
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Mon, 22 Nov 2004 04:18:35 +0100 schrieb Marcel Holtmann:

> I tested again all example files before you moved the bits array
> calculation into an own function. All of them sounded good.

So did I, this time. :-)

> With the latest code you still overwrite the stack at some point,
> because the pcm_sample[][] array is only 2x128 and you return 2x256
> samples from sbc_synthesize_audio() function.

Ahh, thanks. I broke it when I moved the superfluous (I thought)
assignment of current_sample=3D0 out of the channel for loop. Should work
now again.

> I also started to write a simple SBC play program using the libao. It
> works actually quite good linking your sbc.o file, but unfortunately
> with 2 channel files the left channel is silent.

If that was a result of the abovementioned bug it should work now again.

> We should start a new thread and discuss a SBC library.

Sure. I should have the bitstream packer working sometime soon and will
then post again.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Mon__22_Nov_2004_05_32_13_+0100_ox.nT5rqS4.yN7rj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBoWvVIjWgKE0OA2gRAujOAJ9n9H9MWI6fAj2+BxnfnssWoctI1QCgikIi
qRr3z8qnzs02Qv8Yu5+G3g8=
=ddaM
-----END PGP SIGNATURE-----

--Signature=_Mon__22_Nov_2004_05_32_13_+0100_ox.nT5rqS4.yN7rj--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
