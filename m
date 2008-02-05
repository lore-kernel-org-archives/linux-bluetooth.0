Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Feb 2008 16:16:40 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <578422.48756.qm@web8411.mail.in.yahoo.com>
Subject: Re: [Bluez-users] No sound on headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1943667565=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1943667565==
Content-Type: multipart/alternative; boundary="0-238234249-1202208400=:48756"

--0-238234249-1202208400=:48756
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hello again=0AI have compiled linux-2.6.22...with all support needed for Bl=
uez...=0ANow when i again try to play asong to my headset using=0A=0A[Pramo=
d@localhost src]$ mplayer_install/bin/mplayer -ao alsa:device=3Dheadset 1.m=
p3=0AThe popup comes on system when i enter "0000" the application waits an=
d connects to=0Aheadset. One beep is heard on headset...After that system h=
angs with the monitor all white..=0A=0AAs system is hanged i cant see the /=
var/log/messages nor the hcidump...=0ASomeone please help me this...=0AThan=
ks in advance...=0A=0APramod=0A=0A----- Original Message ----=0AFrom: jayjw=
a <jayjwa@atr2.ath.cx>=0ATo: BlueZ users <bluez-users@lists.sourceforge.net=
>=0ASent: Tuesday, 5 February, 2008 12:48:20 AM=0ASubject: Re: [Bluez-users=
] No sound on headset=0A=0A=0A=0AOn =0AMon, =0A4 =0AFeb =0A2008, =0Apramod =
=0Agurav =0Awrote:=0A=0A-> =0AI =0Awant =0Ato =0Aplay =0Aaudio =0Afrom =0Am=
y =0Asystem =0Aon =0Amy =0ABT =0Aheadset..=0A-> =0AI =0Aam =0Aable =0Aconne=
ct =0Ato =0Ait, =0Apair =0Ait, =0Abut =0Awhen =0Ai =0Arun =0Acommand=0A-> =
=0A[Pramod@localhost =0A~]$ =0Amplayer_install/bin/mplayer =0A-ao =0Aalsa:d=
evice=3Dheadset =0A1.mp3  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A =
 =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A  =0A =
 =0A  =0A =0Ammmmmmm=0A-> =0AIt =0Agives =0Aone =0Abeep =0Aand =0Awaits =0A=
for =0Afew =0Aseconds =0Aand =0Aagain =0Acomes =0Aout =0Awith =0Athis =0Aer=
ror.....=0A-> =0A-> =0A[AO_ALSA] =0Aalsa-lib: =0Apcm_sco.c:277:(sco_headset=
_hw_params) =0AUnable =0Ato =0Aset =0Anumber =0Aof =0ASCO =0Abuffers =0A: =
=0Aplease =0Aupgrade =0Ayour =0AKernel =0A!=0A-> =0A[AO_ALSA] =0AUnable =0A=
to =0Aset =0Ahw-parameters: =0AInvalid =0Aargument=0A-> =0ACould =0Anot =0A=
open/initialize =0Aaudio =0Adevice =0A-> =0Ano =0Asound.=0A-> =0AAudio: =0A=
no =0Asound=0A-> =0AVideo: =0Ano =0Avideo=0A=0AYou =0Ashould =0Aat =0Aleast=
 =0Ause =0Aa =0Amodern =0Akernel =0Afor =0Athe =0Abest =0Achance =0Aat =0Ag=
etting =0Athis =0Ato =0Awork. =0AThe =0Acurrent =0Aversion =0Ais =0Asomethi=
ng =0Alike =0A2.6.24 =0Alast =0Atime =0AI =0Alooked, =0Aso =0A2.6.15 =0Ais =
=0Avery =0Aold =0Aand =0Apossibly =0Avulnerable =0Ato =0Aa =0Anumber =0Aroo=
t =0Aexploits =0Aif =0Anot =0Apatched.=0A=0A=0A-> =0AAfter =0Athis =0Aone =
=0Abeep =0Ais =0Abeing =0Alistened..=0A-> =0AWhat =0Amay =0Abe =0Athe =0Are=
ason =0Afor =0Athis =0A???=0A=0AThere's =0Anot =0Aenough =0Ainfo =0Ahere =
=0Afor =0Ame =0Ato =0Atell. =0ATry =0Arunning =0Athe =0Adaemons =0Ain =0Ade=
bug =0Ain =0Athe =0Aforground =0A(hcid, =0Asdpd). =0AMaybe =0Arun =0Ahcidum=
p =0Aduring =0Athe =0Atime =0Ayou =0Atry =0Aas =0Awell.=0A=0A=0A-> =0AI =0A=
tried =0Aadding =0Apatch =0Afrom =0Aplugs =0Afrom =0ABluez =0ACVS....But =
=0Aits =0Anot =0Acompatible  =0Awith =0Amy =0Akernel =0A-> =0A2..6.15 =0Afe=
doraCore-5....=0A-> =0AWhich =0Apatch =0Ai =0Ashould =0Aadd =0Afor =0Aupgra=
ding =0Amy =0Akernel.....?=0A=0AJust =0Adownload =0Athe =0Alatest =0Akernel=
.. =0ABuild, =0Ainstall.=0A=0A=0A=0A----------------------------------------=
---------------------------------=0AThis =0ASF.net =0Aemail =0Ais =0Asponso=
red =0Aby: =0AMicrosoft=0ADefy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVis=
ual =0AStudio =0A2008.=0Ahttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direc=
t/01/=0A_______________________________________________=0ABluez-users =0Ama=
iling =0Alist=0ABluez-users@lists.sourceforge.net=0Ahttps://lists.sourcefor=
ge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=0A=0A      Get the freedom=
 to save as many mails as you wish. To know how, go to http://help.yahoo.co=
m/l/in/yahoo/mail/yahoomail/tools/tools-08.html
--0-238234249-1202208400=:48756
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">hello again<br>I have compiled linux-2.6.22...with =
all support needed for Bluez...<br>Now when i again try to play asong to my=
 headset using<br><br>[Pramod@localhost src]$ mplayer_install/bin/mplayer -=
ao alsa:device=3Dheadset 1.mp3<br>The popup comes on system when i enter "0=
000" the application waits and connects to<br>headset. One beep is heard on=
 headset...After that system hangs with the monitor all white..<br><br>As s=
ystem is hanged i cant see the /var/log/messages nor the hcidump...<br>Some=
one please help me this...<br>Thanks in advance...<br><br>Pramod<br><br><di=
v style=3D"font-family: times new roman,new york,times,serif; font-size: 12=
pt;">----- Original Message ----<br>From: jayjwa
 &lt;jayjwa@atr2.ath.cx&gt;<br>To: BlueZ users &lt;bluez-users@lists.source=
forge.net&gt;<br>Sent: Tuesday, 5 February, 2008 12:48:20 AM<br>Subject: Re=
: [Bluez-users] No sound on headset<br><br><br><br>On =0AMon, =0A4 =0AFeb =
=0A2008, =0Apramod =0Agurav =0Awrote:<br><br>-&gt; =0AI =0Awant =0Ato =0Apl=
ay =0Aaudio =0Afrom =0Amy =0Asystem =0Aon =0Amy =0ABT =0Aheadset..<br>-&gt;=
 =0AI =0Aam =0Aable =0Aconnect =0Ato =0Ait, =0Apair =0Ait, =0Abut =0Awhen =
=0Ai =0Arun =0Acommand<br>-&gt; =0A[Pramod@localhost =0A~]$ =0Amplayer_inst=
all/bin/mplayer =0A-ao =0Aalsa:device=3Dheadset <br>1.mp3&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&n=
bsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =
=0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A&n=
bsp; =0A&nbsp; =0A&nbsp; =0A =0Ammmmmmm<br>-&gt; =0AIt =0Agives =0Aone =0Ab=
eep =0Aand =0Awaits =0Afor =0Afew =0Aseconds =0Aand =0Aagain =0Acomes =0Aou=
t =0Awith =0Athis =0Aerror.....<br>-&gt; <br>-&gt; =0A[AO_ALSA] =0Aalsa-lib=
: =0Apcm_sco.c:277:(sco_headset_hw_params) =0AUnable =0Ato =0Aset =0Anumber=
 =0Aof =0ASCO =0Abuffers =0A: =0Aplease =0Aupgrade =0Ayour =0AKernel =0A!<b=
r>-&gt; =0A[AO_ALSA] =0AUnable =0Ato =0Aset =0Ahw-parameters: =0AInvalid =
=0Aargument<br>-&gt; =0ACould =0Anot =0Aopen/initialize =0Aaudio =0Adevice =
=0A-&gt; =0Ano =0Asound.<br>-&gt; =0AAudio: =0Ano =0Asound<br>-&gt; =0AVide=
o: =0Ano =0Avideo<br><br>You =0Ashould =0Aat =0Aleast =0Ause =0Aa =0Amodern=
 =0Akernel =0Afor =0Athe =0Abest =0Achance =0Aat =0Agetting =0Athis =0Ato <=
br>work. =0AThe =0Acurrent =0Aversion =0Ais =0Asomething =0Alike =0A2.6.24 =
=0Alast =0Atime =0AI =0Alooked, =0Aso <br>2.6.15 =0Ais =0Avery =0Aold =0Aan=
d =0Apossibly =0Avulnerable =0Ato =0Aa =0Anumber =0Aroot =0Aexploits =0Aif =
=0Anot <br>patched.<br><br><br>-&gt; =0AAfter =0Athis =0Aone =0Abeep =0Ais =
=0Abeing =0Alistened..<br>-&gt; =0AWhat =0Amay =0Abe =0Athe =0Areason =0Afo=
r =0Athis =0A???<br><br>There's =0Anot =0Aenough =0Ainfo =0Ahere =0Afor =0A=
me =0Ato =0Atell. =0ATry =0Arunning =0Athe =0Adaemons =0Ain =0Adebug <br>in=
 =0Athe =0Aforground =0A(hcid, =0Asdpd). =0AMaybe =0Arun =0Ahcidump =0Aduri=
ng =0Athe =0Atime =0Ayou =0Atry =0Aas <br>well.<br><br><br>-&gt; =0AI =0Atr=
ied =0Aadding =0Apatch =0Afrom =0Aplugs =0Afrom =0ABluez =0ACVS....But =0Ai=
ts =0Anot =0Acompatible&nbsp; =0Awith =0Amy =0Akernel <br>-&gt; =0A2..6.15 =
=0AfedoraCore-5....<br>-&gt; =0AWhich =0Apatch =0Ai =0Ashould =0Aadd =0Afor=
 =0Aupgrading =0Amy =0Akernel.....?<br><br>Just =0Adownload =0Athe =0Alates=
t =0Akernel. =0ABuild, =0Ainstall.<br><br><br><br>-------------------------=
------------------------------------------------<br>This =0ASF.net =0Aemail=
 =0Ais =0Asponsored =0Aby: =0AMicrosoft<br>Defy =0Aall =0Achallenges. =0AMi=
crosoft(R) =0AVisual =0AStudio =0A2008.<br><a href=3D"http://clk.atdmt.com/=
MRT/go/vse0120000070mrt/direct/01/" target=3D"_blank">http://clk.atdmt.com/=
MRT/go/vse0120000070mrt/direct/01/</a><br>_________________________________=
______________<br>Bluez-users =0Amailing =0Alist<br><a ymailto=3D"mailto:Bl=
uez-users@lists.sourceforge.net" href=3D"mailto:Bluez-users@lists.sourcefor=
ge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.s=
ourceforge.net/lists/listinfo/bluez-users" target=3D"_blank">https://lists.=
sourceforge.net/lists/listinfo/bluez-users</a><br></div><br></div></div><br=
>=0A=0A=0A      <!--5--><hr size=3D1></hr> Get the freedom to save as many =
mails as you wish. <a href=3D"http://in.rd.yahoo.com/tagline_mail_5/*http:/=
/help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Click here =
to know how.</a></body></html>
--0-238234249-1202208400=:48756--



--===============1943667565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1943667565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1943667565==--
