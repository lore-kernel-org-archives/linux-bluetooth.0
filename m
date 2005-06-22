Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B9B2E4.8090008@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>	 <1119374946.26772.119.camel@pegasus>  <42B8563E.9040008@xmission.com>	 <1119378538.26772.127.camel@pegasus>  <42B86FD5.8020204@xmission.com>	 <1119387838.26772.134.camel@pegasus>  <42B8ADC8.6010802@xmission.com> <1119399984.26772.145.camel@pegasus> <42B919BB.6000107@xmission.com>
In-Reply-To: <42B919BB.6000107@xmission.com>
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
Date: Wed, 22 Jun 2005 12:50:12 -0600

guys

> I think a function to do the conversion from double to fixed will 
> require linking libm (for trunc(double) etc) so hopefully we can avoid it.

duh. this conversion is actually very easy and so i committed an inline 
func for doing it.

so i committed the fixed point tables (hopefully the conversion went ok) 
and a little helper app that generated them. i am going to have to get 
back to this later in the week or next week.

brad


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
