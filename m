Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] obexserver and t68i problem?
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407251403.50608.cijoml@volny.cz>
References: <200407251403.50608.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1090758097.4791.81.camel@pegasus>
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
Date: Sun, 25 Jul 2004 14:21:38 +0200

Hi Michal,

> after a long time I needed send photos from my phone to bluez box.
> 
> sdpd
> sdptool add --channel=10 OPUSH
> obexserver
> 
> Mobile finds bluez box, try send, but writes connection problem:
> 
> here is output of hcidump
> 
> # hcidump -x
> HCIDump - HCI packet analyzer ver 1.9
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>   51 EC FC D9 0A 00 04 02 52 01
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   51 EC FC D9 0A 00 00
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Connect Complete (0x03) plen 11
>   1A 2F 00 51 EC FC D9 0A 00 01 00

you can easily look up the error code in the Bluetooth spec. part D. It
says that 0x1a means "unsupported remote feature":

	The Unsupported Remote Feature error code indicates that the
	remote device does not support the feature associated with the
	issued command or LMP PDU.

If I remember correctly then there was an email from a CSR guy that
explained how to interpret these LMP related error messages.

Frist guess is that it is a role switch or scatternet problem.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
