Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] combination keys support?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <27620.1100470371@www17.gmx.net>
References: <27620.1100470371@www17.gmx.net>
Content-Type: text/plain
Message-Id: <1100473781.21403.95.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Nov 2004 00:09:40 +0100

Hi Marco,

> here the dump starting when i enter the pin in the mobile phone:
> 
> ----- start -----
> > HCI Event: PIN Code Request (0x16) plen 6
>   8E 08 52 ED 0E 00
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>   8E 08 52 ED 0E 00 01 31 00 00 00 00 00 00 00 00 00 00 00 00
>   00 00 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0D 04 00 8E 08 52 ED 0E 00
> > HCI Event: Link Key Notification (0x18) plen 23
>   8E 08 52 ED 0E 00 B9 2F DD 2F 51 0C 91 E3 79 3C 53 8A C1 54
>   22 50 01
> > ACL data: handle 0x0000 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> < ACL data: handle 0x0000 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > HCI Event: Disconn Complete (0x05) plen 4
>   00 00 00 29
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 00 00 01 00
> ----- stop -----
> 
> the mobile phone tells me "pairing and connection rejected for security
> reason".
> Then "disconnected from ..."
> if i enter an wrong pin, another message appears.

this is really weird. The error code 0x29 means "pairing with unit key
not supported", but actually it sends out the link key notification. It
tell us that the link key is a local unit key. Whatever local means in
this case. And the PIN code request happens before the SABM on the
control DLCI 0. There is something fundamental wrong.

What device do you use (hciconfig -a)? What kind of phone is this
(hcitool info <bdaddr>)?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
