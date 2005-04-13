Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFComm doesn't disconnect in server mode
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <425BEB6E.4080500@palmsource.com>
References: <425BEB6E.4080500@palmsource.com>
Content-Type: text/plain
Message-Id: <1113392037.9061.18.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 13 Apr 2005 13:33:57 +0200

Hi Frederic,

> I am working on headset profile implementation. In server mode, the 
> headset (Jabra BT200) connects fine, but once my program close the 
> RFComm socket, the ACL link is still up, until I stop the headset.
> 
> I get in console :
>      fdanis:> ./hstest server - 00:07:A4:05:B6:DA
>      Server RFCOMM socket 3 listen on RFComm 2
>      RFComm connected
>      AT+CKPD=200
>      RFComm disconnected
>      fdanis:>
> 
> Here are the last traces I got before stopping headset :
>      > HCI Event: Mode Change (0x14) plen 6
>        0000: 00 29 00 02 00 08                                 .)....
>      < ACL data: handle 0x0029 flags 0x02 dlen 8
>          L2CAP(d): cid 0x0042 len 4 [psm 3]
>            RFCOMM(s): DISC: cr 0 dlci 4 pf 1 ilen 0 fcs 0x16
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>        0000: 01 29 00 01 00                                    .)...
>      > ACL data: handle 0x0029 flags 0x02 dlen 8
>          L2CAP(d): cid 0x0041 len 4 [psm 3]
>            RFCOMM(s): UA: cr 0 dlci 4 pf 1 ilen 0 fcs 0x3c
> 
> Maybe a RFCOMM DISC frame on the DLCI 0 is missing.

the guys from TomTom discovered the same problem some time ago. This is
a reference counting problem on our side and a fix for that was posted
to the mailing list and is in the 2.6.12-rc2 kernel. However it seems
that this fix introduces an oops at some point. I haven't had the time
to investigate this any further.

The funny things with these kind of problems are that the specification
misses some words on who is responsible for terminating a signal channel
or the underlaying ACL link. Basically in your case the headset is the
initiator and it is too stupid too terminate its own RFCOMM signal
channel that it created previous. I have no idea why this is not caught
by the qualification tests.

I think the Jabra headsets are CSR based and maybe the CSR developers
are interested to hear about it. Please post the "hcitool info" output
for them.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
