Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405291108.06457.cijoml@volny.cz>
References: <200405290256.06151.cijoml@volny.cz>
	 <1085820898.3932.6.camel@pegasus>  <200405291108.06457.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1085901284.12117.118.camel@pegasus>
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
Date: Sun, 30 May 2004 09:14:44 +0200

Hi Michal,

> > The problem is not the vendor ID. It is the digital signature of the
> > firmware file. You can download everything you want onto your dongle,
> > but it can happen that the boot loader don't boot the other firmware. In
> > that case it will stay in DFU mode. The boot loader can only be changed
> > over a SPI connection.
> 
> That means, that if I download from dongle original firmware and then flash 
> other one into dongle and it will not work I can't flash original fw back?

this is not quite right. It can happen that the boot loader will load
your current firmware, but in case of a DFU download it will not accept
its own firmware. Now your dongle will stay in DFU mode and it is
useless. The only way to get the firmware back it through SPI.

> What is SPI connection?

Besides UART and USB it is the third interface of the CSR chips. Mainly
used for development and sometimes the only way to get a device working
again.

> Any related docs?

Many of them, but not publicly available.

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
