Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] L2Ping / Rfcomm connect : Function not
	implemented
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412131243.08426.wim.delvaux@adaptiveplanet.com>
References: <200412122356.09617.wim.delvaux@adaptiveplanet.com>
	 <200412131147.13321.wim.delvaux@adaptiveplanet.com>
	 <1102935713.8750.116.camel@pegasus>
	 <200412131243.08426.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102938476.8750.145.camel@pegasus>
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
Date: Mon, 13 Dec 2004 12:47:56 +0100

Hi Wim,

> > why is this device running in security mode 3 ??? As I always said, you
> > should use "auth" and "encrypt" only if you know what you are doing. And
> > btw the "good old" 0x72 firmware is old and can result in unexpected
> > behaviour with non-CSR chips.
> 
>  Can I upgrade that firmware on an Ipaq 3870 ???

it should be possible, but I don't think that you will get a firmware
file for it or even a tool that can do it.

>  So just remove auth enable;. then

You should at least try this, because I never had any problems with my
iPAQ 3970 and any mobile phone.

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
