Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM related oops
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: victor.shcherbatyuk@tomtom.com
In-Reply-To: <Pine.LNX.4.44.0503282103070.7184-201000@antilope>
References: <Pine.LNX.4.44.0503282103070.7184-201000@antilope>
Content-Type: text/plain
Message-Id: <1112045836.9016.56.camel@pegasus>
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
Date: Mon, 28 Mar 2005 23:37:16 +0200

Hi Victor,

> Some more problems...
> 
> The following holds for Motorola V3 (RAZR) and Nokia 6310i (i hope i'm not 
> mistaking), and prob. some more phones I've never seen ;)
> 
> The sequence leading to the oops (oops.txt):
> Open RFCOMM channel exposed as HF channel. Try to open RFCOMM channel 
> exposed as DUN channel for 3 times (first 2 fail, and finally attempt 3 
> gives success). Close RFCOMM channel for DUN. Close RFCOMM channel for HF -> 
> oops.
> 
> Looks like those phones allow only 1 RFCOMM channel to be opened. But 
> strange things happen if you try to connect, when there is 
> already a RFCOMM connection open on another channel (all this story with 
> 3 attempts). 
> 
> What I see from the log (motov3.bin):
> On attempt 2 bluez stack DISC on dlci 0 (for the reason I don't know) 
> where there are still active RFCOMM connections (HF channel, dlci 14 in 
> the log).  So when I try to close HF it oops'es... 
> 
> Have it reproducible on 2 platforms (arm and i386):
> 2.6.11.4 + 2.6.11-mh2 (i386)

I hope this is not because of my fix for the reference counting problem
you found. Check if this still happens with a vanilla 2.6.11 kernel.

If it still happens try to reproduce it without the ndiswrapper. This
taints your kernel and I am not willing to fix buggy Windows drivers.

Next thing is to try it without PREEMPT enabled.

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
