Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jul 2008 15:29:39 +0800 (CST)
From: attaboyu@163.com
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Message-ID: <13504425.775781215674979125.JavaMail.coremail@app168.163.com>
In-Reply-To: <30022094.644201215658920968.JavaMail.coremail@bj163app77.163.com>
References: <30022094.644201215658920968.JavaMail.coremail@bj163app77.163.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Can't send file to bluetooth obex server
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1991318034=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1991318034==
Content-Type: multipart/alternative;
	boundary="----=_Part_205743_8511970.1215674979124"

------=_Part_205743_8511970.1215674979124
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: quoted-printable

 hi

 after read the openobex code, i find out if the obex_test work as server, =
it definitely run to  obex_transport.c line 115-126 which list below:

=20
             DEBUG(4, "Data available on server socket\n");
            /* Accept : create the connected socket */
            ret =3D obex_transport_accept(self);

            /* Tell the app to perform the OBEX_Accept() */
            if(self->keepserver)
                obex_deliver_event(self, OBEX_EV_ACCEPTHINT,
                           0, 0, FALSE);
            /* Otherwise, just disconnect the server */
            if((ret >=3D 0) && (! self->keepserver)) {
                obex_transport_disconnect_server(self);
            }
  the server really accept connection of the client and return 0, but the s=
elf->keepserver=3D=3D0, so it suddenly run to obex_transport_disconnect_ser=
ver(self).

=20
after that, obex_transport_handle_input return 0 which course the "Timeout =
while doing OBEX_HandleInput()" issue out

how to fix this problem=20
--

 Best Regards
 ------------
 Tony



 hi all

 I've got a problem to send file to my bluetooth obex server.
 my toolchain:
 bluez-libs-3.12, bluez-utils-3.12, bluez-hcidump-1.37, openobex-1.3
 my platform is arm based system(local).

 1.if the local(arm based) send file to remote(usb dongle on PC) as openobe=
x work in client, it's totally OK.
$obex_test -b 00:17:cd:60:00:5c 1
Using Bluetooth RFCOMM transport
OBEX Interactive test client/server.
> c
Connect OK!
Version: 0x10. Flags: 0x00
> p hello.txt hw.txt
PUT file (local, remote)> name=3Dhello.txt, size=3D31
PUT successful!
> q

 2.if the local(arm based) work as obex server, it always go wrong.
$obex_test -b ff:ff:ff:00:00:00 9
Using Bluetooth RFCOMM transport
OBEX Interactive test client/server.
> s
 at this time, the remote(usb dongle on pc) try to connect local and send a=
 file to it, then the obex server go wrong like this:

Timeout while doing OBEX_HandleInput()

the file transfer failed every time when my arm based system work as obex s=
erver, here is the hcidump data, a little long.

HCI sniffer - Bluetooth packet analyzer ver 1.37
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Max Slots Change (0x1b) plen 3
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0094
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0094 result 0 status 0
      Connection successful
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0094 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0094 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1105 (OBEXObjPush)
          max 64
          cont 00
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0094 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          count 1
          handle 0x10000
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x1 len 0xe
          handle 0x10000
          max 300
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 42 flags 0x02 dlen 111
    L2CAP(d): cid 0x0094 len 107 [psm 1]
        SDP SA Rsp: tid 0x1 len 0x66
          count 99
          aid 0x0000 (SrvRecHndl)
             uint 0x10000
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
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0094
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0095
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0094
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0095 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1710=20
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0095 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0095 flags 0x00 clen 4
      MTU 1024=20
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0095 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 1012 max_retrans 0 credits 7
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0095 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 1012 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32=20
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0095 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9=20
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0095 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0095 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 credits 100
> ACL data: handle 42 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 7 fcs 0xce=20
        OBEX: Connect cmd(f): len 7 version 1.0 flags 0 mtu 32573
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0095 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 34
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 0 rtr 0 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0095 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 0 rtr 0 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3=20
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0095 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9=20
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd=20
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0095 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0095
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0095
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4

I can't figure it out. is the server side need an agent to comfirm the clie=
nt's request?
who can help me out , many thanks in advance!

tony

=20
=20
=20

--

 Best Regards
 ------------
 Tony




=D4=A8=B2=A8=C0=AB=D5=AC =BA=FE=BE=B0=C8=CB=C9=FA
------=_Part_205743_8511970.1215674979124
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>&nbsp;hi<br><br>&nbsp;after read the openobex code, i find out if the =
obex_test work as server, it definitely run to&nbsp; obex_transport.c line =
115-126 which list below:<br></div><div>&nbsp;</div><div>&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; DEBUG(4, "Data available on se=
rver socket\n");<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;/* Accept : create the connected socket */<br>&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;ret =3D obex_transport_accept(self);<br><br>&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* Tell the app to =
perform the OBEX_Accept() */<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;if(self-&gt;keepserver)<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;obex_deliver_event(self, OBEX_EV_=
ACCEPTHINT,<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0, 0, FA=
LSE);<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* Otherw=
ise, just disconnect the server */<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp;if((ret &gt;=3D 0) &amp;&amp; (! self-&gt;keepserver)) =
{<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;obex_transport_disconnect_server(self);<br>&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;}<br>&nbsp; the server really accept connect=
ion of the client and return 0, but the self-&gt;keepserver=3D=3D0, so it s=
uddenly run to obex_transport_disconnect_server(self).<br></div><div>&nbsp;=
</div><div>after that, obex_transport_handle_input return 0 which course th=
e "Timeout while doing OBEX_HandleInput()" issue out<br><br>how to fix this=
 problem <br>--<br>
<div>&nbsp;Best Regards<br>&nbsp;------------<br>&nbsp;Tony<br></div>
</div><br> <blockquote id=3D"isReplyContent" style=3D"border-left: 1px soli=
d rgb(204, 204, 204); margin: 0px 0px 0px 0.8ex; padding-left: 1ex;"><div>&=
nbsp;hi all<br><br>&nbsp;I've got a problem to send file to my bluetooth ob=
ex server.<br>&nbsp;my toolchain:<br>&nbsp;bluez-libs-3.12, bluez-utils-3.1=
2, bluez-hcidump-1.37, openobex-1.3<br>&nbsp;my platform is arm based syste=
m(local).<br><br>&nbsp;1.if the local(arm based) send file to remote(usb do=
ngle on PC) as openobex work in client, it's totally OK.<br>$obex_test -b 0=
0:17:cd:60:00:5c 1<br>Using Bluetooth RFCOMM transport<br>OBEX Interactive =
test client/server.<br>&gt; c<br>Connect OK!<br>Version: 0x10. Flags: 0x00<=
br>&gt; p hello.txt hw.txt<br>PUT file (local, remote)&gt; name=3Dhello.txt=
, size=3D31<br>PUT successful!<br>&gt; q<br><br>&nbsp;2.if the local(arm ba=
sed) work as obex server, it always go wrong.<br>$obex_test -b ff:ff:ff:00:=
00:00 9<br>Using Bluetooth RFCOMM transport<br>
OBEX Interactive test client/server.<br>
&gt; s<br>&nbsp;at this time, the remote(usb dongle on pc) try to connect l=
ocal and send a file to it, then the obex server go wrong like this:<br><br=
>Timeout while doing OBEX_HandleInput()<br><br>the file transfer failed eve=
ry time when my arm based system work as obex server, here is the hcidump d=
ata, a little long.<br><br>HCI sniffer - Bluetooth packet analyzer ver 1.37=
<br>&gt; HCI Event: Connect Request (0x04) plen 10<br>&lt; HCI Command: Acc=
ept Connection Request (0x01|0x0009) plen 7<br>&gt; HCI Event: Command Stat=
us (0x0f) plen 4<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&gt;=
 HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>&gt; HCI Even=
t: Max Slots Change (0x1b) plen 3<br>&lt; HCI Command: Write Link Policy Se=
ttings (0x02|0x000d) plen 4<br>&gt; HCI Event: Command Complete (0x0e) plen=
 6<br>&gt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2C=
AP(s): Connect req: psm 1 scid 0x0094<br>&lt; ACL data: handle 42 flags 0x0=
2 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0=
094 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successf=
ul<br>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<=
br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; HCI Ev=
ent: Command Status (0x0f) plen 4<br>&gt; HCI Event: Connection Packet Type=
 Changed (0x1d) plen 5<br>&gt; ACL data: handle 42 flags 0x02 dlen 12<br>&n=
bsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>&lt=
; ACL data: handle 42 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Co=
nfig rsp: scid 0x0094 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Success<br>&lt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nb=
sp;&nbsp; L2CAP(s): Config req: dcid 0x0094 flags 0x00 clen 0<br>&gt; HCI E=
vent: Number of Completed Packets (0x13) plen 5<br>&gt; HCI Event: Number o=
f Completed Packets (0x13) plen 5<br>&gt; ACL data: handle 42 flags 0x02 dl=
en 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 re=
sult 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&gt; ACL data: h=
andle 42 flags 0x02 dlen 17<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
13 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x=
0 len 0x8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uui=
d-16 0x1105 (OBEXObjPush)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; max 64<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ont 00<br>&lt; ACL data: handle 42 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp;=
 L2CAP(d): cid 0x0094 len 14 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SDP SS Rsp: tid 0x0 len 0x9<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; count 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; handle 0x10000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; cont 00<br>&gt; HCI Event: Number of Completed Packets (0x13) plen =
5<br>&gt; ACL data: handle 42 flags 0x02 dlen 23<br>&nbsp;&nbsp;&nbsp; L2CA=
P(d): cid 0x0040 len 19 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; SDP SA Req: tid 0x1 len 0xe<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; handle 0x10000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; max 300<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; cont 00<br>&lt; ACL data: handle 42 flags 0x02 dlen 111<br>&nbsp;&=
nbsp;&nbsp; L2CAP(d): cid 0x0094 len 107 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SDP SA Rsp: tid 0x1 len 0x66<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 99<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10000<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
lt; uuid-16 0x1105 (OBEXObjPush) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x010=
0 (L2CAP) &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x9 &gt; &lt;<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x=
0008 (OBEX) &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDes=
cList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &lt; &lt; uuid-16 0x1105 (OBEXObjPush) uint 0x100 &gt; &gt;<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
r "OBEX Object Push"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aid 0x0303 (SuppFormatsList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x1 uint 0x2 uint 0x3 uint 0x4 =
uint 0x5 uint 0x6 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; cont 00<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<=
br>&gt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(=
s): Disconn req: dcid 0x0040 scid 0x0094<br>&gt; ACL data: handle 42 flags =
0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0095=
<br>&lt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP=
(s): Disconn rsp: dcid 0x0040 scid 0x0094<br>&lt; ACL data: handle 42 flags=
 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid=
 0x0095 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection succ=
essful<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt;=
 HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; ACL data: han=
dle 42 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid =
0x0040 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1710 <br>&lt=
; ACL data: handle 42 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Co=
nfig rsp: scid 0x0095 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Success<br>&lt; ACL data: handle 42 flags 0x02 dlen 16<br>&nbsp;&nb=
sp;&nbsp; L2CAP(s): Config req: dcid 0x0095 flags 0x00 clen 4<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; MTU 1024 <br>&gt; HCI Event: Number of Completed Packe=
ts (0x13) plen 5<br>&gt; HCI Event: Number of Completed Packets (0x13) plen=
 5<br>&gt; ACL data: handle 42 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2C=
AP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; Success<br>&gt; ACL data: handle 42 flags 0x02 dlen 8<br>&=
nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c <br>&lt; ACL =
data: handle 42 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x009=
5 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci =
0 pf 1 ilen 0 fcs 0xd7 <br>&gt; HCI Event: Number of Completed Packets (0x1=
3) plen 5<br>&gt; ACL data: handle 42 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nb=
sp; L2CAP(d): cid 0x0040 len 14 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=
FCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; dlci 18 frame_type 0 credit_flow 15 pri 0 ack_timer 0<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 1012 max_retrans 0 credits 7<b=
r>&lt; ACL data: handle 42 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(d=
): cid 0x0095 len 14 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): P=
N RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dlci 18 frame_type 0 credit_flow 14 pri 0 ack_timer 0<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; frame_size 1012 max_retrans 0 credits 7<br>&gt; HCI =
Event: Number of Completed Packets (0x13) plen 5<br>&gt; ACL data: handle 4=
2 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3=
]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen=
 0 fcs 0x32 <br>&lt; ACL data: handle 42 flags 0x02 dlen 8<br>&nbsp;&nbsp;&=
nbsp; L2CAP(d): cid 0x0095 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9 <br>&lt; ACL data: handle =
42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0095 len 8 [psm=
 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 =
ilen 4 fcs 0xaa mcc_len 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 18 fc 0 rt=
c 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0<br>&gt; HCI Event: Number of Compl=
eted Packets (0x13) plen 5<br>&gt; HCI Event: Number of Completed Packets (=
0x13) plen 5<br>&gt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;=
&nbsp; L2CAP(d): cid 0x0040 len 8 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 le=
n 0<br>&lt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2=
CAP(d): cid 0x0095 len 8 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s=
): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0<br>&g=
t; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(d): c=
id 0x0040 len 8 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RS=
P: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0<br>&gt; HCI Ev=
ent: Number of Completed Packets (0x13) plen 5<br>&gt; ACL data: handle 42 =
flags 0x02 dlen 9<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 5 [psm 3]<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 =
fcs 0xd2 credits 100<br>&gt; ACL data: handle 42 flags 0x02 dlen 15<br>&nbs=
p;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 11 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 7 fcs 0xce <br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OBEX: Connect cmd(f): len 7 version 1.0 fla=
gs 0 mtu 32573<br>&lt; ACL data: handle 42 flags 0x02 dlen 9<br>&nbsp;&nbsp=
;&nbsp; L2CAP(d): cid 0x0095 len 5 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 34<br>&gt; HCI E=
vent: Number of Completed Packets (0x13) plen 5<br>&gt; ACL data: handle 42=
 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 8 [psm 3=
]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 il=
en 4 fcs 0x70 mcc_len 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 18 fc 0 rtc =
0 rtr 0 ic 0 dv 0 b1 1 b2 1 b3 0 len 0<br>&lt; ACL data: handle 42 flags 0x=
02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0095 len 8 [psm 3]<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs =
0xaa mcc_len 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 18 fc 0 rtc 0 rtr 0 i=
c 0 dv 0 b1 1 b2 1 b3 0 len 0<br>&gt; HCI Event: Number of Completed Packet=
s (0x13) plen 5<br>&gt; ACL data: handle 42 flags 0x02 dlen 8<br>&nbsp;&nbs=
p;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3 <br>&lt; ACL data: ha=
ndle 42 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0095 len 4 =
[psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 18 pf 1 =
ilen 0 fcs 0xf9 <br>&gt; HCI Event: Number of Completed Packets (0x13) plen=
 5<br>&gt; ACL data: handle 42 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CA=
P(d): cid 0x0040 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s):=
 DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd <br>&lt; ACL data: handle 42 flags =
0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0095 len 4 [psm 3]<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=
 <br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; ACL =
data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn =
req: dcid 0x0040 scid 0x0095<br>&lt; ACL data: handle 42 flags 0x02 dlen 12=
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0095<br>&g=
t; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; HCI Event: =
Disconn Complete (0x05) plen 4<br><br>I can't figure it out. is the server =
side need an agent to comfirm the client's request?<br>who can help me out =
, many thanks in advance!<br><br>tony<br></div><div>&nbsp;</div><div>&nbsp;=
</div><div>&nbsp;</div><div><br>--<br>
<div>&nbsp;Best Regards<br>&nbsp;------------<br>&nbsp;Tony<br></div>
</div><br><!-- footer --><br>=20
<hr>
<font style=3D"font-size: 12px; line-height: 15px;"></font><a style=3D"font=
-size: 12px; line-height: 15px; color: blue; text-decoration: underline;" h=
ref=3D"http://popme.163.com/link/003984_0707_2982.html">=D4=A8=B2=A8=C0=AB=
=D5=AC =BA=FE=BE=B0=C8=CB=C9=FA</a></blockquote><br><!-- footer --><br>=20
<hr>
<font style=3D"font-size:12px;line-height:15px;"></font><a style=3D"font-si=
ze:12px;line-height:15px; color:blue; text-decoration:underline;" href=3D"h=
ttp://popme.163.com/link/003984_0707_2982.html">=D4=A8=B2=A8=C0=AB=D5=AC =
=BA=FE=BE=B0=C8=CB=C9=FA</a>
------=_Part_205743_8511970.1215674979124--



--===============1991318034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1991318034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1991318034==--
