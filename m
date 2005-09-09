Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] sbc decoder unrolled
Message-ID: <C70061B183DE09419568AB2060C52A95C7C7E7@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Fri, 9 Sep 2005 15:56:19 +0200

Brad,

I think I know another way of getting rid of shifting for the sample
history array (X[] in case of encoder). If I use double sized array (160
elements instead of 80), copy incoming data twice (to both halfs of the
array) and passing a modulo 80 (40 for 4 subbands) index (increased by
8(4) each of the runs) to _sbc_analyse8(4)(), I will eliminate data
shifting at price that I have to copy incoming data twice. So for 8
subbands instead of 72 + 8 mem copies I will have 8+8 mem copies... This
would not require any smart index calculations.

Sorry, just an idea, it might be applicable only to the encoder, do not
have access/time to the code right know, will implement it when I can
(I'm going on vacation for a week)...

Regards,
    Victor.=20

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
Midgley
Sent: Friday, September 09, 2005 15:16 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc decoder unrolled

Victor,

Yeah, the only thing I didn't like about it is adding a bunch of
computed array index and index modulo operations... I think we end up
coming out ahead but I didn't test it specifically.

I could also double the size of sbc_proto_x_x0 and then I wouldn't have
to worry about the modulo ops wrapping around our indexing into it. That
will hurt any kind of caching of the array however.

Brad

Victor Shcherbatyuk wrote:
> Brad,
>=20
> I'll check if I can do the same for the encoder, getting rid of that=20
> array shifting might speed up the stuff (well, it will probably add=20
> some array index operations which might make things worse, but we will
see).
>=20
> Regards,
>     Victor.
>=20
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad=20
> Midgley
> Sent: Friday, September 09, 2005 7:37 AM
> To: BlueZ Mailing List
> Subject: [Bluez-devel] sbc decoder unrolled
>=20
> Hey
>=20
> woohoo... I worked over the decoder a lot more and finally unrolled &=20
> committed it. It still uses floating point for now.
>=20
> I was very proud of the fact that I found a way to rotate which=20
> sbc_proto_x_x0 value we choose rather than shifting matrixed values=20
> around in every loop. It's even more clear that the implementation=20
> they illustrate in the spec is meant to make the algorithm clear but=20
> not be an efficient way to do it.
>=20
> I don't know how the instruction cache size in arm compares to x86. I=20
> haven't checked to see yet if unrolling is as big a win on xscale.=20
> fwiw, it cut x86 cpu use by about 50% over the looped code.
>=20
> I'll look at fixed point next.
>=20
> Brad
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO=20
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
> Practices Agile & Plan-Driven Development * Managing Projects & Teams=20
> * Testing & QA Security * Process Improvement & Measurement *=20
> http://www.sqe.com/bsce5sf=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20
>=20
> This e-mail message contains information which is confidential and may
be privileged. It is intended for use by the addressee only. If you are
not the intended addressee, we request that you notify the sender
immediately and delete or destroy this e-mail message and any
attachment(s), without copying, saving, forwarding, disclosing or using
its contents in any other way. TomTom N.V., TomTom International BV or
any other company belonging to the TomTom group of companies will not be
liable for damage relating to the communication by e-mail of data,
documents or any other information.
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO=20
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
> Practices Agile & Plan-Driven Development * Managing Projects & Teams=20
> * Testing & QA Security * Process Improvement & Measurement *=20
> http://www.sqe.com/bsce5sf=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle
Practices Agile & Plan-Driven Development * Managing Projects & Teams *
Testing & QA Security * Process Improvement & Measurement *
http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


This e-mail message contains information which is confidential and may be=
 privileged. It is intended for use by the addressee only. If you are not=
 the intended addressee, we request that you notify the sender immediatel=
y and delete or destroy this e-mail message and any attachment(s), withou=
t copying, saving, forwarding, disclosing or using its contents in any ot=
her way. TomTom N.V., TomTom International BV or any other company belong=
ing to the TomTom group of companies will not be liable for damage relati=
ng to the communication by e-mail of data, documents or any other informa=
tion.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
