Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050330020952.80645.qmail@web50702.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
Subject: Re: [Bluez-users] cannot connect to pm-325 phone w/bluez
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 29 Mar 2005 18:09:52 -0800 (PST)

This is the last response I got from you.

Hi John,

> Despite it saying connection refused, the phone,
when
> searching/pairing, finds laptop-0, but pair fails
> after i tell it to use 0000 for pin.

for that you need some service running, I think.

> < ACL data: handle 41 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0041 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10
fcs
> 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 7
> ack_timer 0
>       frame_size 670 max_retrans 0 credits 7
> > HCI Event: Number of Completed Packets (0x13) plen
5
>     handle 41
> > ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 0 ilen 0 fcs
0x66

and here we go. You try to connect to RFCOMM channel
1, but your phone
says that there is not service available on that
channel.

Run a "sdptool browse" or "sdptool search" to find out
the correct
channel number.

Regards

Marcel


--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi John,
> 
> > Despite it saying connection refused, the phone,
> when
> > searching/pairing, finds laptop-0, but pair fails
> > after i tell it to use 0000 for pin.
> 
> stop resending this post. I already answered it.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now.
>
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search. 
http://info.mail.yahoo.com/mail_250


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
