Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42377AFF.8030405@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
References: <1110683934.5056.43.camel@pc7.dolda2000.com>	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>	 <423589B1.6000403@xmission.com>	 <1110809103.5056.102.camel@pc7.dolda2000.com>	 <42368D18.2000405@xmission.com> <1110930125.19889.13.camel@pc7.dolda2000.com>
In-Reply-To: <1110930125.19889.13.camel@pc7.dolda2000.com>
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
Date: Tue, 15 Mar 2005 17:17:03 -0700

Fredrik

> I just saw that sometimes the kernel apparently notices a broken RFCOMM
> channel and closes the socket. I don't know yet what might trigger it
> apart from an explicit disconnect.

wandering out of range, powering off the headset, suspending the laptop 
are the ones I would run into.

> Either way, it made the btsco daemon chew up 100% CPU, so I added a case
> to detect it and exit for now. If it should be handled otherwise, that
> can be fixed when it is figured out what it should do instead.

ok

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
