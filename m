Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Erasure of records of previously discovered
	devices
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001a01c53b78$a1e1c7d0$344914ac@stu.nus.edu.sg>
References: <001a01c53b78$a1e1c7d0$344914ac@stu.nus.edu.sg>
Content-Type: text/plain
Message-Id: <1112882559.9047.79.camel@pegasus>
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
Date: Thu, 07 Apr 2005 16:02:39 +0200

Hi Teck,

> I wrote a small c program to continuously inquire for nearby bluetooth
> devices and record their address, name and time of discovery. However,
> the program always seems to return a list of devices found earlier,
> even when the discovered device has been switched off. 
>  
> Following is part of the code, which does 5 rounds of inquiry, largely
> derived from Bastian Ballmann's hciscan program. Is there anyway I can
> erase records of previously found devices and do a fresh inquiry
> everytime? 

your code doesn't use hci_inquiry() at all. However you should take a
look a the IREQ_CACHE_FLUSH flag.

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
