Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42368D18.2000405@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
References: <1110683934.5056.43.camel@pc7.dolda2000.com>	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>	 <423589B1.6000403@xmission.com> <1110809103.5056.102.camel@pc7.dolda2000.com>
In-Reply-To: <1110809103.5056.102.camel@pc7.dolda2000.com>
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
Date: Tue, 15 Mar 2005 00:22:00 -0700

Fredrik

> Another thing, that I'm not sure is a good idea, is to implement a
> "fail-safe" mode in the daemon. Running the daemon in fail-safe mode
> would mean that it doesn't die from not being able to connect to the
> headset. Instead, it would try to reconnect periodically. Same thing if
> the connection is lost at some point. The reason I'm not sure if this is
> a good idea is that one would have to wait for the reconnection attempt
> to get the headset working after making it accessible. Therefore, it may
> well be a good idea to just have to run the daemon manually when one
> knows that the headset is accessible. However, in this case, the daemon
> should at least terminate if it looses the RFCOMM connection to the
> headset. I don't know if it's possible to detect if the RFCOMM
> connection is lost, though. Comments are appreciated.

I don't know about detecting broken rfcomm. I haven't experimented with it.

The way my cell phone works is the headset "connection" is dropped if 
the rfcomm connection is broken. The next call will ring only in the 
handset, not the headset.

We *could* have the daemon attempt to reestablish the rfcomm connection 
when an audio client tries to send/receive audio on a stale link. That 
seems more reasonable than retrying periodically and we might get the 
daemon to the point that it can be left running regardless of the 
transient availability of the target headset.

Next to consider is the convenience of establishing a connection again 
from the headset by advertising audio gateway through sdpd. I think this 
is where Florian is illustrating the similarity to hidd in how we'll 
operate.

BTW, I updated the bug list at sourceforge today.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
