Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Feb 2008 19:48:34 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: bluez-users@brisammon.fastmail.fm,
	bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <439923.71794.qm@web8409.mail.in.yahoo.com>
Subject: [Bluez-devel] Obex FTP failing on ARM platform
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0881573544=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0881573544==
Content-Type: multipart/alternative; boundary="0-1432646801-1204294714=:71794"

--0-1432646801-1204294714=:71794
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi list=0AI am trying to transfer file using BT to my phone.=0AI have cross=
 compiled bluez libs, utils, openobex, obexftp=0Ahcid & sdpd  are running=
=0Awhen I try to send file using=0A$obexftp -b 00:0E:6D:E0:E5:13 -B 10 -p t=
est1.raw=0AI get =0ABrowsing 00:0E:6D:E0:E5:13 ...=0AChannel: 10=0AConnecti=
ng...failed: connect=0AStill trying to connect=0AConnecting...failed: conne=
ct=0AStill trying to connect=0AConnecting...failed: connect=0AStill trying =
to connect=0A=0AAlso when I try to run obexftpd daemon =0A# obexftpd -b=0Af=
ailed to register bluetooth server: Success=0A=0Awhen I try bluetooth-servi=
ce-transfer=0A#bluetoothd-service-transfer &=0Atransfer[514]: Bluetooth tra=
nsfer service ver 3.25=0Athis keep on waiting =0A=0ACan anyone help me in t=
his please?=0A=0A=0A =0AThanks and Best regards=0A=0APramod=0A=0A=0A=0A=0A=
=0A      Why delete messages? Unlimited storage is just a click away. Go to=
 http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
--0-1432646801-1204294714=:71794
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi list<br>I am trying to transfer file using BT to my phon=
e.<br>I have cross compiled bluez libs, utils, openobex, obexftp<br>hcid &a=
mp; sdpd&nbsp; are running<br>when I try to send file using<br>$obexftp -b =
00:0E:6D:E0:E5:13 -B 10 -p test1.raw<br>I get <br>Browsing 00:0E:6D:E0:E5:1=
3 ...<br>Channel: 10<br>Connecting...failed: connect<br>Still trying to con=
nect<br>Connecting...failed: connect<br>Still trying to connect<br>Connecti=
ng...failed: connect<br>Still trying to connect<br><br>Also when I try to r=
un obexftpd daemon <br># obexftpd -b<br>failed to register bluetooth server=
: Success<br><br>when I try bluetooth-service-transfer<br>#bluetoothd-servi=
ce-transfer &amp;<br>transfer[514]: Bluetooth transfer service ver 3.25<br>=
this keep on waiting <br><br>Can anyone help me in this
 please?<br><br><br><div>&nbsp;</div>Thanks and Best regards<br><br><div>Pr=
amod<div><br></div></div></div><br>=0A=0A=0A=0A      <!--1--><hr size=3D1><=
/hr> Why delete messages? Unlimited storage is <a href=3D"http://in.rd.yaho=
o.com/tagline_mail_1/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools=
/tools-08.html/">just a click away.</a></body></html>
--0-1432646801-1204294714=:71794--


--===============0881573544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0881573544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0881573544==--
