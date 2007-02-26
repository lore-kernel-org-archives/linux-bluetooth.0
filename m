Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <752642.79554.qm@web31711.mail.mud.yahoo.com>
References: <752642.79554.qm@web31711.mail.mud.yahoo.com>
Date: Mon, 26 Feb 2007 10:36:54 +0100
Message-Id: <1172482614.27370.11.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] tryig to get bluetooth keyboad to work
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Tim,

> Thanks for the response.
> 
> Heres my hciconfig right after it locks up.
> 
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 2 packets 1
> > ACL data: handle 2 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x00
> result 0 clen 4
>       Success
>       MTU 48 
> > HCI Event: QoS Setup Complete (0x0d) plen 21
>     status 0x00 handle 2 flags 0
>     Service type: 1
>     Token rate: 0
>     Peak bandwith: 0
>     Latency: 11250
>     Delay variation: -1
> < ACL data: handle 2 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Output report
>       0000: 01 00 00 00 00 00 00 00  00               
>        .........
> < ACL data: handle 2 flags 0x02 dlen 7
>     L2CAP(d): cid 0x0041 len 3 [psm 19]
>       HIDP: Data: Output report
>       0000: 02 00                                     
>        ..
> < ACL data: handle 2 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Output report
>       0000: 05 00 00 00 00 00 00 00  00               
>        .........
> < ACL data: handle 2 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 19]
>       HIDP: Data: Output report
>       0000: 06 00 00                                  
>        ...
> < ACL data: handle 2 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Output report
>       0000: 05 00 00 00 00 00 00 00  00               
>        .........
> > ACL data: handle 2 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0041 len 10 [psm 19]
>       HIDP: Data: Input report
>       0000: 05 44 7c 72 d3 c9 03 00  00               
>        .D|r.....

you might wanna try a 2.6.20-mh1 kernel. That has full report mode
support and might make it work without issues.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
