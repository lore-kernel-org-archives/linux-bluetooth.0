Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0612210439p7ae210e1vd0d3bb56cac2ee5e@mail.gmail.com>
Date: Thu, 21 Dec 2006 18:09:34 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] cannot transfer file to my computer from mobile via
	bluetooth
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0724569265=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0724569265==
Content-Type: multipart/alternative;
	boundary="----=_Part_39937_1499836.1166704774777"

------=_Part_39937_1499836.1166704774777
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
    I am not able to transfer files from my mobile to my linux pc. I have
started OPUSH service on my computer with command :-

    #sdptool add OPUSH

   when i was sending file to the linux machine via a windows PC through
BlueSoleil software , i got the following dump on my linux machine by
hcidump :-


I Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 0x000b flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0048
< ACL data: handle 0x000b flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 result 0 status 0
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 0x000b flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x000b flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0048 flags 0x0000 result 0 clen 0
< ACL data: handle 0x000b flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x0000 clen 0
> ACL data: handle 0x000b flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x000b flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1105 (OBEXObjPush)
          max 0x20
          cont 00
< ACL data: handle 0x000b flags 0x02 dlen 18
    L2CAP(d): cid 0x0048 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          tot 0x1 cur 0x1 hndl 0x9dc86f0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x000b flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x1 len 0xe
          hndl 0x9dc86f0
          max 0x12c
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x000b flags 0x02 dlen 111
    L2CAP(d): cid 0x0048 len 107 [psm 1]
        SDP SA Rsp: tid 0x1 len 0x66
          cnt 0x63
          aid 0x0000 (SrvRecHndl)
             uint 0x9dc86f0
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1105 (OBEXObjPush) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x9 > <
             uuid-16 0x0008 (OBEX) > >
          aid 0x0005 (BrwGrpList)
             < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
          aid 0x0100 (SrvName)
             str "OBEX Object Push"
          aid 0x0303 (SuppFormatsList)
             < uint 0x1 uint 0x2 uint 0x3 uint 0x4 uint 0x5 uint 0x6 >

          cont 00
> ACL data: handle 0x000b flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0048
< ACL data: handle 0x000b flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0048
> ACL data: handle 0x000b flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0049
< ACL data: handle 0x000b flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0049 result 0 status 0
> ACL data: handle 0x000b flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1600
< ACL data: handle 0x000b flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0049 flags 0x0000 result 0 clen 0
< ACL data: handle 0x000b flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0049 flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x000b flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x000b flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x000b flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 0x000b flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 1018 max_retrans 0 credits 7
< ACL data: handle 0x000b flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x18
> ACL data: handle 0x000b flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0049
< ACL data: handle 0x000b flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0049
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4


thanks
siddhant

------=_Part_39937_1499836.1166704774777
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,<br>&nbsp;&nbsp;&nbsp; I am not able to transfer files from my mobile to my linux pc. I have started OPUSH service on my computer with command :-<br><br>&nbsp;&nbsp;&nbsp; #sdptool add OPUSH<br><br>&nbsp;&nbsp; when i was sending file to the linux machine via a windows PC through BlueSoleil software , i got the following dump on my linux machine by hcidump :-
<br><br><br>I Event: Connect Request (0x04) plen 10<br>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&gt; HCI Event: Command Complete (0x0e) plen 6<br>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0048<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 result 0 status 0
<br>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 14
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0048 flags 0x0000 result 0 clen 0<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0048 flags 0x0000 clen 0<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 14
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 17<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 13 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x0 len 0x8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x1105 (OBEXObjPush)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 0x20<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0048 len 14 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x0 len 0x9<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tot 0x1 cur 0x1 hndl 0x9dc86f0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 23<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 19 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Req: tid 0x1 len 0xe<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hndl 0x9dc86f0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 0x12c<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 111<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0048 len 107 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x1 len 0x66<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt 0x63
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x9dc86f0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1105 (OBEXObjPush) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x9 &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0008 (OBEX) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x1105 (OBEXObjPush) uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;OBEX Object Push&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0303 (SuppFormatsList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x1 uint 0x2 uint 0x3 uint 0x4 uint 0x5 uint 0x6 &gt;
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0048<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0048
<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0049<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0049 result 0 status 0
<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4<br>&nbsp;&nbsp;&nbsp; MTU 1600<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0049 flags 0x0000 result 0 clen 0
<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0049 flags 0x0000 clen 4<br>&nbsp;&nbsp;&nbsp; MTU 1024<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 14
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 14 [psm 3]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 18 frame_type 0 credit_flow 15 pri 0 ack_timer 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 1018 max_retrans 0 credits 7<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 8
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x18<br>&gt; ACL data: handle 0x000b flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0049<br>&lt; ACL data: handle 0x000b flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0049<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; HCI Event: Disconn Complete (0x05) plen 4<br><br><br>thanks<br>siddhant<br>

------=_Part_39937_1499836.1166704774777--


--===============0724569265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0724569265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0724569265==--
