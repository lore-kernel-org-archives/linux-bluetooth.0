Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dd - device descriptor HELP :)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <de33c8be05021107172b943a1e@mail.gmail.com>
References: <de33c8be05021107172b943a1e@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1108149073.18099.50.camel@pegasus>
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
Date: Fri, 11 Feb 2005 20:11:13 +0100

Hi Flavio,

> I have two USB dongles connected to my pc. Using both of them in
> MASTER mode, when i do one connection to another bluetooth device (i
> was testing with a cell phone) for both dongles (hci1 and hci0) the
> device descriptor for both connections is the same!!! Shouldn't they
> be different?
> And, apparently, because of this, when i try to set up the second
> connection (connet my hci1 to the cell phone, when the hci0 is
> allready conneted), it fails.
> function used: dd = hci_open_dev(dev_id);

what are you doing? I don't understand what's your problem. Be more
specific. Show more code or commands.

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
