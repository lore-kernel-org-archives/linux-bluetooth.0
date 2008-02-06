Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Feb 2008 18:11:48 +0530 (IST)
From: Andrew William <andrewonwork@yahoo.co.in>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <181244.61376.qm@web94001.mail.in2.yahoo.com>
Subject: [Bluez-devel] Can't connect RFCOMM socket: Connection refused
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0166594131=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0166594131==
Content-Type: multipart/alternative; boundary="0-1862842156-1202301708=:61376"

--0-1862842156-1202301708=:61376
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi All=0AI am using kernel 2.6.15, bluez 3.25(libs, utils) =0Atrying to con=
nect to mobile...=0A[root@localhost ~]# /usr/local/bin/rfcomm connect 0 00:=
0E:6D:E0:E5:13 1=0ACan't connect RFCOMM socket: Connection refused=0A=0A# H=
CI daemon configuration file.=0A# HCId options=0Aoptions {=0A         autoi=
nit yes;=0A          security user;=0A        pairing multi;=0A#       pass=
key "0000";=0A} =0A=0Adevice {=0A        name "MyBD";=0A        class 0x000=
100;=0A        #pkt_type DH1,DM1,HV1;=0A        iscan enable; pscan enable;=
=0A        lp rswitch,hold,sniff,park;=0A}=0A=0AI have no pin file specifie=
d as pin_helper.....=0A=0AThese are the log when i do=0A[root@localhost Pra=
mod]# /usr/local/sbin/hcid -f /etc/bluetooth/hcid.conf=0A[root@localhost Pr=
amod]# /usr/local/sbin/hciconfig hci0 up=0A[root@localhost ~]# /usr/local/b=
in/rfcomm connect 0 00:0E:6D:E0:E5:13 1=0A=0AFeb  6 17:46:20 localhost hcid=
[15010]: Bluetooth HCI daemon=0AFeb  6 17:46:20 localhost hcid[15010]: HCI =
dev 0 registered=0AFeb  6 17:46:20 localhost hcid[15010]: Created local ser=
ver at unix:abstract=3D/var/run/dbus-a5T4GfFoIo,guid=3D14a5a94738c59b0fec46=
ed95331ff200=0AFeb  6 17:46:20 localhost hcid[15010]: HCI dev 0 up=0AFeb  6=
 17:46:20 localhost hcid[15010]: Device hci0 has been added=0AFeb  6 17:46:=
20 localhost hcid[15010]: Starting security manager 0=0AFeb  6 17:46:20 loc=
alhost input[15012]: Bluetooth Input daemon=0AFeb  6 17:46:20 localhost inp=
ut[15012]: Registered input manager path:/org/bluez/input=0AFeb  6 17:46:20=
 localhost input[15012]: Failed to listen on control channel=0AFeb  6 17:46=
:20 localhost hcid[15010]: Device hci0 has been activated=0AFeb  6 17:48:11=
 localhost hcid[15010]: pin_code_request (sba=3D00:0B:0D:33:9E:FB, dba=3D00=
:0E:6D:E0:E5:13)=0AFeb  6 17:50:41 localhost hcid[15010]: pin_code_request =
(sba=3D00:0B:0D:33:9E:FB, dba=3D00:0E:6D:E0:E5:13)=0AFeb  6 18:05:12 localh=
ost hcid[15010]: pin_code_request (sba=3D00:0B:0D:33:9E:FB, dba=3D00:0E:6D:=
E0:E5:13)=0A=0ASome one please help me?=0AThank you in advance=0AAndrew=0A=
=0A=0A=0A=0A      5, 50, 500, 5000 - Store N number of mails in your inbox.=
 Go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
--0-1862842156-1202301708=:61376
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>hi All<br>I am using kernel 2.6.15, bluez 3.25(libs, u=
tils) <br>trying to connect to mobile...<br>[root@localhost ~]# /usr/local/=
bin/rfcomm connect 0 00:0E:6D:E0:E5:13 1<br>Can't connect RFCOMM socket: Co=
nnection refused<br><br># HCI daemon configuration file.<br># HCId options<=
br>options {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autoinit y=
es;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security user=
;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pairing multi;<br>#&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; passkey "0000";<br>} <br><br>device {<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name "MyBD";<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; class 0x000100;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; #pkt_type
 DH1,DM1,HV1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iscan enable; p=
scan enable;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lp rswitch,hold,=
sniff,park;<br>}<br><br>I have no pin file specified as pin_helper.....<br>=
<br>These are the log when i do<br>[root@localhost Pramod]# /usr/local/sbin=
/hcid -f /etc/bluetooth/hcid.conf<br>[root@localhost Pramod]# /usr/local/sb=
in/hciconfig hci0 up<br>[root@localhost ~]# /usr/local/bin/rfcomm connect 0=
 00:0E:6D:E0:E5:13 1<br><br>Feb&nbsp; 6 17:46:20 localhost hcid[15010]: Blu=
etooth HCI daemon<br>Feb&nbsp; 6 17:46:20 localhost hcid[15010]: HCI dev 0 =
registered<br>Feb&nbsp; 6 17:46:20 localhost hcid[15010]: Created local ser=
ver at unix:abstract=3D/var/run/dbus-a5T4GfFoIo,guid=3D14a5a94738c59b0fec46=
ed95331ff200<br>Feb&nbsp; 6 17:46:20 localhost hcid[15010]: HCI dev 0 up<br=
>Feb&nbsp; 6 17:46:20 localhost hcid[15010]: Device hci0 has been added<br>=
Feb&nbsp; 6 17:46:20 localhost hcid[15010]: Starting security manager
 0<br>Feb&nbsp; 6 17:46:20 localhost input[15012]: Bluetooth Input daemon<b=
r>Feb&nbsp; 6 17:46:20 localhost input[15012]: Registered input manager pat=
h:/org/bluez/input<br>Feb&nbsp; 6 17:46:20 localhost input[15012]: Failed t=
o listen on control channel<br>Feb&nbsp; 6 17:46:20 localhost hcid[15010]: =
Device hci0 has been activated<br>Feb&nbsp; 6 17:48:11 localhost hcid[15010=
]: pin_code_request (sba=3D00:0B:0D:33:9E:FB, dba=3D00:0E:6D:E0:E5:13)<br>F=
eb&nbsp; 6 17:50:41 localhost hcid[15010]: pin_code_request (sba=3D00:0B:0D=
:33:9E:FB, dba=3D00:0E:6D:E0:E5:13)<br>Feb&nbsp; 6 18:05:12 localhost hcid[=
15010]: pin_code_request (sba=3D00:0B:0D:33:9E:FB, dba=3D00:0E:6D:E0:E5:13)=
<br><br>Some one please help me?<br>Thank you in advance<br>Andrew<br></div=
></div><br>=0A=0A=0A      <!--2--><hr size=3D1></hr> Unlimited freedom, unl=
imited storage. <a href=3D"http://in.rd.yahoo.com/tagline_mail_2/*http://he=
lp.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Get it now</a>=
</body></html>
--0-1862842156-1202301708=:61376--



--===============0166594131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0166594131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0166594131==--
