Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: pand connection to XP SP2 fails
From: Erwin Authried <eauth@softsys.co.at>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <cpmnro$2p5$1@sea.gmane.org>
References: <1103024795.4097.65.camel@justakiss>
	 <1103024932.2143.156.camel@pegasus> <1103025459.4095.68.camel@justakiss>
	 <cpmnro$2p5$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1103036073.4095.101.camel@justakiss>
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
Date: Tue, 14 Dec 2004 15:54:33 +0100

Am Die, den 14.12.2004 schrieb Sebastian Roth um 13:55:
> Hi Erwin,
> 
> ...
> < ACL data: handle 0x0029 flags 0x02 dlen 11
>      L2CAP(d): cid 0x0040 len 7 [psm 15]
>        BNEP: Control(0x01|0)
>          Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
> 
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>    01 29 00 01 00
> 
>  > ACL data: handle 0x0029 flags 0x02 dlen 8
>      L2CAP(d): cid 0x0040 len 4 [psm 15]
>        BNEP: Control(0x01|0)
>          Setup Rsp(0x02) res 0x0001
> ...
> 
> The linux box is asking for a connection but the windows box respondes
> with 0x0001 (Operation Failed: Invalid Destination Service UUID)
> http://grouper.ieee.org/groups/802/15/Bluetooth/BNEP.pdf (page 22)
> 
> So I guess the windows bluetooth stack doesn't provide this service.
> Discover the services it provides with this command:
> 
> hcitool info <bdaddr>
> 
> 
> Best regards,
> Sebastian
> 
Thanks a lot, I found out now that XP SP2 is obviously always configured
as PANU, I didn't find any way to change that. Maybe a different driver
would help to be able to configure it as NAP, I don't know.

Regards,
Erwin




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
