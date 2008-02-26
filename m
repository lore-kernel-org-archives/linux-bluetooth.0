Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Feb 2008 16:02:25 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <797939.59523.qm@web8410.mail.in.yahoo.com>
Subject: Re: [Bluez-devel] error whjile cross compiling Bluez-utils
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1266929478=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1266929478==
Content-Type: multipart/alternative; boundary="0-1156836405-1204021945=:59523"

--0-1156836405-1204021945=:59523
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi =0AThanks for reply=0AI solved that. But one more error is occuring this=
 time. =0A=0Amake[2]: Entering directory `/home/Pramod/projects/waterloo/bl=
uez-utils-3.25/audio'=0A/bin/sh ../libtool --tag=3DCC   --mode=3Dcompile ar=
m-linux-gcc -DHAVE_CONFIG_H -I. -I.. -I../common   -I/usr/include/alsa   -I=
.../sbc -Wall -O2 -D_FORTIFY_SOURCE=3D2 -MT libasound_module_pcm_bluetooth_l=
a-pcm_bluetooth.lo -MD -MP -MF .deps/libasound_module_pcm_bluetooth_la-pcm_=
bluetooth.Tpo -c -o libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo `tes=
t -f 'pcm_bluetooth.c' || echo './'`pcm_bluetooth.c=0A arm-linux-gcc -DHAVE=
_CONFIG_H -I. -I.. -I../common -I/usr/include/alsa -I../sbc -Wall -O2 -D_FO=
RTIFY_SOURCE=3D2 -MT libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo -MD=
 -MP -MF .deps/libasound_module_pcm_bluetooth_la-pcm_bluetooth.Tpo -c pcm_b=
luetooth.c  -fPIC -DPIC -o .libs/libasound_module_pcm_bluetooth_la-pcm_blue=
tooth.o=0Apcm_bluetooth.c:39:28: alsa/asoundlib.h: No such file or director=
y=0Apcm_bluetooth.c:40:31: alsa/pcm_external.h: No such file or directory=
=0Apcm_bluetooth.c:129: error: parse error before "snd_pcm_ioplug_t"=0Apcm_=
bluetooth.c:129: warning: no semicolon at end of struct or union=0A=0AI hav=
e all the headers included.+=0A =0AThanks and Best regards =0APramod=0A=0A-=
---- Original Message ----=0AFrom: Ming-I Hsieh <mihs@wmlab.csie.ncu.edu.tw=
>=0ATo: bluez-devel <bluez-devel@lists.sourceforge.net>=0ASent: Tuesday, 26=
 February, 2008 3:48:08 PM=0ASubject: Re: [Bluez-devel] error whjile cross =
compiling Bluez-utils=0A=0A> =0Asdp-xml.c:36:27: =0Abluetooth/sdp.h: =0ANo =
=0Asuch =0Afile =0Aor =0Adirectory=0A> =0Asdp-xml.c:37:31: =0Abluetooth/sdp=
_lib.h: =0ANo =0Asuch =0Afile =0Aor =0Adirectory=0Acheck =0Ayour =0Ainclude=
 =0Adirectories. =0Agcc =0Acould =0Anot =0Afind=0A=0Abluetooth/sdp.h =0Aand=
=0Abluetooth/sdp_lib.h=0A=0Ain =0Ayour =0Ainclude =0Adirectories.=0A=0A> =
=0AIn =0Afile =0Aincluded =0Afrom =0Asdp-xml.c:41:=0A> =0Asdp-xml.h:33: =0A=
error: =0Aparse =0Aerror =0Abefore =0A'*' =0Atoken=0A> =0Asdp-xml.h:34: =0A=
error: =0Aparse =0Aerror =0Abefore =0A')' =0Atoken=0A> =0Asdp-xml.h:36: =0A=
warning: =0Atype =0Adefaults =0Ato =0A`int' =0Ain =0Adeclaration =0Aof  =0A=
 =0A> =0A`sdp_xml_parse_nil'=0A> =0Asdp-xml.h:36: =0Awarning: =0Adata =0Ade=
finition =0Ahas =0Ano =0Atype =0Aor =0Astorage =0Aclass=0A>=0A=0A=0A-------=
---------------------------------------------------------=0AThis =0Amessage=
 =0Awas =0Asent =0Ausing =0AIMP, =0Athe =0AInternet =0AMessaging =0AProgram=
..=0A=0A=0A=0A--------------------------------------------------------------=
-----------=0AThis =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosof=
t=0ADefy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=
=0Ahttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=0A______________=
_________________________________=0ABluez-devel =0Amailing =0Alist=0ABluez-=
devel@lists.sourceforge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/=
bluez-devel=0A=0A=0A=0A=0A=0A=0A=0A      Save all your chat conversations. =
Find them online at http://in.messenger.yahoo.com/webmessengerpromo.php
--0-1156836405-1204021945=:59523
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi <br>Thanks for reply<br>I solved that. But one more erro=
r is occuring this time. <br><br>make[2]: Entering directory `/home/Pramod/=
projects/waterloo/bluez-utils-3.25/audio'<br>/bin/sh ../libtool --tag=3DCC&=
nbsp;&nbsp; --mode=3Dcompile arm-linux-gcc -DHAVE_CONFIG_H -I. -I.. -I../co=
mmon&nbsp;&nbsp; -I/usr/include/alsa&nbsp;&nbsp; -I../sbc -Wall -O2 -D_FORT=
IFY_SOURCE=3D2 -MT libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo -MD -=
MP -MF .deps/libasound_module_pcm_bluetooth_la-pcm_bluetooth.Tpo -c -o liba=
sound_module_pcm_bluetooth_la-pcm_bluetooth.lo `test -f 'pcm_bluetooth.c' |=
| echo './'`pcm_bluetooth.c<br>&nbsp;arm-linux-gcc -DHAVE_CONFIG_H -I. -I..=
 -I../common -I/usr/include/alsa -I../sbc -Wall -O2 -D_FORTIFY_SOURCE=3D2 -=
MT libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo -MD -MP -MF
 .deps/libasound_module_pcm_bluetooth_la-pcm_bluetooth.Tpo -c pcm_bluetooth=
..c&nbsp; -fPIC -DPIC -o .libs/libasound_module_pcm_bluetooth_la-pcm_bluetoo=
th.o<br>pcm_bluetooth.c:39:28: alsa/asoundlib.h: No such file or directory<=
br>pcm_bluetooth.c:40:31: alsa/pcm_external.h: No such file or directory<br=
>pcm_bluetooth.c:129: error: parse error before "snd_pcm_ioplug_t"<br>pcm_b=
luetooth.c:129: warning: no semicolon at end of struct or union<br><br><div=
>I have all the headers included.+<br>&nbsp;</div>Thanks and Best regards<d=
iv>&nbsp;</div><div>Pramod<div style=3D"font-family: times new roman,new yo=
rk,times,serif; font-size: 12pt;"><br><br><div style=3D"font-family: times =
new roman,new york,times,serif; font-size: 12pt;">----- Original Message --=
--<br>From: Ming-I Hsieh &lt;mihs@wmlab.csie.ncu.edu.tw&gt;<br>To: bluez-de=
vel &lt;bluez-devel@lists.sourceforge.net&gt;<br>Sent: Tuesday, 26 February=
, 2008 3:48:08 PM<br>Subject: Re: [Bluez-devel] error whjile cross
 compiling Bluez-utils<br><br>&gt; =0Asdp-xml.c:36:27: =0Abluetooth/sdp.h: =
=0ANo =0Asuch =0Afile =0Aor =0Adirectory<br>&gt; =0Asdp-xml.c:37:31: =0Ablu=
etooth/sdp_lib.h: =0ANo =0Asuch =0Afile =0Aor =0Adirectory<br>check =0Ayour=
 =0Ainclude =0Adirectories. =0Agcc =0Acould =0Anot =0Afind<br><br>bluetooth=
/sdp.h =0Aand<br>bluetooth/sdp_lib.h<br><br>in =0Ayour =0Ainclude =0Adirect=
ories.<br><br>&gt; =0AIn =0Afile =0Aincluded =0Afrom =0Asdp-xml.c:41:<br>&g=
t; =0Asdp-xml.h:33: =0Aerror: =0Aparse =0Aerror =0Abefore =0A'*' =0Atoken<b=
r>&gt; =0Asdp-xml.h:34: =0Aerror: =0Aparse =0Aerror =0Abefore =0A')' =0Atok=
en<br>&gt; =0Asdp-xml.h:36: =0Awarning: =0Atype =0Adefaults =0Ato =0A`int' =
=0Ain =0Adeclaration =0Aof&nbsp; =0A <br>&gt; =0A`sdp_xml_parse_nil'<br>&gt=
; =0Asdp-xml.h:36: =0Awarning: =0Adata =0Adefinition =0Ahas =0Ano =0Atype =
=0Aor =0Astorage =0Aclass<br>&gt;<br><br><br>------------------------------=
----------------------------------<br>This =0Amessage =0Awas =0Asent =0Ausi=
ng =0AIMP, =0Athe =0AInternet =0AMessaging =0AProgram.<br><br><br><br>-----=
--------------------------------------------------------------------<br>Thi=
s =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft<br>Defy =0Aall =
=0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.<br><a href=3D"h=
ttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target=3D"_blank">h=
ttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>_____________=
__________________________________<br>Bluez-devel =0Amailing =0Alist<br><a =
ymailto=3D"mailto:Bluez-devel@lists.sourceforge.net" href=3D"mailto:Bluez-d=
evel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a hre=
f=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" target=3D"_b=
lank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></div=
><br></div></div></div><br>=0A=0A=0A      <!--6--><hr size=3D1></hr> Explor=
e your hobbies and interests. <a href=3D"http://in.rd.yahoo.com/tagline_gro=
ups_6/*http://in.promos.yahoo.com/groups">Click here to begin.</a></body></=
html>
--0-1156836405-1204021945=:59523--



--===============1266929478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1266929478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1266929478==--
