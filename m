Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Initial support for the BPA 100/105 sniffers
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20050314T161343-122@post.gmane.org>
References: <1107294719.9652.81.camel@pegasus>
	 <loom.20050314T161343-122@post.gmane.org>
Content-Type: text/plain
Message-Id: <1110817752.629.23.camel@pegasus>
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
Date: Mon, 14 Mar 2005 17:29:12 +0100

Hi Andreas,

> I have one for testing (more sniffing) the telematic devices coming from our 
> suppliers.
> Up to now we are using it with windows. But now we will have a deeper look to 
> your support for the BPA105 :-) 

I never thought that these sniffers are still in use. I would be great
to increase the Linux support for them. However be aware of that the
current code is not able to sniff encrypted traffic. I also still don't
have any idea how to differ between traffic from the master and the
slaves.

> We plan to switch to kernel 2.6.10 with your patches within the next two weeks.

It seems that people are really beginning to love the 2.6.10 kernel, but
personally I would see them to use 2.6.11.x.

> By the way, it's nice to have bluez for testing ...

me, too :)

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
