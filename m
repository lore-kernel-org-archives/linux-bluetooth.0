Return-Path: <Neil@OnDrugs.co.nz>
Subject: Re: [Bluez-devel] Logitech MX900 Hub + i-mate smartphone2
From: Neil Fenemor <Neil@OnDrugs.co.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1088030296.4296.14.camel@pegasus>
References: <1088029361.3703.17.camel@localhost.localdomain>
	 <1088030296.4296.14.camel@pegasus>
Content-Type: multipart/alternative; boundary="=-PlQOvp2M31y/YFALcOst"
Message-Id: <1088030943.3703.26.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Thu, 24 Jun 2004 10:49:03 +1200
List-ID: <bluez-devel.lists.sourceforge.net>


--=-PlQOvp2M31y/YFALcOst
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

My apologies on the cross posting, won't happen again. I've also now
tried with both auth and enc switched off as well, which is what
follows. 

[root@localhost neil]# hcitool info 00:0E:6D:07:E1:BF
Requesting information ...
        BD Address:  00:0E:6D:07:E1:BF
        Device Name: Smartphone
        LMP Version: 1.1 (0x1) LMP Subversion: 0x20e
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> 
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
                <CVSD> <paging scheme> <power control> <transparent SCO>

[root@localhost neil]# /usr/sbin/hcidump -x
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
  BF E1 07 6D 0E 00 18 CC 02 00 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04 
> HCI Event: Connect Complete(0x03) plen 11
  00 29 00 BF E1 07 6D 0E 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  29 00 0E 00 
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00 
> HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 29 00 
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  BF E1 07 6D 0E 00 01 
> HCI Event: Max Slots Change(0x1b) plen 3
  29 00 05 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0152 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0152 flags 0x0000 clen 4
    MTU 1024 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0152 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8

    L2CAP(d): cid 0x152 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x152 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size
667 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size
667 max_retrans 0 credits 7
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x152 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0152
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0152
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00 
< HCI Command: Disconnect(0x01|0x0006) plen 3
  29 00 13 
> HCI Event: Command Status(0x0f) plen 4
  00 01 06 04 
> HCI Event: Disconn Complete(0x05) plen 4
  00 29 00 16 

--------------------------------------------------------

[root@localhost neil]# /opt/bluetooth/sbin/hciconfig -a
hci0:   Type: USB
        BD Address: 00:07:61:1A:A7:23  ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:125557 acl:6054 sco:0 events:5693 errors:0
        TX bytes:82916 acl:6254 sco:0 commands:78 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: MASTER ACCEPT
        Name: 'Laptop'
        Class: 0x120105
        HCI Ver: 1.1 (0x1) HCI Rev: 0x34e  LMP Ver: 1.1 (0x1) LMP
Subver: 0x34e
        Manufacturer: Cambridge Silicon Radio (10)

---------------------------------------------------------


On Thu, 2004-06-24 at 10:38, Marcel Holtmann wrote:

> Hi Neil,
> 
> choose one mailing list, because I hate cross-postings.
> 
> > I'm trying to get my MX900 Hub and my i-mate smartphone2 to place
> > nicely together, but so far, I haven't had much luck on that front.
> > The smartphone2 FYI runs Windows Mobile 2003, or CE4, which ever you
> > prefer to call it. The phone is also called a Orange SPV E200 for
> > those on that network.
> 
> Send us the information about your phone from "hcitool info <bdaddr>".
> 
> > I can get rfcomm stuff to work fine with other phones, so I believe it
> > is the phone itself at fault. The end result that I'm after, is to be
> > able to sync with my phone, and also surf from my laptop via GPRS. The
> > time frame I'm trying t work within is of course tight, as I'm needed
> > this next week for while I'm away. 
> > 
> > When all connected, peered, etc, and it looks successful, I get odd
> > things like the following.
> > 
> > [root@localhost neil]# cat /dev/rfcomm0
> > cat: /dev/rfcomm0: Connection reset by peer
> > [root@localhost neil]# 
> > 
> > I've put the hcidump information at the bottom of the e-mail.
> 
> Do it again, but this time with -x or send us the binary dump.
> 
> > I'm also having problems with the ActiveSync facilities on the phone,
> > as when I try the "BT ActiveSync" it comes up with "Please bond with
> > other Bluetooth device which supports serial port or ActiveSync
> > profile as your ActiveSync partner!"
> 
> >From the dump I saw that you use security mode 3. Do you enabled auth
> and encrypt in hcid.conf? Don't do so. Show us "hciconfig -a".
> 
> Regards
> 
> Marcel
> 

--=-PlQOvp2M31y/YFALcOst
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
My apologies on the cross posting, won't happen again. I've also now tried with both auth and enc switched off as well, which is what follows. <BR>
<BR>
[root@localhost neil]# hcitool info 00:0E:6D:07:E1:BF<BR>
Requesting information ...<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:0E:6D:07:E1:BF<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: Smartphone<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) LMP Subversion: 0x20e<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; &lt;slot offset&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV2 packets&gt; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;CVSD&gt; &lt;paging scheme&gt; &lt;power control&gt; &lt;transparent SCO&gt; <BR>
<BR>
[root@localhost neil]# /usr/sbin/hcidump -x<BR>
HCIDump - HCI packet analyzer ver 1.5<BR>
device: hci0 snap_len: 1028 filter: 0xffffffff<BR>
&lt; HCI Command: Create Connection(0x01|0x0005) plen 13<BR>
&nbsp; BF E1 07 6D 0E 00 18 CC 02 00 00 00 00 <BR>
&gt; HCI Event: Command Status(0x0f) plen 4<BR>
&nbsp; 00 01 05 04 <BR>
&gt; HCI Event: Connect Complete(0x03) plen 11<BR>
&nbsp; 00 29 00 BF E1 07 6D 0E 00 01 00 <BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0040<BR>
&lt; HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4<BR>
&nbsp; 29 00 0E 00 <BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&nbsp; 01 29 00 01 00 <BR>
&gt; HCI Event: Command Complete(0x0e) plen 6<BR>
&nbsp; 01 0D 08 00 29 00 <BR>
&gt; HCI Event: Page Scan Repetition Mode Change(0x20) plen 7<BR>
&nbsp; BF E1 07 6D 0E 00 01 <BR>
&gt; HCI Event: Max Slots Change(0x1b) plen 3<BR>
&nbsp; 29 00 05 <BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0152 scid 0x0040 result 0 status 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 16<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0152 flags 0x0000 clen 4<BR>
&nbsp;&nbsp;&nbsp; MTU 1024 <BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0152 flags 0x0000 result 0 clen 0<BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&nbsp; 01 29 00 01 00 <BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&nbsp; 01 29 00 01 00 <BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 14<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x152 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c <BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&nbsp; 01 29 00 01 00 <BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 <BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 18<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x152 len 14 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 667 max_retrans 0 credits 7<BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&nbsp; 01 29 00 01 00 <BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 18<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 14 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 667 max_retrans 0 credits 7<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<BR>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x152 len 4 [psm 3]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 <BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&nbsp; 01 29 00 01 00 <BR>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0152<BR>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<BR>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0152<BR>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<BR>
&nbsp; 01 29 00 01 00 <BR>
&lt; HCI Command: Disconnect(0x01|0x0006) plen 3<BR>
&nbsp; 29 00 13 <BR>
&gt; HCI Event: Command Status(0x0f) plen 4<BR>
&nbsp; 00 01 06 04 <BR>
&gt; HCI Event: Disconn Complete(0x05) plen 4<BR>
&nbsp; 00 29 00 16 <BR>
<BR>
--------------------------------------------------------<BR>
<BR>
[root@localhost neil]# /opt/bluetooth/sbin/hciconfig -a<BR>
hci0:&nbsp;&nbsp; Type: USB<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:07:61:1A:A7:23&nbsp; ACL MTU: 192:8&nbsp; SCO MTU: 64:8<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:125557 acl:6054 sco:0 events:5693 errors:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:82916 acl:6254 sco:0 commands:78 errors:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: HOLD SNIFF PARK<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: MASTER ACCEPT<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'Laptop'<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x120105<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x34e&nbsp; LMP Ver: 1.1 (0x1) LMP Subver: 0x34e<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<BR>
<BR>
---------------------------------------------------------<BR>
<BR>
<BR>
On Thu, 2004-06-24 at 10:38, Marcel Holtmann wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373"><I>Hi Neil,

choose one mailing list, because I hate cross-postings.

&gt; I'm trying to get my MX900 Hub and my i-mate smartphone2 to place
&gt; nicely together, but so far, I haven't had much luck on that front.
&gt; The smartphone2 FYI runs Windows Mobile 2003, or CE4, which ever you
&gt; prefer to call it. The phone is also called a Orange SPV E200 for
&gt; those on that network.

Send us the information about your phone from &quot;hcitool info &lt;bdaddr&gt;&quot;.

&gt; I can get rfcomm stuff to work fine with other phones, so I believe it
&gt; is the phone itself at fault. The end result that I'm after, is to be
&gt; able to sync with my phone, and also surf from my laptop via GPRS. The
&gt; time frame I'm trying t work within is of course tight, as I'm needed
&gt; this next week for while I'm away. 
&gt; 
&gt; When all connected, peered, etc, and it looks successful, I get odd
&gt; things like the following.
&gt; 
&gt; [root@localhost neil]# cat /dev/rfcomm0
&gt; cat: /dev/rfcomm0: Connection reset by peer
&gt; [root@localhost neil]# 
&gt; 
&gt; I've put the hcidump information at the bottom of the e-mail.

Do it again, but this time with -x or send us the binary dump.

&gt; I'm also having problems with the ActiveSync facilities on the phone,
&gt; as when I try the &quot;BT ActiveSync&quot; it comes up with &quot;Please bond with
&gt; other Bluetooth device which supports serial port or ActiveSync
&gt; profile as your ActiveSync partner!&quot;

&gt;From the dump I saw that you use security mode 3. Do you enabled auth
and encrypt in hcid.conf? Don't do so. Show us &quot;hciconfig -a&quot;.

Regards

Marcel
</I></FONT></PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-PlQOvp2M31y/YFALcOst--
