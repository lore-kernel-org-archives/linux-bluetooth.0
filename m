Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] cannot connect to pm-325
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050325023814.19446.qmail@web50701.mail.yahoo.com>
References: <20050325023814.19446.qmail@web50701.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1111751727.9195.69.camel@pegasus>
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
Date: Fri, 25 Mar 2005 12:55:27 +0100

Hi John,

> Despite it saying connection refused, the phone, when
> searching/pairing, finds laptop-0, but pair fails
> after i tell it to use 0000 for pin.

for that you need some service running, I think.

> < ACL data: handle 41 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0041 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs
> 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 7
> ack_timer 0
>       frame_size 670 max_retrans 0 credits 7
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41
> > ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 0 ilen 0 fcs 0x66

and here we go. You try to connect to RFCOMM channel 1, but your phone
says that there is not service available on that channel.

Run a "sdptool browse" or "sdptool search" to find out the correct
channel number.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
