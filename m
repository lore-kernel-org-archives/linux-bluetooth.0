Return-Path: <cyrus@holtmann.org>
Date: Sat, 2 Feb 2008 12:46:43 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: Bluez-users@lists.sourceforge.net,
	bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <523334.87939.qm@web8401.mail.in.yahoo.com>
Subject: [Bluez-users] SDP server failing to connect
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1272448274=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net
List-ID: <bluez-devel.lists.sourceforge.net>

--===============1272448274==
Content-Type: multipart/alternative; boundary="0-1489287100-1201936603=:87939"

--0-1489287100-1201936603=:87939
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi all=0Ai am trying to connect to my BT headset to system which has a USB =
dongle on it.=0ABut when i do =0A[root@localhost Pramod]# rfcomm connect 0 =
00:0F:DE:B1:02:42 1=0ACan't connect RFCOMM socket: Permission denied=0AAlso=
 when i try to browse services on headset=0A[root@localhost Pramod]# sdptoo=
l browse 00:0F:DE:B1:02:42=0AFailed to connect to SDP server on 00:0F:DE:B1=
:02:42: Permission denied=0A=0AWhats the reason???=0Amy hcid.conf file look=
s like this=0A=0A# HCI daemon configuration file.=0A# HCId options=0Aoption=
s {=0A         autoinit yes;=0A         security user;=0A         pairing m=
ulti;=0A=0A        # Default PIN code for incoming connections=0A#       pa=
sskey "147";=0A#       pin_helper /etc/bluetooth/pin;=0A        pin_helper =
/bin/bluepin;=0A#       pin_helper /etc/bluetooth/feed-pin.sh;=0A}=0A=0A# D=
efault settings for HCI devices=0Adevice {=0A             name "MistralBD";=
=0A        class 0x000100;=0A=0A        # Default packet type=0A        #pk=
t_type DH1,DM1,HV1;=0A=0A        iscan enable; pscan enable;=0A        lm a=
ccept;=0A=0A        # Default link policy=0A        lp rswitch,hold,sniff,p=
ark;=0A}=0Amy /bin/bluepin(permission 755) has =0A        #!/bin/sh=0A     =
   echo "PIN:G1UvjyBAx2WZ2ebc"=0Amy rfcomm.conf has  everything commented..=
...=0AI am not able to pair my headset with system.=0Athe logs in /var/log/m=
essages show that PIN request is being made=0AFeb  2 12:32:07 localhost hci=
d[3879]: pin_code_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42=
)=0AFeb  2 12:37:47 localhost hcid[3879]: pin_code_request (sba=3D00:00:00:=
00:00:00, dba=3D00:0F:DE:B1:02:42)=0A=0Ahelp please...=0Athanks in advance.=
...=0A=0APramod=0A=0A=0A=0A=0A=0A=0A=0A=0A      Forgot the famous last words=
? Access your message archive online at http://in.messenger.yahoo.com/webme=
ssengerpromo.php
--0-1489287100-1201936603=:87939
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>hi all<br>i am trying to connect to my BT headset to s=
ystem which has a USB dongle on it.<br>But when i do <br>[root@localhost Pr=
amod]# rfcomm connect 0 00:0F:DE:B1:02:42 1<br>Can't connect RFCOMM socket:=
 Permission denied<br>Also when i try to browse services on headset<br>[roo=
t@localhost Pramod]# sdptool browse 00:0F:DE:B1:02:42<br>Failed to connect =
to SDP server on 00:0F:DE:B1:02:42: Permission denied<br><br>Whats the reas=
on???<br>my hcid.conf file looks like this<br><br># HCI daemon configuratio=
n file.<br># HCId options<br>options {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; autoinit yes;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; security user;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
airing multi;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #
 Default PIN code for incoming connections<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; passkey "147";<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pin_helper=
 /etc/bluetooth/pin;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pin_help=
er /bin/bluepin;<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pin_helper /etc/b=
luetooth/feed-pin.sh;<br>}<br><br># Default settings for HCI devices<br>dev=
ice {<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; name "MistralBD";<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class 0x0=
00100;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default packet t=
ype<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #pkt_type DH1,DM1,HV1;<br=
><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iscan enable; pscan enable;=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lm accept;<br><br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default link policy<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; lp rswitch,hold,sniff,park;<br>}<br>my
 /bin/bluepin(permission 755) has <br><pre>        #!/bin/sh<br>        ech=
o "PIN:G1UvjyBAx2WZ2ebc"<br></pre>my rfcomm.conf has&nbsp; everything comme=
nted....<br>I am not able to pair my headset with system.<br>the logs in /v=
ar/log/messages show that PIN request is being made<br>Feb&nbsp; 2 12:32:07=
 localhost hcid[3879]: pin_code_request (sba=3D00:00:00:00:00:00, dba=3D00:=
0F:DE:B1:02:42)<br>Feb&nbsp; 2 12:37:47 localhost hcid[3879]: pin_code_requ=
est (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)<br><br>help please..=
..<br>thanks in advance...<br><br>Pramod<br><br><br><br><br></div></div><br>=
=0A=0A=0A=0A      <!--1--><hr size=3D1></hr> Why delete messages? Unlimited=
 storage is <a href=3D"http://in.rd.yahoo.com/tagline_mail_1/*http://help.y=
ahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">just a click away.=
</a></body></html>
--0-1489287100-1201936603=:87939--



--===============1272448274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1272448274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1272448274==--
