Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sbc and fixed-point progress
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42C8B510.7080206@xmission.com>
References: <42C8B510.7080206@xmission.com>
Content-Type: text/plain
Message-Id: <1120475470.10273.99.camel@pegasus>
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
Date: Mon, 04 Jul 2005 13:11:10 +0200

Hi Brad,

> I found a decent fixed point multiply that preshifts the values before
> multiplying them. It keeps things in 32 bits. Most of the roundoff error
> is taken care of in two additional terms. I think the result is
> reasonable.
> (http://www.accu.org/acornsig/public/caugers/volume2/issue6/fixedpoint.html)
> 
> If you compile with fixed-point on, libsbc will run both the
> fixed and floating point calculations and flag errors when they differ
> too much. It seems to be working well and has helped me catch a couple
> of fixed-point calculation problems.
> 
> I have the decoder almost finished but I probably need to split some 
> terms into integer and fixed-point components. Loading up 
> frame->sb_sample for example can have a big integer part but we want to 
> use most of the 32 bit fixed-point type for the fractional part.

go ahead and keep on with the good work.

However someone might be looking at the SBC algorithm itself. I've been
told that there are a lot of optimizations possible.

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
