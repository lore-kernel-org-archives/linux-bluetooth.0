Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to get bluetooth to emulate comport?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050321091923.29784.qmail@web50701.mail.yahoo.com>
References: <20050321091923.29784.qmail@web50701.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1111404610.22872.46.camel@pegasus>
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
Date: Mon, 21 Mar 2005 12:30:10 +0100

Hi John,

>  Not been prompted to enter pin, keep getting 
>  
>  Can't connect RFCOMM socket: Connection refused
>  
>  despite scan finding the device.
>  
>  put those lm and lp entries in hcid.conf, and even
>  tried(afterward)putting the following in rfcomm.conf
>  
>  rfcomm0 {
>  bind no;
>  device    08:00:37:12:C4:B1;
>  channel   1;
>  comment   "PM325 by LG";
>  }
>  
> 
>  any ideas?

what about starting a new mailing list thread with a new posting to the
correct mailing list with your problem?

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
