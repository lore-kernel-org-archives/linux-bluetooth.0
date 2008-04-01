Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Apr 2008 16:28:39 +0530 (IST)
From: Andrew William <andrewonwork@yahoo.co.in>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <405428.48051.qm@web94001.mail.in2.yahoo.com>
Subject: [Bluez-users] RFCOMM between PCs returns DM
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0915151338=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0915151338==
Content-Type: multipart/alternative; boundary="0-1395279680-1207047519=:48051"

--0-1395279680-1207047519=:48051
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0A       I have compiled and installed bluez-utils-3.25 on myPC and =
a custom board based on ARM.I can connect to a mobile phoneusing 'rfcomm co=
nnect' from the board and PC.But when I try to connectthe PC to the board o=
r from the board to the PC,the connect-rfcommsocket call fails with connect=
ion refused( ECONNREFUSED).Passkey agentsare running on both sides.=0A =0A =
   hcidump shows that SABM ,UA ,PNCMD,frames are exchanged.But after PN CMD=
 the initiator gets a DM frameback instead of PN RSP .So the disconnection.=
The hcidump is =0A=0AHCI sniffer - Bluetooth packet analyzer ver 1.40=0Adev=
ice: hci0 snap_len: 1028 filter: 0xffffffff=0A< HCI Command: Create Connect=
ion (0x01|0x0005) plen 13=0A> HCI Event: Command Status (0x0f) plen 4=0A> H=
CI Event: Connect Complete (0x03) plen 11=0A< ACL data: handle 1 flags 0x02=
 dlen 12=0A    L2CAP(s): Connect req: psm 3 scid 0x0040=0A< HCI Command: Wr=
ite Link Policy Settings (0x02|0x000d) plen 4=0A> HCI Event: Command Comple=
te (0x0e) plen 6=0A> HCI Event: Max Slots Change (0x1b) plen 3=0A> HCI Even=
t: Number of Completed Packets (0x13) plen 5=0A> HCI Event: Connection Pack=
et Type Changed (0x1d) plen 5=0A< HCI Command: Remote Name Request (0x01|0x=
0019) plen 10=0A> ACL data: handle 1 flags 0x02 dlen 16=0A    L2CAP(s): Con=
nect rsp: dcid 0x0040 scid 0x0040 result 0 status 0=0A      Connection succ=
essful=0A> HCI Event: Command Status (0x0f) plen 4=0A< ACL data: handle 1 f=
lags 0x02 dlen 16=0A    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4=
=0A      MTU 1013=0A> HCI Event: Number of Completed Packets (0x13) plen 5=
=0A> ACL data: handle 1 flags 0x02 dlen 18=0A    L2CAP(s): Config rsp: scid=
 0x0040 flags 0x00 result 0 clen 4=0A      Success=0A      MTU 1013=0A> HCI=
 Event: Remote Name Req Complete (0x07) plen 255=0A> ACL data: handle 1 fla=
gs 0x02 dlen 16=0A    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4=
=0A      MTU 1013=0A< ACL data: handle 1 flags 0x02 dlen 14=0A    L2CAP(s):=
 Config rsp: scid 0x0040 flags 0x00 result 0 clen 0=0A      Success=0A< ACL=
 data: handle 1 flags 0x02 dlen 8=0A    L2CAP(d): cid 0x0040 len 4 [psm 3]=
=0A      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=0A> HCI Event: N=
umber of Completed Packets (0x13) plen 5=0A> HCI Event: Number of Completed=
 Packets (0x13) plen 5=0A> ACL data: handle 1 flags 0x02 dlen 8=0A    L2CAP=
(d): cid 0x0040 len 4 [psm 3]=0A      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen =
0 fcs 0xd7=0A< ACL data: handle 1 flags 0x02 dlen 18=0A    L2CAP(d): cid 0x=
0040 len 14 [psm 3]=0A      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs=
 0x70 mcc_len 8=0A      dlci 20 frame_type 0 credit_flow 15 pri 7 ack_timer=
 0=0A      frame_size 1008 max_retrans 0 credits 7=0A> HCI Event: Number of=
 Completed Packets (0x13) plen 5=0A> ACL data: handle 1 flags 0x02 dlen 8=
=0A    L2CAP(d): cid 0x0040 len 4 [psm 3]=0A      RFCOMM(s): DM: cr 1 dlci =
20 pf 1 ilen 0 fcs 0xd7=0A< ACL data: handle 1 flags 0x02 dlen 8=0A    L2CA=
P(d): cid 0x0040 len 4 [psm 3]=0A      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 il=
en 0 fcs 0xfd=0A< ACL data: handle 1 flags 0x02 dlen 12=0A    L2CAP(s): Dis=
conn req: dcid 0x0040 scid 0x0040=0A> HCI Event: Number of Completed Packet=
s (0x13) plen 5=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
> ACL data: handle 1 flags 0x02 dlen 8=0A    L2CAP(d): cid 0x0040 len 4 [ps=
m 3]=0A      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=0A> ACL data: =
handle 1 flags 0x02 dlen 12=0A    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0=
x0040=0A< HCI Command: Disconnect (0x01|0x0006) plen 3=0A> HCI Event: Comma=
nd Status (0x0f) plen 4=0A> HCI Event: Disconn Complete (0x05) plen 4=0A=0A=
  What could be the problem here?=0A=0AThank you for your time,=0ARegards,=
=0AAndrew.=0A=0A=0A=0A      Explore your hobbies and interests. Go to http:=
//in.promos.yahoo.com/groups
--0-1395279680-1207047519=:48051
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>Hi,<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; I have comp=
iled and installed bluez-utils-3.25 on my=0APC and a custom board based on =
ARM.I can connect to a mobile phone=0Ausing 'rfcomm connect' from the board=
 and PC.But when I try to connect=0Athe PC to the board or from the board t=
o the PC,the connect-rfcomm=0Asocket call fails with connection refused( EC=
ONNREFUSED).Passkey agents=0Aare running on both sides.<br>&nbsp;<br>&nbsp;=
&nbsp;&nbsp; hcidump shows that SABM ,UA ,PN=0ACMD,frames are exchanged.But=
 after PN CMD the initiator gets a DM frame=0Aback instead of PN RSP .So th=
e disconnection.The hcidump is <br><br>HCI sniffer - Bluetooth packet analy=
zer ver 1.40<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&lt; HCI =
Command: Create Connection (0x01|0x0005) plen 13<br>&gt; HCI Event: Command=
 Status (0x0f) plen 4<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br=
>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s):=
 Connect req: psm 3 scid 0x0040<br>&lt; HCI=0A Command: Write Link Policy S=
ettings (0x02|0x000d) plen 4<br>&gt; HCI Event: Command Complete (0x0e) ple=
n 6<br>&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&gt; HCI Event: Nu=
mber of Completed Packets (0x13) plen 5<br>&gt; HCI Event: Connection Packe=
t Type Changed (0x1d) plen 5<br>&lt; HCI Command: Remote Name Request (0x01=
|0x0019) plen 10<br>&gt; ACL data: handle 1 flags 0x02 dlen 16<br>&nbsp;&nb=
sp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>&gt; HCI Event: =
Command Status (0x0f) plen 4<br>&lt; ACL data: handle 1 flags 0x02 dlen 16<=
br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1013<br>&gt; HCI Event: Number of Comp=
leted Packets (0x13) plen 5<br>&gt; ACL data: handle 1 flags 0x02 dlen 18<b=
r>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 =
clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A Success<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; MTU 1013<br>&gt; HCI Event: Remote Name Req Complete (0x07) plen=
 255<br>&gt; ACL data: handle 1 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2=
CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; MTU 1013<br>&lt; ACL data: handle 1 flags 0x02 dlen 14<br>&nbsp;&n=
bsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&lt; ACL data: handle 1 flags 0x0=
2 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c<=
br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; HCI Ev=
ent: Number of Completed Packets (0x13) plen 5<br>&gt; ACL data: handle 1 f=
lags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs=
 0xd7<br>&lt; ACL data: handle 1
 flags 0x02 dlen=0A 18<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 14 [p=
sm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0=
 ilen 10 fcs 0x70 mcc_len 8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 20 frame=
_type 0 credit_flow 15 pri 7 ack_timer 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
frame_size 1008 max_retrans 0 credits 7<br>&gt; HCI Event: Number of Comple=
ted Packets (0x13) plen 5<br>&gt; ACL data: handle 1 flags 0x02 dlen 8<br>&=
nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; RFCOMM(s): DM: cr 1 dlci 20 pf 1 ilen 0 fcs 0xd7<br>&lt; ACL da=
ta: handle 1 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 l=
en 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 0=
 pf 1 ilen 0 fcs 0xfd<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbs=
p;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040<br>&gt; HCI E=
vent: Number of Completed Packets (0x13) plen 5<br>&gt; HCI Event: Number o=
f Completed
 Packets (0x13) plen=0A 5<br>&gt; ACL data: handle 1 flags 0x02 dlen 8<br>&=
nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<br>&gt; ACL dat=
a: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp:=
 dcid 0x0040 scid 0x0040<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen=
 3<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&gt; HCI Event: Disco=
nn Complete (0x05) plen 4<br><br>&nbsp; What could be the problem here?<br>=
<br>Thank you for your time,<br>Regards,<br>Andrew.</div></div><br>=0A=0A=
=0A=0A      <!--1--><hr size=3D1></hr> Why delete messages? Unlimited stora=
ge is <a href=3D"http://in.rd.yahoo.com/tagline_mail_1/*http://help.yahoo.c=
om/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">just a click away.</a></=
body></html>
--0-1395279680-1207047519=:48051--



--===============0915151338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0915151338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0915151338==--
