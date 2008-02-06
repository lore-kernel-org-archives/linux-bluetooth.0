Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Feb 2008 10:16:20 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: bluez-devel <bluez-devel@lists.sourceforge.net>,
	bluez-users@brisammon.fastmail.fm
MIME-Version: 1.0
Message-ID: <248211.83326.qm@web8403.mail.in.yahoo.com>
Subject: [Bluez-devel] system hangs playing audio on headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0218216354=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0218216354==
Content-Type: multipart/alternative; boundary="0-1436130499-1202273180=:83326"

--0-1436130499-1202273180=:83326
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi All=0AI am trying play audio from system on my headset.=0AWhen try mplay=
er=0A[Pramod@localhost ~]$ mplayer_install/bin/mplayer -ao alsa:device=3Dhe=
adset 1.mp3=0A=0Asystem hangs with following logs in /var/log/messages=0A=
=0AFeb  6 09:52:36 localhost hcid[3559]: Bluetooth HCI daemon=0AFeb  6 09:5=
2:36 localhost hcid[3559]: Starting security manager 0=0AFeb  6 09:52:56 lo=
calhost sdpd[3567]: Bluetooth SDP daemon=0AFeb  6 09:53:40 localhost headse=
td[3596]: Bluetooth headset daemon version 0.5=0AFeb  6 09:54:46 localhost =
hcid[3559]: pin_code_request (sba=3D00:0B:0D:33:9E:FB, dba=3D00:0F:DE:B1:02=
:42)=0AFeb  6 09:54:51 localhost hcid[3559]: link_key_notify (sba=3D00:0B:0=
D:33:9E:FB, dba=3D00:0F:DE:B1:02:42)Feb  6 09:55:17 localhost headsetd[3596=
]: Configuration phase ended: target bdaddr is 00:0F:DE:B1:02:42, timeout i=
s 6000 ms=0AFeb  6 09:55:17 localhost headsetd[3596]: Changing state: Idle-=
->Paging=0AFeb  6 09:55:19 localhost hcid[3559]: pin_code_request (sba=3D00=
:0B:0D:33:9E:FB, dba=3D00:0F:DE:B1:02:42)=0AFeb  6 09:55:23 localhost heads=
etd[3596]: Timeout connecting L2CAP socket to headset, aborting.=0AFeb  6 0=
9:55:23 localhost headsetd[3596]: Changing state: Paging-->Idle=0AFeb  6 09=
:55:28 localhost hcid[3559]: link_key_notify (sba=3D00:0B:0D:33:9E:FB, dba=
=3D00:0F:DE:B1:02:42)Feb  6 09:55:36 localhost headsetd[3596]: Configuratio=
n phase ended: target bdaddr is 00:0F:DE:B1:02:42, timeout is 6000 ms=0AFeb=
  6 09:55:36 localhost headsetd[3596]: Changing state: Idle-->Paging=0AFeb =
 6 09:55:39 localhost hcid[3559]: link_key_request (sba=3D00:0B:0D:33:9E:FB=
, dba=3D00:0F:DE:B1:02:42)=0AFeb  6 09:55:39 localhost headsetd[3596]: Chan=
ging state: Paging-->Connecting=0AFeb  6 09:55:39 localhost headsetd[3596]:=
 Changing state: Connecting-->Ready=0AFeb  6 09:55:39 localhost headsetd[35=
96]: Changing state: Ready-->Opening=0AFeb  6 09:55:39 localhost headsetd[3=
596]: SCO channel opened handle=3D0x0100 mtu=3D60=0AFeb  6 09:55:39 localho=
st headsetd[3596]: Changing state: Opening-->Streaming=0AFeb  6 10:00:05 lo=
calhost syslogd 1.4.1: restart.=0A=0A1) My ~/.asoundrc has =0Apcm.headset {=
=0A        @args [BDADDR TIMEOUT]=0A=0A        # The Bluetooth device addre=
ss for target headset,=0A        # used for Audio Gateway (PC) initiated co=
nnections=0A        # Please note that this value is ignored when the conne=
ction is Headset initiated=0A        @args.BDADDR {=0A                type =
string=0A                # Enter address of your headset here=0A           =
     default "00:0F:DE:B1:02:42"    #headset BDADDRESS=0A        }=0A=0A   =
     # This value represents how long we will try to reach the headset, unt=
il we give up.=0A        # Value is in milliseconds=0A        @args.TIMEOUT=
 {=0A                type integer=0A                default 6000=0A        =
}=0A=0A        type        sco=0A        bdaddr      $BDADDR=0A        time=
out     $TIMEOUT=0A}=0A=0Actl.headset {=0A        type sco=0A}=0A=0A2) My /=
etc/bluetooth/audio.service has.................=0A[Bluetooth Service]=0AId=
entifier=3Daudio=0AName=3DAudio service=0ADescription=3DBluetooth Audio ser=
vice=0AAutostart=3Dtrue=0A=0A3)  /etc/bluetooth/hcid.conf  has.............=
...=0A# HCI daemon configuration file.=0Aoptions {=0A        autoinit yes;=
=0A        security user;=0A        pairing multi;=0A#      passkey "BlueZ"=
;=0A}=0A=0A4) I am using linux-2.6.22 kernel, Bluez-3.25 (libs, utils), als=
o installed PLUGS & SBC from svn=0A    But i could not aplly SCO flow contr=
ol patch to my kernel...it failed..=0A=0ANeed I give more info to know what=
s going wrong..=0AWhats is the patch for   SCO flow control for 2.6.22 ??=
=0ASomeone help me please. =0A=0A=0AThanks and Best regards=0A =0APramod=0A=
=0A=0A=0A=0A=0A      Forgot the famous last words? Access your message arch=
ive online at http://in.messenger.yahoo.com/webmessengerpromo.php
--0-1436130499-1202273180=:83326
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Hi All<br>I am trying play audio from system on my headset.=
<br>When try mplayer<br>[Pramod@localhost ~]$ mplayer_install/bin/mplayer -=
ao alsa:device=3Dheadset 1.mp3<br><br>system hangs with following logs in /=
var/log/messages<br><br>Feb&nbsp; 6 09:52:36 localhost hcid[3559]: Bluetoot=
h HCI daemon<br>Feb&nbsp; 6 09:52:36 localhost hcid[3559]: Starting securit=
y manager 0<br>Feb&nbsp; 6 09:52:56 localhost sdpd[3567]: Bluetooth SDP dae=
mon<br>Feb&nbsp; 6 09:53:40 localhost headsetd[3596]: Bluetooth headset dae=
mon version 0.5<br>Feb&nbsp; 6 09:54:46 localhost hcid[3559]: pin_code_requ=
est (sba=3D00:0B:0D:33:9E:FB, dba=3D00:0F:DE:B1:02:42)<br>Feb&nbsp; 6 09:54=
:51 localhost hcid[3559]: link_key_notify (sba=3D00:0B:0D:33:9E:FB, dba=3D0=
0:0F:DE:B1:02:42)Feb&nbsp; 6 09:55:17 localhost headsetd[3596]: Configurati=
on
 phase ended: target bdaddr is 00:0F:DE:B1:02:42, timeout is 6000 ms<br>Feb=
&nbsp; 6 09:55:17 localhost headsetd[3596]: Changing state: Idle--&gt;Pagin=
g<br>Feb&nbsp; 6 09:55:19 localhost hcid[3559]: pin_code_request (sba=3D00:=
0B:0D:33:9E:FB, dba=3D00:0F:DE:B1:02:42)<br>Feb&nbsp; 6 09:55:23 localhost =
headsetd[3596]: Timeout connecting L2CAP socket to headset, aborting.<br>Fe=
b&nbsp; 6 09:55:23 localhost headsetd[3596]: Changing state: Paging--&gt;Id=
le<br>Feb&nbsp; 6 09:55:28 localhost hcid[3559]: link_key_notify (sba=3D00:=
0B:0D:33:9E:FB, dba=3D00:0F:DE:B1:02:42)Feb&nbsp; 6 09:55:36 localhost head=
setd[3596]: Configuration phase ended: target bdaddr is 00:0F:DE:B1:02:42, =
timeout is 6000 ms<br>Feb&nbsp; 6 09:55:36 localhost headsetd[3596]: Changi=
ng state: Idle--&gt;Paging<br>Feb&nbsp; 6 09:55:39 localhost hcid[3559]: li=
nk_key_request (sba=3D00:0B:0D:33:9E:FB, dba=3D00:0F:DE:B1:02:42)<br>Feb&nb=
sp; 6 09:55:39 localhost headsetd[3596]: Changing state:
 Paging--&gt;Connecting<br>Feb&nbsp; 6 09:55:39 localhost headsetd[3596]: C=
hanging state: Connecting--&gt;Ready<br>Feb&nbsp; 6 09:55:39 localhost head=
setd[3596]: Changing state: Ready--&gt;Opening<br>Feb&nbsp; 6 09:55:39 loca=
lhost headsetd[3596]: SCO channel opened handle=3D0x0100 mtu=3D60<br>Feb&nb=
sp; 6 09:55:39 localhost headsetd[3596]: Changing state: Opening--&gt;Strea=
ming<br>Feb&nbsp; 6 10:00:05 localhost syslogd 1.4.1: restart.<br><br><div>=
1) My ~/.asoundrc has <br>pcm.headset {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; @args [BDADDR TIMEOUT]<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; # The Bluetooth device address for target headset,<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # used for Audio Gateway (PC) initiated conn=
ections<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Please note that th=
is value is ignored when the connection is Headset initiated<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @args.BDADDR
 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; type string<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Enter address of you=
r headset here<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default "00:0F:DE:B1:02:42"&nbsp;&nbsp;&n=
bsp; #headset BDADDRESS<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # This value represents how =
long we will try to reach the headset, until we give up.<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; # Value is in milliseconds<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; @args.TIMEOUT {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type integer<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; default
 6000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 sco<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; $BDADDR<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout&=
nbsp;&nbsp;&nbsp;&nbsp; $TIMEOUT<br>}<br><br>ctl.headset {<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type sco<br>}<br><br>2) My /etc/bluetooth/aud=
io.service has.................<br>[Bluetooth Service]<br>Identifier=3Daudi=
o<br>Name=3DAudio service<br>Description=3DBluetooth Audio service<br>Autos=
tart=3Dtrue<br><br>3)&nbsp; /etc/bluetooth/hcid.conf&nbsp; has.............=
...<br># HCI daemon configuration file.<br>options {<br>&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp;&nbsp; autoinit yes;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; security user;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pairing mul=
ti;<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; passkey "BlueZ";<br>}<br><br>4) I am
 using linux-2.6.22 kernel, Bluez-3.25 (libs, utils), also installed PLUGS =
&amp; SBC from svn<br>&nbsp;&nbsp;&nbsp; But i could not aplly SCO flow con=
trol patch to my kernel...it failed..<br><br>Need I give more info to know =
whats going wrong..<br>Whats is the patch for&nbsp;  SCO flow control for 2=
..6.22 ??<br>Someone help me please. <br><br></div>Thanks and Best regards<b=
r><div>&nbsp;</div><div>Pramod<div><br></div></div></div><br>=0A=0A=0A     =
 <!--1--><hr size=3D1></hr> Download prohibited? No problem. <a href=3D"htt=
p://in.rd.yahoo.com/tagline_webmessenger_1/*http://in.messenger.yahoo.com/w=
ebmessengerpromo.php">CHAT</a> from any browser, without download.</body></=
html>
--0-1436130499-1202273180=:83326--



--===============0218216354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0218216354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0218216354==--
