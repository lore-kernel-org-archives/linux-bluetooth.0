Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] L2Ping / Rfcomm connect : Function not
	implemented
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412122356.09617.wim.delvaux@adaptiveplanet.com>
References: <200412122356.09617.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102924939.8750.84.camel@pegasus>
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
Date: Mon, 13 Dec 2004 09:02:19 +0100

Hi Wim,

> If I  execute on my 3870 Ipaq
> 
> l2ping 00:60:57:35:81:B6
> 
> Where the BDAddr is of a Nokial 6310 telephone 
> 
> I get the above error. 
> 
> Hcidump -x shows
> 
> 
> < HCI Command: Create Connection(0x01|0x0005) plen 13
>   B6 81 35 57 60 00 18 CC 02 00 00 00 01
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 05 04
> > HCI Event: Connect Complete(0x03) plen 11
>   1F 00 00 B6 81 35 57 60 00 01 00
> 
> If I read the specs properly 0x1f is a 'unspecified error' ;-(
> 
> What could be wrong ?

show us "hciconfig -a" from the iPAQ.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
