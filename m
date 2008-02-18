Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2008 18:46:50 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <802174.10793.qm@web8410.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0763972316=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0763972316==
Content-Type: multipart/alternative; boundary="0-1125774382-1203340610=:10793"

--0-1125774382-1203340610=:10793
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi again=0AI was on wekend..Sorry could not catch you=0A>According =0Ato =
=0Athe =0AGentoo =0AWiki, =0Ayour =0AHS =0Adoes =0Awork =0Awith =0Amodern =
=0Akernel/bluez. =0ABTW, =0A>last =0Atime =0Awhen =0Aeverything =0Alooked =
=0Aright =0Abut =0Ayou =0Adidn't =0Ahear =0Aanything, =0Adid =0Ayou =0A>rem=
ember =0Ato =0Aturn =0Aup =0Athe =0Aalsa =0Asound? =0AWhen =0AI =0Areboot, =
=0Aalsa =0Ais =0Aalways =0Aset =0Ato =0A0. =0AI =0A>use =0Arexima/aumix =0A=
to =0Aturn =0Aup =0Athe =0Avolumn. =0AThat's =0Aa =0Acommon =0Aoversight. =
=0AOther =0Athan =0A>that, =0AI =0Areally =0Adon't =0Aknow =0Awhy =0Ait's =
=0Aworking.=0A =0Ahow can I turn =0Aup =0Athe =0Aalsa =0Asound? can you jus=
t give me some hint?=0AShall I really try Btsco way?=0AElse I replace my BT=
 adapter?? But I have three. Two are Broadcom and one is silicon wave.=0AOn=
ly one is working to the maximum is the current one which is broadcom.=0AWh=
ich one shall I try now?=0ASorry for too many Ques???=0AHave a nice time ah=
ead.=0A=0AThanks and Best regards =0APramod=0A=0A----- Original Message ---=
-=0AFrom: jayjwa <jayjwa@atr2.ath.cx>=0ATo: BlueZ users <bluez-users@lists.=
sourceforge.net>=0ASent: Sunday, 17 February, 2008 3:50:27 PM=0ASubject: Re=
: [Bluez-users] Headset not playing audio HELP PLEASE=0A=0A=0AOn =0AFri, =
=0A15 =0AFeb =0A2008, =0Apramod =0Agurav =0Awrote:=0A=0A-> =0AI =0Ajust =0A=
tried =0Achanging =0Asome =0Alines =0Ain =0A/usr/src/linux/net/bluetooth/hc=
i_event.c=0A-> =0Aand =0Acompiled =0Athe =0Akernel..=0A=0AYou =0Acan't =0Aj=
ust =0Achange =0Avalues =0Aunless =0Ayou =0Aknow =0Akernel/bluetooth =0Apro=
gramming =0A;)=0A=0A=0A-> =0ASCO =0AMTU: =0A64:8 =0Athis =0Ahas =0Achanged =
=0A-> =0Abut =0Anew =0Aproblem =0Ais =0Ahwen =0AI =0Apress =0Abutton =0Aon =
=0AHS =0Alink =0Areq =0Acomes =0Abut =0Athe =0Aconnection =0Ais =0Adifferen=
t =0Athis =0Atime=0A-> =0A[root@localhost =0APramod]# =0Ahcitool =0Aconn=0A=
-> =0AConnections:=0A->  =0A  =0A  =0A  =0A =0A> =0AACL =0A00:0F:DE:B1:02:4=
2 =0Ahandle =0A0 =0Astate =0A2 =0Alm =0ASLAVE=0A-> =0Apreviously =0Ait =0Au=
sed =0Ato =0Abe =0Aas=0A-> =0A->=0A=0AThat's =0Awhat =0Amine =0Alooks =0Ali=
ke =0Abefore =0AI =0Apress =0Athe =0Abutton- =0Athen =0Ait =0Adoes =0Athe =
=0Apass/auth =0Astep.=0A=0A=0A-> =0A[Pramod@localhost =0A~]$ =0Aaplay =0A-D=
 =0Abluetooth =0A-f =0AS16_LE =0Atest.raw=0A-> =0Athere =0Ais =0Aa =0Along =
=0Await =0Aand =0Aconnections =0Aare=0A-> =0A[root@localhost =0APramod]# =
=0Ahcitool =0Aconn=0A-> =0AConnections:=0A->  =0A  =0A  =0A  =0A =0A> =0AAC=
L =0A00:0F:DE:B1:02:43 =0Ahandle =0A0 =0Astate =0A2 =0Alm =0ASLAVE =0A->  =
=0A  =0A  =0A  =0A =0A< =0AACL =0A00:0F:DE:B1:02:42 =0Ahandle =0A0 =0Astate=
 =0A5 =0Alm =0AMASTER=0A-> =0A->  =0A00:0F:DE:B1:02:43 =0Athis =0Ais =0Anot=
 =0Amy =0AHS =0Aaddress(there =0Ais =0Ano =0Aother =0Adevice =0Anear =0Aher=
e)=0A-> =0A00:0F:DE:B1:02:42 =0Athis =0Aone =0Ais =0Amine.=0A=0AThat's =0Ao=
dd. =0ANever =0Asaw =0Aa =0Asecond =0Aaddress =0Alike =0Athat =0Abefore...=
=0A=0A-> =0Aplanning =0Ato =0Arecompile =0Athe =0Akernel =0Awith =0Aorigina=
l =0Ahci_event.c=0A=0AAccording =0Ato =0Athe =0AGentoo =0AWiki, =0Ayour =0A=
HS =0Adoes =0Awork =0Awith =0Amodern =0Akernel/bluez. =0ABTW, =0Alast =0Ati=
me =0Awhen =0Aeverything =0Alooked =0Aright =0Abut =0Ayou =0Adidn't =0Ahear=
 =0Aanything, =0Adid =0Ayou =0Aremember =0Ato =0Aturn =0Aup =0Athe =0Aalsa =
=0Asound? =0AWhen =0AI =0Areboot, =0Aalsa =0Ais =0Aalways =0Aset =0Ato =0A0=
.. =0AI =0Ause =0Arexima/aumix =0Ato =0Aturn =0Aup =0Athe =0Avolumn. =0AThat=
's =0Aa =0Acommon =0Aoversight. =0AOther =0Athan =0Athat, =0AI =0Areally =
=0Adon't =0Aknow =0Awhy =0Ait's =0Aworking.=0A=0A-> =0AAs =0Ayou =0Asaid =
=0Athere =0Amight =0Abe =0Aa =0Aincompatibility =0Aissues =0Ain =0Aone =0Ao=
f =0Athem(HS/dongle)=0A=0AThe =0Aheadset =0Aseems =0AOK, =0Afrom =0Athe =0A=
wiki. =0AYou =0Amight =0Alook =0Aup =0Athe =0Adongle, =0Aif =0Ayou =0Adidn'=
t =0Aalready.=0A=0A=0A-> =0ACan =0Ait =0Ahappen =0Athat =0AI =0Amight =0Are=
quire =0Ato =0Aplay =0Athe =0Aaudio =0Awith =0Acertain =0Afrequency, =0Arat=
e =0Aor =0Aparameters =0Awhich =0Aare =0Asupported =0Aby =0Amy =0AHS(Its =
=0Aa =0ASony =0AEricsson =0AHBH-602)?=0A=0ANot =0Atotally =0Asure, =0Abut =
=0Amine =0Adidn't =0Arequire =0Athem. =0AI'm =0Aassuming =0Ait =0Aused =0At=
he =0Adefaults =0Ain =0Athat =0Acase.=0A=0A=0A-----------------------------=
--------------------------------------------=0AThis =0ASF.net =0Aemail =0Ai=
s =0Asponsored =0Aby: =0AMicrosoft=0ADefy =0Aall =0Achallenges. =0AMicrosof=
t(R) =0AVisual =0AStudio =0A2008.=0Ahttp://clk.atdmt.com/MRT/go/vse01200000=
70mrt/direct/01/=0A_______________________________________________=0ABluez-=
users =0Amailing =0Alist=0ABluez-users@lists.sourceforge.net=0Ahttps://list=
s.sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=0A=0A=0A      N=
ow you can chat without downloading messenger. Go to http://in.messenger.ya=
hoo.com/webmessengerpromo.php
--0-1125774382-1203340610=:10793
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi again<br>I was on wekend..Sorry could not catch you<br>&=
gt;According =0Ato =0Athe =0AGentoo =0AWiki, =0Ayour =0AHS =0Adoes =0Awork =
=0Awith =0Amodern =0Akernel/bluez. =0ABTW, <br>&gt;last =0Atime =0Awhen =0A=
everything =0Alooked =0Aright =0Abut =0Ayou =0Adidn't =0Ahear =0Aanything, =
=0Adid =0Ayou <br>&gt;remember =0Ato =0Aturn =0Aup =0Athe =0Aalsa =0Asound?=
 =0AWhen =0AI =0Areboot, =0Aalsa =0Ais =0Aalways =0Aset =0Ato =0A0. =0AI <b=
r>&gt;use =0Arexima/aumix =0Ato =0Aturn =0Aup =0Athe =0Avolumn. =0AThat's =
=0Aa =0Acommon =0Aoversight. =0AOther =0Athan <br>&gt;that, =0AI =0Areally =
=0Adon't =0Aknow =0Awhy =0Ait's =0Aworking.<br><div>&nbsp;<br>how can I tur=
n =0Aup =0Athe =0Aalsa =0Asound? can you just give me some hint?<br>Shall I=
 really try Btsco way?<br>Else I replace my BT adapter?? But I have three. =
Two are Broadcom and one is silicon wave.<br>Only one is working to the max=
imum is the current one which is broadcom.<br>Which one shall I try now?<br=
>Sorry for too many Ques???<br>Have a nice time ahead.<br></div>Thanks and =
Best regards<div>&nbsp;</div><div>Pramod<div style=3D"font-family: times ne=
w roman,new york,times,serif; font-size: 12pt;"><br><br><div style=3D"font-=
family: times new roman,new york,times,serif; font-size: 12pt;">----- Origi=
nal Message ----<br>From: jayjwa &lt;jayjwa@atr2.ath.cx&gt;<br>To: BlueZ us=
ers &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Sunday, 17 February,=
 2008 3:50:27 PM<br>Subject: Re: [Bluez-users] Headset not playing audio HE=
LP PLEASE<br><br><br>On =0AFri, =0A15 =0AFeb =0A2008, =0Apramod =0Agurav =
=0Awrote:<br><br>-&gt; =0AI =0Ajust =0Atried =0Achanging =0Asome =0Alines =
=0Ain =0A/usr/src/linux/net/bluetooth/hci_event.c<br>-&gt; =0Aand =0Acompil=
ed =0Athe =0Akernel..<br><br>You =0Acan't =0Ajust =0Achange =0Avalues =0Aun=
less =0Ayou =0Aknow =0Akernel/bluetooth =0Aprogramming =0A;)<br><br><br>-&g=
t; =0ASCO =0AMTU: =0A64:8 =0Athis =0Ahas =0Achanged <br>-&gt; =0Abut =0Anew=
 =0Aproblem =0Ais =0Ahwen =0AI =0Apress =0Abutton =0Aon =0AHS =0Alink =0Are=
q =0Acomes =0Abut =0Athe =0Aconnection =0Ais =0Adifferent =0Athis =0Atime<b=
r>-&gt; =0A[root@localhost =0APramod]# =0Ahcitool =0Aconn<br>-&gt; =0AConne=
ctions:<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A&gt; =0AACL =0A=
00:0F:DE:B1:02:42 =0Ahandle =0A0 =0Astate =0A2 =0Alm =0ASLAVE<br>-&gt; =0Ap=
reviously =0Ait =0Aused =0Ato =0Abe =0Aas<br>-&gt; =0A-&gt;<br><br>That's =
=0Awhat =0Amine =0Alooks =0Alike =0Abefore =0AI =0Apress =0Athe =0Abutton- =
=0Athen =0Ait =0Adoes =0Athe <br>pass/auth =0Astep.<br><br><br>-&gt; =0A[Pr=
amod@localhost =0A~]$ =0Aaplay =0A-D =0Abluetooth =0A-f =0AS16_LE =0Atest.r=
aw<br>-&gt; =0Athere =0Ais =0Aa =0Along =0Await =0Aand =0Aconnections =0Aar=
e<br>-&gt; =0A[root@localhost =0APramod]# =0Ahcitool =0Aconn<br>-&gt; =0ACo=
nnections:<br>-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A&gt; =0AACL =
=0A00:0F:DE:B1:02:43 =0Ahandle =0A0 =0Astate =0A2 =0Alm =0ASLAVE <br>-&gt;&=
nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A&lt; =0AACL =0A00:0F:DE:B1:02:42=
 =0Ahandle =0A0 =0Astate =0A5 =0Alm =0AMASTER<br>-&gt; <br>-&gt;&nbsp; =0A0=
0:0F:DE:B1:02:43 =0Athis =0Ais =0Anot =0Amy =0AHS =0Aaddress(there =0Ais =
=0Ano =0Aother =0Adevice =0Anear =0Ahere)<br>-&gt; =0A00:0F:DE:B1:02:42 =0A=
this =0Aone =0Ais =0Amine.<br><br>That's =0Aodd. =0ANever =0Asaw =0Aa =0Ase=
cond =0Aaddress =0Alike =0Athat =0Abefore...<br><br>-&gt; =0Aplanning =0Ato=
 =0Arecompile =0Athe =0Akernel =0Awith =0Aoriginal =0Ahci_event.c<br><br>Ac=
cording =0Ato =0Athe =0AGentoo =0AWiki, =0Ayour =0AHS =0Adoes =0Awork =0Awi=
th =0Amodern =0Akernel/bluez. =0ABTW, <br>last =0Atime =0Awhen =0Aeverythin=
g =0Alooked =0Aright =0Abut =0Ayou =0Adidn't =0Ahear =0Aanything, =0Adid =
=0Ayou <br>remember =0Ato =0Aturn =0Aup =0Athe =0Aalsa =0Asound? =0AWhen =
=0AI =0Areboot, =0Aalsa =0Ais =0Aalways =0Aset =0Ato =0A0. =0AI <br>use =0A=
rexima/aumix =0Ato =0Aturn =0Aup =0Athe =0Avolumn. =0AThat's =0Aa =0Acommon=
 =0Aoversight. =0AOther =0Athan <br>that, =0AI =0Areally =0Adon't =0Aknow =
=0Awhy =0Ait's =0Aworking.<br><br>-&gt; =0AAs =0Ayou =0Asaid =0Athere =0Ami=
ght =0Abe =0Aa =0Aincompatibility =0Aissues =0Ain =0Aone =0Aof =0Athem(HS/d=
ongle)<br><br>The =0Aheadset =0Aseems =0AOK, =0Afrom =0Athe =0Awiki. =0AYou=
 =0Amight =0Alook =0Aup =0Athe =0Adongle, =0Aif =0Ayou <br>didn't =0Aalread=
y.<br><br><br>-&gt; =0ACan =0Ait =0Ahappen =0Athat =0AI =0Amight =0Arequire=
 =0Ato =0Aplay =0Athe =0Aaudio =0Awith =0Acertain =0Afrequency, =0Arate =0A=
or =0Aparameters =0Awhich =0Aare =0Asupported =0Aby =0Amy =0AHS(Its =0Aa =
=0ASony =0AEricsson =0AHBH-602)?<br><br>Not =0Atotally =0Asure, =0Abut =0Am=
ine =0Adidn't =0Arequire =0Athem. =0AI'm =0Aassuming =0Ait =0Aused =0Athe <=
br>defaults =0Ain =0Athat =0Acase.<br><br><br>-----------------------------=
--------------------------------------------<br>This =0ASF.net =0Aemail =0A=
is =0Asponsored =0Aby: =0AMicrosoft<br>Defy =0Aall =0Achallenges. =0AMicros=
oft(R) =0AVisual =0AStudio =0A2008.<br><a href=3D"http://clk.atdmt.com/MRT/=
go/vse0120000070mrt/direct/01/" target=3D"_blank">http://clk.atdmt.com/MRT/=
go/vse0120000070mrt/direct/01/</a><br>_____________________________________=
__________<br>Bluez-users =0Amailing =0Alist<br><a ymailto=3D"mailto:Bluez-=
users@lists.sourceforge.net" href=3D"mailto:Bluez-users@lists.sourceforge.n=
et">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.sourc=
eforge.net/lists/listinfo/bluez-users" target=3D"_blank">https://lists.sour=
ceforge.net/lists/listinfo/bluez-users</a><br></div><br></div></div></div><=
br>=0A=0A=0A      <!--6--><hr size=3D1></hr> Explore your hobbies and inter=
ests. <a href=3D"http://in.rd.yahoo.com/tagline_groups_6/*http://in.promos.=
yahoo.com/groups">Click here to begin.</a></body></html>
--0-1125774382-1203340610=:10793--



--===============0763972316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0763972316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0763972316==--
