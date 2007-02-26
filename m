Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 25 Feb 2007 18:57:30 -0800 (PST)
From: tim culwins <mail0123456789101112@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1172447452.20450.15.camel@violet>
MIME-Version: 1.0
Message-ID: <752642.79554.qm@web31711.mail.mud.yahoo.com>
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

Thanks for the response.

Heres my hciconfig right after it locks up.

> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
> ACL data: handle 2 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00
result 0 clen 4
      Success
      MTU 48 
> HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 2 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 11250
    Delay variation: -1
< ACL data: handle 2 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Output report
      0000: 01 00 00 00 00 00 00 00  00               
       .........
< ACL data: handle 2 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 02 00                                     
       ..
< ACL data: handle 2 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Output report
      0000: 05 00 00 00 00 00 00 00  00               
       .........
< ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 19]
      HIDP: Data: Output report
      0000: 06 00 00                                  
       ...
< ACL data: handle 2 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Output report
      0000: 05 00 00 00 00 00 00 00  00               
       .........
> ACL data: handle 2 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Input report
      0000: 05 44 7c 72 d3 c9 03 00  00               
       .D|r.....



--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Tim,
> 
> > i have a think outside keyboard for pdas that im
> > trying to use on ubuntu. it can connect and auto
> > reconnect most of the time. but sometimes when i
> hit a
> > key to auto reconnect the light on my dongle stops
> > flashing and bluetooth stops working. If i unplug
> and
> > replug the dongle it starts working again. 
> > i dont have this problem with my bluetooth mouse. 
> 
> you need to run "hcidump -X -V" to see what actually
> happens.
> 
> > hci0:   Type: USB
> >         BD Address: 00:11:67:4F:EE:F9 ACL MTU:
> 678:8
> > SCO MTU: 64:10
> >         UP RUNNING PSCAN ISCAN 
> >         RX bytes:4879 acl:194 sco:0 events:67
> errors:0
> >         TX bytes:756 acl:19 sco:0 commands:34
> errors:0
> >         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18
> 0x00
> > 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
> HV2
> > HV3 
> >         Link policy: RSWITCH HOLD SNIFF PARK 
> >         Link mode: SLAVE ACCEPT 
> >         Name: 'ISSCBTA'
> >         Class: 0x3e0100
> >         Service Classes: Networking, Rendering,
> > Capturing, Object Transfer, Audio
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver:
> 1.2
> > (0x2) LMP Subver: 0x1fe
> >         Manufacturer: Integrated System Solution
> Corp.
> > (57)
> 
> Dongles with chips from these manufacturer are
> actually kinda poor
> quality. They always have problems. Get yourself a
> CSR based BlueCore4
> dongle and you will be much happier.
> 
> Regards
> 
> Marcel
> 
> 
> 
>
-------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get
> the chance to share your
> opinions on IT & business topics through brief
> surveys-and earn cash
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



 
____________________________________________________________________________________
Looking for earth-friendly autos? 
Browse Top Cars by "Green Rating" at Yahoo! Autos' Green Center.
http://autos.yahoo.com/green_center/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
