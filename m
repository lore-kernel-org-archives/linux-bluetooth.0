Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USSP compilation problem for linux 2.6
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <f54d8640503160537449496dd@mail.gmail.com>
References: <d1f423d30503071045794c487e@mail.gmail.com>
	 <f54d86405030903455bf71640@mail.gmail.com>
	 <1110391057.5462.30.camel@notepaq>
	 <f54d8640503160537449496dd@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1110981332.11792.32.camel@pegasus>
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
Date: Wed, 16 Mar 2005 14:55:32 +0100

Hi Benny,

> We have purchased a BT Serial port adapter. I am now involved in
> testing this. To one PC I am connecting a Standard BT USB dongle and
> to another PC I am connecting the BT Serial port adaptor.
> 
> I am facing some problems while compiling(On fedora 3 - linux kernel -
> 2.6.9-1.667) the "ussp" source found in the "rfcomm-0.10" source
> downloaded from the
> http://www.holtmann.org/linux/bluetooth/rfcomm.html site.

don't even try to deal the the old RFCOMM implementation. The new one is
inside the kernel and directly integrated into the network socket and
the TTY layer.

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
