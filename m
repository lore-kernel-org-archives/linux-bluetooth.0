Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] cannot connect to pm-325 phone w/bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050330075106.49322.qmail@web50710.mail.yahoo.com>
References: <20050330075106.49322.qmail@web50710.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1112169481.9016.232.camel@pegasus>
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
Date: Wed, 30 Mar 2005 09:58:01 +0200

Hi John,

> That is bizarre, as I remember trying the next
> recommendation and sending the output that I got.
> 
> well, here it is again...
> 
> 
> sdptool browse
> Inquiring ...
> Browsing 08:00:37:12:C4:B1 ...
> Service Search failed: Connection timed out
> 
>  sdptool search --bdaddr 08:00:37:12:C4:B1  OPUSH
> Searching for OPUSH on 08:00:37:12:C4:B1 ...
> 
> got that for every service I specified.

first you need to know what service you wanna use. If you see failures
like this, then run "hcidump -X -V" in another terminal and send in the
output.

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
