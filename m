Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 2-AT command
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050129055215.33954.qmail@web60901.mail.yahoo.com>
References: <20050129055215.33954.qmail@web60901.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1107007571.10735.19.camel@pegasus>
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
Date: Sat, 29 Jan 2005 15:06:11 +0100

Hi Michael,

>     When I ran my main program with "hcidump -t"
> running in other terminal, the following occurs:
> When I choose an item and then the other menu, for
> which the items are found in MySQL DB, is generated,
> the hcidump -t shows
> 1106977607.097970 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977607.099967 > ACL data: handle 0x0029 flags 0x01
> dlen 5
>     L2CAP(d): cid 0x0040 len 18 [psm 0]
> 1106977607.668238 < ACL data: handle 0x0029 flags 0x02
> dlen 38
>     L2CAP(d): cid 0x0040 len 34 [psm 0]
> 1106977607.690862 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977607.716864 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977607.718855 > ACL data: handle 0x0029 flags 0x01
> dlen 17
> 1106977607.719863 > ACL data: handle 0x0029 flags 0x01
> dlen 6
>     L2CAP(d): cid 0x0040 len 36 [psm 0]
> 1106977608.216723 < ACL data: handle 0x0029 flags 0x02
> dlen 15
>     L2CAP(d): cid 0x0040 len 11 [psm 0]
> 1106977608.221762 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977608.246760 > ACL data: handle 0x0029 flags 0x02
> dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 0]
> 1106977608.766719 < ACL data: handle 0x0029 flags 0x02
> dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 0]
> 1106977608.772661 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977608.798667 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977608.800657 > ACL data: handle 0x0029 flags 0x01
> dlen 3
>     L2CAP(d): cid 0x0040 len 16 [psm 0]
> 1106977608.800702 < ACL data: handle 0x0029 flags 0x02
> dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 0]
> 1106977608.806656 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977609.316716 < ACL data: handle 0x0029 flags 0x02
> dlen 14
>     L2CAP(d): cid 0x0040 len 10 [psm 0]
> 1106977609.330564 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977609.356569 > ACL data: handle 0x0029 flags 0x02
> dlen 16
>     L2CAP(d): cid 0x0040 len 12 [psm 0]
> 1106977609.866708 < ACL data: handle 0x0029 flags 0x02
> dlen 20
>     L2CAP(d): cid 0x0040 len 16 [psm 0]
> 1106977609.877461 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977609.903469 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977609.905483 > ACL data: handle 0x0029 flags 0x01
> dlen 5
>     L2CAP(d): cid 0x0040 len 18 [psm 0]
> 1106977610.416722 < ACL data: handle 0x0029 flags 0x02
> dlen 16
>     L2CAP(d): cid 0x0040 len 12 [psm 0]
> 1106977610.433359 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977610.459367 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977610.461362 > ACL data: handle 0x0029 flags 0x01
> dlen 1
>     L2CAP(d): cid 0x0040 len 14 [psm 0]
> 1106977610.966700 < ACL data: handle 0x0029 flags 0x02
> dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 0]
> 1106977610.976260 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977611.002265 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977611.004283 > ACL data: handle 0x0029 flags 0x01
> dlen 3
>     L2CAP(d): cid 0x0040 len 16 [psm 0]
> 1106977611.516716 < ACL data: handle 0x0029 flags 0x02
> dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 0]
> 1106977611.537162 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977611.561163 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977611.563188 > ACL data: handle 0x0029 flags 0x01
> dlen 2
>     L2CAP(d): cid 0x0040 len 15 [psm 0]
> 1106977611.789114 > ACL data: handle 0x0029 flags 0x02
> dlen 16
>     L2CAP(d): cid 0x0040 len 12 [psm 0]
> Then when I choose other item and wait for generating
> other menu, where  the items are also found from MySQL
> DB, the hcidump -t shows
> 1106977778.719674 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977778.721671 > ACL data: handle 0x0029 flags 0x01
> dlen 5
>     L2CAP(d): cid 0x0040 len 18 [psm 0]
> 1106977779.157250 < ACL data: handle 0x0029 flags 0x02
> dlen 38
>     L2CAP(d): cid 0x0040 len 34 [psm 0]
> 1106977779.178591 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977779.202585 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977779.204592 > ACL data: handle 0x0029 flags 0x01
> dlen 17
> 1106977779.206614 > ACL data: handle 0x0029 flags 0x01
> dlen 6
>     L2CAP(d): cid 0x0040 len 36 [psm 0]
> 1106977779.706707 < ACL data: handle 0x0029 flags 0x02
> dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 0]
> 1106977779.717489 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977779.742486 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977779.744493 > ACL data: handle 0x0029 flags 0x01
> dlen 3
>     L2CAP(d): cid 0x0040 len 16 [psm 0]
> 1106977780.256721 < ACL data: handle 0x0029 flags 0x02
> dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 0]
> 1106977780.280395 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977780.306385 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977780.308392 > ACL data: handle 0x0029 flags 0x01
> dlen 2
>     L2CAP(d): cid 0x0040 len 15 [psm 0]
> 1106977780.806713 < ACL data: handle 0x0029 flags 0x02
> dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 0]
> 1106977780.823288 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977780.851297 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977780.853290 > ACL data: handle 0x0029 flags 0x01
> dlen 3
>     L2CAP(d): cid 0x0040 len 16 [psm 0]
> 1106977781.356790 < ACL data: handle 0x0029 flags 0x02
> dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 0]
> 1106977781.364188 > HCI Event: Number of Completed
> Packets (0x13) plen 5
> 1106977781.391194 > ACL data: handle 0x0029 flags 0x02
> dlen 17
> 1106977781.393193 > ACL data: handle 0x0029 flags 0x01
> dlen 2
>     L2CAP(d): cid 0x0040 len 15 [psm 0]
> 1106977781.573153 > ACL data: handle 0x0029 flags 0x02
> dlen 16
>     L2CAP(d): cid 0x0040 len 12 [psm 0]
>     Then does it mean that the items are too much that
> the sending of AT command from PC to T610 has delay?
> And what is the cause of the delay?

run it with "hcidump -t -X" and make sure that your email client don't
insert any line breaks in the dump. And you need to also get the initial
creation of the connection. Otherwise the PSM tracking won't work and
the RFCOMM decoder is not working.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
