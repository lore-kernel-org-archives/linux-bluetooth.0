Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Neil Fenemor <Neil@OnDrugs.co.nz>
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
Content-Type: multipart/alternative; boundary="=-WRKsX2CVtG1eve8qq5VD"
Message-Id: <1088029361.3703.17.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Logitech MX900 Hub + i-mate smartphone2
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
Date: Thu, 24 Jun 2004 10:22:41 +1200


--=-WRKsX2CVtG1eve8qq5VD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all, 

I'm trying to get my MX900 Hub and my i-mate smartphone2 to place nicely
together, but so far, I haven't had much luck on that front. The
smartphone2 FYI runs Windows Mobile 2003, or CE4, which ever you prefer
to call it. The phone is also called a Orange SPV E200 for those on that
network.

I can get rfcomm stuff to work fine with other phones, so I believe it
is the phone itself at fault. The end result that I'm after, is to be
able to sync with my phone, and also surf from my laptop via GPRS. The
time frame I'm trying t work within is of course tight, as I'm needed
this next week for while I'm away. 

When all connected, peered, etc, and it looks successful, I get odd
things like the following.
 
[root@localhost neil]# cat /dev/rfcomm0
cat: /dev/rfcomm0: Connection reset by peer
[root@localhost neil]# 

I've put the hcidump information at the bottom of the e-mail.

I'm sure, if I could get this going, I could probably move forward with
the whole thing. 

I'm also having problems with the ActiveSync facilities on the phone, as
when I try the "BT ActiveSync" it comes up with "Please bond with other
Bluetooth device which supports serial port or ActiveSync profile as
your ActiveSync partner!"

I'm not sure where I should go for solving this one, any help would be
greatly appreciated, as I would hate to install windows on my
laptop.....

Regards

Neil Fenemor


Doing a hcidump during the rfcomm0 cat returns the following:

-----------------------------------------------
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Connect Complete(0x03) plen 11
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Command Complete(0x0e) plen 6
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0151 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0151 flags 0x0000 clen 4
    MTU 1024 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0151 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x151 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x151 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size
667 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 1
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size
667 max_retrans 0 credits 7
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x151 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0151
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0151
> HCI Event: Number of Completed Packets(0x13) plen 5
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4


-------------------------------------------------------------



--=-WRKsX2CVtG1eve8qq5VD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
Hi all, <BR>
<BR>
I'm trying to get my MX900 Hub and my i-mate smartphone2 to place nicely together, but so far, I haven't had much luck on that front. The smartphone2 FYI runs Windows Mobile 2003, or CE4, which ever you prefer to call it. The phone is also called a Orange SPV E200 for those on that network.<BR>
<BR>
I can get rfcomm stuff to work fine with other phones, so I believe it is the phone itself at fault. The end result that I'm after, is to be able to sync with my phone, and also surf from my laptop via GPRS. The time frame I'm trying t work within is of course tight, as I'm needed this next week for while I'm away. <BR>
<BR>
When all connected, peered, etc, and it looks successful, I get odd things like the following.<BR>
 <BR>
[root@localhost neil]# cat /dev/rfcomm0<BR>
cat: /dev/rfcomm0: Connection reset by peer<BR>
[root@localhost neil]# <BR>
<BR>
I've put the hcidump information at the bottom of the e-mail.<BR>
<BR>
I'm sure, if I could get this going, I could probably move forward with the whole thing. <BR>
<BR>
I'm also having problems with the ActiveSync facilities on the phone, as when I try the &quot;BT ActiveSync&quot; it comes up with &quot;Please bond with other Bluetooth device which supports serial port or ActiveSync profile as your ActiveSync partner!&quot;<BR>
<BR>
I'm not sure where I should go for solving this one, any help would be greatly appreciated, as I would hate to install windows on my laptop.....<BR>
<BR>
Regards<BR>
<BR>
Neil Fenemor<BR>
<BR>
<BR>
Doing a hcidump during the rfcomm0 cat returns the following:<BR>
<BR>
-----------------------------------------------<BR>
&lt; HCI Command: Create Connection(0x01|0x0005) plen 13<BR>
&gt; HCI Event: Command Status(0x0f) plen 4<BR>
&gt; HCI Event: Link Key Request(0x17) plen 6<BR>
&lt; HCI Command: Link Key Request Reply(0x01|0x000b) plen 22<BR>
&gt; HCI Event: Command Complete(0x0e) plen 10<BR>
&gt; HCI Event: Connect Complete(0x03) plen 11<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0040<BR>
&lt; HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4<BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&gt; HCI Event: Command Complete(0x0e) plen 6<BR>
&gt; HCI Event: Page Scan Repetition Mode Change(0x20) plen 7<BR>
&gt; HCI Event: Max Slots Change(0x1b) plen 3<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0151 scid 0x0040 result 0 status 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0151 flags 0x0000 clen 4<BR>
&nbsp;&nbsp;&nbsp; MTU 1024 <BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0151 flags 0x0000 result 0 clen 0<BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x151 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c <BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 <BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 18<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x151 len 14 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 667 max_retrans 0 credits 7<BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 17<BR>
&gt; ACL data: handle 0x0029 flags 0x01 dlen 1<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 14 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 667 max_retrans 0 credits 7<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x151 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 <BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0151<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0151<BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&lt; HCI Command: Disconnect(0x01|0x0006) plen 3<BR>
&gt; HCI Event: Command Status(0x0f) plen 4<BR>
&gt; HCI Event: Disconn Complete(0x05) plen 4<BR>
<BR>
<BR>
-------------------------------------------------------------<BR>
<BR>
<BR>
</BODY>
</HTML>

--=-WRKsX2CVtG1eve8qq5VD--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
