Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Service registering but not visible
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Stoddart <d.stoddart@cs.ucl.ac.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000701c46c08$958becd0$af2dbeac@oemcomputer>
References: <000d01c46b72$fb6af0f0$8425b9ac@oemcomputer>
	 <1090012501.9117.29.camel@pegasus>
	 <000701c46c08$958becd0$af2dbeac@oemcomputer>
Content-Type: text/plain
Message-Id: <1090078779.4558.35.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 17 Jul 2004 17:39:39 +0200

Hi Daniel,

> I tried the commands you suggested with the following results:
> 
> root@darkstar:~# hcid
> root@darkstar:~# /usr/sbin/sdpd

after that check what /proc/bluetooth/l2cap is saying.

> root@darkstar:~# hcitool dev
> Devices:
>         hci0    00:0A:3A:50:2F:2D
> root@darkstar:~# hcitool inq
> Inquiring ...
>         00:0E:6D:11:E6:EB       clock offset: 0x4c21    class: 0x500204
> root@darkstar:~# sdptool add --channel=13 OPUSH
> OBEX Object Push service registered
> root@darkstar:~# sdptool browse local
> Browsing FF:FF:FF:00:00:00 ...
> Service Search failed: Protocol error

That is the problem. Make sure that sdpd is really running.

> root@darkstar:~# hcidump -x
> HCIDump - HCI packet analyzer ver 1.9
> device: hci0 snap_len: 1028 filter: 0xffffffff
> 
> root@darkstar:~# hcidump -x
> HCIDump - HCI packet analyzer ver 1.9
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>   EB E6 11 6D 0E 00 04 02 50 01
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   EB E6 11 6D 0E 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Connect Complete (0x03) plen 11
>   00 29 00 EB E6 11 6D 0E 00 01 00
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>   29 00 0E 00
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>   EB E6 11 6D 0E 00 01
> > HCI Event: Command Complete (0x0e) plen 6
>   01 0D 08 00 29 00
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>   29 00 18 CC
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0041
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 2 status 0

This means "Connection refused - PSM not supported" and leads to me that
the sdpd is not running.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
