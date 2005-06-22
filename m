Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: =?ISO-8859-1?Q?Henryk_Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
In-Reply-To: <42B919BB.6000107@xmission.com>
Message-ID: <Pine.LNX.4.62.0506222203110.4779@server1.ploetzli.ch>
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>
 <1119374946.26772.119.camel@pegasus>  <42B8563E.9040008@xmission.com>
 <1119378538.26772.127.camel@pegasus>  <42B86FD5.8020204@xmission.com>
 <1119387838.26772.134.camel@pegasus>  <42B8ADC8.6010802@xmission.com>
 <1119399984.26772.145.camel@pegasus> <42B919BB.6000107@xmission.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811694-1231436046-1119471781=:4779"
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
Date: Wed, 22 Jun 2005 22:23:01 +0200 (CEST)

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811694-1231436046-1119471781=:4779
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Moin,

On Wed, 22 Jun 2005, Brad Midgley wrote:

> One strange thing was I had to abandon using int32_t as the native type. =
For=20
> some reason, math ops on these things that should have used 64 bits for=
=20
> intermediate results instead used 32-bit intermediates. Anyway, using the=
=20
> type "int" outright made it work as expected.

So now you're going to bigger-than-32-bit integers anyways?

Some time ago I already stated that using 32 bit for the floating point=20
presentation with 16 bits before the decimal point and 16 bits after=20
should be enough. (PCM and reconstructed subband samples should not exceed=
=20
16 bits and all intermediary values should only be fractions of these=20
samples. I might have forgotten one bit for the sign, though.)

But then intermediate results during multiplication need an additional 16=
=20
bits and your platform therefore needs to be able to handle (at least) 48=
=20
bit integers without falling back to floating-point emulation speeds.

If it can do that, then of course doing fixed point should be easy:=20
Addition, multiplication and shift work unchanged. Each multiplication=20
must be followed by a shift right 16 bits. Conversion integer -> fixed=20
point or fixed point -> integer is shift left 16 bits or shift right 16=20
bits respectively. And that would be about all we need, I think. (I can't=
=20
check right now because my laptop is broken and out for repair since some=
=20
time.)

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
---1463811694-1231436046-1119471781=:4779--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
