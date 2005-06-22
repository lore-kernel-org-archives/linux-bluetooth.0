Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5256d0b05062123457f881104@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
In-Reply-To: <1119387838.26772.134.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>
	 <1119374946.26772.119.camel@pegasus> <42B8563E.9040008@xmission.com>
	 <1119378538.26772.127.camel@pegasus> <42B86FD5.8020204@xmission.com>
	 <1119387838.26772.134.camel@pegasus>
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
Date: Wed, 22 Jun 2005 07:45:07 +0100

> > as far as integer stuff, should we be doing something like a short floa=
t
> >
> > struct sfloat {
> >   int16 mantissa;
> >   uint8 exponent;
> > }
> >
> > or a fixed point 32-bit value? any idea what part of the 32 bits would
> > be best to have in front and behind the decimal?
> >
> > i guess i should start by having libsbc keep track of ranges of the
> > different floats so we can figure out where the precision needs to be.
>=20
> Look at how the MAD project does it:
>=20
> http://www.underbit.com/products/mad/

The development version of the speex library which has a lot of fixed
point stuff which generic implementation and some arch specific ones
may be a good place to look too. www.speex.org

Pete


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
