Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Moving over to GCC 4.0
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42CC0841.9070301@conectiva.com.br>
References: <1120649879.8836.5.camel@pegasus>
	 <42CC0841.9070301@conectiva.com.br>
Content-Type: text/plain
Message-Id: <1120672130.18553.6.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 06 Jul 2005 19:48:50 +0200

Hi Luiz,

> > since Debian Etch now also switched to GCC 4.0 as default compiler, it
> > is time to address all GCC 4.0 problems in the BlueZ source code. I
> > started two days ago with fixing most of its crazy compiler warnings.
> > The GCC 4.0 is really picky with the signedness and so I moved over to
> > explicit types like uint8_t, uint16_t and uint32_t where possible. I now
> > hope that I haven't introduced any signedness bugs. Please start testing
> > the CVS versions of libs and utils.
> 
> Good news. :)
> 
>  I'd like to know if you're going to accept patches which fixes Linus sparse
> warnings, they seems to be trivial though.

I never used sparse outside the kernel, but go ahead and send patches.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
