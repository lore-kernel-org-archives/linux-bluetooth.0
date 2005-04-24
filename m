Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050424151621.48134.qmail@web8303.mail.in.yahoo.com>
References: <20050424151621.48134.qmail@web8303.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1114356931.10706.108.camel@pegasus>
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
Date: Sun, 24 Apr 2005 17:35:31 +0200

Hi Mayank,

> > (A question first - did you add the usleep to Mayank
> > code? I'll then
> > take it and try to optimise it for ARM. Last time I
> > just made it
> > barely compile :-)
> 
> It was me who added the usleep to the a2play code.
> this was after trying various parameters to the usleep
> while I was testing my code with BlueSoleil. And the
> number that I got is the one which gives the best
> sound output for almost all music files. 

I haven't noticed that you also played with adding usleep(). I only
tried a2play once on a Logitech headphone and it was terrible. However
this can be the final solution and we need an exact timing source for
proper A2DP support.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
