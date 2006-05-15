Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY111-DAV39E3C1E24B8A8C6F71B7998A30@phx.gbl>
From: =?iso-8859-1?B?1nprYW4gR/xt/HM=?= <ozkan_gumus@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
References: <3e890f530605131204w2980dee2v586468fed3fe16ed@mail.gmail.com>
Subject: Re: [Bluez-devel] Inquiry with RSSI on Broadcom BCM2035 - not supported ?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0075_01C6780F.86996440"
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
Date: Mon, 15 May 2006 11:05:50 +0300

This is a multi-part message in MIME format.

------=_NextPart_000_0075_01C6780F.86996440
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

how you can understand that the dongle does not support <Inquiry with =
RSSI>.
if this is a code which test it, can you send me the code used to =
<Inquiry with RSSI> ? In my BT-DG03 chipset compliant with v1.1 and it =
says=20
~$ hciconfig hci0 features
hci0:  =20
     Type: USB       =20
         BD Address: 00:04:61:81:B8:45 ACL MTU: 192:8 SCO MTU: 64:8
         Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00             =20
         <3-slot packets> <5-slot packets> <encryption> <slot offset>    =
        =20
         <timing accuracy> <role switch> <hold mode> <sniff mode>        =
       =20
         <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>  =
             =20
         <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>    =
         =20
         <transparent SCO>

i am using Ubuntu Breezy badger with Bluez stack.



  --- Original Message -----=20
  From: Javier Rodas Gonz=E1lez=20
  To: bluez-devel@lists.sourceforge.net=20
  Sent: Saturday, May 13, 2006 10:04 PM
  Subject: [Bluez-devel] Inquiry with RSSI on Broadcom BCM2035 - not =
supported ?


  I have make this question on bluez-users mailing list some time ago, =
without answer.


  I have tested the D-Link DBT-122 dongle (BCM2035 chipset) with =
BlueZ-utils and I find the following features list:

  # hciconfig hci0 features
  hci0:   Type: USB
          BD Address: 00:13:46:01:22:90 ACL MTU: 377:10 SCO MTU: 16:0
          Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
                  <3-slot packets> <5-slot packets> <encryption> <slot =
offset>
                  <timing accuracy> <role switch> <hold mode> <sniff =
mode>
                  <RSSI> <channel quality> <SCO link> <HV2 packets>
                  <HV3 packets> <u-law log> <A-law log> <CVSD> <power =
control>
                  <transparent SCO> <enhanced iscan> <interlaced iscan>
                  <interlaced pscan> <AFH cap. slave> <AFH cap. master>

  Looking the manufactured specification page of BCM2035 chipset it says =
that it implements the Bluetooth v1.2 specification. Nevertheless I =
found that it's not true, because this dongle doesn't support the =
<Inquiry with RSSI> feature, that belongs to that version and following =
of the BT specification.


  I have also tested other usb dongles, for example CSR BlueCore4, =
successfully with this feature:

  # hciconfig hci0 features
  hci0:   Type: USB
          BD Address: 00:80:5A:46:2D:51 ACL MTU: 384:8 SCO MTU: 64:8
          Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
                  <3-slot packets> <5-slot packets> <encryption> <slot =
offset>
                  <timing accuracy> <role switch> <hold mode> <sniff =
mode>
                  <park state> <RSSI> <channel quality> <SCO link> <HV2 =
packets>
                  <HV3 packets> <u-law log> <A-law log> <CVSD> <paging =
scheme>
                  <power control> <transparent SCO> <broadcast encrypt>
                  <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
                  <interlaced iscan> <interlaced pscan> <inquiry with =
RSSI>  <-----
                  <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. =
slave>
                  <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
                  <AFH cap. master> <AFH class. master> <EDR eSCO 2 =
Mbps>
                  <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended =
features>



  Please, could you confirm me that it's impossible to make an "Inquiry =
with RSSI" operation with the BCM2035 chipset from Broadcom ?
  Do you know on existence of an firmware upgrade for this chipsets that =
solves this lack ?


  I have asked the same question on D-Link support page without =
response.
  I use Ubuntu Dapper with Kernel v2.6.15 and BlueZ-utils v2.25.


  Thanks for your attention.

  Best regards.

------=_NextPart_000_0075_01C6780F.86996440
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>how you can understand that the dongle =
does not=20
support <FONT face=3D"Times New Roman" size=3D3>&lt;Inquiry with=20
RSSI&gt;.</FONT></FONT></DIV>
<DIV>if this is a code which test it, <FONT face=3DArial size=3D2>can =
you send me=20
the code used to <FONT face=3D"Times New Roman" size=3D3>&lt;Inquiry =
with RSSI&gt; ?=20
In my BT-DG03 chipset compliant with v1.1 and it says <BR>~$ hciconfig =
hci0=20
features<BR>hci0:&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp;&nbsp; Type:=20
USB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
BD Address: 00:04:61:81:B8:45 ACL MTU: 192:8 SCO MTU:=20
64:8<BR>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Features: 0xff 0xff =
0x0b=20
0x00 0x00 0x00 0x00=20
0x00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt;=20
&lt;encryption&gt; &lt;slot=20
offset&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold =
mode&gt;=20
&lt;sniff=20
mode&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &lt;park state&gt; <FONT =
color=3D#800000>&lt;RSSI&gt;</FONT>=20
&lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2=20
packets&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law =
log&gt;=20
&lt;CVSD&gt; &lt;paging=20
scheme&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &lt;transparent SCO&gt;</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3DArial =
size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3><FONT=20
face=3DArial size=3D2>i am using Ubuntu Breezy badger with Bluez=20
stack.</FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3><FONT=20
face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><BR></DIV></FONT></FONT>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">--- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Djavier.rodas@nomasystems.com=20
  href=3D"mailto:javier.rodas@nomasystems.com">Javier Rodas =
Gonz=E1lez</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A=20
  title=3Dbluez-devel@lists.sourceforge.net=20
  =
href=3D"mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourc=
eforge.net</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Saturday, May 13, 2006 =
10:04=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> [Bluez-devel] Inquiry =
with RSSI=20
  on Broadcom BCM2035 - not supported ?</DIV>
  <DIV><BR></DIV>I have make this question on bluez-users mailing list =
some time=20
  ago, without answer.<BR><BR><BR>I have tested the D-Link DBT-122 =
dongle=20
  (BCM2035 chipset) with BlueZ-utils and I find the following features=20
  list:<BR><BR># hciconfig hci0 features<BR>hci0:&nbsp;&nbsp; Type:=20
  USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:=20
  00:13:46:01:22:90 ACL MTU: 377:10 SCO MTU:=20
  16:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xfe =
0x0d=20
  0x38 0x08 0x08 0x00=20
  =
0x00<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; =
&lt;slot=20
  =
offset&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; =
&lt;sniff=20
  =
mode&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2=20
  =
packets&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt; =
&lt;power=20
  =
control&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;transparent SCO&gt; &lt;enhanced iscan&gt; &lt;interlaced=20
  =
iscan&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;interlaced pscan&gt; &lt;AFH cap. slave&gt; &lt;AFH cap.=20
  master&gt;<BR><BR>Looking the manufactured specification page of =
BCM2035=20
  chipset it says that it implements the Bluetooth v1.2 specification.=20
  Nevertheless I found that it's not true, because this dongle doesn't =
support=20
  the &lt;Inquiry with RSSI&gt; feature, that belongs to that version =
and=20
  following of the BT specification.<BR><BR><BR>I have also tested other =
usb=20
  dongles, for example CSR BlueCore4, successfully with this =
feature:<BR><BR>#=20
  hciconfig hci0 features<BR>hci0:&nbsp;&nbsp; Type:=20
  USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:=20
  00:80:5A:46:2D:51 ACL MTU: 384:8 SCO MTU:=20
  64:8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff =
0x8f=20
  0xfe 0x9b 0xf9 0x00=20
  =
0x80<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; =
&lt;slot=20
  =
offset&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; =
&lt;sniff=20
  =
mode&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO =
link&gt;=20
  &lt;HV2=20
  =
packets&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt;=20
  &lt;paging=20
  =
scheme&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;power control&gt; &lt;transparent SCO&gt; &lt;broadcast=20
  =
encrypt&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;EDR ACL 2 Mbps&gt; &lt;EDR ACL 3 Mbps&gt; &lt;enhanced=20
  =
iscan&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;interlaced iscan&gt; &lt;interlaced pscan&gt; &lt;inquiry with=20
  RSSI&gt;&nbsp;=20
  =
&lt;-----<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;extended SCO&gt; &lt;EV4 packets&gt; &lt;EV5 packets&gt; &lt;AFH =
cap.=20
  =
slave&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;AFH class. slave&gt; &lt;3-slot EDR ACL&gt; &lt;5-slot EDR=20
  =
ACL&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;AFH cap. master&gt; &lt;AFH class. master&gt; &lt;EDR eSCO 2=20
  =
Mbps&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &lt;EDR eSCO 3 Mbps&gt; &lt;3-slot EDR eSCO&gt; &lt;extended=20
  features&gt;<BR><BR><BR><BR>Please, could you confirm me that it's =
impossible=20
  to make an "Inquiry with RSSI" operation with the BCM2035 chipset from =

  Broadcom ?<BR>Do you know on existence of an firmware upgrade for this =

  chipsets that solves this lack ?<BR><BR><BR>I have asked the same =
question on=20
  D-Link support page without response.<BR>I use Ubuntu Dapper with =
Kernel=20
  v2.6.15 and BlueZ-utils v2.25.<BR><BR><BR>Thanks for your=20
  attention.<BR><BR>Best regards.<BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0075_01C6780F.86996440--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
