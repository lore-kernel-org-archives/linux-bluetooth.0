Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405290256.06151.cijoml@volny.cz>
References: <200405290256.06151.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1085820898.3932.6.camel@pegasus>
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
Date: Sat, 29 May 2004 10:54:58 +0200

Hi Michal,

> have anybody downloaded firmware from csr dongle? I would like to make 
> research if is possible to change vendor ID in it and then flash it back. I 
> think it is possibly way to upgrade firmware in old dongles.
> 
> Can somebody give me help how download it? I have now access to 14 different 
> csr based dongles from different wendors, which have same firmware version. 
> So I'll try find differences in firmware.

the software you search for is my btdfu tool.

	http://www.holtmann.org/linux/bluetooth/btdfu-0.2.tar.gz

And you upload a firmware from the dongle (archive mode) and you
download a new one to a dongle (upgrade mode).

The problem is not the vendor ID. It is the digital signature of the
firmware file. You can download everything you want onto your dongle,
but it can happen that the boot loader don't boot the other firmware. In
that case it will stay in DFU mode. The boot loader can only be changed
over a SPI connection.

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
