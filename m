Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ms explorer for bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: neoclust <n1c0l4s.l3@wanadoo.fr>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <200410131224.13689.n1c0l4s.l3@wanadoo.fr>
References: <200410122022.30501.n1c0l4s.l3@wanadoo.fr>
	 <200410131143.26811.n1c0l4s.l3@wanadoo.fr>
	 <1097662706.4643.21.camel@notepaq>
	 <200410131224.13689.n1c0l4s.l3@wanadoo.fr>
Content-Type: text/plain
Message-Id: <1097668334.4643.24.camel@notepaq>
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
Date: Wed, 13 Oct 2004 13:52:14 +0200

Hi Nicholas,

> > I misread your email. What I think is that maybe the keyboard will only
> > work if you enforce the encryption. Is this the second generation of the
> > Microsoft keyboard? 
> 
> how can i know this info ?

look at your box. What does it say and how does the keyboard look like?

> > Can you do a "hcitool info ..." as root to your 
> > keyboard?
> 
> how can i know my <bdaddr> for my keabord  ?

Press the "connect" button on the keyboard and run "hcitool scan".

> > Run also "hcidump -x" as root and show it to us. 
> 
> # hcidump -x
> HCIDump - HCI packet analyzer ver 1.12
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Mode Change (0x14) plen 6
>   00 2A 00 00 00 00
> > HCI Event: Mode Change (0x14) plen 6
>   00 2A 00 02 70 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 03 FE 00
> > HCI Event: Mode Change (0x14) plen 6
>   00 2A 00 00 00 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 0C EC 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 00 FE 00
> > HCI Event: Mode Change (0x14) plen 6
>   00 2A 00 02 12 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 01 00 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 00 FF 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 01 FF 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 01 00 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 01 FF 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 02 FF 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 01 FF 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 01 FF 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 02 FD 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 01 00 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 02 FD 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 01 FE 00
> > ACL data: handle 0x002a flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       A1 02 00 01 00 00
> > HCI Event: Mode Change (0x14) plen 6
>   00 2A 00 00 00 00
> > HCI Event: Mode Change (0x14) plen 6
>   00 2A 00 02 70 00

Please don't connect the mouse when doing any testing with the keyboard.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
