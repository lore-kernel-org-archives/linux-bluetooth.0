Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2test problem
From: Marcel Holtmann <marcel@holtmann.org>
To: mohalik@india.hp.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <405E6C9E.1030600@india.hp.com>
References: <405E6C9E.1030600@india.hp.com>
Content-Type: text/plain
Message-Id: <1079937432.2663.78.camel@pegasus>
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
Date: Mon, 22 Mar 2004 07:37:12 +0100

Hi Swarup,

> I have BlueZ on a red hat 8 linux kerner 2.6.0.
> I have built all the modules for bluetooth (I believe so).
> 
> I am able to send and receive to/from a Nokia 3650 via Obex Push.
> I can establish a ppp connection as well and browse the web.
> 
> After all this, when I ran
>     l2test -s <phone bt address>,
> 
> I get the following output
> [root@lx98218 tools]# cd ../test;./l2test -s 00:60:57:4A:25:DB
> l2test[11744]: Can't connect. Connection refused(111)
> 
> hcidump data
> 
> [root@lx98218 bluetooth]# hcidump
> HCIDump - HCI packet analyzer ver 1.6
> device: hci0 snap_len: 1028 filter: 0xffffffff
>  > HCI Event: Link Key Notification(0x18) plen 23
>  > HCI Event: Connect Complete(0x03) plen 11
> < ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 4097 scid 0x0040
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>  > HCI Event: Command Complete(0x0e) plen 6
>  > HCI Event: Number of Completed Packets(0x13) plen 5
>  > HCI Event: Max Slots Change(0x1b) plen 3
>  > ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 2 status 0
>  > HCI Event: QoS Setup Complete(0x0d) plen 21
> < HCI Command: Disconnect(0x01|0x0006) plen 3
>  > HCI Event: Command Status(0x0f) plen 4
>  > HCI Event: Disconn Complete(0x05) plen 4
> 
> The original l2test.c uses PSM 10, which gives identical failure.

may you wanna take a look at the Bluetooth specification and search for
result code 2 of the L2CAP connect response ;)

	0x0002 Connection refused - PSM not supported.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
