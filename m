Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY102-W17970DD14D6076D3F44BCBF0420@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>,
	<bluez-users@lists.sourceforge.net>
Date: Fri, 18 Jan 2008 15:04:58 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Same Old Speed Issues
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0508140567=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net
List-ID: <bluez-devel.lists.sourceforge.net>

--===============0508140567==
Content-Type: multipart/alternative;
	boundary="_1d621f38-11be-4354-910e-743276a4d57b_"

--_1d621f38-11be-4354-910e-743276a4d57b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
You'll have to forgive me, I've posted a copy of this mail to both the user=
s and developers list in the hope that I might widen the audience a little =
bit and hopefully find a solution to this problem as its been causing me pr=
oblems for quite some time, I hope you don't mind.
=20
The crux of the issue is that I'm getting very slow OBEX transmit speeds, d=
espite the fact that all the conditions seems to be correct for me to take =
advantage of the full Bluetooth 2 + EDR specification. I'll try my best to =
help explain all the details and hopefully you'll have some ideas on diagno=
sing or solving the problems.
=20
I'm running a USB dongle from Ezurio which is based on a CSR chipset, runni=
ng Bluetooth version 2.0 with EDR capabilities. more details on the dongle =
can be found on thier site. http://www.ezurio.co.uk/products/highspeedusbad=
aptor/
=20
I'm running this on a Debian based system, which is running kernel version =
2.6.23 and has Bluez version 3.24 which has been installed from a package o=
n the apt-get service.
=20
At the moment I've tried using both ussp-push and open-obex push clients to=
 transfer the file, both giving me the same results. I'm achieving roughly =
25Kbytes/s transfer speed both up and down. I've tried running these same d=
ongles from my Windows PC and achieve well over 100kBytes/s. (This is trans=
mitting to a Sony k850i handset which is v2.0 + EDR). This would lead me to=
 believe its not an issue with the Dongle, more likely something with my Li=
nux configuration
=20
The output from hciconfig -a look as follows, I'm unable to see anything un=
expected in it:
=20
hci0:   Type: USB        BD Address: 00:80:98:E6:38:BD ACL MTU: 310:10 SCO =
MTU: 64:8        UP RUNNING PSCAN ISCAN         RX bytes:242063 acl:5074 sc=
o:0 events:16608 errors:0        TX bytes:5053795 acl:24234 sco:0 commands:=
146 errors:0        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80      =
  Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3         Link policy: RSW=
ITCH HOLD SNIFF PARK         Link mode: MASTER         Name: 'Hello'       =
 Class: 0x080100        Service Classes: Capturing        Device Class: Com=
puter, Uncategorized        HCI Ver: 2.0 (0x3) HCI Rev: 0xbf4 LMP Ver: 2.0 =
(0x3) LMP Subver: 0xbf4        Manufacturer: Cambridge Silicon Radio (10)
=20
And likewise when looking at the features for the chip, it lists the EDR su=
pport as we would expect.
=20
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80                <3=
-slot packets> <5-slot packets> <encryption> <slot offset>                 =
<timing accuracy> <role switch> <hold mode> <sniff mode>                 <p=
ark state> <RSSI> <channel quality> <SCO link> <HV2 packets>               =
  <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>             =
    <power control> <transparent SCO> <broadcast encrypt>                 <=
EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>                 <interlac=
ed iscan> <interlaced pscan> <inquiry with RSSI>                 <extended =
SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>                 <AFH clas=
s. slave> <3-slot EDR ACL> <5-slot EDR ACL>                 <AFH cap. maste=
r> <AFH class. master> <EDR eSCO 2 Mbps>                 <EDR eSCO 3 Mbps> =
<3-slot EDR eSCO> <extended features>
=20
This slow speed has been plaguing me for a long time and I've never been ab=
le to find anything which looks out of place, regardless of the different k=
ernel and blues editions I've tried.
=20
Can anyone provide any advice? if you need any more information at all them=
 please do let me know.
=20
Thanks for your time,
=20
Robert
_________________________________________________________________
Get Hotmail on your mobile, text MSN to 63463!
http://mobile.uk.msn.com/pc/mail.aspx=

--_1d621f38-11be-4354-910e-743276a4d57b_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>Hello Guys,<BR>
&nbsp;<BR>
You'll have to forgive me, I've posted a copy of this mail to both the user=
s and developers list in the hope that I might widen the audience a little =
bit and hopefully find a solution to this problem as its been causing me pr=
oblems for quite some time, I hope you don't mind.<BR>
&nbsp;<BR>
The crux of the issue is that I'm getting very slow OBEX transmit speeds, d=
espite the fact that all the conditions seems to be correct for me to take =
advantage of the full Bluetooth 2 + EDR specification. I'll try my best to =
help explain all the details and hopefully you'll have some ideas on diagno=
sing or solving the problems.<BR>
&nbsp;<BR>
I'm running a USB dongle from Ezurio which is based on a CSR chipset, runni=
ng Bluetooth version 2.0 with EDR capabilities. more details on the dongle =
can be found on thier site. <A href=3D"http://www.ezurio.co.uk/products/hig=
hspeedusbadaptor/">http://www.ezurio.co.uk/products/highspeedusbadaptor/</A=
><BR>
&nbsp;<BR>
I'm running this on a Debian based system, which is running kernel version =
2.6.23 and has Bluez version 3.24 which has been installed from a package o=
n the apt-get service.<BR>
&nbsp;<BR>
At the moment I've tried using both ussp-push and open-obex push clients to=
 transfer the file, both giving me the same results. I'm achieving roughly =
25Kbytes/s transfer speed both up and down. I've tried running these same d=
ongles from my Windows&nbsp;PC and achieve well over 100kBytes/s. (This is =
transmitting to a Sony k850i handset which is v2.0 + EDR). This would lead =
me to believe its not an issue with the Dongle, more likely something with =
my Linux configuration<BR>
&nbsp;<BR>
The output from hciconfig -a look as follows, I'm unable to see anything un=
expected in it:<BR>
&nbsp;<BR>
hci0:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B=
D Address: 00:80:98:E6:38:BD ACL MTU: 310:10 SCO MTU: 64:8<BR>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN <BR>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:242063 acl:5074 sco:0 events:16608 errors=
:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:5053795 acl:24234=
 sco:0 commands:146 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80<BR>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 <BR>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF P=
ARK <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: MASTER <BR>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'Hello'<BR>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x080100<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; Service Classes: Capturing<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Device Class: Computer, Uncategorized<BR>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; HCI Ver: 2.0 (0x3) HCI Rev: 0xbf4 LMP Ver: 2.0 (0x3) LM=
P Subver: 0xbf4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer:=
 Cambridge Silicon Radio (10)<BR>
&nbsp;<BR>
And likewise when looking at the features for the chip, it lists the EDR su=
pport as we would expect.<BR>
&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x8f 0xfe 0x=
9b 0xf9 0x00 0x80<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot pack=
ets&gt; &lt;encryption&gt; &lt;slot offset&gt; <BR>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timi=
ng accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt; <B=
R>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &=
lt;SCO link&gt; &lt;HV2 packets&gt; <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt;=
 &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt; &lt;paging scheme&gt; <BR=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &lt;power control&gt; &lt;transparent SCO&gt; &lt;broadcas=
t encrypt&gt; <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;EDR ACL 2 Mbps&gt; &lt;EDR ACL 3 Mbps=
&gt; &lt;enhanced iscan&gt; <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;interlaced iscan&gt; &l=
t;interlaced pscan&gt; &lt;inquiry with RSSI&gt; <BR>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;ex=
tended SCO&gt; &lt;EV4 packets&gt; &lt;EV5 packets&gt; &lt;AFH cap. slave&g=
t; <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;AFH class. slave&gt; &lt;3-slot EDR ACL&gt; &lt;=
5-slot EDR ACL&gt; <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH cap. master&gt; &lt;AFH clas=
s. master&gt; &lt;EDR eSCO 2 Mbps&gt; <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;EDR eSCO 3 Mb=
ps&gt; &lt;3-slot EDR eSCO&gt; &lt;extended features&gt;<BR>
&nbsp;<BR>
This slow speed has been plaguing me for a long time and I've never been ab=
le to find anything which looks out of place, regardless of the different k=
ernel and blues editions I've tried.<BR>
&nbsp;<BR>
Can anyone provide any advice? if you need any more information at all them=
 please do let me know.<BR>
&nbsp;<BR>
Thanks for your time,<BR>
&nbsp;<BR>
Robert<BR><br /><hr />Think you know your TV, music and film? <a href=3D'ht=
tps://www.searchcharades.com' target=3D'_new'>Try Search Charades!</a></bod=
y>
</html>=

--_1d621f38-11be-4354-910e-743276a4d57b_--


--===============0508140567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0508140567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0508140567==--
