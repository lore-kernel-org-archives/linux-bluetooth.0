Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluepin ERROR with RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <f16b04cf05033022021405d585@mail.gmail.com>
References: <f16b04cf05033022021405d585@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112554304.8263.0.camel@pegasus>
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
Date: Sun, 03 Apr 2005 20:51:44 +0200

Hi Hariharan,

>       we have bind the RFCOMM with bluetooth device using 
> 
> rfcomm bind 0 <BD_ADDR> 1
>      binding was successful.
> 
> while connecting the device with RFCOMM we get error,
>       Cannot connect RFCOMM socket: 
> 
> As per your mailing list, we checked the HCID dameon running state 
> and bluepin working status.
> 
> we found that bluepin is not working properly it returns ERR.

use either the bind or the connect method of the rfcomm utility. If you
bind then open /dev/rfcomm0 to connect. Check with "hcidump -X -V" for
further problems.

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
