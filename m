Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42377AFF.8030405@xmission.com>
References: <1110683934.5056.43.camel@pc7.dolda2000.com>
	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>
	 <423589B1.6000403@xmission.com>
	 <1110809103.5056.102.camel@pc7.dolda2000.com>
	 <42368D18.2000405@xmission.com>
	 <1110930125.19889.13.camel@pc7.dolda2000.com>
	 <42377AFF.8030405@xmission.com>
Content-Type: text/plain
Message-Id: <1110938218.19889.16.camel@pc7.dolda2000.com>
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
Date: Wed, 16 Mar 2005 02:56:58 +0100

On Tue, 2005-03-15 at 17:17 -0700, Brad Midgley wrote:
> Fredrik
> 
> > I just saw that sometimes the kernel apparently notices a broken RFCOMM
> > channel and closes the socket. I don't know yet what might trigger it
> > apart from an explicit disconnect.
> 
> wandering out of range, powering off the headset, suspending the laptop 
> are the ones I would run into.

In a perfect world, yes. But the question is: Does the kernel actually
detect wandering out of range, and if so, after how long? If the kernel
can't detect it, is there a way of periodically pinging the headset to
detect it manually?

Fredrik Tolf




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
