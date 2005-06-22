Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B919BB.6000107@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>	 <1119374946.26772.119.camel@pegasus>  <42B8563E.9040008@xmission.com>	 <1119378538.26772.127.camel@pegasus>  <42B86FD5.8020204@xmission.com>	 <1119387838.26772.134.camel@pegasus>  <42B8ADC8.6010802@xmission.com> <1119399984.26772.145.camel@pegasus>
In-Reply-To: <1119399984.26772.145.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 22 Jun 2005 01:56:43 -0600

Marcel

It actually isn't that bad to do multiply and divide ops using fixed 
point. I committed a change that provides a config option --enable-fixed 
and provides the datatype and inline functions for the basic math ops 
and conversions (add and subtract don't need anything special)

I like the flexibility of keeping an LGPL license as long as we can.

I used the explanation in 
http://home.rochester.rr.com/ohommes/MathFP/mathfp_bg.html which is a 
lot better than trying to figure out or tear out code from mad.

One strange thing was I had to abandon using int32_t as the native type. 
For some reason, math ops on these things that should have used 64 bits 
for intermediate results instead used 32-bit intermediates. Anyway, 
using the type "int" outright made it work as expected.

I think a function to do the conversion from double to fixed will 
require linking libm (for trunc(double) etc) so hopefully we can avoid it.

Brad


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
