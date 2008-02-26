Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Feb 2008 14:35:44 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: bluez-users@brisammon.fastmail.fm,
	bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <307246.71328.qm@web8401.mail.in.yahoo.com>
Subject: [Bluez-devel] error whjile cross compiling Bluez-utils
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0638222977=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0638222977==
Content-Type: multipart/alternative; boundary="0-418839311-1204016744=:71328"

--0-418839311-1204016744=:71328
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi All=0AI am cross comiling bluez for arm processer.=0AI cross compiled li=
bdbus, libxml, bluez-libs successfully=0AI am getting errors whilr compilin=
g utils.=0A=0Asdp-xml.c:36:27: bluetooth/sdp.h: No such file or directory=
=0Asdp-xml.c:37:31: bluetooth/sdp_lib.h: No such file or directory=0AIn fil=
e included from sdp-xml.c:41:=0Asdp-xml.h:33: error: parse error before '*'=
 token=0Asdp-xml.h:34: error: parse error before ')' token=0Asdp-xml.h:36: =
warning: type defaults to `int' in declaration of `sdp_xml_parse_nil'=0Asdp=
-xml.h:36: warning: data definition has no type or storage class=0A=0Ai con=
figured it with=0A[Pramod@localhost bluez-utils-3.25]$ export LD_LIBRARY_PA=
TH=3D$LD_LIBRARY_PATH:/home/Pramod/projects/install/lib=0A=0A[Pramod@localh=
ost bluez-utils-3.25]$ export PATH=3D$PATH:/opt/gcc-3.4.4-glibc-2.3.5/bin=
=0A=0A[Pramod@localhost bluez-utils-3.25]$ ./configure --build=3Di686-pc-li=
nux-gnu --host=3Darm-linux --sysconfdir=3D/home/Pramod/projects/install/etc=
 --prefix=3D/home/Pramod/projects/install ./configure --enable-inotify --en=
able-usb --enable-obex --enable-alsa --enable-test --enable-audio --enable-=
input --enable-serial --enable-gstreamer --enable-network --enable-sync --e=
nable-hcid --enable-sdpd --enable-hidd --enable-pand --enable-echo --enable=
-configfiles --enable-initscripts --enable-avctrl=0A=0ACan anyone help me i=
n this?=0A=0AThanks and Best regards =0APramod=0A=0A=0A=0A=0A=0A      5, 50=
, 500, 5000 - Store N number of mails in your inbox. Go to http://help.yaho=
o.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
--0-418839311-1204016744=:71328
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi All<br>I am cross comiling bluez for arm processer.<br>I=
 cross compiled libdbus, libxml, bluez-libs successfully<br>I am getting er=
rors whilr compiling utils.<br><br>sdp-xml.c:36:27: bluetooth/sdp.h: No suc=
h file or directory<br>sdp-xml.c:37:31: bluetooth/sdp_lib.h: No such file o=
r directory<br>In file included from sdp-xml.c:41:<br>sdp-xml.h:33: error: =
parse error before '*' token<br>sdp-xml.h:34: error: parse error before ')'=
 token<br>sdp-xml.h:36: warning: type defaults to `int' in declaration of `=
sdp_xml_parse_nil'<br>sdp-xml.h:36: warning: data definition has no type or=
 storage class<br><br>i configured it with<br>[Pramod@localhost bluez-utils=
-3.25]$ export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/home/Pramod/projects/ins=
tall/lib<br><br>[Pramod@localhost bluez-utils-3.25]$ export
 PATH=3D$PATH:/opt/gcc-3.4.4-glibc-2.3.5/bin<br><br>[Pramod@localhost bluez=
-utils-3.25]$ ./configure --build=3Di686-pc-linux-gnu --host=3Darm-linux --=
sysconfdir=3D/home/Pramod/projects/install/etc --prefix=3D/home/Pramod/proj=
ects/install ./configure --enable-inotify --enable-usb --enable-obex --enab=
le-alsa --enable-test --enable-audio --enable-input --enable-serial --enabl=
e-gstreamer --enable-network --enable-sync --enable-hcid --enable-sdpd --en=
able-hidd --enable-pand --enable-echo --enable-configfiles --enable-initscr=
ipts --enable-avctrl<br><br>Can anyone help me in this?<br><br>Thanks and B=
est regards<div>&nbsp;</div><div>Pramod<div><br></div></div></div><br>=0A=
=0A=0A      <!--3--><hr size=3D1></hr> Save all your chat conversations. <a=
 href=3D"http://in.rd.yahoo.com/tagline_webmessenger_3/*http://in.messenger=
..yahoo.com/webmessengerpromo.php">Find them online.</a></body></html>
--0-418839311-1204016744=:71328--



--===============0638222977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0638222977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0638222977==--
