Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Re: hciattach problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <420BB138.1080201@web.de>
References: <420BB138.1080201@web.de>
Content-Type: text/plain
Message-Id: <1108063022.15974.121.camel@pegasus>
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
Date: Thu, 10 Feb 2005 20:17:02 +0100

Hi Andreas,

> >actually I asked you to test 2.6.11-rc3 and not the -mh3. I want to be
> >sure that the latest testing kernel before the final 2.6.11 has no
> >problems with it. So grab 2.6.11-rc3-bk3 and test it please.
> >  
> I now have tested with 2.6.11-rc3-bk3 and the freez is back.
> The last message in /var/log/messages is:
> Feb 10 19:38:59 tuxlaptop exiting on signal 15
> 
> The messages at shutdown are:
> 
> Shuting down PCMCIA cardmgr [3595]: check cmd exited with status 1
> cardmgr[3595]: exiting: `./serial stop ttyS16 2>&1`
> cardmgr[3595]: +/dev/ttyS16:
> 
> The system hangs at this point. Only a power off does help. It seams, 
> that there have been changes in PCMCIA or serial, because the messages 
> with 2.6.10-mh3 look different. When I dont attach the card with 
> hciattach the system shuts down, but there's also a error.
> The last message in the log is also "exiting on signal 15".

please try 2.6.11-rc3-bk7 and what does "modinfo bluetooth" say?

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
