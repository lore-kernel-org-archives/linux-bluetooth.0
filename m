Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with security mode 3
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030703173538.063183a8@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030703173538.063183a8@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1057279722.27638.1.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 04 Jul 2003 02:48:35 +0200

Hi Max,

> >there is a little problem with local devices in security mode 3
> >(hciconfig hci0 auth). If you have already paired two devices, but you
> >have used your dongle within another OS and paired it again to the same
> >remote device. The local link key stored by the hcid is outdated. But
> >this can not be known by the hcid and so it sends it on the next
> >connection request. The remote device will deny the connection because
> >of the wrong link key, but the error you get is not an authentication
> >failure. You get the timeout error from the L2CAP layer.
> >
> >        < HCI Command: Write Authentication Enable(0x03|0x0020) plen 1
> >          01 
> >        > HCI Event: Command Complete(0x0e) plen 4
> >          01 20 0C 00 
> >        < HCI Command: Create Connection(0x01|0x0005) plen 13
> >          FD 06 81 0E 04 00 18 CC 01 00 00 00 01 
> >        > HCI Event: Command Status(0x0f) plen 4
> >          00 01 05 04 
> >        > HCI Event: Link Key Request(0x17) plen 6
> >          FD 06 81 0E 04 00 
> >        < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> >          FD 06 81 0E 04 00 38 06 D7 5D E2 DD FD 10 88 EF 5A 65 66 C2 
> >          80 26 
> >        > HCI Event: Connect Complete(0x03) plen 11
> >          05 00 00 FD 06 81 0E 04 00 01 00 
> >
> >I have looked at hci_conn_complete_evt() and l2cap_connect_cfm() and the
> >code seems correct to me.
> >
> >If you try to connect again after the timeout, you will get a "Operation
> >already in progress" error.
> >
> >Where is the problem?
> Did you pull all of my latest fixes ? That bug was introduced by 
> SO_LINGER patch (bt_sock_wait_state() to be more specific). I fixed it 
> some time ago (should be in -pre2). The bug is unrelated to security 
> and stuff and affects connect in general (ie it'd timeout instead of an error).

it is still present in 2.4.22-pre2 :(

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
