Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Hp bluetooth headset a2dp
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050324165647.GA12921@externe.net>
References: <20050324165647.GA12921@externe.net>
Content-Type: text/plain
Message-Id: <1111683862.1916.77.camel@pegasus>
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
Date: Thu, 24 Mar 2005 18:04:22 +0100

Hi Guylhem,

> I didn't have time to play with them for sometime. Guess what happens
> when I try them again today? Acceptable audio !
> Same hardware, same binaries - nothing changed !
> 
> I then realised it was making sudden accelerations (little by little),
> then suddently going back to normal, and so on during audio playback.
> 
> subbands = 1
> allocation method = 1
> channel_mode = 2
> blocks = 3
> sampling frequency = 2
> bitpool = 32
> frame len = 72
> Using address: 00:0D:44:2A:09:00
> 
> I started to do something else, and now even after power cycling,
> relinking, it's not playing anymore.
> 
> Wow. Any idea on that strange beast?
> 
> PS: I was suggested to try to record a session of normal audio
> interaction. How can it be done? I'll try to borrow a frieds ipaq and
> see how it is supposed to work.

does somebody wants to donate one of these to me? Then I can start
looking what's the problem with them. I think our AVDTP implementation
is not quite right and needs some more work at the timing part of the
stream sending.

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
