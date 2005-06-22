Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B8ADC8.6010802@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>	 <1119374946.26772.119.camel@pegasus>  <42B8563E.9040008@xmission.com>	 <1119378538.26772.127.camel@pegasus>  <42B86FD5.8020204@xmission.com> <1119387838.26772.134.camel@pegasus>
In-Reply-To: <1119387838.26772.134.camel@pegasus>
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
Date: Tue, 21 Jun 2005 18:16:08 -0600

Marcel

> http://www.underbit.com/products/mad/
> I think they have the fastest MP3 decoder at the moment.

wow, their fixed-point math looks great. Its range is about +/- 8.0 so I 
just need to run some tests and make sure all the variables and 
intermediate results stay in that range.

in fact, I'd like to drop it in as-is, but is it a non-starter to have a 
GPL component (mad_fixed_t etc) inside our LGPL library (libsbc)? Could 
we just say that apps linked against the integer version of libsbc must 
be GPL? Putting a requirement like this on users of the library wouldn't 
be unprecedented.

argh. it's only a few pages of code but it's perfect for what we're 
doing. did they dredge this out of a computer science algorithms 101 
textbook perchance? :)

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
