Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth serial vs. audio connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0503271813180.3135@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.62.0503271303450.3134@ybpnyubfg.ybpnyqbznva>
	 <1111923433.9195.216.camel@pegasus>
	 <Pine.LNX.4.62.0503271357080.3134@ybpnyubfg.ybpnyqbznva>
	 <1111926923.9195.218.camel@pegasus>
	 <Pine.LNX.4.62.0503271736360.3135@ybpnyubfg.ybpnyqbznva>
	 <1111938339.9195.229.camel@pegasus>
	 <Pine.LNX.4.62.0503271751420.3135@ybpnyubfg.ybpnyqbznva>
	 <1111939568.9195.236.camel@pegasus>
	 <Pine.LNX.4.62.0503271813180.3135@ybpnyubfg.ybpnyqbznva>
Content-Type: text/plain
Message-Id: <1111942691.9195.241.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 27 Mar 2005 18:58:11 +0200

Hi Andreas,

> >MH: > If I just run sdptool browse 00:xx, I don't get any output, I'm 
> >MH: > not sure, this is the normal behavior. I see this as a problem, 
> >MH: > as there are some supported services. But then, I didn't check 
> >MH: > the code of this tool.
> >MH: 
> >MH: this does not answer my question. What kind of phone is this? Does 
> >MH: adding "--tree" before the "--bdaddr" parameter helps?
> 
> Yes, I misread the question. This is a Samsung SGH-D500 (a nice phone 
> but crappy windows software...)
> 
> No difference. With or without --tree, there is only one line of output 
> "Browsing 00:xx ...", nothing else

I actually meant the "spdtool search" part to see if the segmentation
fault is still present then. However, again the bad Samsung phone. I
think I need one of these at home for fixing this thing.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
