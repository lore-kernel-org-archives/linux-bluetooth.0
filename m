Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405301229.25546.cijoml@volny.cz>
References: <200405290256.06151.cijoml@volny.cz>
	 <200405291108.06457.cijoml@volny.cz> <1085901284.12117.118.camel@pegasus>
	 <200405301229.25546.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1085914997.5925.1.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 30 May 2004 13:03:17 +0200

Hi Michal,

> Did you write some tool for linux to communicate via SPI?

do you know any dongle with SPI ;)

> I tried your btdfu-0.2 and I was not allowed to dowload firmware to it :(

I never released a version with download support. Currently only upload
is supported.

> and archive with 2 dongles doesn't work too.
> notas:/usr/src/btdfu-0.2/src# ./btdfu -d 03ee:641f archive test
> Searching for devices ...
>         002/002 03ee:641f 114
>         004/002 045e:007e 505

I know. Unplug one of your dongles and try again ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
