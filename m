Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pin code problem
From: Marcel Holtmann <marcel@holtmann.org>
To: guang <m9187@cn.ee.ccu.edu.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000c01c41a0c$b0441c80$7b6b7b8c@yaya>
References: <000c01c41a0c$b0441c80$7b6b7b8c@yaya>
Content-Type: text/plain
Message-Id: <1081073411.2839.31.camel@pegasus>
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
Date: Sun, 04 Apr 2004 12:10:11 +0200

Hi,

> I implement an Audio Gateway (PC) to communication a Headset (sony
> ericsson HBH-65), but  AG can't commucation HS. As fllow:
>  
> I type " l2ping 00:0D:E3:00:00:33" 
> and it appear :
>   [root@bluez root]# l2ping 00:0A:D9:A1:F4:49
>   Can't connect.: Permission denied
>  
> and i used hcidump to dump file:
>  
> HCIDump - HCI packet analyzer ver 1.6
> < HCI Command: Create Connection(0x01|0x0005) plen 13
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Link Key Request(0x17) plen 6
> < HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> > HCI Event: Command Complete(0x0e) plen 10
> < HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> > HCI Event: Command Complete(0x0e) plen 10
> < HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> > HCI Event: Command Complete(0x0e) plen 10
> > HCI Event: Connect Complete(0x03) plen 11
> 
> I guess the problem be caused by PIN Code.
> How can I enter PIN Code to response HS.
> How to paring between AG and HS ?

make sure that only one hcid is running.

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
